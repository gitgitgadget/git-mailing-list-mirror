From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Add ANSI control code emulation for the Windows console
Date: Fri, 18 Jul 2008 09:34:44 +0200
Message-ID: <1216366485-12201-4-git-send-email-johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Peter Harris <git@peter.is-a-geek.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 09:36:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJkVW-0003a0-6G
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 09:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbYGRHe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 03:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbYGRHe5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 03:34:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48429 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYGRHet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 03:34:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KJkUI-0004B3-KS; Fri, 18 Jul 2008 09:34:47 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 68492FF4F; Fri, 18 Jul 2008 09:34:46 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 19E2DFA48; Fri, 18 Jul 2008 09:34:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.275.g0a3e0f
In-Reply-To: <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89002>

From: Peter Harris <git@peter.is-a-geek.org>

This adds only the minimum necessary to keep git pull/merge's diffstat from
wrapping. Notably absent is support for the K (erase) operation, and support
for POSIX write.

Signed-off-by: Peter Harris <git@peter.is-a-geek.org>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile         |    2 +-
 compat/mingw.h   |   11 ++
 compat/winansi.c |  345 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+), 1 deletions(-)
 create mode 100644 compat/winansi.c

diff --git a/Makefile b/Makefile
index 78e08d3..2c6cc9d 100644
--- a/Makefile
+++ b/Makefile
@@ -740,7 +740,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
 	template_dir = ../share/git-core/templates/
diff --git a/compat/mingw.h b/compat/mingw.h
index 6bc049a..5f11114 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -194,6 +194,17 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define signal mingw_signal
 
 /*
+ * ANSI emulation wrappers
+ */
+
+int winansi_fputs(const char *str, FILE *stream);
+int winansi_printf(const char *format, ...) __attribute__((format (printf, 1, 2)));
+int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format (printf, 2, 3)));
+#define fputs winansi_fputs
+#define printf(...) winansi_printf(__VA_ARGS__)
+#define fprintf(...) winansi_fprintf(__VA_ARGS__)
+
+/*
  * git specific compatibility
  */
 
diff --git a/compat/winansi.c b/compat/winansi.c
new file mode 100644
index 0000000..e2d96df
--- /dev/null
+++ b/compat/winansi.c
@@ -0,0 +1,345 @@
+/*
+ * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
+ */
+
+#include <windows.h>
+#include "../git-compat-util.h"
+
+/*
+ Functions to be wrapped:
+*/
+#undef printf
+#undef fprintf
+#undef fputs
+/* TODO: write */
+
+/*
+ ANSI codes used by git: m, K
+
+ This file is git-specific. Therefore, this file does not attempt
+ to implement any codes that are not used by git.
+
+ TODO: K
+*/
+
+static HANDLE console;
+static WORD plain_attr;
+static WORD attr;
+static int negative;
+
+static void init(void)
+{
+	CONSOLE_SCREEN_BUFFER_INFO sbi;
+
+	static int initialized = 0;
+	if (initialized)
+		return;
+
+	console = GetStdHandle(STD_OUTPUT_HANDLE);
+	if (console == INVALID_HANDLE_VALUE)
+		console = NULL;
+
+	if (!console)
+		return;
+
+	GetConsoleScreenBufferInfo(console, &sbi);
+	attr = plain_attr = sbi.wAttributes;
+	negative = 0;
+
+	initialized = 1;
+}
+
+
+#define FOREGROUND_ALL (FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE)
+#define BACKGROUND_ALL (BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_BLUE)
+
+static void set_console_attr(void)
+{
+	WORD attributes = attr;
+	if (negative) {
+		attributes &= ~FOREGROUND_ALL;
+		attributes &= ~BACKGROUND_ALL;
+
+		/* This could probably use a bitmask
+		   instead of a series of ifs */
+		if (attr & FOREGROUND_RED)
+			attributes |= BACKGROUND_RED;
+		if (attr & FOREGROUND_GREEN)
+			attributes |= BACKGROUND_GREEN;
+		if (attr & FOREGROUND_BLUE)
+			attributes |= BACKGROUND_BLUE;
+
+		if (attr & BACKGROUND_RED)
+			attributes |= FOREGROUND_RED;
+		if (attr & BACKGROUND_GREEN)
+			attributes |= FOREGROUND_GREEN;
+		if (attr & BACKGROUND_BLUE)
+			attributes |= FOREGROUND_BLUE;
+	}
+	SetConsoleTextAttribute(console, attributes);
+}
+
+static const char *set_attr(const char *str)
+{
+	const char *func;
+	size_t len = strspn(str, "0123456789;");
+	func = str + len;
+
+	switch (*func) {
+	case 'm':
+		do {
+			long val = strtol(str, (char **)&str, 10);
+			switch (val) {
+			case 0: /* reset */
+				attr = plain_attr;
+				negative = 0;
+				break;
+			case 1: /* bold */
+				attr |= FOREGROUND_INTENSITY;
+				break;
+			case 2:  /* faint */
+			case 22: /* normal */
+				attr &= ~FOREGROUND_INTENSITY;
+				break;
+			case 3:  /* italic */
+				/* Unsupported */
+				break;
+			case 4:  /* underline */
+			case 21: /* double underline */
+				/* Wikipedia says this flag does nothing */
+				/* Furthermore, mingw doesn't define this flag
+				attr |= COMMON_LVB_UNDERSCORE; */
+				break;
+			case 24: /* no underline */
+				/* attr &= ~COMMON_LVB_UNDERSCORE; */
+				break;
+			case 5:  /* slow blink */
+			case 6:  /* fast blink */
+				/* We don't have blink, but we do have
+				   background intensity */
+				attr |= BACKGROUND_INTENSITY;
+				break;
+			case 25: /* no blink */
+				attr &= ~BACKGROUND_INTENSITY;
+				break;
+			case 7:  /* negative */
+				negative = 1;
+				break;
+			case 27: /* positive */
+				negative = 0;
+				break;
+			case 8:  /* conceal */
+			case 28: /* reveal */
+				/* Unsupported */
+				break;
+			case 30: /* Black */
+				attr &= ~FOREGROUND_ALL;
+				break;
+			case 31: /* Red */
+				attr &= ~FOREGROUND_ALL;
+				attr |= FOREGROUND_RED;
+				break;
+			case 32: /* Green */
+				attr &= ~FOREGROUND_ALL;
+				attr |= FOREGROUND_GREEN;
+				break;
+			case 33: /* Yellow */
+				attr &= ~FOREGROUND_ALL;
+				attr |= FOREGROUND_RED | FOREGROUND_GREEN;
+				break;
+			case 34: /* Blue */
+				attr &= ~FOREGROUND_ALL;
+				attr |= FOREGROUND_BLUE;
+				break;
+			case 35: /* Magenta */
+				attr &= ~FOREGROUND_ALL;
+				attr |= FOREGROUND_RED | FOREGROUND_BLUE;
+				break;
+			case 36: /* Cyan */
+				attr &= ~FOREGROUND_ALL;
+				attr |= FOREGROUND_GREEN | FOREGROUND_BLUE;
+				break;
+			case 37: /* White */
+				attr |= FOREGROUND_RED |
+					FOREGROUND_GREEN |
+					FOREGROUND_BLUE;
+				break;
+			case 38: /* Unknown */
+				break;
+			case 39: /* reset */
+				attr &= ~FOREGROUND_ALL;
+				attr |= (plain_attr & FOREGROUND_ALL);
+				break;
+			case 40: /* Black */
+				attr &= ~BACKGROUND_ALL;
+				break;
+			case 41: /* Red */
+				attr &= ~BACKGROUND_ALL;
+				attr |= BACKGROUND_RED;
+				break;
+			case 42: /* Green */
+				attr &= ~BACKGROUND_ALL;
+				attr |= BACKGROUND_GREEN;
+				break;
+			case 43: /* Yellow */
+				attr &= ~BACKGROUND_ALL;
+				attr |= BACKGROUND_RED | BACKGROUND_GREEN;
+				break;
+			case 44: /* Blue */
+				attr &= ~BACKGROUND_ALL;
+				attr |= BACKGROUND_BLUE;
+				break;
+			case 45: /* Magenta */
+				attr &= ~BACKGROUND_ALL;
+				attr |= BACKGROUND_RED | BACKGROUND_BLUE;
+				break;
+			case 46: /* Cyan */
+				attr &= ~BACKGROUND_ALL;
+				attr |= BACKGROUND_GREEN | BACKGROUND_BLUE;
+				break;
+			case 47: /* White */
+				attr |= BACKGROUND_RED |
+					BACKGROUND_GREEN |
+					BACKGROUND_BLUE;
+				break;
+			case 48: /* Unknown */
+				break;
+			case 49: /* reset */
+				attr &= ~BACKGROUND_ALL;
+				attr |= (plain_attr & BACKGROUND_ALL);
+				break;
+			default:
+				/* Unsupported code */
+				break;
+			}
+			str++;
+		} while (*(str-1) == ';');
+
+		set_console_attr();
+		break;
+	case 'K':
+		/* TODO */
+		break;
+	default:
+		/* Unsupported code */
+		break;
+	}
+
+	return func + 1;
+}
+
+static int ansi_emulate(const char *str, FILE *stream)
+{
+	int rv = 0;
+	const char *pos = str;
+
+	while (*pos) {
+		pos = strstr(str, "\033[");
+		if (pos) {
+			size_t len = pos - str;
+
+			if (len) {
+				size_t out_len = fwrite(str, 1, len, stream);
+				rv += out_len;
+				if (out_len < len)
+					return rv;
+			}
+
+			str = pos + 2;
+			rv += 2;
+
+			fflush(stream);
+
+			pos = set_attr(str);
+			rv += pos - str;
+			str = pos;
+		} else {
+			rv += strlen(str);
+			fputs(str, stream);
+			return rv;
+		}
+	}
+	return rv;
+}
+
+int winansi_fputs(const char *str, FILE *stream)
+{
+	int rv;
+
+	if (!isatty(fileno(stream)))
+		return fputs(str, stream);
+
+	init();
+
+	if (!console)
+		return fputs(str, stream);
+
+	rv = ansi_emulate(str, stream);
+
+	if (rv >= 0)
+		return 0;
+	else
+		return EOF;
+}
+
+static int winansi_vfprintf(FILE *stream, const char *format, va_list list)
+{
+	int len, rv;
+	char small_buf[256];
+	char *buf = small_buf;
+	va_list cp;
+
+	if (!isatty(fileno(stream)))
+		goto abort;
+
+	init();
+
+	if (!console)
+		goto abort;
+
+	va_copy(cp, list);
+	len = vsnprintf(small_buf, sizeof(small_buf), format, cp);
+	va_end(cp);
+
+	if (len > sizeof(small_buf) - 1) {
+		buf = malloc(len + 1);
+		if (!buf)
+			goto abort;
+
+		len = vsnprintf(buf, len + 1, format, list);
+	}
+
+	rv = ansi_emulate(buf, stream);
+
+	if (buf != small_buf)
+		free(buf);
+	return rv;
+
+abort:
+	rv = vfprintf(stream, format, list);
+	return rv;
+}
+
+int winansi_fprintf(FILE *stream, const char *format, ...)
+{
+	va_list list;
+	int rv;
+
+	va_start(list, format);
+	rv = winansi_vfprintf(stream, format, list);
+	va_end(list);
+
+	return rv;
+}
+
+int winansi_printf(const char *format, ...)
+{
+	va_list list;
+	int rv;
+
+	va_start(list, format);
+	rv = winansi_vfprintf(stdout, format, list);
+	va_end(list);
+
+	return rv;
+}
-- 
1.5.6.1.275.g0a3e0f
