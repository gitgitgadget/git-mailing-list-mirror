From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Refactoring tracing code in "git.c" and "exec_cmd.c".
Date: Thu, 24 Aug 2006 07:45:47 +0200
Message-ID: <20060824074547.a8fa0005.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 07:40:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GG7xO-0000fi-5t
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 07:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWHXFkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 01:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWHXFkb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 01:40:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51913 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030298AbWHXFkb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 01:40:31 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 453E447F89;
	Thu, 24 Aug 2006 07:40:29 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25941>

Some new helper functions in "quote.c" are used for this.
The goal is also to get near the point where we can use
one write(2) call to trace in any open file descriptor.
This is why we put the trace string into one buffer.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 exec_cmd.c |   10 ++------
 git.c      |   20 ++++-----------
 quote.c    |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 quote.h    |    3 ++
 4 files changed, 88 insertions(+), 23 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index e30936d..5688e0b 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -98,14 +98,8 @@ int execv_git_cmd(const char **argv)
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
+			sq_quote_argv_printf(stderr, argv, -1,
+					     "trace: exec: ARGV\n");
 			fflush(stderr);
 		}
 
diff --git a/git.c b/git.c
index 930998b..d13b841 100644
--- a/git.c
+++ b/git.c
@@ -180,14 +180,9 @@ static int handle_alias(int *argcp, cons
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
+			sq_quote_argv_printf(stderr, new_argv, count,
+					     "trace: alias expansion: %s => ARGV\n",
+					     alias_command);
 			fflush(stderr);
 		}
 
@@ -292,13 +287,8 @@ static void handle_internal_command(int 
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
+			sq_quote_argv_printf(stderr, argv, argc,
+					     "trace: built-in: git ARGV\n");
 			fflush(stderr);
 		}
 
diff --git a/quote.c b/quote.c
index e220dcc..84d0b7b 100644
--- a/quote.c
+++ b/quote.c
@@ -74,6 +74,84 @@ char *sq_quote(const char *src)
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
+/* Return a newly allocated copy of "format" where the
+ * first occurence of "old" has been replaced by "new". */
+static char *str_subst(const char *format, const char *old, const char *new)
+{
+	/* Get destination buffer length. */
+	size_t fmt_len = strlen(format);
+	size_t old_len = strlen(old);
+	size_t new_len = strlen(new);
+	size_t len = fmt_len - old_len + new_len + 1;
+
+	/* Get the first occurence of old. */ 
+	char *pos = strstr(format, old);
+	if (!pos)
+		return strcpy(xmalloc(fmt_len + 1), format);
+	size_t start_len = pos - format;
+
+	/* Alloc destination buffer. */
+	char *result = xmalloc(len);
+
+	/* Copy into destination buffer. */
+	strncpy(result, format, start_len);
+	strncpy(result + start_len, new, new_len);
+	strcpy(result + start_len + new_len,
+	       format + start_len + old_len);
+
+	return result;
+}
+
+void sq_quote_argv_printf(FILE* out, const char **argv, int count,
+			   const char *format, ...)
+{
+	/* Replace the string "ARGV" in format with the quoted arg values. */
+	char *argv_str = sq_quote_argv(argv, count);
+	char *new_format = str_subst(format, "ARGV", argv_str);
+
+	/* Print into "out" using the new format. */
+	va_list rest;
+	va_start(rest, format);
+	vfprintf(out, new_format, rest);
+	va_end(rest);
+
+	free(new_format);
+	free(argv_str);	
+}
+
 char *sq_dequote(char *arg)
 {
 	char *dst = arg;
diff --git a/quote.h b/quote.h
index fc5481e..2bbf196 100644
--- a/quote.h
+++ b/quote.h
@@ -31,6 +31,9 @@ #include <stdio.h>
 extern char *sq_quote(const char *src);
 extern void sq_quote_print(FILE *stream, const char *src);
 extern size_t sq_quote_buf(char *dst, size_t n, const char *src);
+extern char *sq_quote_argv(const char** argv, int count);
+extern void sq_quote_argv_printf(FILE* out, const char **argv, int count,
+				 const char *format, ...);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
-- 
1.4.2.gc35c-dirty
