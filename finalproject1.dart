import 'dart:io';
import 'classstack.dart';

class Concert {
  String name;
  // Map untuk menyimpan kategori tiket dan harga dalam setiap konser
  Map<String, int> ticketPrices;

  Concert(this.name, this.ticketPrices);
}

class TicketOrder {
  String concertName;
  String ticketCategory;
  int ticketQuantity;
  int totalPrice;
  String fullName;
  String email;
  String phoneNumber;
  String paymentMethod;
  String paymentDetail;

  TicketOrder(
    this.concertName,
    this.ticketCategory,
    this.ticketQuantity,
    this.totalPrice,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.paymentMethod,
    this.paymentDetail,
  );
}

void main() {
  // List untuk menyimpan atau menampilkan konser yang tersedia
  List<Concert> concerts = [
    Concert('NEXFEST CONCERT ANCOL 2024', {'1x Festival Ticket General': 2399999, '3x Festival Tickets General(2279999 Per Ticket)': 6839999}),
    Concert('Avenged Savenfold 2024 jakarta', {'CAT1': 2600000, 'CAT2': 1900000, 'CAT3': 1350000, 'CAT4': 2250000, 'CAT5': 1600000}),
    Concert('Skena Ambyar', {'Reguler': 100000, 'VIP': 250000})
  ];
// menampilkan metode pembayaran yang tersedia
  List<String> paymentMethods = ['Transfer Bank', 'E-Wallet'];

  print('Selamat datang di sistem pembelian tiket konser!\n');

  //Menampilkan dan mengurutkan daftar konser berdasarkan nama (Sorting)
  concerts.sort((a, b) => a.name.compareTo(b.name));
  print('Konser yang tersedia:');
  for (int i = 0; i < concerts.length; i++) {
    print('${i + 1}. ${concerts[i].name}');
  }

  // Memilih konser
  stdout.write('Pilih konser (1-${concerts.length}): ');
  int concertChoice = int.parse(stdin.readLineSync()!);
  Concert selectedConcert = concerts[concertChoice - 1];
  print('Anda memilih: ${selectedConcert.name}\n');

  // Menampilkan kategori tiket dan harga
  print('Kategori tiket untuk ${selectedConcert.name}:');
  List<String> ticketCategories = selectedConcert.ticketPrices.keys.toList();
  for (int i = 0; i < ticketCategories.length; i++) {
    String category = ticketCategories[i];
    print('${i + 1}. $category: Rp ${selectedConcert.ticketPrices[category]}');
  }

  // Memilih kategori tiket
  stdout.write('Pilih kategori tiket (1-${ticketCategories.length}): ');
  int categoryChoice = int.parse(stdin.readLineSync()!);
  String ticketCategory = ticketCategories[categoryChoice - 1];
  int ticketPrice = selectedConcert.ticketPrices[ticketCategory]!;

  // Memasukkan jumlah tiket
  stdout.write('Masukkan jumlah tiket: ');
  int ticketQuantity = int.parse(stdin.readLineSync()!);
  int totalPrice = ticketPrice * ticketQuantity;
  print('Total harga: Rp $totalPrice\n');

  // Memasukkan informasi pribadi
  stdout.write('Masukkan nama lengkap: ');
  String fullName = stdin.readLineSync()!;
  stdout.write('Masukkan alamat email: ');
  String email = stdin.readLineSync()!;
  stdout.write('Masukkan nomor telepon: ');
  String phoneNumber = stdin.readLineSync()!;

  // Memilih metode pembayaran
  print('\nMetode pembayaran yang tersedia:');
  for (int i = 0; i < paymentMethods.length; i++) {
    print('${i + 1}. ${paymentMethods[i]}');
  }
  stdout.write('Pilih metode pembayaran (1-${paymentMethods.length}): ');
  int paymentChoice = int.parse(stdin.readLineSync()!);
  String paymentMethod = paymentMethods[paymentChoice - 1];
  print('Anda memilih metode pembayaran: $paymentMethod\n');

  String paymentDetail = '';
  // Jika metode pembayaran adalah Transfer Bank
  if (paymentMethod == 'Transfer Bank') {
    stdout.write('Pilih bank Anda (BCA, Mandiri, BRI): ');
    String bankChoice = stdin.readLineSync()!;
    paymentDetail = bankChoice;
    print('Anda telah memilih $bankChoice sebagai metode pembayaran.\n');
  }
  // Jika metode pembayaran adalah E-Wallet
  else if (paymentMethod == 'E-Wallet') {
    stdout.write('Masukkan nama layanan E-Wallet Anda (GoPay, OVO, Dana): ');
    String eWalletChoice = stdin.readLineSync()!;
    paymentDetail = eWalletChoice;
    print('Anda telah memilih $eWalletChoice sebagai metode pembayaran.\n');
  }

  // Konfirmasi pembelian
  print('\n--- Konfirmasi Pembelian ---');
  print('Nama: $fullName');
  print('Email: $email');
  print('Nomor Telepon: $phoneNumber');
  print('Konser: ${selectedConcert.name}');
  print('Kategori Tiket: $ticketCategory');
  print('Jumlah Tiket Yang Dibeli : $ticketQuantity');
  print('Total Harga: Rp $totalPrice');
  print('Metode Pembayaran: $paymentMethod');

  if (paymentMethod == 'Transfer Bank') {
    print('Bank: $paymentDetail');
  } else if (paymentMethod == 'E-Wallet') {
    print('Layanan E-Wallet: $paymentDetail');
  }

  stdout.write('\nApakah informasi ini sudah benar? (y/n): ');
  String confirmation = stdin.readLineSync()!;

  // Stack untuk menyimpan pesanan tiket
  Stack<TicketOrder> orderStack = Stack<TicketOrder>();

  if (confirmation.toLowerCase() == 'y') {
    // Membuat pesanan tiket dan menambahkannya ke stack
    TicketOrder order = TicketOrder(selectedConcert.name, ticketCategory, ticketQuantity, totalPrice, fullName, email, phoneNumber, paymentMethod, paymentDetail);
    orderStack.push(order);
    print('\nPembelian tiket berhasil! Tiket akan dikirim ke email Anda.');

    // Menampilkan struk pembayaran
    stdout.write('\nApakah Anda ingin menampilkan struk pembayaran? (y/n): ');
    String showReceipt = stdin.readLineSync()!;
    if (showReceipt.toLowerCase() == 'y') {
      print('\n--- Struk Pembayaran ---');
      print('Nama: ${order.fullName}');
      print('Email: ${order.email}');
      print('Nomor Telepon: ${order.phoneNumber}');
      print('Konser: ${order.concertName}');
      print('Kategori Tiket: ${order.ticketCategory}');
      print('Jumlah Tiket: ${order.ticketQuantity}');
      print('Total Harga: Rp ${order.totalPrice}');
      print('Metode Pembayaran: ${order.paymentMethod}');
      if (order.paymentMethod == 'Transfer Bank') {
        print('Bank: ${order.paymentDetail}');
      } else if (order.paymentMethod == 'E-Wallet') {
        print('Layanan E-Wallet: ${order.paymentDetail}');
      }
    }
  } else {
    print('\nTerima Kasih!.');
  }
}



