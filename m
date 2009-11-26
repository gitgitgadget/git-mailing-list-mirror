From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 03/11] mingw: implement syslog
Date: Thu, 26 Nov 2009 00:44:12 +0000
Message-ID: <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTM-00014J-LK
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759934AbZKZAoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759903AbZKZAoX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:23 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:46652 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759902AbZKZAoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:22 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so298499ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qZcXaeRljEHZOT24o9XvOSmKRv7RsKkbgYMSj4a9fI0=;
        b=uR+xt0K9lYA3hwfH0twWNCRAjxzsc3hcfG0Ufwwy7ECSpV45NGSpRLCLU0gyjcRGYO
         wqRgzbY51T5Idgm+CU+ZLb1dAMIct7a8Hi9P6hNQXSv2vPWqnraabOTK9ZRDTjZB6RrB
         7pEfVYtifkSu6K/9zHVawt/k2kKgayyGZcMaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K4nkgsHrnrDdPolrDrbTigB7qZk7LnbFk6ey2eYYm4fYJJnlHjB/pO1C/r4fDMtB+H
         Q5+Yin9MrcRBqwX2Md42+lZvrjpDizEw8h5aKzYhaq8RTWb9CG1LB6cJNW3nOqghIlFQ
         xqS9gWw2xPW8shQLRMCUX6VrjCmmLQINg3A5U=
Received: by 10.213.24.9 with SMTP id t9mr8718667ebb.4.1259196268014;
        Wed, 25 Nov 2009 16:44:28 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm392178eyg.12.2009.11.25.16.44.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:27 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133735>

From: Mike Pape <dotzenlabs@gmail.com>

Syslog does not usually exist on Windows, so we implement our own
using Window's ReportEvent mechanism.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c    |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h    |   15 +++++++++++++++
 daemon.c          |    2 --
 git-compat-util.h |    1 +
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 458021b..68116ac 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1255,6 +1255,57 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 	return 0;
 }
 
+static HANDLE ms_eventlog;
+
+void openlog(const char *ident, int logopt, int facility) {
+	if (ms_eventlog)
+		return;
+	ms_eventlog = RegisterEventSourceA(NULL, ident);
+}
+
+void syslog(int priority, const char *fmt, ...) {
+	struct strbuf msg;
+	va_list va;
+	WORD logtype;
+
+	strbuf_init(&msg, 0);
+	va_start(va, fmt);
+	strbuf_vaddf(&msg, fmt, va);
+	va_end(va);
+
+	switch (priority) {
+		case LOG_EMERG:
+		case LOG_ALERT:
+		case LOG_CRIT:
+		case LOG_ERR:
+			logtype = EVENTLOG_ERROR_TYPE;
+			break;
+
+		case LOG_WARNING:
+			logtype = EVENTLOG_WARNING_TYPE;
+			break;
+
+		case LOG_NOTICE:
+		case LOG_INFO:
+		case LOG_DEBUG:
+		default:
+			logtype = EVENTLOG_INFORMATION_TYPE;
+			break;
+	}
+
+	ReportEventA(ms_eventlog,
+	    logtype,
+	    (WORD)NULL,
+	    (DWORD)NULL,
+	    NULL,
+	    1,
+	    0,
+	    (const char **)&msg.buf,
+	    NULL);
+
+	strbuf_release(&msg);
+}
+
 #undef signal
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index f362f61..576b1a1 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -37,6 +37,19 @@ typedef int socklen_t;
 #define EAFNOSUPPORT WSAEAFNOSUPPORT
 #define ECONNABORTED WSAECONNABORTED
 
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
 struct passwd {
 	char *pw_name;
 	char *pw_gecos;
@@ -157,6 +170,8 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
 int symlink(const char *oldpath, const char *newpath);
 int readlink(const char *path, char *buf, size_t bufsiz);
+void openlog(const char *ident, int logopt, int facility);
+void syslog(int priority, const char *fmt, ...);
 
 /*
  * replacements of existing functions
diff --git a/daemon.c b/daemon.c
index 1b5ada6..07d7356 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,8 +4,6 @@
 #include "run-command.h"
 #include "strbuf.h"
 
-#include <syslog.h>
-
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index ef60803..33a8e33 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -105,6 +105,7 @@
 #include <netdb.h>
 #include <pwd.h>
 #include <inttypes.h>
+#include <syslog.h>
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
-- 
1.6.5.rc2.7.g4f8d3
