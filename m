From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/6] Make report() from usage.c public as vreportf() and use it.
Date: Sat,  6 Mar 2010 16:40:39 +0100
Message-ID: <dd91671bd5bb1a60a314e71a265ba0068080a47e.1267889703.git.j6t@kdbg.org>
References: <cover.1267889703.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15s-0004YU-JI
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab0CFPmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:42:46 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47681 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751287Ab0CFPmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:42:42 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1D514CDF8C;
	Sat,  6 Mar 2010 16:42:41 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 47B5619F703;
	Sat,  6 Mar 2010 16:41:00 +0100 (CET)
X-Mailer: git-send-email 1.7.0.rc2.65.g7b13a
In-Reply-To: <cover.1267889703.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There exist already a number of static functions named 'report', therefore,
the function name was changed.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 fast-import.c     |    8 +++-----
 git-compat-util.h |    1 +
 http-backend.c    |    5 +----
 usage.c           |   10 +++++-----
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 74f08bd..5bb3d41 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -483,14 +483,12 @@ static void dump_marks(void);
 static NORETURN void die_nicely(const char *err, va_list params)
 {
 	static int zombie;
-	char message[2 * PATH_MAX];
 
-	vsnprintf(message, sizeof(message), err, params);
-	fputs("fatal: ", stderr);
-	fputs(message, stderr);
-	fputc('\n', stderr);
+	vreportf("fatal: ", err, params);
 
 	if (!zombie) {
+		char message[2 * PATH_MAX];
+
 		zombie = 1;
 		write_crash_report(message);
 		end_packfile();
diff --git a/git-compat-util.h b/git-compat-util.h
index a3c4537..3cabcdd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -192,6 +192,7 @@ extern char *gitbasename(char *);
 #include "compat/bswap.h"
 
 /* General helper functions */
+extern void vreportf(const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/http-backend.c b/http-backend.c
index 345c12b..8c7b7d0 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -538,14 +538,11 @@ static void service_rpc(char *service_name)
 
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
-	char buffer[1000];
-
 	http_status(500, "Internal Server Error");
 	hdr_nocache();
 	end_headers();
 
-	vsnprintf(buffer, sizeof(buffer), err, params);
-	fprintf(stderr, "fatal: %s\n", buffer);
+	vreportf("fatal: ", err, params);
 	exit(0);
 }
 
diff --git a/usage.c b/usage.c
index 79856a2..ec4cf53 100644
--- a/usage.c
+++ b/usage.c
@@ -5,7 +5,7 @@
  */
 #include "git-compat-util.h"
 
-static void report(const char *prefix, const char *err, va_list params)
+void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	vsnprintf(msg, sizeof(msg), err, params);
@@ -14,24 +14,24 @@ static void report(const char *prefix, const char *err, va_list params)
 
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	report("usage: ", err, params);
+	vreportf("usage: ", err, params);
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	report("fatal: ", err, params);
+	vreportf("fatal: ", err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
-	report("error: ", err, params);
+	vreportf("error: ", err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	report("warning: ", warn, params);
+	vreportf("warning: ", warn, params);
 }
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
-- 
1.7.0.rc2.65.g7b13a
