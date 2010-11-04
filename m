From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 02/16] mingw: implement syslog
Date: Thu,  4 Nov 2010 02:35:10 +0100
Message-ID: <1288834524-2400-3-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDok0-00013V-KJ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab0KDBfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56990 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0KDBfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:31 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so722316eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Uc8TJ2HbUD1pB7OnVuwhKXSB5jughU73mUjR/J6VUww=;
        b=ZWeIX0FKaHwz12p2vI9nwBEcTGjym3OqeJXm+p5foTXlY52YtjE71xPU4llVnpaLM1
         AFHa8nZi8l8hXHOEknoJoUmbnDeE4PpX8YXMhIEXuRpC4Md1I47LmjGysL5Sg5fVZaR7
         MspErdacoCML4/lulrnjdWGy9BR9tZjI+cZ9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LBeYHc8rAPMHKhmBGiWLz9THYshvKE7NZ9Vw8usefIvo5KQQPCggmPHoUg3KnCS1dG
         o0WfzPo3DGSvxlBHR1DNlYtkqVM4cKTX/VHDyXVhlWyIUpKzG2My1ADFlHU9SvUVxFd+
         SNYsHrJjT+lZdPvh9oNkexNAF2bRcUYfzYChs=
Received: by 10.213.14.70 with SMTP id f6mr169234eba.7.1288834530785;
        Wed, 03 Nov 2010 18:35:30 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v51sm7206790eeh.22.2010.11.03.18.35.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160666>

From: Mike Pape <dotzenlabs@gmail.com>

Syslog does not usually exist on Windows, so implement our own using
Window's ReportEvent mechanism.

Strings containing "%1" gets expanded into them selves by ReportEvent,
resulting in an unreadable string. "%2" and above is not a problem.
Unfortunately, on Windows an IPv6 address can contain "%1", so expand
"%1" to "% 1" before reporting. "%%1" is also a problem for ReportEvent,
but that string cannot occur in an IPv6 address.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile              |    5 ++-
 compat/win32/syslog.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/syslog.h |   20 +++++++++++++
 daemon.c              |    2 -
 git-compat-util.h     |    1 +
 5 files changed, 96 insertions(+), 4 deletions(-)
 create mode 100644 compat/win32/syslog.c
 create mode 100644 compat/win32/syslog.h

diff --git a/Makefile b/Makefile
index 1f1ce04..d9d9419 100644
--- a/Makefile
+++ b/Makefile
@@ -496,6 +496,7 @@ LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
 LIB_H += compat/win32/pthread.h
+LIB_H += compat/win32/syslog.h
 LIB_H += csum-file.h
 LIB_H += decorate.h
 LIB_H += delta.h
@@ -1081,7 +1082,7 @@ ifeq ($(uname_S),Windows)
 	AR = compat/vcbuild/scripts/lib.pl
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o compat/win32/pthread.o compat/win32/syslog.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1131,7 +1132,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
-		compat/win32/pthread.o
+		compat/win32/pthread.o compat/win32/syslog.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
new file mode 100644
index 0000000..42b95a9
--- /dev/null
+++ b/compat/win32/syslog.c
@@ -0,0 +1,72 @@
+#include "../../git-compat-util.h"
+#include "../../strbuf.h"
+
+static HANDLE ms_eventlog;
+
+void openlog(const char *ident, int logopt, int facility)
+{
+	if (ms_eventlog)
+		return;
+
+	ms_eventlog = RegisterEventSourceA(NULL, ident);
+
+	if (!ms_eventlog)
+		warning("RegisterEventSource() failed: %lu", GetLastError());
+}
+
+void syslog(int priority, const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf_expand_dict_entry dict[] = {
+		{"1", "% 1"},
+		{NULL, NULL}
+	};
+	WORD logtype;
+	char *str;
+	int str_len;
+	va_list ap;
+
+	if (!ms_eventlog)
+		return;
+
+	va_start(ap, fmt);
+	str_len = vsnprintf(NULL, 0, fmt, ap);
+	va_end(ap);
+
+	if (str_len < 0) {
+		warning("vsnprintf failed: '%s'", strerror(errno));
+		return;
+	}
+
+	str = malloc(str_len + 1);
+	va_start(ap, fmt);
+	vsnprintf(str, str_len + 1, fmt, ap);
+	va_end(ap);
+	strbuf_expand(&sb, str, strbuf_expand_dict_cb, &dict);
+	free(str);
+
+	switch (priority) {
+	case LOG_EMERG:
+	case LOG_ALERT:
+	case LOG_CRIT:
+	case LOG_ERR:
+		logtype = EVENTLOG_ERROR_TYPE;
+		break;
+
+	case LOG_WARNING:
+		logtype = EVENTLOG_WARNING_TYPE;
+		break;
+
+	case LOG_NOTICE:
+	case LOG_INFO:
+	case LOG_DEBUG:
+	default:
+		logtype = EVENTLOG_INFORMATION_TYPE;
+		break;
+	}
+
+	ReportEventA(ms_eventlog, logtype, 0, 0, NULL, 1, 0,
+	    (const char **)&sb.buf, NULL);
+
+	strbuf_release(&sb);
+}
diff --git a/compat/win32/syslog.h b/compat/win32/syslog.h
new file mode 100644
index 0000000..70daa7c
--- /dev/null
+++ b/compat/win32/syslog.h
@@ -0,0 +1,20 @@
+#ifndef SYSLOG_H
+#define SYSLOG_H
+
+#define LOG_PID     0x01
+
+#define LOG_EMERG   0
+#define LOG_ALERT   1
+#define LOG_CRIT    2
+#define LOG_ERR     3
+#define LOG_WARNING 4
+#define LOG_NOTICE  5
+#define LOG_INFO    6
+#define LOG_DEBUG   7
+
+#define LOG_DAEMON  (3<<3)
+
+void openlog(const char *ident, int logopt, int facility);
+void syslog(int priority, const char *fmt, ...);
+
+#endif /* SYSLOG_H */
diff --git a/daemon.c b/daemon.c
index 7ccd097..535ae88 100644
--- a/daemon.c
+++ b/daemon.c
@@ -5,8 +5,6 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-#include <syslog.h>
-
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..e192831 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -104,6 +104,7 @@
 #include <assert.h>
 #include <regex.h>
 #include <utime.h>
+#include <syslog.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
 #include <sys/poll.h>
-- 
1.7.3.2.162.g09d37
