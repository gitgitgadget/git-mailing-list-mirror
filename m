From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Mon, 16 May 2005 16:40:45 -0700
Message-ID: <7v3bsmn3ia.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0l3puzg.fsf@assigned-by-dhcp.cox.net>
	<7v8y2en4e8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXpEW-00061U-Ja
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVEPXnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVEPXnF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:43:05 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:47754 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261964AbVEPXks (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 19:40:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516234047.VNDT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 19:40:47 -0400
To: pasky@ucw.cz, torvalds@osdl.org
In-Reply-To: <7v8y2en4e8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 16 May 2005 16:21:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A new command git-run-with-user-path takes a command and paths
that are filesystem paths (either relative to the cwd or
absolute pathname).  It canonicalizes these paths to be usable
by the core GIT commands, filters using the ignore pattern rule,
chdir(2)'s to the top level of the tree and runs the given
command with these canonicalizd paths as its arguments.

This version contains necessary hooks to implement the ignore
pattern rule, but it does not implement any ignore pattern
rules, waiting for more mailing list discussions.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-run-with-user-path.txt |  100 +++++++++++++++
Makefile                                 |    7 -
paths.c                                  |  199 +++++++++++++++++++++++++++++++
paths.h                                  |   14 ++
run-with-user-path.c                     |   87 +++++++++++++
t/README                                 |    1 
t/t7000-git-run-with-user-path-basic.sh  |   87 +++++++++++++
update-cache.c                           |   29 ----
8 files changed, 495 insertions(+), 29 deletions(-)
Documentation/git-run-with-user-path.txt (. --> 100644)
paths.c (. --> 100644)
paths.h (. --> 100644)
run-with-user-path.c (. --> 100644)
t/t7000-git-run-with-user-path-basic.sh (. --> 100755)

--- /dev/null
+++ b/Documentation/git-run-with-user-path.txt
@@ -0,0 +1,100 @@
+git-run-with-user-path(1)
+=========================
+v0.1, May 2005
+
+NAME
+----
+git-run-with-user-path - Run command from the top after canonicalizing paths.
+
+
+SYNOPSIS
+--------
+'git-run-with-user-path' [options] <command> <argument>... '--' <path>...
+'git-run-with-user-path' [options] ( '--echo-z' | '--echo' ) <path>...
+
+DESCRIPTION
+-----------
+In the first form, this command takes a <command>, zero or more
+<argument> and zero or more <path> arguments.  <path> arguments name
+objects on the filesystem, <command> is typically a core GIT command,
+and <argument> are the initial arguments to the <command>.
+
+It first finds the project top directory (the directory that corresponds
+to the top of the tree structure GIT_INDEX_FILE describes).  When the
+environment variable GIT_PROJECT_TOP is set, the value of the variable
+is used.  Then the <path> parameters are canonicalized to be relative to
+the project top.  It then chdir(2)'s to the project top directory and
+runs the given <command>, with <argument> and these canonicalized <path>
+arguments.
+
+This is useful for the Porcelain layer to run core GIT commands from
+subdirectories.  For example, if linux-2.6.git tree is checked out in
+/usr/src/linux, you can do:
+
+    $ cd /usr/src/linux/fs
+    $ ... work in fs directory making changes ...
+    $ git-run-with-user-path git-diff-tree -r HEAD -- ext? ../include/linux
+    $ find ext? ../include/linux ! -type d -print0 |
+      xargs -0 git-run-with-user-path git-update-cache --add -- --
+
+The above is roughly equivalent to:
+
+    $ cd /usr/src/linux
+    $ git-diff-tree -r HEAD fs/ext? include/linux
+    $ find fs/ext? include/linux ! -type d -print0 |
+      xargs git-update-cache --add --
+
+In the second form, this command just canonicalizes and filters paths,
+and writes the resulting paths to the standard output.  '--echo'
+separates each output record with a newline while '--echo-z' uses NUL as
+the record separator.
+
+    $ find ext? ../include/linux ! -type d -print0 |
+      xargs -0 git-run-with-user-path --echo --show-ignore
+
+This example gives you the list of ignored files, one per line.  It is
+roughly equivalent to:
+
+    $ find ext? ../include/linux ! -type d -print0 |
+      xargs -0 -n1 git-run-with-user-path --show-ignore echo --
+
+
+OPTIONS
+-------
+
+--no-ignore::
+
+	By default, the path arguments are filtered with the same ignore
+	rules Porcelain layers use.  With --no-ignore flag, there is no
+	such filtering done.
+
+--show-ignore::
+
+	This causes the filter to be applied in reverse.  Only the paths
+	ignored by the ignore rules are passed to the command (or
+	output).
+
+
+ENVIRONMENT VARIABLES
+---------------------
+
+'GIT_PROJECT_TOP'::
+	If the 'GIT_PROJECT_TOP' environment variable is set then it
+	specifies the directory that corresponds to the top level of the
+	tree structure GIT_INDEX_FILE describes.  When this environment
+	variable is not defined, the closest parent directory that has
+	.git/ subdirectory in it is looked for and used.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
--- a/Makefile
+++ b/Makefile
@@ -28,7 +28,7 @@
 	git-unpack-file git-export git-diff-cache git-convert-cache \
 	git-http-pull git-rpush git-rpull git-rev-list git-mktag \
 	git-diff-helper git-tar-tree git-local-pull git-write-blob \
-	git-get-tar-commit-id
+	git-get-tar-commit-id git-run-with-user-path
 
 all: $(PROG)
 
@@ -46,6 +46,9 @@
 LIB_H += diff.h
 LIB_OBJS += diff.o
 
+LIB_H += paths.h
+LIB_OBJS += paths.o
+
 LIB_OBJS += gitenv.o
 
 LIBS = $(LIB_FILE)
@@ -100,6 +103,7 @@
 git-rpush: rsh.c
 git-rpull: rsh.c pull.c
 git-rev-list: rev-list.c
+git-run-with-user-path: run-with-user-path.c 
 git-mktag: mktag.c
 git-diff-helper: diff-helper.c
 git-tar-tree: tar-tree.c
@@ -117,6 +121,7 @@
 sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
 diff.o: $(LIB_H)
+paths.o: $(LIB_H)
 strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
 
--- /dev/null
+++ b/paths.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright (c) 2005 Junio C Hamano
+ */
+#include <string.h>
+#include "cache.h"
+#include "paths.h"
+
+/****************************************************************/
+
+/* Ignore list handling part */
+
+/*
+ * We fundamentally don't like some paths: we don't want
+ * dot or dot-dot anywhere, and in fact, we don't even want
+ * any other dot-files (.git or anything else). They
+ * are hidden, for chist sake.
+ *
+ * Also, we don't want double slashes or slashes at the
+ * end that can make pathnames ambiguous.
+ */
+int verify_path(const char *path)
+{
+	char c;
+
+	goto inside;
+	for (;;) {
+		if (!c)
+			return 1;
+		if (c == '/') {
+inside:
+			c = *path++;
+			if (c != '/' && c != '.' && c != '\0')
+				continue;
+			return 0;
+		}
+		c = *path++;
+	}
+}
+
+static int initialize_ignore_list(void)
+{
+	/* Put the Porcelain layer ignore logic initialization here.
+	 * Return non-zero after issuing appropriate error message
+	 * if initialization fails.
+	 */
+	return 0;
+}
+
+int path_ignored(const char *path)
+{
+	if (!verify_path(path))
+		return 1;
+
+	/* Put the Porcelain layer ignore logic here.
+	 * Return non-zero if path is to be ignored.
+	 */
+	return 0;
+}
+
+
+/****************************************************************/
+
+/* Path canonicalization part */
+
+char *git_project_top = NULL;
+static char git_cwd[PATH_MAX];
+
+static int find_project_top(void)
+{
+	char path[PATH_MAX];
+	int dir_length;
+
+	if (!getcwd(git_cwd, sizeof(git_cwd)))
+		return error("cannot get cwd to find GIT_PROJECT_TOP");
+
+	git_project_top = gitenv("GIT_PROJECT_TOP");
+	if (git_project_top)
+		return 0;
+
+	strcpy(path, git_cwd);
+	while (path[0] && strcmp(path, "/") && !git_project_top) {
+		char *cp;
+		struct stat st;
+		dir_length = strlen(path);
+		path[dir_length] = '/';
+
+		strcpy(path + dir_length + 1, ".git");
+		if (stat(path, &st) < 0) {
+			if (errno != ENOENT)
+				return error("%s: %s", path, strerror(errno));
+			/* notfound */
+		}
+		else if (S_ISDIR(st.st_mode)) {
+			path[dir_length] = 0;
+			git_project_top = strdup(path);
+			break;
+		}
+		else
+			return error("%s: not a directory", path);
+		path[dir_length] = 0;
+		cp = strrchr(path, '/');
+		if (cp)
+			*cp = 0;
+	}
+	if (!git_project_top)
+		return error("cannot find GIT_PROJECT_TOP");
+
+	return 0;
+}
+
+char *canon_path(const char *path)
+{
+	/* path is either absolute path from root fs or
+	 * relative to the git_cwd.  What is the relative path
+	 * for that thing, viewed from GIT_PROJECT_TOP?
+	 */
+	char *cp, *op, *endp, *result = NULL;
+	char *work = xmalloc(strlen(git_cwd) + strlen(path) + 2);
+	int pfxlen = strlen(git_project_top);
+
+	if (path[0] == '/')
+		strcpy(work, path);
+	else
+		sprintf(work, "%s/%s", git_cwd, path);
+	/* We will copy to *op starting from *cp while removing
+	 * nonsense.  Initially op and cp are both set to one
+	 * past the root-level '/'.
+	 */
+	op = cp = work + 1;
+	endp = cp + strlen(cp);
+	while (cp < endp) {
+		char *ep = strchr(cp, '/');
+		if (!ep)
+			ep = endp; /* at terminating NUL */
+		/* Now look at what is between cp and ep. */
+		if (ep == cp) {
+			/* Remove double slashes.
+			 * "/xxx//foo" ==> "/xxx//foo"
+			 *    cp^              cp^
+			 */
+			cp++;
+			continue;
+		}
+		if (*cp == '.') {
+			/* dot something.  What is it? */
+			if (cp[1] == 0 || cp[1] == '/') {
+				/* Remove trailing dot.
+				 * "/xxx/." ==> "/xxx/."
+				 *     cp^           cp^
+				 * "/xxx/./foo" ==> "/xxx/./foo"
+				 *     cp^               cp^
+				 */
+				cp = ep;
+				continue;
+			}
+			if (cp[1] == '.' && (cp[2] == 0 || cp[2] == '/')) {
+				/* Uplevel.
+				 * "/xxx/../foo" ==> "/xxx/../foo"
+				 *     cp^                  cp^
+				 * while backspacing "xxx" in the op
+				 */
+				cp = cp + 3;
+				op -= 2;
+				if (op < work)
+					op = work + 1;
+				while (*op != '/' && work < op)
+					op--;
+				op++;
+				continue;
+			}
+		}
+		/* otherwise there is no funnies */
+		while (cp <= ep && *cp)
+			*op++ = *cp++;
+	}
+	*op = 0;
+	if (op[-1] == '/' && op != work)
+		op[-1] = 0;
+
+	if (!strncmp(git_project_top, work, pfxlen) &&
+	    (work[pfxlen] == '/' || work[pfxlen] == 0))
+		result = strdup(work + pfxlen + 1);
+	/* otherwise, path is outside of git-project-top and we ignore it. */
+
+	free(work);
+	return result;
+}
+
+/****************************************************************/
+
+int setup_paths(void)
+{
+	if (find_project_top())
+		return -1;
+	if (initialize_ignore_list())
+		return -1;
+	return 0;
+}
+
--- /dev/null
+++ b/paths.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (c) 2005 Junio C Hamano
+ */
+#ifndef _PATHS_H_
+#define _PATHS_H_
+
+int setup_paths(void);
+extern char *git_project_top;
+
+char *canon_path(const char *);
+int path_ignored(const char *);
+int verify_path(const char *);
+
+#endif
--- /dev/null
+++ b/run-with-user-path.c
@@ -0,0 +1,87 @@
+/*
+ * Copyright (c) 2005 Junio C Hamano
+ */
+#include <unistd.h>
+#include "cache.h"
+#include "paths.h"
+
+static int no_ignore = 0, show_ignore = 0, echo = 0, line_termination = '\n';
+
+static const char *usage_rwup = 
+"git-run-with-user-path [ --no-ignore ] [ --show-ignore ] "
+"( --echo-z | --echo | <command> <argument>... -- <path>... )";
+
+static int prepare_path_args(char **exec_param, char **path)
+{
+	int i, cnt;
+	char *canon;
+
+	for (i = cnt = 0; path[i]; i++) {
+		canon = canon_path(path[i]);
+		if (no_ignore ||
+		    !!path_ignored(canon) == !!show_ignore)
+			exec_param[cnt++] = canon;
+	}
+	return cnt;
+}
+
+int main(int ac, char **av)
+{
+	char **exec_param;
+	int i, command_end, cnt_path;
+
+	if (setup_paths())
+		exit(1);
+
+	while (1 < ac && av[1][0] == '-') {
+		if (!strcmp(av[1], "--no-ignore"))
+			no_ignore = 1;
+		else if (!strcmp(av[1], "--show-ignore"))
+			show_ignore = 1;
+		else if (!strcmp(av[1], "--echo"))
+			echo = 1;
+		else if (!strcmp(av[1], "--echo-z")) {
+			echo = 1;
+			line_termination = 0;
+		}
+		else
+			break;
+		ac--; av++;
+	}
+
+	exec_param = xcalloc(ac, sizeof(char *));
+
+	if (echo) {
+		cnt_path = prepare_path_args(exec_param, av + 1);
+		for (i = 0; exec_param[i]; i++)
+			printf("%s%c", exec_param[i], line_termination);
+		exit(0);
+	}
+
+	for (i = 1; i < ac; i++)
+		if (!strcmp(av[i], "--"))
+			break;
+	if (ac <= i)
+		die(usage_rwup); /* no -- to start path */
+
+	command_end = i; /* pointing at -- */
+	/* command command arg1 arg2 ... path1 path2 ... NULL */
+	for (i = 1; i < command_end; i++)
+		exec_param[i - 1] = av[i];
+
+	/* We need to special case -- (end of command) followed
+	 * immediately by -- (beginning of paths); otherwise
+	 * "git-run-with-user-path git-update-cache --add -- -- foo"
+	 * would try canonicalize and filter path arguments starting
+	 * from -- (beginning of paths), which is not what we want.
+	 */
+	if (!strcmp(av[command_end + 1], "--")) {
+		exec_param[command_end-1] = av[command_end + 1];
+		command_end++;
+	}
+	cnt_path = prepare_path_args(exec_param + command_end - 1,
+				     av + command_end + 1);
+	chdir(git_project_top);
+	execvp(exec_param[0], exec_param);
+	exit(1);
+}
--- a/t/README
+++ b/t/README
@@ -73,6 +73,7 @@
 	4 - the diff commands
 	5 - the pull and exporting commands
 	6 - the revision tree commands (even e.g. merge-base)
+	7 - the non-core commands and helpers
 
 Second digit tells the particular command we are testing.
 
--- /dev/null
+++ b/t/t7000-git-run-with-user-path-basic.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+#
+# Copyright (c) 2005, Junio C Hamano
+#
+
+test_description='git-run-with-user-path basic test.
+
+The command is used to help running core GIT commands that always
+expect to be run from the top level directory (i.e. the directory
+that corresponds to the top of tree GIT_INDEX_FILE describes).
+'
+
+. ./test-lib.sh
+
+LF='
+'
+HERE=$(pwd)
+
+test_expect_success \
+setup '
+mkdir path0 path1 path1/path2
+for p in path0/file0 path1/file1 path1/path2/file2
+do
+    echo hello >$p
+    git-update-cache --add -- $p
+done
+'
+
+test_expect_success \
+'finding paths from a subdirectory' '
+    case "$(cd path0 &&
+            git-run-with-user-path --no-ignore cat -- \
+	    file0 ../path1/path2/file2)" in
+    "hello${LF}hello") : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+test_expect_success \
+'feeding find output via xargs from a subdirectory' '
+    case "$(cd path0 &&
+	    find . ../path1 -type f -print0 |
+	    xargs -r -0 git-run-with-user-path --no-ignore cat --)" in
+    "hello${LF}hello${LF}hello") : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+cd $HERE
+test_expect_success \
+'handling special case -- at the end of command' '
+    case "$(cd path0 &&
+            git-run-with-user-path --no-ignore echo -- \
+	    -- ../path1/file1)" in
+    "-- path1/file1") : ;;
+    *) (exit 1) ;;
+    esac	    
+'
+
+cd $HERE
+test_expect_success \
+'the --echo option' '
+    case "$(cd path0 &&
+            git-run-with-user-path --no-ignore --echo ../path1/file1)" in
+    "path1/file1") : ;;
+    *) (exit 1) ;;
+    esac	    
+'
+
+cd $HERE
+mv .git .svn
+GIT_DIR=$(pwd)/.svn
+GIT_PROJECT_TOP=$(pwd)
+export GIT_DIR GIT_PROJECT_TOP
+
+test_expect_success \
+'feeding find output via xargs from a subdirectory (with GIT_PROJECT_TOP)' '
+    case "$(cd path0 &&
+            find . ../path1 -type f -print0 |
+	    xargs -r -0 git-run-with-user-path --no-ignore cat --)" in
+    "hello${LF}hello${LF}hello") : ;;
+    *) (exit 1) ;;
+    esac
+    cd ..
+'
+
+test_done
--- a/update-cache.c
+++ b/update-cache.c
@@ -5,6 +5,7 @@
  */
 #include <signal.h>
 #include "cache.h"
+#include "paths.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -257,34 +258,6 @@
 	return has_errors;
 }
 
-/*
- * We fundamentally don't like some paths: we don't want
- * dot or dot-dot anywhere, and in fact, we don't even want
- * any other dot-files (.git or anything else). They
- * are hidden, for chist sake.
- *
- * Also, we don't want double slashes or slashes at the
- * end that can make pathnames ambiguous.
- */
-static int verify_path(char *path)
-{
-	char c;
-
-	goto inside;
-	for (;;) {
-		if (!c)
-			return 1;
-		if (c == '/') {
-inside:
-			c = *path++;
-			if (c != '/' && c != '.' && c != '\0')
-				continue;
-			return 0;
-		}
-		c = *path++;
-	}
-}
-
 static int add_cacheinfo(char *arg1, char *arg2, char *arg3)
 {
 	int size, len, option;
------------------------------------------------

