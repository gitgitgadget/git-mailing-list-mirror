From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Trace and quote with argv: get rid of unneeded count
 argument.
Date: Mon, 3 Dec 2007 05:51:50 +0100
Message-ID: <20071203055150.b8d222f8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 05:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3Bi-0008Rr-Sz
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 05:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbXLCEpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 23:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbXLCEpY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 23:45:24 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48062 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbXLCEpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 23:45:21 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 2F5931AB2BA;
	Mon,  3 Dec 2007 05:45:20 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id E75CB1AB2B2;
	Mon,  3 Dec 2007 05:45:19 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66860>

Now that str_buf takes care of all the allocations, there is
no more gain to pass an argument count.

So this patch removes the "count" argument from:
	- "sq_quote_argv"
	- "trace_argv_printf"
and all the callers.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-parse.c |    2 +-
 cache.h             |    2 +-
 exec_cmd.c          |    2 +-
 git.c               |    6 +++---
 quote.c             |   13 +++----------
 quote.h             |    3 +--
 trace.c             |    4 ++--
 7 files changed, 12 insertions(+), 20 deletions(-)

	I wrote to Junio:
	> Minor nit: now that the number of arguments is known, we could perhaps use 
	> the argument count instead of -1 in trace_argv_printf, so that it is not 
	> computed again in quote.c:sq_quote_argv, like this:
	>
	>trace_argv_printf(nargv, argc + 1, "trace: exec:");

	After looking at it a little more, I think it's better to get rid of the
	"count" argument altogether with a patch like this one.

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index d1038a0..20d1789 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -327,7 +327,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	                     keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0);
 
 	strbuf_addf(&parsed, " --");
-	sq_quote_argv(&parsed, argv, argc, 0);
+	sq_quote_argv(&parsed, argv, 0);
 	puts(parsed.buf);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 4e59646..9f63199 100644
--- a/cache.h
+++ b/cache.h
@@ -617,7 +617,7 @@ extern void alloc_report(void);
 
 /* trace.c */
 extern void trace_printf(const char *format, ...);
-extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
+extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 /* convert.c */
 /* returns 1 if *dst was used */
diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..e189cac 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -80,7 +80,7 @@ int execv_git_cmd(const char **argv)
 	tmp = argv[0];
 	argv[0] = cmd.buf;
 
-	trace_argv_printf(argv, -1, "trace: exec:");
+	trace_argv_printf(argv, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
 	execvp(cmd.buf, (char **)argv);
diff --git a/git.c b/git.c
index f406c4b..c8b7e74 100644
--- a/git.c
+++ b/git.c
@@ -178,7 +178,7 @@ static int handle_alias(int *argcp, const char ***argv)
 
 				strbuf_init(&buf, PATH_MAX);
 				strbuf_addstr(&buf, alias_string);
-				sq_quote_argv(&buf, (*argv) + 1, *argcp - 1, PATH_MAX);
+				sq_quote_argv(&buf, (*argv) + 1, PATH_MAX);
 				free(alias_string);
 				alias_string = buf.buf;
 			}
@@ -207,7 +207,7 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (!strcmp(alias_command, new_argv[0]))
 			die("recursive alias: %s", alias_command);
 
-		trace_argv_printf(new_argv, count,
+		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
 
@@ -261,7 +261,7 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
 	if (p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
-	trace_argv_printf(argv, argc, "trace: built-in: git");
+	trace_argv_printf(argv, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
 	if (status)
diff --git a/quote.c b/quote.c
index 0455783..6986b44 100644
--- a/quote.c
+++ b/quote.c
@@ -56,20 +56,13 @@ void sq_quote_print(FILE *stream, const char *src)
 	fputc('\'', stream);
 }
 
-void sq_quote_argv(struct strbuf *dst, const char** argv, int count,
-                   size_t maxlen)
+void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
 {
 	int i;
 
-	/* Count argv if needed. */
-	if (count < 0) {
-		for (count = 0; argv[count]; count++)
-			; /* just counting */
-	}
-
 	/* Copy into destination buffer. */
-	strbuf_grow(dst, 32 * count);
-	for (i = 0; i < count; ++i) {
+	strbuf_grow(dst, 255);
+	for (i = 0; argv[i]; ++i) {
 		strbuf_addch(dst, ' ');
 		sq_quote_buf(dst, argv[i]);
 		if (maxlen && dst->len > maxlen)
diff --git a/quote.h b/quote.h
index 4287990..ab7596f 100644
--- a/quote.h
+++ b/quote.h
@@ -31,8 +31,7 @@
 extern void sq_quote_print(FILE *stream, const char *src);
 
 extern void sq_quote_buf(struct strbuf *, const char *src);
-extern void sq_quote_argv(struct strbuf *, const char **argv, int count,
-                          size_t maxlen);
+extern void sq_quote_argv(struct strbuf *, const char **argv, size_t maxlen);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
diff --git a/trace.c b/trace.c
index d3d1b6d..4713f91 100644
--- a/trace.c
+++ b/trace.c
@@ -93,7 +93,7 @@ void trace_printf(const char *fmt, ...)
 		close(fd);
 }
 
-void trace_argv_printf(const char **argv, int count, const char *fmt, ...)
+void trace_argv_printf(const char **argv, const char *fmt, ...)
 {
 	struct strbuf buf;
 	va_list ap;
@@ -117,7 +117,7 @@ void trace_argv_printf(const char **argv, int count, const char *fmt, ...)
 	}
 	strbuf_setlen(&buf, len);
 
-	sq_quote_argv(&buf, argv, count, 0);
+	sq_quote_argv(&buf, argv, 0);
 	strbuf_addch(&buf, '\n');
 	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
 	strbuf_release(&buf);
-- 
1.5.3.6.2115.gb9452-dirty
