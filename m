From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] error_routine: use parent's stderr if exec fails
Date: Wed, 27 Jul 2011 23:32:34 +0200
Message-ID: <20110727213234.GA22159@toss.lan>
References: <20110726210401.GA25207@toss.lan>
 <4E3068D4.4050006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@linux-foundation.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 23:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmBig-000403-D5
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 23:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab1G0Vcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 17:32:41 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:25529 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755262Ab1G0Vcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 17:32:39 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 13FF2CDF82;
	Wed, 27 Jul 2011 23:32:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E3068D4.4050006@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177999>

The new process's error output may be redirected elsewhere, but if
the exec fails, output should still go to the parent's stderr. This
has already been done for the die_routine. Do the same for
error_routine.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Wed, Jul 27, 2011 at 09:36:52PM +0200, Johannes Sixt wrote:
> 
> This change is not good enough: There is no guarantee that this message
> goes to the right channel (stderr in the child can be redirected).

Ah, good point. I skipped over that part thinking it was not
relevant.  This should take care of it.

Clemens

 git-compat-util.h |    2 ++
 run-command.c     |   15 +++++++--------
 usage.c           |   18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a75530d..07cbfe9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -240,6 +240,7 @@ extern char *gitbasename(char *);
 
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
+extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -248,6 +249,7 @@ extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
+extern void set_error_routine(void (*routine)(const char *err, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern int suffixcmp(const char *str, const char *suffix);
diff --git a/run-command.c b/run-command.c
index c752174..a2796c4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -77,16 +77,14 @@ static void notify_parent(void)
 
 static NORETURN void die_child(const char *err, va_list params)
 {
-	char msg[4096];
-	int len = vsnprintf(msg, sizeof(msg), err, params);
-	if (len > sizeof(msg))
-		len = sizeof(msg);
-
-	write_in_full(child_err, "fatal: ", 7);
-	write_in_full(child_err, msg, len);
-	write_in_full(child_err, "\n", 1);
+	vwritef(child_err, "fatal: ", err, params);
 	exit(128);
 }
+
+static void error_child(const char *err, va_list params)
+{
+	vwritef(child_err, "error: ", err, params);
+}
 #endif
 
 static inline void set_cloexec(int fd)
@@ -214,6 +212,7 @@ fail_pipe:
 			set_cloexec(child_err);
 		}
 		set_die_routine(die_child);
+		set_error_routine(error_child);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
diff --git a/usage.c b/usage.c
index b5e67e3..a2a6678 100644
--- a/usage.c
+++ b/usage.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "git-compat-util.h"
+#include "cache.h"
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
@@ -12,6 +13,18 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	fprintf(stderr, "%s%s\n", prefix, msg);
 }
 
+void vwritef(int fd, const char *prefix, const char *err, va_list params)
+{
+	char msg[4096];
+	int len = vsnprintf(msg, sizeof(msg), err, params);
+	if (len > sizeof(msg))
+		len = sizeof(msg);
+
+	write_in_full(fd, prefix, strlen(prefix));
+	write_in_full(fd, msg, len);
+	write_in_full(fd, "\n", 1);
+}
+
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
 	vreportf("usage: ", err, params);
@@ -46,6 +59,11 @@ void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list param
 	die_routine = routine;
 }
 
+void set_error_routine(void (*routine)(const char *err, va_list params))
+{
+	error_routine = routine;
+}
+
 void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
-- 
1.7.3.1.105.g84915
