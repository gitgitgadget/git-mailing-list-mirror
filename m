From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Helper function to shell quote all arg values at once.
Date: Sun, 20 Aug 2006 08:07:49 +0200
Message-ID: <20060820080749.e31276dd.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 08:03:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEgOr-0004Ll-UP
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 08:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWHTGCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 02:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWHTGCf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 02:02:35 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:26844 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750727AbWHTGCf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 02:02:35 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with SMTP id 65FE5755BE;
	Sun, 20 Aug 2006 08:02:33 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25745>

The new sq_quote_argv function is used to refactor the
tracing code in "git.c" and "exec_cmd.c".
This function allocates memory and fills it with a string
containing the quoted argument values. Then it returns a
pointer to this memory that must be freed afterwards.
---
 exec_cmd.c |   11 +++--------
 git.c      |   22 +++++++---------------
 quote.c    |   33 +++++++++++++++++++++++++++++++++
 quote.h    |    1 +
 4 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index e30936d..6d215d8 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -98,15 +98,10 @@ int execv_git_cmd(const char **argv)
 		argv[0] = git_command;
 
 		if (getenv("GIT_TRACE")) {
-			const char **p = argv;
-			fputs("trace: exec:", stderr);
-			while (*p) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, *p);
-				++p;
-			}
-			putc('\n', stderr);
+			char *arg_str = sq_quote_argv(argv, -1);
+			fprintf(stderr, "trace: exec: %s\n", arg_str);
 			fflush(stderr);
+			free(arg_str);
 		}
 
 		/* execve() can only ever return if it fails */
diff --git a/git.c b/git.c
index 930998b..ff4ba66 100644
--- a/git.c
+++ b/git.c
@@ -180,15 +180,11 @@ static int handle_alias(int *argcp, cons
 			die("recursive alias: %s", alias_command);
 
 		if (getenv("GIT_TRACE")) {
-			int i;
-			fprintf(stderr, "trace: alias expansion: %s =>",
-				alias_command);
-			for (i = 0; i < count; ++i) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, new_argv[i]);
-			}
-			fputc('\n', stderr);
+			char *arg_str = sq_quote_argv(new_argv, count);
+			fprintf(stderr, "trace: alias expansion: %s => %s\n",
+				alias_command, arg_str);
 			fflush(stderr);
+			free(arg_str);
 		}
 
 		new_argv = realloc(new_argv, sizeof(char*) *
@@ -292,14 +288,10 @@ static void handle_internal_command(int 
 		if (p->option & USE_PAGER)
 			setup_pager();
 		if (getenv("GIT_TRACE")) {
-			int i;
-			fprintf(stderr, "trace: built-in: git");
-			for (i = 0; i < argc; ++i) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, argv[i]);
-			}
-			putc('\n', stderr);
+			char *arg_str = sq_quote_argv(argv, argc);
+			fprintf(stderr, "trace: built-in: git %s\n", arg_str);
 			fflush(stderr);
+			free(arg_str);
 		}
 
 		exit(p->fn(argc, argv, prefix));
diff --git a/quote.c b/quote.c
index e220dcc..2e6289b 100644
--- a/quote.c
+++ b/quote.c
@@ -74,6 +74,39 @@ char *sq_quote(const char *src)
 	return buf;
 }
 
+char *sq_quote_argv(const char** argv, int count)
+{
+	char *buf, *to;
+	int i;
+	size_t len;
+
+	/* Count argv if needed. */
+	if (count < 0) {
+		char **p = (char **)argv;
+		count = 0;
+		while (*p++) count++;
+	}
+
+	/* Get destination buffer length. */
+	len = count ? count : 1;
+	for (i = 0; i < count; ++i)
+		len += sq_quote_buf(NULL, 0, argv[i]);
+
+	/* Alloc destination buffer. */
+	to = buf = xmalloc(len);
+
+	/* Copy into destination buffer. */
+	for (i = 0; i < count; ++i) {
+		if (i) *to++ = ' ';
+		to += sq_quote_buf(to, len, argv[i]);
+	}
+
+	if (!count)
+		*buf = 0;
+	
+	return buf;
+}
+
 char *sq_dequote(char *arg)
 {
 	char *dst = arg;
diff --git a/quote.h b/quote.h
index fc5481e..a6c4611 100644
--- a/quote.h
+++ b/quote.h
@@ -31,6 +31,7 @@ #include <stdio.h>
 extern char *sq_quote(const char *src);
 extern void sq_quote_print(FILE *stream, const char *src);
 extern size_t sq_quote_buf(char *dst, size_t n, const char *src);
+extern char *sq_quote_argv(const char** argv, int count);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
-- 
1.4.2.g44496-dirty
