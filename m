From: Luke Dashjr <luke-jr+git@utopios.org>
Subject: [PATCH 4/5] implement error_errno and warning_errno
Date: Wed, 12 Aug 2009 22:20:23 -0500
Message-ID: <1250133624-2272-4-git-send-email-luke-jr+git@utopios.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-3-git-send-email-luke-jr+git@utopios.org>
Cc: Luke Dashjr <luke-jr+git@utopios.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 05:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQsL-0007QD-5V
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbZHMDUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 23:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbZHMDUn
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:20:43 -0400
Received: from unused ([66.216.20.21]:45443 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbZHMDUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 23:20:42 -0400
Received: from tsuruki (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	by zinan.dashjr.org (Postfix) with SMTP id 64A69B9DB7C;
	Thu, 13 Aug 2009 03:20:42 +0000 (UTC)
Received: by tsuruki (sSMTP sendmail emulation); Wed, 12 Aug 2009 22:20:42 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1250133624-2272-3-git-send-email-luke-jr+git@utopios.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125770>

This allows for easier conversion of code that currently does a (fatal)
die_errno to a safer error (which can be ignored), or perhaps even warning
status.

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 git-compat-util.h |    2 +
 usage.c           |   66 ++++++++++++++++++++++++-----------------------------
 2 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 9f941e4..25d4c1e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -181,7 +181,9 @@ extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern void die_errno(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+extern void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
 
diff --git a/usage.c b/usage.c
index b6aea45..dce90dc 100644
--- a/usage.c
+++ b/usage.c
@@ -39,7 +39,7 @@ static void warn_builtin(const char *warn, va_list params)
 static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
 static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
-static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
+static void (*warning_routine)(const char *err, va_list params) = warn_builtin;
 
 void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN)
 {
@@ -51,19 +51,8 @@ void usage(const char *err)
 	usage_routine(err);
 }
 
-void die(const char *err, ...)
+static void _e_errno(const char *fmt, char *fmt_with_err, size_t sizeof_fmt_with_err)
 {
-	va_list params;
-
-	va_start(params, err);
-	die_routine(err, params);
-	va_end(params);
-}
-
-void die_errno(const char *fmt, ...)
-{
-	va_list params;
-	char fmt_with_err[1024];
 	char str_error[256], *err;
 	int i, j;
 
@@ -81,28 +70,33 @@ void die_errno(const char *fmt, ...)
 		}
 	}
 	str_error[j] = 0;
-	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error);
-
-	va_start(params, fmt);
-	die_routine(fmt_with_err, params);
-	va_end(params);
-}
-
-int error(const char *err, ...)
-{
-	va_list params;
-
-	va_start(params, err);
-	error_routine(err, params);
-	va_end(params);
-	return -1;
+	snprintf(fmt_with_err, sizeof_fmt_with_err, "%s: %s", fmt, str_error);
 }
 
-void warning(const char *warn, ...)
-{
-	va_list params;
-
-	va_start(params, warn);
-	warn_routine(warn, params);
-	va_end(params);
-}
+#define BUILD_E(RTYPE, NAME, CODE)  \
+RTYPE NAME(const char *err, ...)  \
+{  \
+	va_list params;  \
+  \
+	va_start(params, err);  \
+	NAME ## _routine(err, params);  \
+	va_end(params);  \
+	CODE  \
+}  \
+  \
+RTYPE NAME ## _errno(const char *fmt, ...)  \
+{  \
+	va_list params;  \
+	static char fmt_with_err[1024];  \
+  \
+	va_start(params, fmt);  \
+	_e_errno(fmt, fmt_with_err, sizeof(fmt_with_err));  \
+	NAME ## _routine(fmt_with_err, params);  \
+	va_end(params);  \
+	CODE  \
+}  \
+// END OF BUILD_E MACRO
+
+BUILD_E(void, die, )
+BUILD_E(int, error, return -1;)
+BUILD_E(void, warning, )
-- 
1.6.3.3
