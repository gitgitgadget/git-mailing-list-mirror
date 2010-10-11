From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 02/15] mingw: implement syslog
Date: Mon, 11 Oct 2010 23:50:16 +0200
Message-ID: <1286833829-5116-3-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com, Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QHJ-0005xW-GD
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab0JKVvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:51:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab0JKVvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:51:21 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QD004p3A66S4fsQLRAf4AJdAcgDmk4MtqPgN0YljaEs=;
        b=JaoJ8abYLtQfFj0+0Lk1mFsGKPLMg0IZk1/bVJzXMH5O5csoCdln9MzPg0vL/TWS+7
         GFFds+vL3HJZo6Cj3c3z8okont0zStImVd85LDX5/EWkvE2p6mnxtAy+XNUcMA3L1u03
         HzosJFDxnHXOejYrN5BVD/5uJ+RhWFFGzjxVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lpcEu8lv4f6EjdiJ6tiW0Y3e+63p2R3OT6KfeJbi7yix+zWQlBqCSMfKW/YElCGaSA
         InmW8uEsnFVDqjJbkvZkTdeJXmHHzTkaz+vWn97rgs3QGPXCaSkA195XmX9GfxVNVVAP
         JuVAhYxgrt1j2bB5xnP3RHmU7ix4fzUVrpFPE=
Received: by 10.213.14.67 with SMTP id f3mr3556227eba.28.1286833881161;
        Mon, 11 Oct 2010 14:51:21 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm1574171eeh.5.2010.10.11.14.51.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:51:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158794>

From: Mike Pape <dotzenlabs@gmail.com>

Syslog does not usually exist on Windows, so we implement our own
using Window's ReportEvent mechanism.

Strings containing "%1" gets corrupted by ReportEvent, so expand
"%1" to "% 1" before reporting.

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
index d6e20c6..d594375 100644
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
1.7.3.1.199.g72340
