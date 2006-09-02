From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Trace into a file or an open fd and refactor tracing code.
Date: Sat, 2 Sep 2006 18:23:48 +0200
Message-ID: <20060902182348.bdbe9d60.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 18:18:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJYCG-0007hs-S3
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 18:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIBQSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 12:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIBQSN
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 12:18:13 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:20193 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751149AbWIBQSM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 12:18:12 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with SMTP id 53620938C;
	Sat,  2 Sep 2006 18:18:10 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26343>

If GIT_TRACE is set to an absolute path (starting with a
'/' character), we interpret this as a file path and we
trace into it.

Also if GIT_TRACE is set to an integer value greater than
1 and lower than 10, we interpret this as an open fd value
and we trace into it.

Note that this behavior is not compatible with the
previous one.

We also trace whole messages using one write(2) call to
make sure messages from processes do net get mixed up in
the middle.

This patch makes it possible to get trace information when
running "make test".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile       |    2 -
 cache.h        |    6 ++
 exec_cmd.c     |   18 +------
 git.c          |   25 ++-------
 imap-send.c    |   25 ---------
 quote.c        |   32 ++++++++++++
 quote.h        |    1 
 t/test-lib.sh  |   10 +++-
 trace.c        |  149 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 write_or_die.c |   25 +++++++++
 10 files changed, 229 insertions(+), 64 deletions(-)

diff --git a/Makefile b/Makefile
index 05bd77f..a639cdf 100644
--- a/Makefile
+++ b/Makefile
@@ -249,7 +249,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	write_or_die.o \
+	write_or_die.o trace.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS)
 
 BUILTIN_OBJS = \
diff --git a/cache.h b/cache.h
index 7257c4c..195908f 100644
--- a/cache.h
+++ b/cache.h
@@ -398,6 +398,7 @@ extern char git_commit_encoding[MAX_ENCO
 
 extern int copy_fd(int ifd, int ofd);
 extern void write_or_die(int fd, const void *buf, size_t count);
+extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 
 /* Finish off pack transfer receiving end */
 extern int receive_unpack_pack(int fd[2], const char *me, int quiet, int);
@@ -423,4 +424,9 @@ extern struct commit *alloc_commit_node(
 extern struct tag *alloc_tag_node(void);
 extern void alloc_report(void);
 
+/* trace.c */
+extern int nfvasprintf(char **str, const char *fmt, va_list va);
+extern void trace_printf(const char *format, ...);
+extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
+
 #endif /* CACHE_H */
diff --git a/exec_cmd.c b/exec_cmd.c
index e30936d..5d6a124 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -97,26 +97,12 @@ int execv_git_cmd(const char **argv)
 		tmp = argv[0];
 		argv[0] = git_command;
 
-		if (getenv("GIT_TRACE")) {
-			const char **p = argv;
-			fputs("trace: exec:", stderr);
-			while (*p) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, *p);
-				++p;
-			}
-			putc('\n', stderr);
-			fflush(stderr);
-		}
+		trace_argv_printf(argv, -1, "trace: exec:");
 
 		/* execve() can only ever return if it fails */
 		execve(git_command, (char **)argv, environ);
 
-		if (getenv("GIT_TRACE")) {
-			fprintf(stderr, "trace: exec failed: %s\n",
-				strerror(errno));
-			fflush(stderr);
-		}
+		trace_printf("trace: exec failed: %s\n", strerror(errno));
 
 		argv[0] = tmp;
 	}
diff --git a/git.c b/git.c
index 05871ad..403fb3a 100644
--- a/git.c
+++ b/git.c
@@ -179,17 +179,9 @@ static int handle_alias(int *argcp, cons
 		if (!strcmp(alias_command, new_argv[0]))
 			die("recursive alias: %s", alias_command);
 
-		if (getenv("GIT_TRACE")) {
-			int i;
-			fprintf(stderr, "trace: alias expansion: %s =>",
-				alias_command);
-			for (i = 0; i < count; ++i) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, new_argv[i]);
-			}
-			fputc('\n', stderr);
-			fflush(stderr);
-		}
+		trace_argv_printf(new_argv, count,
+				  "trace: alias expansion: %s =>",
+				  alias_command);
 
 		new_argv = xrealloc(new_argv, sizeof(char*) *
 				    (count + *argcp + 1));
@@ -292,16 +284,7 @@ static void handle_internal_command(int 
 			prefix = setup_git_directory();
 		if (p->option & USE_PAGER)
 			setup_pager();
-		if (getenv("GIT_TRACE")) {
-			int j;
-			fprintf(stderr, "trace: built-in: git");
-			for (j = 0; j < argc; ++j) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, argv[j]);
-			}
-			putc('\n', stderr);
-			fflush(stderr);
-		}
+		trace_argv_printf(argv, argc, "trace: built-in: git");
 
 		exit(p->fn(argc, argv, prefix));
 	}
diff --git a/imap-send.c b/imap-send.c
index 65c71c6..6a52dbd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -110,7 +110,6 @@ static char *next_arg( char ** );
 
 static void free_generic_messages( message_t * );
 
-static int nfvasprintf( char **str, const char *fmt, va_list va );
 static int nfsnprintf( char *buf, int blen, const char *fmt, ... );
 
 
@@ -372,21 +371,6 @@ free_generic_messages( message_t *msgs )
 }
 
 static int
-git_vasprintf( char **strp, const char *fmt, va_list ap )
-{
-	int len;
-	char tmp[1024];
-
-	if ((len = vsnprintf( tmp, sizeof(tmp), fmt, ap )) < 0 || !(*strp = xmalloc( len + 1 )))
-		return -1;
-	if (len >= (int)sizeof(tmp))
-		vsprintf( *strp, fmt, ap );
-	else
-		memcpy( *strp, tmp, len + 1 );
-	return len;
-}
-
-static int
 nfsnprintf( char *buf, int blen, const char *fmt, ... )
 {
 	int ret;
@@ -399,15 +383,6 @@ nfsnprintf( char *buf, int blen, const c
 	return ret;
 }
 
-static int
-nfvasprintf( char **str, const char *fmt, va_list va )
-{
-	int ret = git_vasprintf( str, fmt, va );
-	if (ret < 0)
-		die( "Fatal: Out of memory\n");
-	return ret;
-}
-
 static struct {
 	unsigned char i, j, s[256];
 } rs;
diff --git a/quote.c b/quote.c
index e220dcc..f90091e 100644
--- a/quote.c
+++ b/quote.c
@@ -74,6 +74,38 @@ char *sq_quote(const char *src)
 	return buf;
 }
 
+char *sq_quote_argv(const char** argv, int count)
+{
+	char *buf, *to;
+	int i;
+	size_t len = 0;
+
+	/* Count argv if needed. */
+	if (count < 0) {
+		for (count = 0; argv[count]; count++)
+			; /* just counting */
+	}
+
+	/* Special case: no argv. */
+	if (!count)
+		return xcalloc(1,1);
+	
+	/* Get destination buffer length. */
+	for (i = 0; i < count; i++)
+		len += sq_quote_buf(NULL, 0, argv[i]) + 1;
+
+	/* Alloc destination buffer. */
+	to = buf = xmalloc(len + 1);
+
+	/* Copy into destination buffer. */
+	for (i = 0; i < count; ++i) {
+		*to++ = ' ';
+		to += sq_quote_buf(to, len, argv[i]);
+	}
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
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 470a909..e262933 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -28,13 +28,21 @@ unset GIT_DIR
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
-unset GIT_TRACE
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
 
+case $(echo $GIT_TRACE |tr [A-Z] [a-z]) in
+	1|2|true)
+		echo "* warning: Some tests will not work if GIT_TRACE" \
+			"is set as to trace on STDERR ! *"
+		echo "* warning: Please set GIT_TRACE to something" \
+			"other than 1, 2 or true ! *"
+		;;
+esac
+
 # Each test should start with something like this, after copyright notices:
 #
 # test_description='Description of this test...
diff --git a/trace.c b/trace.c
new file mode 100644
index 0000000..fecd897
--- /dev/null
+++ b/trace.c
@@ -0,0 +1,149 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) 2000-2002 Michael R. Elkins <me@mutt.org>
+ * Copyright (C) 2002-2004 Oswald Buddenhagen <ossi@users.sf.net>
+ * Copyright (C) 2004 Theodore Y. Ts'o <tytso@mit.edu>
+ * Copyright (C) 2006 Mike McCormack
+ * Copyright (C) 2006 Christian Couder 
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "cache.h"
+#include "quote.h"
+
+/* Stolen from "imap-send.c". */
+static int git_vasprintf(char **strp, const char *fmt, va_list ap)
+{
+	int len;
+	char tmp[1024];
+
+	if ((len = vsnprintf(tmp, sizeof(tmp), fmt, ap)) < 0 ||
+	    !(*strp = xmalloc(len + 1)))
+		return -1;
+	if (len >= (int)sizeof(tmp))
+		vsprintf(*strp, fmt, ap);
+	else
+		memcpy(*strp, tmp, len + 1);
+	return len;
+}
+
+/* Stolen from "imap-send.c". */
+int nfvasprintf(char **str, const char *fmt, va_list va)
+{
+	int ret = git_vasprintf(str, fmt, va);
+	if (ret < 0)
+		die("Fatal: Out of memory\n");
+	return ret;
+}
+
+/* Get a trace file descriptor from GIT_TRACE env variable. */
+static int get_trace_fd(int *need_close)
+{
+	char *trace = getenv("GIT_TRACE");
+
+	if (!trace || !strcmp(trace, "0") || !strcasecmp(trace," false"))
+		return 0;
+	if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
+		return STDERR_FILENO;
+	if (strlen(trace) == 1 && isdigit(*trace))
+		return atoi(trace);
+	if (*trace == '/') {
+		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
+		if (fd == -1) {
+			fprintf(stderr,
+				"Could not open '%s' for tracing: %s\n"
+				"Defaulting to tracing on stderr...\n",
+				trace, strerror(errno));
+			return STDERR_FILENO;
+		}
+		*need_close = 1;
+		return fd;
+	}
+
+	fprintf(stderr, "What does '%s' for GIT_TRACE means ?\n", trace);
+	fprintf(stderr, "If you want to trace into a file, "
+		"then please set GIT_TRACE to an absolute pathname "
+		"(starting with /).\n");
+	fprintf(stderr, "Defaulting to tracing on stderr...\n");
+	
+	return STDERR_FILENO;
+}
+
+static const char err_msg[] = "Could not trace into fd given by "
+	"GIT_TRACE environment variable";
+
+void trace_printf(const char *format, ...)
+{
+	char *trace_str;
+	va_list rest;
+	int need_close = 0;
+	int fd = get_trace_fd(&need_close);
+
+	if (!fd)
+		return;
+
+	va_start(rest, format);
+	nfvasprintf(&trace_str, format, rest);
+	va_end(rest);
+
+	write_or_whine(fd, trace_str, strlen(trace_str), err_msg);
+
+	free(trace_str);
+
+	if (need_close)
+		close(fd);
+}
+
+void trace_argv_printf(const char **argv, int count, const char *format, ...)
+{
+	char *argv_str, *format_str, *trace_str;
+	size_t argv_len, format_len, trace_len;
+	va_list rest;
+	int need_close = 0;
+	int fd = get_trace_fd(&need_close);
+
+	if (!fd)
+		return;
+
+	/* Get the argv string. */
+	argv_str = sq_quote_argv(argv, count);
+	argv_len = strlen(argv_str);
+
+	/* Get the formated string. */
+	va_start(rest, format);
+	nfvasprintf(&format_str, format, rest);
+	va_end(rest);
+
+	/* Allocate buffer for trace string. */
+	format_len = strlen(format_str);
+	trace_len = argv_len + format_len + 1; /* + 1 for \n */
+	trace_str = xmalloc(trace_len + 1);
+
+	/* Copy everything into the trace string. */
+	strncpy(trace_str, format_str, format_len);
+	strncpy(trace_str + format_len, argv_str, argv_len);
+	strcpy(trace_str + trace_len - 1, "\n");
+
+	write_or_whine(fd, trace_str, trace_len, err_msg);
+	
+	free(argv_str);
+	free(format_str);
+	free(trace_str);
+
+	if (need_close)
+		close(fd);
+}
diff --git a/write_or_die.c b/write_or_die.c
index ab4cb8a..bfe4eeb 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -18,3 +18,28 @@ void write_or_die(int fd, const void *bu
 		p += written;
 	}
 }
+
+int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
+{
+	const char *p = buf;
+	ssize_t written;
+
+	while (count > 0) {
+		written = xwrite(fd, p, count);
+		if (written == 0) {
+			fprintf(stderr, "%s: disk full?\n", msg);
+			return 0;
+		}
+		else if (written < 0) {
+			if (errno == EPIPE)
+				exit(0);
+			fprintf(stderr, "%s: write error (%s)\n",
+				msg, strerror(errno));
+			return 0;
+		}
+		count -= written;
+		p += written;
+	}
+
+	return 1;
+}
-- 
1.4.2.g0f2c-dirty


-- 
VGER BF report: U 0.5
