From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] vreportf: report to arbitrary filehandles
Date: Tue, 11 Aug 2015 14:06:15 -0400
Message-ID: <20150811180614.GA18002@sigill.intra.peff.net>
References: <20150811180524.GB15521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:06:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPDwP-0005pg-17
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 20:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbbHKSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 14:06:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:43745 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751751AbbHKSGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 14:06:20 -0400
Received: (qmail 26921 invoked by uid 102); 11 Aug 2015 18:06:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 13:06:19 -0500
Received: (qmail 17569 invoked by uid 107); 11 Aug 2015 18:06:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 14:06:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 14:06:15 -0400
Content-Disposition: inline
In-Reply-To: <20150811180524.GB15521@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275704>

The vreportf function always goes to stderr, but run-command
wants child errors to go to the parent's original stderr. To
solve this, commit a5487dd duplicates the stderr fd and
installs die and error handlers to direct the output
appropriately (which later turned into the vwritef
function). This has two downsides, though:

  - we make multiple calls to write(), which contradicts the
    "write at once" logic from d048a96 (print
    warning/error/fatal messages in one shot, 2007-11-09).

  - the custom handlers basically duplicate the normal
    handlers.  They're only a few lines of code, but we
    should not have to repeat the magic "exit(128)", for
    example.

We can solve the first by using fdopen() on the duplicated
descriptor. We can't pass this to vreportf, but we could
introduce a new vreportf_to to handle it.

However, to fix the second problem, we instead introduce a
new "set_error_handle" function, which lets the normal
vreportf calls output to a handle besides stderr. Thus we
can get rid of our custom handlers entirely, and just ask
the regular handlers to output to our new descriptor.

And as vwritef has no more callers, it can just go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h |  2 +-
 run-command.c     | 17 ++---------------
 usage.c           | 22 +++++++++-------------
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c6d391f..076461e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -389,7 +389,6 @@ struct strbuf;
 
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
-extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
 extern NORETURN void usage(const char *err);
 extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
@@ -425,6 +424,7 @@ static inline int const_error(void)
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
+extern void set_error_handle(FILE *);
 
 extern int starts_with(const char *str, const char *prefix);
 
diff --git a/run-command.c b/run-command.c
index 4d73e90..0d01671 100644
--- a/run-command.c
+++ b/run-command.c
@@ -200,7 +200,6 @@ static int execv_shell_cmd(const char **argv)
 #endif
 
 #ifndef GIT_WINDOWS_NATIVE
-static int child_err = 2;
 static int child_notifier = -1;
 
 static void notify_parent(void)
@@ -212,17 +211,6 @@ static void notify_parent(void)
 	 */
 	xwrite(child_notifier, "", 1);
 }
-
-static NORETURN void die_child(const char *err, va_list params)
-{
-	vwritef(child_err, "fatal: ", err, params);
-	exit(128);
-}
-
-static void error_child(const char *err, va_list params)
-{
-	vwritef(child_err, "error: ", err, params);
-}
 #endif
 
 static inline void set_cloexec(int fd)
@@ -362,11 +350,10 @@ fail_pipe:
 		 * in subsequent call paths use the parent's stderr.
 		 */
 		if (cmd->no_stderr || need_err) {
-			child_err = dup(2);
+			int child_err = dup(2);
 			set_cloexec(child_err);
+			set_error_handle(fdopen(child_err, "w"));
 		}
-		set_die_routine(die_child);
-		set_error_routine(error_child);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
diff --git a/usage.c b/usage.c
index ed14645..e4fa6d2 100644
--- a/usage.c
+++ b/usage.c
@@ -6,23 +6,14 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+static FILE *error_handle;
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
+	FILE *fh = error_handle ? error_handle : stderr;
 	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
-}
-
-void vwritef(int fd, const char *prefix, const char *err, va_list params)
-{
-	char msg[4096];
-	int len = vsnprintf(msg, sizeof(msg), err, params);
-	if (len > sizeof(msg))
-		len = sizeof(msg);
-
-	write_in_full(fd, prefix, strlen(prefix));
-	write_in_full(fd, msg, len);
-	write_in_full(fd, "\n", 1);
+	fprintf(fh, "%s%s\n", prefix, msg);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -76,6 +67,11 @@ void set_die_is_recursing_routine(int (*routine)(void))
 	die_is_recursing = routine;
 }
 
+void set_error_handle(FILE *fh)
+{
+	error_handle = fh;
+}
+
 void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
-- 
2.5.0.417.g2db689c
