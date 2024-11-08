import 'flutter_pos_printer_platform_image_3.dart';

class PrinterDiscovered<T> {
  String name;
  T detail;
  PrinterDiscovered({
    required this.name,
    required this.detail,
  });
}

typedef DiscoverResult<T> = Future<List<PrinterDiscovered<T>>>;

Future<List<PrinterDiscovered>> discoverPrinters(
    {List<DiscoverResult Function()> modes = const [
      // discoverStarPrinter,
      UsbPrinterConnector.discoverPrinters,
      BluetoothPrinterConnector.discoverPrinters,
      TcpPrinterConnector.discoverPrinters
    ]}) async {
  List<PrinterDiscovered> result = [];
  await Future.wait(modes.map((m) async {
    result.addAll(await m());
  }));
  return result;
}
