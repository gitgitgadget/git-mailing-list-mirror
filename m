From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 05/12] Customizable error handlers
Date: Sat, 24 Jun 2006 04:34:38 +0200
Message-ID: <20060624023438.32751.46867.stgit@machine.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 24 04:35:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtxzS-0006hJ-27
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 04:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbWFXCfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 22:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933195AbWFXCfM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 22:35:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61591 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S933194AbWFXCfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 22:35:09 -0400
Received: (qmail 333 invoked from network); 24 Jun 2006 04:34:38 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 24 Jun 2006 04:34:38 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060624023429.32751.80619.stgit@machine.or.cz>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22468>

This patch makes the usage(), die() and error() handlers customizable.
Nothing in the git code itself uses that but many other libgit users
(like Git.pm) will.

This is implemented using the mutator functions primarily because you
cannot directly modifying global variables of libgit from a program that
dlopen()ed it, apparently. But having functions for that is a better API
anyway.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-compat-util.h |    4 ++++
 usage.c           |   46 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5d543d2..b3d4cf5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -40,6 +40,10 @@ extern void usage(const char *err) NORET
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+extern void set_usage_routine(void (*routine)(const char *err) NORETURN);
+extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
+extern void set_error_routine(void (*routine)(const char *err, va_list params));
+
 #ifdef NO_MMAP
 
 #ifndef PROT_READ
diff --git a/usage.c b/usage.c
index 1fa924c..b781b00 100644
--- a/usage.c
+++ b/usage.c
@@ -12,20 +12,58 @@ static void report(const char *prefix, c
 	fputs("\n", stderr);
 }
 
-void usage(const char *err)
+void usage_builtin(const char *err)
 {
 	fprintf(stderr, "usage: %s\n", err);
 	exit(129);
 }
 
+void die_builtin(const char *err, va_list params)
+{
+	report("fatal: ", err, params);
+	exit(128);
+}
+
+void error_builtin(const char *err, va_list params)
+{
+	report("error: ", err, params);
+}
+
+
+/* If we are in a dlopen()ed .so write to a global variable would segfault
+ * (ugh), so keep things static. */
+static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
+static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
+static void (*error_routine)(const char *err, va_list params) = error_builtin;
+
+void set_usage_routine(void (*routine)(const char *err) NORETURN)
+{
+	usage_routine = routine;
+}
+
+void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN)
+{
+	die_routine = routine;
+}
+
+void set_error_routine(void (*routine)(const char *err, va_list params))
+{
+	error_routine = routine;
+}
+
+
+void usage(const char *err)
+{
+	usage_routine(err);
+}
+
 void die(const char *err, ...)
 {
 	va_list params;
 
 	va_start(params, err);
-	report("fatal: ", err, params);
+	die_routine(err, params);
 	va_end(params);
-	exit(128);
 }
 
 int error(const char *err, ...)
@@ -33,7 +71,7 @@ int error(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	report("error: ", err, params);
+	error_routine(err, params);
 	va_end(params);
 	return -1;
 }
