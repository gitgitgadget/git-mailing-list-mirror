From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC/PATCH] Implement git-cp.
Date: Sun, 10 Feb 2008 02:12:03 +0100
Message-ID: <20080210011203.GL25954@genesis.frugalware.org>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> <vpq63x5swsj.fsf@bauges.imag.fr> <m3tzkp6eqz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO0ko-0006gg-2x
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbYBJBMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYBJBMg
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:12:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55312 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbYBJBMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:12:34 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JO0ju-0005zy-1T
	from <vmiklos@frugalware.org>; Sun, 10 Feb 2008 02:12:27 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C5CD911901F8; Sun, 10 Feb 2008 02:12:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <m3tzkp6eqz.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73281>

Actually it adds a -c option to git-mv to copy instead of move and add a
builtin alias git-cp for 'git mv -c'.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Feb 03, 2008 at 11:07:10AM -0800, Jakub Narebski <jnareb@gmail.com> wrote:
> You can just put git-cp shell script doing this in PATH (or
> GIT_EXEC_PATH if they are different) for "git cp" to just work.
> Or you can write builtin-cp.c, following builtin-mv.c

something like this?

 .gitignore                   |    1 +
 Documentation/git-cp.txt     |   42 +++++++++++++++++
 Documentation/git-mv.txt     |   12 +----
 Documentation/mv-options.txt |    9 ++++
 Makefile                     |    1 +
 builtin-cp.c                 |   24 ++++++++++
 builtin-mv.c                 |  104 ++++++++++++++++++++++++++++++++++++++++--
 builtin.h                    |    1 +
 command-list.txt             |    1 +
 git.c                        |    1 +
 t/t7006-cp.sh                |   75 ++++++++++++++++++++++++++++++
 11 files changed, 257 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/git-cp.txt
 create mode 100644 Documentation/mv-options.txt
 create mode 100644 builtin-cp.c
 create mode 100755 t/t7006-cp.sh

diff --git a/.gitignore b/.gitignore
index 7f8421d..3d1dcdd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@ git-commit
 git-commit-tree
 git-config
 git-count-objects
+git-cp
 git-cvsexportcommit
 git-cvsimport
 git-cvsserver
diff --git a/Documentation/git-cp.txt b/Documentation/git-cp.txt
new file mode 100644
index 0000000..3109d04
--- /dev/null
+++ b/Documentation/git-cp.txt
@@ -0,0 +1,42 @@
+git-cp(1)
+=========
+
+NAME
+----
+git-cp - Copy a file, a directory, or a symlink
+
+SYNOPSIS
+--------
+'git-cp' <options>... <args>...
+
+DESCRIPTION
+-----------
+This script is used to copy a file, directory or symlink.
+
+ git-cp [-f] [-n] <source> <destination>
+ git-cp [-f] [-n] [-k] <source> ... <destination directory>
+
+In the first form, it copies <source>, which must exist and be either
+a file, symlink or directory, to <destination>.
+In the second form, the last argument has to be an existing
+directory; the given sources will be copied into this directory.
+
+The index is updated after successful completion, but the change must still be
+committed.
+
+
+OPTIONS
+-------
+include::mv-options.txt[]
+
+SEE ALSO
+--------
+linkgit:git-mv[1]
+
+AUTHOR
+------
+Written by Miklos Vajna <vmiklos@frugalware.org>.
+
+GIT
+---
+Part of the linkgit:git[7] suite
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index bff3fbe..45d8255 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -27,15 +27,9 @@ committed.
 
 OPTIONS
 -------
--f::
-	Force renaming or moving of a file even if the target exists
--k::
-        Skip move or rename actions which would lead to an error
-	condition. An error happens when a source is neither existing nor
-        controlled by GIT, or when it would overwrite an existing
-        file unless '-f' is given.
--n, \--dry-run::
-	Do nothing; only show what would happen
+include::mv-options.txt[]
+-c::
+	Copy instead of move.
 
 
 Author
diff --git a/Documentation/mv-options.txt b/Documentation/mv-options.txt
new file mode 100644
index 0000000..ad78d1e
--- /dev/null
+++ b/Documentation/mv-options.txt
@@ -0,0 +1,9 @@
+-f::
+	Force renaming or moving of a file even if the target exists
+-k::
+        Skip move or rename actions which would lead to an error
+	condition. An error happens when a source is neither existing nor
+        controlled by GIT, or when it would overwrite an existing
+        file unless '-f' is given.
+-n, \--dry-run::
+	Do nothing; only show what would happen
diff --git a/Makefile b/Makefile
index 92341c4..0dd8e02 100644
--- a/Makefile
+++ b/Makefile
@@ -338,6 +338,7 @@ BUILTIN_OBJS = \
 	builtin-commit.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
+	builtin-cp.o \
 	builtin-describe.o \
 	builtin-diff.o \
 	builtin-diff-files.o \
diff --git a/builtin-cp.c b/builtin-cp.c
new file mode 100644
index 0000000..f66daba
--- /dev/null
+++ b/builtin-cp.c
@@ -0,0 +1,24 @@
+/*
+ * "git cp" builtin alias
+ *
+ * Copyright (C) 2008 Miklos Vajna
+ */
+#include "git-compat-util.h"
+#include "builtin.h"
+
+int cmd_cp(int argc, const char **argv, const char *prefix)
+{
+	const char **nargv;
+	int i;
+	nargv = xmalloc(sizeof(char *) * (argc + 2));
+
+	nargv[0] = "mv";
+	nargv[1] = "-c";
+
+	for (i = 1; i < argc; i++) {
+		nargv[i+1] = argv[i];
+	}
+	nargv[argc + 1] = NULL;
+
+	return cmd_mv(argc + 1, nargv, prefix);
+}
diff --git a/builtin-mv.c b/builtin-mv.c
index 990e213..8c069a5 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -60,14 +60,103 @@ static const char *add_slash(const char *path)
 	return path;
 }
 
+static int copyfile(const char *src_name, const char *dst_name)
+{
+	int ifd;
+	int ofd;
+	struct stat sb;
+	int cnt;
+	char buf[1024];
+
+	stat(src_name, &sb);
+	if ((ifd = open (src_name, O_RDONLY)) < 0)
+		die("could not open file %s for reading: %s", src_name, strerror(errno));
+	if ((ofd =
+	     open (dst_name, O_WRONLY | O_CREAT | O_TRUNC, 0)) < 0
+	    || chmod (dst_name, sb.st_mode & 07777))
+		die("could not open file %s for writing: %s", dst_name, strerror(errno));
+	while ((cnt = read (ifd, buf, sizeof buf)) > 0) {
+		if (write (ofd, buf, cnt) != cnt)
+			die("could not write to file %s", dst_name);
+	}
+	close (ifd);
+	close (ofd);
+	return 0;
+}
+
+static int copytree (const char *src_root, const char *dst_root)
+{
+	char src_name[1024];
+	char dst_name[1024];
+	int err = 0;
+	struct dirent *ent;
+	struct stat sb;
+	DIR *dir;
+
+	lstat(src_root, &sb);
+
+	if (!(dir = opendir (src_root)))
+		return copyfile(src_root, dst_root);
+	else
+		mkdir(dst_root, sb.st_mode);
+
+	while ((ent = readdir (dir))) {
+
+		if (strcmp (ent->d_name, ".") == 0 ||
+		    strcmp (ent->d_name, "..") == 0)
+			continue;
+
+		snprintf (src_name, sizeof src_name, "%s/%s", src_root,
+			  ent->d_name);
+
+		snprintf (dst_name, sizeof dst_name, "%s/%s", dst_root,
+			  ent->d_name);
+
+		if (lstat (src_name, &sb) < 0)
+			continue;
+
+		if (S_ISDIR (sb.st_mode)) {
+
+			if (mkdir (dst_name, sb.st_mode)
+			    || chmod (dst_name, sb.st_mode & 07777)
+			    || copytree (src_name, dst_name)) {
+				break;
+			}
+			continue;
+		}
+
+		if (S_ISLNK (sb.st_mode)) {
+			char oldlink[1024];
+			char dummy[1024];
+			int len;
+
+			if ((len =
+			     readlink (src_name, oldlink,
+				       sizeof (oldlink) - 1)) < 0)
+				die("could not read symlink %s: %s", src_name, strerror(errno));
+			oldlink[len] = '\0'; /* readlink() does not NULL-terminate */
+			if (symlink (oldlink, dst_name))
+				die("could not create symlink %s: %s", dst_name, strerror(errno));
+			continue;
+		}
+
+		if (copyfile(src_name, dst_name) == -1)
+			break;
+	}
+	closedir (dir);
+
+	return 0;
+}
+
 static struct lock_file lock_file;
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
+	int verbose = 0, show_only = 0, copy = 0, force = 0, ignore_errors = 0;
 	struct option builtin_mv_options[] = {
 		OPT__DRY_RUN(&show_only),
+		OPT_BOOLEAN('c', NULL, &copy, "copy instead of move/rename"),
 		OPT_BOOLEAN('f', NULL, &force, "force move/rename even if target exists"),
 		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
 		OPT_END(),
@@ -220,15 +309,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		enum update_mode mode = modes[i];
 		if (show_only || verbose)
 			printf("Renaming %s to %s\n", src, dst);
-		if (!show_only && mode != INDEX &&
-				rename(src, dst) < 0 && !ignore_errors)
-			die ("renaming %s failed: %s", src, strerror(errno));
+		if (!show_only && mode != INDEX)
+		{
+			if(!copy && rename(src, dst) < 0 && !ignore_errors)
+				die ("renaming %s failed: %s", src, strerror(errno));
+			else if (copytree(src, dst) < 0 && !ignore_errors)
+				die ("copying %s failed: %s", src, strerror(errno));
+		}
 
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
 		if (cache_name_pos(src, strlen(src)) >= 0) {
-			path_list_insert(src, &deleted);
+			if(!copy)
+				path_list_insert(src, &deleted);
 
 			/* destination can be a directory with 1 file inside */
 			if (path_list_has_path(&overwritten, dst))
diff --git a/builtin.h b/builtin.h
index cb675c4..e1a85fe 100644
--- a/builtin.h
+++ b/builtin.h
@@ -28,6 +28,7 @@ extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_cp(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/command-list.txt b/command-list.txt
index 3583a33..ddfcdaf 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -24,6 +24,7 @@ git-commit                              mainporcelain common
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
+git-cp                                  mainporcelain common
 git-cvsexportcommit                     foreignscminterface
 git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
diff --git a/git.c b/git.c
index 15fec89..f6a104b 100644
--- a/git.c
+++ b/git.c
@@ -298,6 +298,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "cp", cmd_cp, RUN_SETUP | NEED_WORK_TREE },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files },
diff --git a/t/t7006-cp.sh b/t/t7006-cp.sh
new file mode 100755
index 0000000..217072c
--- /dev/null
+++ b/t/t7006-cp.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='git cp in subdirs'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare reference tree' \
+    'mkdir path0 path1 &&
+     cp ../../COPYING path0/COPYING &&
+     git add path0/COPYING &&
+     git-commit -m add -a'
+
+test_expect_success \
+    'copying the file out of subdirectory' \
+    'cd path0 && git cp COPYING ../path1/COPYING'
+
+# in path0 currently
+test_expect_success \
+    'commiting the change' \
+    'cd .. && git-commit -m copy-out -a'
+
+test_expect_success \
+    'checking the commit' \
+    'git diff-tree -r -C --find-copies-harder --name-status  HEAD^ HEAD | \
+    grep "^C100..*path0/COPYING..*path1/COPYING"'
+
+test_expect_success \
+    'adding another file' \
+    'cp ../../README path0/README &&
+     git add path0/README &&
+     git-commit -m add2 -a'
+
+test_expect_success \
+    'copying whole subdirectory' \
+    'git cp path0 path2'
+
+test_expect_success \
+    'commiting the change' \
+    'git-commit -m dir-copy -a'
+
+test_expect_success \
+    'checking the commit' \
+    'git diff-tree -r -C --find-copies-harder --name-status  HEAD^ HEAD | \
+     grep "^C100..*path0/COPYING..*path2/COPYING" &&
+     git diff-tree -r -C --find-copies-harder --name-status  HEAD^ HEAD | \
+     grep "^C100..*path0/README..*path2/README"'
+
+test_expect_success \
+    'succeed when source is a prefix of destination' \
+    'git cp path2/COPYING path2/COPYING-copied'
+
+test_expect_success \
+    'copying whole subdirectory into subdirectory' \
+    'git cp path2 path1'
+
+test_expect_success \
+    'commiting the change' \
+    'git-commit -m dir-move -a'
+
+test_expect_success \
+    'checking the commit' \
+    'git diff-tree -r -C --find-copies-harder --name-status  HEAD^ HEAD | \
+     grep "^C100..*path0/COPYING..*path1/path2/COPYING" &&
+     git diff-tree -r -C --find-copies-harder --name-status  HEAD^ HEAD | \
+     grep "^C100..*path0/README..*path1/path2/README"'
+
+test_expect_success \
+    'do not copy directory over existing directory' \
+    'rm -rf path0 && mkdir path0 && mkdir path0/path2 && ! git cp path2 path0'
+
+test_expect_success \
+    'copy "."' \
+    'rm -rf path2 && git cp path1/path2/ .'
+
+test_done
-- 
1.5.4
