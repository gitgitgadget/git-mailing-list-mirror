From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] winansi: support ESC [ K (erase in line)
Date: Tue, 10 Mar 2009 01:41:53 +0100 (CET)
Message-ID: <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Harris <git@peter.is-a-geek.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 10 01:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgq46-00042w-AS
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZCJAl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 20:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbZCJAl6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:41:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:54588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751101AbZCJAl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 20:41:57 -0400
Received: (qmail invoked by alias); 10 Mar 2009 00:41:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 10 Mar 2009 01:41:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oPmY62fwoundKCm98TS+L6ixe8gwDNumclQ5Rfv
	rUInsm/O4NYVOg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1236639280u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112771>

To make use of it during a fetch, write() needs to be overridden, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This fixes the last bit of msysGit issue 124 for me:

		http://code.google.com/p/msysgit/issues/detail?id=124

	which annoyed me one time to many today.

	I had an earlier version which was smaller, but pretty hacky, in 
	that it checked if fprintf is #define'd in xwrite(), and had 
	special handling for that case.

	This patch is only slightly hacky, in that it assumes that you do 
	not try to output something that ends in an incomplete ESC [
	sequence.

 compat/mingw.h   |    2 ++
 compat/winansi.c |   51 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index b82903c..9aac4e1 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -192,9 +192,11 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 int winansi_fputs(const char *str, FILE *stream);
 int winansi_printf(const char *format, ...) __attribute__((format (printf, 1, 2)));
 int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format (printf, 2, 3)));
+int winansi_write(int fd, const void *buf, size_t len);
 #define fputs winansi_fputs
 #define printf(...) winansi_printf(__VA_ARGS__)
 #define fprintf(...) winansi_fprintf(__VA_ARGS__)
+#define write winansi_write
 
 /*
  * git specific compatibility
diff --git a/compat/winansi.c b/compat/winansi.c
index e2d96df..a9d981c 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -11,15 +11,13 @@
 #undef printf
 #undef fprintf
 #undef fputs
-/* TODO: write */
+#undef write
 
 /*
  ANSI codes used by git: m, K
 
  This file is git-specific. Therefore, this file does not attempt
  to implement any codes that are not used by git.
-
- TODO: K
 */
 
 static HANDLE console;
@@ -79,6 +77,20 @@ static void set_console_attr(void)
 	SetConsoleTextAttribute(console, attributes);
 }
 
+static void erase_in_line(void)
+{
+	CONSOLE_SCREEN_BUFFER_INFO sbi;
+
+	if (!console)
+		return;
+
+	GetConsoleScreenBufferInfo(console, &sbi);
+	FillConsoleOutputCharacterA(console, ' ',
+		sbi.dwSize.X - sbi.dwCursorPosition.X, sbi.dwCursorPosition,
+		NULL);
+}
+
+
 static const char *set_attr(const char *str)
 {
 	const char *func;
@@ -218,7 +230,7 @@ static const char *set_attr(const char *str)
 		set_console_attr();
 		break;
 	case 'K':
-		/* TODO */
+		erase_in_line();
 		break;
 	default:
 		/* Unsupported code */
@@ -228,13 +240,16 @@ static const char *set_attr(const char *str)
 	return func + 1;
 }
 
-static int ansi_emulate(const char *str, FILE *stream)
+static int ansi_emulate(const char *str, ssize_t len, FILE *stream)
 {
 	int rv = 0;
 	const char *pos = str;
 
-	while (*pos) {
-		pos = strstr(str, "\033[");
+	if (len < 0)
+		len = strlen(str);
+
+	while (rv < len) {
+		pos = memmem(str, len - rv, "\033[", 2);
 		if (pos) {
 			size_t len = pos - str;
 
@@ -254,10 +269,11 @@ static int ansi_emulate(const char *str, FILE *stream)
 			rv += pos - str;
 			str = pos;
 		} else {
-			rv += strlen(str);
-			fputs(str, stream);
-			return rv;
+			fwrite(str, len - rv, 1, stream);
+			return len;
 		}
+		if (rv > len)
+			die ("Invalid use of ESC [ sequence detected");
 	}
 	return rv;
 }
@@ -274,7 +290,7 @@ int winansi_fputs(const char *str, FILE *stream)
 	if (!console)
 		return fputs(str, stream);
 
-	rv = ansi_emulate(str, stream);
+	rv = ansi_emulate(str, -1, stream);
 
 	if (rv >= 0)
 		return 0;
@@ -309,7 +325,7 @@ static int winansi_vfprintf(FILE *stream, const char *format, va_list list)
 		len = vsnprintf(buf, len + 1, format, list);
 	}
 
-	rv = ansi_emulate(buf, stream);
+	rv = ansi_emulate(buf, -1, stream);
 
 	if (buf != small_buf)
 		free(buf);
@@ -343,3 +359,14 @@ int winansi_printf(const char *format, ...)
 
 	return rv;
 }
+
+int winansi_write(int fd, const void *buf, size_t len)
+{
+	if (isatty(fd)) {
+		init();
+		if (console)
+			return ansi_emulate((const char *)buf, len,
+					fd == 2 ? stderr : stdout);
+	}
+	return write(fd, buf, len);
+}
-- 
1.6.2.240.g23c7
