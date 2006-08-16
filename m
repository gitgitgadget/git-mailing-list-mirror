From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH] Trace into a file if GIT_TRACE can interpreted as a
 filename.
Date: Wed, 16 Aug 2006 22:58:46 +0200
Message-ID: <20060816225846.ae424b46.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 22:54:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDSOV-0005Ov-Qk
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 22:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWHPUxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWHPUxk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 16:53:40 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:27589 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932216AbWHPUxj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 16:53:39 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 4B1D154A22;
	Wed, 16 Aug 2006 22:53:37 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.18; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25528>

This RFC/patch is a first step to trace the git commands used when running
the test suite.

Thanks,
Christian.

-- 8< --
[RFC/PATCH] Trace into a file if GIT_TRACE can interpreted as a filename.

If GIT_TRACE is set to something different than "1" or
"true" then we suppose it's a filemane and try to trace
into it instead of stderr.
So this change is not compatible with the previous
behavior, because stderr will not be used anymore if
GIT_TRACE is set to something other than "1" or "true".
No file locking is done. This maybe a problem.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

---
 Makefile      |    3 ++-
 cache.h       |    4 ++++
 exec_cmd.c    |   19 ++++++++++---------
 git.c         |   26 ++++++++++++++------------
 t/test-lib.sh |    3 +++
 trace.c       |   43 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index c6b62d9..8ce78b3 100644
--- a/Makefile
+++ b/Makefile
@@ -253,7 +253,8 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o revision.o pager.o tree-walk.o xdiff-interface.o \
-	alloc.o merge-file.o path-list.o unpack-trees.o help.o $(DIFF_OBJS)
+	alloc.o merge-file.o path-list.o unpack-trees.o help.o trace.o \
+	$(DIFF_OBJS)

 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/cache.h b/cache.h
index 913be6a..0efcf50 100644
--- a/cache.h
+++ b/cache.h
@@ -409,4 +409,8 @@ extern struct commit *alloc_commit_node(
 extern struct tag *alloc_tag_node(void);
 extern void alloc_report(void);
 
+/* trace.c */
+extern FILE *start_trace(void);
+extern void stop_trace(void);
+  
 #endif /* CACHE_H */
diff --git a/exec_cmd.c b/exec_cmd.c
index 62f51fc..ddb45a3 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -43,6 +43,7 @@ int execv_git_cmd(const char **argv)
 		int rc;
 		const char *exec_dir = paths[i];
 		const char *tmp;
+		FILE *trace_file;
 
 		if (!exec_dir || !*exec_dir) continue;
 
@@ -97,25 +98,25 @@ int execv_git_cmd(const char **argv)
 		tmp = argv[0];
 		argv[0] = git_command;
 
-		if (getenv("GIT_TRACE")) {
+		if ((trace_file = start_trace())) {
 			const char **p = argv;
-			fputs("trace: exec:", stderr);
+			fputs("trace: exec:", trace_file);
 			while (*p) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, *p);
+				fputc(' ', trace_file);
+				sq_quote_print(trace_file, *p);
 				++p;
 			}
-			putc('\n', stderr);
-			fflush(stderr);
+			putc('\n', trace_file);
+			stop_trace();
 		}
 
 		/* execve() can only ever return if it fails */
 		execve(git_command, (char **)argv, environ);
 
-		if (getenv("GIT_TRACE")) {
-			fprintf(stderr, "trace: exec failed: %s\n",
+		if ((trace_file = start_trace())) {
+			fprintf(trace_file, "trace: exec failed: %s\n",
 				strerror(errno));
-			fflush(stderr);
+			stop_trace();
 		}
 
 		argv[0] = tmp;
diff --git a/git.c b/git.c
index 96e596b..39b78e2 100644
--- a/git.c
+++ b/git.c
@@ -161,6 +161,7 @@ static int handle_alias(int *argcp, cons
 	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
+	FILE *trace_file;
 
 	subdir = setup_git_directory_gently(&nongit);
 
@@ -179,16 +180,16 @@ static int handle_alias(int *argcp, cons
 		if (!strcmp(alias_command, new_argv[0]))
 			die("recursive alias: %s", alias_command);
 
-		if (getenv("GIT_TRACE")) {
+		if ((trace_file = start_trace())) {
 			int i;
-			fprintf(stderr, "trace: alias expansion: %s =>",
+			fprintf(trace_file, "trace: alias expansion: %s =>",
 				alias_command);
 			for (i = 0; i < count; ++i) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, new_argv[i]);
+				fputc(' ', trace_file);
+				sq_quote_print(trace_file, new_argv[i]);
 			}
-			fputc('\n', stderr);
-			fflush(stderr);
+			fputc('\n', trace_file);
+			stop_trace();
 		}
 
 		new_argv = realloc(new_argv, sizeof(char*) *
@@ -282,6 +283,7 @@ static void handle_internal_command(int 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
 		const char *prefix;
+		FILE * trace_file;
 		if (strcmp(p->cmd, cmd))
 			continue;
 
@@ -290,15 +292,15 @@ static void handle_internal_command(int 
 			prefix = setup_git_directory();
 		if (p->option & USE_PAGER)
 			setup_pager();
-		if (getenv("GIT_TRACE")) {
+		if ((trace_file = start_trace())) {
 			int i;
-			fprintf(stderr, "trace: built-in: git");
+			fprintf(trace_file, "trace: built-in: git");
 			for (i = 0; i < argc; ++i) {
-				fputc(' ', stderr);
-				sq_quote_print(stderr, argv[i]);
+				fputc(' ', trace_file);
+				sq_quote_print(trace_file, argv[i]);
 			}
-			putc('\n', stderr);
-			fflush(stderr);
+			putc('\n', trace_file);
+			stop_trace();
 		}
 
 		exit(p->fn(argc, argv, prefix));
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b6d119a..5afa5f0 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,6 +35,9 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR VISUAL
 
+# Uncomment the following line to trace the git commands into a file.
+# export GIT_TRACE=`pwd`/git_trace.log
+
 # Each test should start with something like this, after copyright notices:
 #
 # test_description='Description of this test...
diff --git a/trace.c b/trace.c
new file mode 100644
index 0000000..b1a14e0
--- /dev/null
+++ b/trace.c
@@ -0,0 +1,43 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Christian Couder, 2006
+ *
+ */
+#include "cache.h"
+
+static FILE *trace_file = NULL;
+
+FILE *start_trace()
+{
+	char * trace = getenv("GIT_TRACE");
+
+	if (trace && (!strcmp(trace,"1") || !strcasecmp(trace,"true")))
+		trace_file = stderr;
+	else if (trace && strcmp(trace, "") &&
+		 strcmp(trace, "0") && strcasecmp(trace, "false")) {
+		/* We suppose we have a filename. */
+		trace_file = fopen(trace, "a");
+		if (!trace_file) {
+			fprintf(stderr, "Error: %s\n"
+				"when opening trace file: %s\n"
+				"Tracing on stderr instead.\n",
+				strerror(errno), trace);
+			trace_file = stderr;
+		}
+	}
+
+	return trace_file;
+}
+
+void stop_trace()
+{
+	if (trace_file) {
+		if (trace_file == stderr)
+			fflush(stderr);
+		else
+			fclose(trace_file);
+		trace_file = NULL;
+	}
+}
+
-- 
1.4.2.rc3.gcc6ea
