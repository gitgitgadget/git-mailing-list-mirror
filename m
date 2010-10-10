From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 15:20:42 +0200
Message-ID: <1286716854-5744-3-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:21:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vqa-0004eR-Hx
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab0JJNVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:21:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab0JJNVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:21:37 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bVBSkwX2tCO4Qo+ycN7YZszr2NhQSuto+8Ez0BLsJ+4=;
        b=h/YKg+nEXVqHukXcoiDG1ESLj5Ol5E6fXUVLQgw6VjIUANRncZACWtOE5OY+YGaW+y
         fvDim+L4ZHpz02BuZj8Uv//MlFInLFp14YJMalApfKKjyt4mKjDdKTPeX9qecIIqDZfP
         cNWZ1YuFLkuxf+TI06TOtwCD2K/XG/AJt72y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jin4P6JRYYv2vvIb3DbbrjKgfvvOCJo1W4BhVfQ2ahtCPcgSDccATH+gPStAZxd+O+
         0DEzs76KdjSI46hhN56ZKWc2bsB4/tL1yvxoF7S82zi3BX87kO67VO5BDWCJVog6Rbrt
         iDTlvF/qS5arNz52gxWb2LujrRosMjLqJdV6Q=
Received: by 10.213.28.205 with SMTP id n13mr1246255ebc.5.1286716896974;
        Sun, 10 Oct 2010 06:21:36 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v59sm9037775eeh.22.2010.10.10.06.21.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:21:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158662>

From: Mike Pape <dotzenlabs@gmail.com>

Syslog does not usually exist on Windows, so we implement our own
using Window's ReportEvent mechanism.

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.c    |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h    |   15 +++++++++++++
 daemon.c          |    2 -
 git-compat-util.h |    1 +
 4 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 563ef1f..cc5eb2c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1431,6 +1431,66 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 	return 0;
 }
 
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
+void syslog(int priority, const char *fmt, const char *arg)
+{
+	WORD logtype;
+
+	if (!ms_eventlog)
+		return;
+
+	if (strcmp(fmt, "%s")) {
+		warning("format string of syslog() not implemented");
+		return;
+	}
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
+	/*
+	 * ReportEvent() doesn't handle strings containing %n, where n is
+	 * an integer. Such events must be reformatted by the caller.
+	 */
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
index a5bde82..bbfcc0c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -51,6 +51,19 @@ typedef int socklen_t;
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
@@ -185,6 +198,8 @@ struct passwd *getpwuid(uid_t uid);
 int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
+void openlog(const char *ident, int logopt, int facility);
+void syslog(int priority, const char *fmt, const char *arg);
 
 /*
  * replacements of existing functions
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
index 2af8d3e..8770854 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -119,6 +119,7 @@
 #include <netdb.h>
 #include <pwd.h>
 #include <inttypes.h>
+#include <syslog.h>
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
-- 
1.7.3.1.51.ge462f.dirty
