From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Add sample ignore logic to git-run-with-user-path
 command.
Date: Mon, 16 May 2005 16:41:22 -0700
Message-ID: <7vwtpylowt.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0l3puzg.fsf@assigned-by-dhcp.cox.net>
	<7v8y2en4e8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 01:44:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXpF8-00065z-Nn
	for gcvg-git@gmane.org; Tue, 17 May 2005 01:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVEPXns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 19:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVEPXns
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 19:43:48 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:3467 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261312AbVEPXla (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 19:41:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050516234124.VNLI19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 May 2005 19:41:24 -0400
To: pasky@ucw.cz, torvalds@osdl.org
In-Reply-To: <7v8y2en4e8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 16 May 2005 16:21:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a sample ignore file logic to git-run-with-user-path
command.  This is primarily to serve as an example for plugging
ignore file logic to the previously introduced framework, and to
spur mailing list discussions on what the final ignore file
logic should be, and where the information should come from.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/git-run-with-user-path.txt |   32 ++++++++
Makefile                                 |    6 +
paths.c                                  |  117 +++++++++++++++++++++++++++++--
t/t7001-git-run-with-user-path-ignore.sh |   67 +++++++++++++++++
4 files changed, 215 insertions(+), 7 deletions(-)
t/t7001-git-run-with-user-path-ignore.sh (. --> 100755)

--- a/Documentation/git-run-with-user-path.txt
+++ b/Documentation/git-run-with-user-path.txt
@@ -75,6 +75,38 @@
 	output).
 
 
+IGNORE FILES
+------------
+
+This command currently uses a pcre based implementation to express
+ignore patterns.  The purpose of this implementation is to primarily
+serve as an example and to start GIT mailing list discussions, and by no
+means is cast in stone.  This section describes what this sample
+implementation does.
+
+The information used to define which paths to ignore is read from two
+files.  Both files use the same syntax.
+
+First, $CIT_DIR/ignore is read.  Then, the file whose path (relative to
+the project top) recorded in $GIT_DIR/info/ignore-file is read next.
+The latter file is expected to be revision controlled with GIT.
+
+These two files should record one ignore record per line.  A line that
+is empty, and a line that starts with a '#' are ignored and used as
+comments.
+
+Each ignore record is a pcre regular expression, optionally prefixed
+with a '!'.  To determine if a path is to be ignored, the path is
+matched against each ignore record in the order they appear in the
+ignore file.  If the ignore record matches the path, and it does not
+have the optional '!', then the path is ignored.  Otherwise, the path is
+not ignored.  In either case, the rest of ignore records are not used
+after the first match.  This means (1) an earlier entry in an ignore
+file has precedence over later ones, and (2) the entries in
+$GIT_DIR/ignore file have precedence over the ones in the file named
+by $GIT_DIR/info/ignore-file.
+
+
 ENVIRONMENT VARIABLES
 ---------------------
 
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,12 @@
 LIBS = $(LIB_FILE)
 LIBS += -lz
 
+IGNORE_USING_PCRE=1
+
+ifdef IGNORE_USING_PCRE
+  LIBS += -lpcreposix
+endif
+
 ifdef MOZILLA_SHA1
   SHA1_HEADER="mozilla-sha1/sha1.h"
   LIB_OBJS += mozilla-sha1/sha1.o
--- a/paths.c
+++ b/paths.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 #include <string.h>
+#include <pcreposix.h>
 #include "cache.h"
 #include "paths.h"
 
@@ -37,23 +38,125 @@
 	}
 }
 
+static struct ignore_entry {
+	int negate;
+	regex_t regexp;
+} **ignore_list;
+static int ignore_nr;
+static int ignore_alloc;
+
+static void add_ignore(const char *buf)
+{
+	struct ignore_entry *ie = xmalloc(sizeof(*ie));
+	if (buf[0] == '!') {
+		ie->negate = 1;
+		buf++;
+	}
+	else
+		ie->negate = 0;
+
+	if (regcomp(&(ie->regexp), buf, 0)) {
+		fprintf(stderr, "bad regexp <%s>\n", buf);
+		free(ie);
+		return;
+	}
+	if (ignore_alloc <= ignore_nr) {
+		ignore_alloc = alloc_nr(ignore_alloc);
+		ignore_list = xrealloc(ignore_list,
+				       ignore_alloc * sizeof(ie));
+	}
+	ignore_list[ignore_nr++] = ie;
+}
+
+static void read_ignore_list(const char *path)
+{
+	FILE *in;
+	char buf[1024];
+	in = fopen(path, "r");
+	if (!in)
+		return;
+	while (fgets(buf, sizeof(buf), in) != NULL) {
+		int l = strlen(buf);
+		/* An empty line and a line that starts with # is comment. */
+		if (buf[0] != '#' && buf[0] != '\n' && buf[l-1] == '\n') {
+			buf[l-1] = 0;
+			add_ignore(buf);
+		}
+	}
+	fclose(in);
+}
+
+static void read_ignore_list_from_file(const char *path)
+{
+	char filename[PATH_MAX];
+	int len;
+	FILE *in;
+
+	in = fopen(path, "r");
+	if (!in)
+		return;
+	strcpy(filename, git_project_top);
+	len = strlen(filename);
+	filename[len++] = '/';
+	if (fgets(filename + len, sizeof(filename) - len, in) == NULL) {
+		fclose(in);
+		return;
+	}
+	fclose(in);
+	len = strlen(filename);
+	if (filename[len-1] != '\n')
+		return;
+	filename[len-1] = 0;
+	read_ignore_list(filename);
+}
+
 static int initialize_ignore_list(void)
 {
-	/* Put the Porcelain layer ignore logic initialization here.
-	 * Return non-zero after issuing appropriate error message
-	 * if initialization fails.
-	 */
+	char *git_dir = gitenv("GIT_DIR");
+	char path[PATH_MAX];
+	int git_dir_len;
+
+	if (! git_dir)
+		sprintf(path, "%s/.git", git_project_top);
+	else
+		strcpy(path, git_dir);
+	git_dir_len = strlen(path);
+	path[git_dir_len++] = '/';
+
+	/* read private list first, and then shared list. */
+	strcpy(path + git_dir_len, "ignore");
+	read_ignore_list(path);
+
+	strcpy(path + git_dir_len, "info/ignore-file");
+	read_ignore_list_from_file(path);
+
 	return 0;
 }
 
 int path_ignored(const char *path)
 {
+	int i;
+
 	if (!verify_path(path))
 		return 1;
 
-	/* Put the Porcelain layer ignore logic here.
-	 * Return non-zero if path is to be ignored.
-	 */
+	for (i = 0; i < ignore_nr; i++) {
+		int status;
+		regmatch_t pmatch[10];
+		char errbuf[1024];
+
+		status = regexec(&(ignore_list[i]->regexp), path,
+				 sizeof(pmatch)/sizeof(pmatch[0]),
+				 pmatch, 0);
+		if (!status)
+			return !ignore_list[i]->negate;
+		if (status == REG_NOMATCH)
+			continue;
+
+		regerror(status, &(ignore_list[i]->regexp), errbuf,
+			 sizeof(errbuf));
+		fprintf(stderr, "pcre regexp execution error <%s>\n", errbuf);
+	}
 	return 0;
 }
 
--- /dev/null
+++ b/t/t7001-git-run-with-user-path-ignore.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+#
+# Copyright (c) 2005, Junio C Hamano
+#
+
+test_description='git-run-with-user-path basic test (part #2).
+
+The command is used to help running core GIT commands that always
+expect to be run from the top level directory (i.e. the directory
+that corresponds to the top of tree GIT_INDEX_FILE describes).
+
+It knows how to handle ignore files convention used by the Porcelain
+layer implementation.
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
+echo ".*1\$" >.git/ignore &&
+echo ".*0\$" >dontdiff &&
+mkdir .git/info &&
+echo "dontdiff" >.git/info/ignore-file &&
+mkdir path0 path1 path1/path2 &&
+for p in path0/file0 path1/file1 path1/path2/file2
+do
+    echo hello >$p || exit 1
+done
+'
+
+cd $HERE
+test_expect_success \
+'finding paths from a subdirectory' '
+    case "$(cd path0 &&
+            git-run-with-user-path echo -- \
+	    file0 ../path1/path2/file2)" in
+    "path1/path2/file2") : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+cd $HERE
+test_expect_success \
+'feeding find output via xargs from a subdirectory' '
+    case "$(cd path0 &&
+	    find . ../path1 -type f -print0 |
+	    xargs -r -0 git-run-with-user-path ls -1 --)" in
+    "path1/path2/file2") : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+cd $HERE
+test_expect_success \
+'using !negate pattern' '
+    echo "!path0/file0$" >>.git/ignore &&
+    case "$(git-run-with-user-path ls -1 -- path0/* path1/file1)" in
+    "path0/file0") : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+test_done
------------------------------------------------

