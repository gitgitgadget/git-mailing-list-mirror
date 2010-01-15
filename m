From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 02/14] mingw: implement syslog
Date: Fri, 15 Jan 2010 22:30:21 +0100
Message-ID: <1263591033-4992-3-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlK-0005cC-Lc
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758359Ab0AOVbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361Ab0AOVbI
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:08 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42825 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358Ab0AOVbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:05 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so568991ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tUb6I3IBklUY8ZgMomAxYuNiCwi3wHSdbNXNDDVXjKc=;
        b=JrIQMfwtz0bEUDbdCfvWpXsQ+63+Q+DAkXGlTgp34miXJwRrJEZOYC0J0cURcLrcFV
         aMuggP+PhTShhomPRA4M9d0MEVqw2ENmSykKwcqQh0i2U1fe0BbAeG28ADbneGDRqEBi
         Jft9hmc1znrTSoKw1y5+x9a/OBzFJoU9I3ncE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=d5oT0VCWVa5o1OsU6PDPMKQqbPLmuN4mop2IDuyXgeBuOPsH/9r7U5rDwrKet/axX/
         RwEpVmNPneNjbH4PkoODhF3xRCaCeCA7H+cIeLNA82LAMexbO9rLSKo6I3uxpANxaBFK
         ab7T5MqYNg7UO48TJuWf0o6VHM8ylP5WyIUns=
Received: by 10.213.39.129 with SMTP id g1mr2938518ebe.36.1263591061963;
        Fri, 15 Jan 2010 13:31:01 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 13sm1806393ewy.13.2010.01.15.13.31.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:01 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137123>

From: Mike Pape <dotzenlabs@gmail.com>

Syslog does not usually exist on Windows, so we implement our own
using Window's ReportEvent mechanism.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c    |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h    |   15 +++++++++++++++
 daemon.c          |    2 --
 git-compat-util.h |    1 +
 4 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 42ef9e2..54be905 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1351,6 +1351,55 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 	return 0;
 }
 
+static HANDLE ms_eventlog;
+
+void openlog(const char *ident, int logopt, int facility)
+{
+	if (ms_eventlog)
+		return;
+	ms_eventlog = RegisterEventSourceA(NULL, ident);
+}
+
+void syslog(int priority, const char *fmt, const char *arg)
+{
+	WORD logtype;
+
+	if (strcmp(fmt, "%s")) {
+		warning("format string of syslog() not implemented");
+		return;
+	}
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
+	    0,
+	    0,
+	    NULL,
+	    1,
+	    0,
+	    (const char **)&arg,
+	    NULL);
+}
+
 #undef signal
 sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 07513bb..d934e56 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -38,6 +38,19 @@ typedef int socklen_t;
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
@@ -166,6 +179,8 @@ struct passwd *getpwuid(int uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
+void openlog(const char *ident, int logopt, int facility);
+void syslog(int priority, const char *fmt, const char *arg);
 
 /*
  * replacements of existing functions
diff --git a/daemon.c b/daemon.c
index 918e560..79ba1aa 100644
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
index 5c59687..30e6240 100644
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
1.6.6.211.g26720
