From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Wed, 11 May 2005 15:12:10 -0700
Message-ID: <7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 00:06:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzKw-0005sp-4C
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVEKWNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVEKWNG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:13:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52108 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261282AbVEKWMN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 18:12:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511221211.SVWQ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 18:12:11 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vpsvxqwab.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 11 May 2005 14:37:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a re-diff against the current tip of the git-pb tree.

------------
Fix checkout-cache when existing work tree interferes with the checkout.

This is essentially the same one as the last one I sent to the
GIT list, except that the patch is rebased to the current tip of
the git-pb tree, and an unnecessary call to create_directories()
removed.

The checkout-cache command gets confused when checking out a
file in a subdirectory and the work tree has a symlink to the
subdirectory.  Also it fails to check things out when there is a
non-directory in the work tree when cache expects a directory
there, and vice versa.  This patch fixes the first problem by
making sure all the leading paths in the file being checked out
are indeed directories, and also fixes directory vs
non-directory conflicts when '-f' is specified by removing the
offending paths.

I've added test subdirectory and two tests to check the above
problems are fixed.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

checkout-cache.c          |   49 +++++++++++++++++++++++++++++++++--
t/t0000.sh                |   38 +++++++++++++++++++++++++++
t/t1000-checkout-cache.sh |   42 ++++++++++++++++++++++++++++++
t/t1001-checkout-cache.sh |   64 ++++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 190 insertions(+), 3 deletions(-)

--- a/checkout-cache.c
+++ b/checkout-cache.c
@@ -32,6 +32,8 @@
  * of "-a" causing problems (not possible in the above example,
  * but get used to it in scripting!).
  */
+#include <sys/types.h>
+#include <dirent.h>
 #include "cache.h"
 
 static int force = 0, quiet = 0, not_new = 0;
@@ -46,20 +48,61 @@ static void create_directories(const cha
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
-		mkdir(buf, 0755);
+		if (mkdir(buf, 0755)) {
+			if (errno == EEXIST) {
+				struct stat st;
+				if (!lstat(buf, &st) && S_ISDIR(st.st_mode))
+					continue; /* ok */
+				if (force && !unlink(buf) && !mkdir(buf, 0755))
+					continue;
+			}
+			die("cannot create directory at %s", buf);
+		}
 	}
 	free(buf);
 }
 
+static void remove_subtree(const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *de;
+	char pathbuf[PATH_MAX];
+	char *name;
+	
+	if (!dir)
+		die("cannot opendir %s", path);
+	strcpy(pathbuf, path);
+	name = pathbuf + strlen(path);
+	*name++ = '/';
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+		if ((de->d_name[0] == '.') &&
+		    ((de->d_name[1] == 0) ||
+		     ((de->d_name[1] == '.') && de->d_name[2] == 0)))
+			continue;
+		strcpy(name, de->d_name);
+		if (lstat(pathbuf, &st))
+			die("cannot lstat %s", pathbuf);
+		if (S_ISDIR(st.st_mode))
+			remove_subtree(pathbuf);
+		else if (unlink(pathbuf))
+			die("cannot unlink %s", pathbuf);
+	}
+	closedir(dir);
+	if (rmdir(path))
+		die("cannot rmdir %s", path);
+}
+
 static int create_file(const char *path, unsigned int mode)
 {
 	int fd;
 
 	mode = (mode & 0100) ? 0777 : 0666;
+	create_directories(path);
 	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 	if (fd < 0) {
-		if (errno == ENOENT) {
-			create_directories(path);
+		if (errno == EISDIR && force) {
+			remove_subtree(path);
 			fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, mode);
 		}
 	}
Created: t/t0000.sh (mode:100755)
--- /dev/null
+++ b/t/t0000.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+case "${verbose+set}" in
+set)	say= ;;
+*)	say=: ;;
+esac
+
+export LANG C
+unset AUTHOR_DATE
+unset AUTHOR_EMAIL
+unset AUTHOR_NAME
+unset COMMIT_AUTHOR_EMAIL
+unset COMMIT_AUTHOR_NAME
+unset GIT_ALTERNATE_OBJECT_DIRECTORIES
+unset GIT_AUTHOR_DATE
+unset GIT_AUTHOR_EMAIL
+unset GIT_AUTHOR_NAME
+unset GIT_COMMITTER_EMAIL
+unset GIT_COMMITTER_NAME
+unset GIT_DIFF_OPTS
+unset GIT_DIR
+unset GIT_EXTERNAL_DIFF
+unset GIT_INDEX_FILE
+unset GIT_OBJECT_DIRECTORY
+unset SHA1_FILE_DIRECTORIES
+unset SHA1_FILE_DIRECTORY
+
+# Test the binaries we have just built.
+PATH=$(pwd)/..:$PATH
+
+# Test repository
+test=test-repo
+rm -fr "$test"
+mkdir "$test"
+cd "$test"
Created: t/t1000-checkout-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t1000-checkout-cache.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./t0000.sh
+git-init-db 2>/dev/null || exit
+date >path0
+mkdir path1
+date >path1/file1
+git-update-cache --add path0 path1/file1
+$say git-ls-files --stage
+
+rm -fr path0 path1
+mkdir path0
+date >path0/file0
+date >path1
+$say git-ls-files --stage
+$say find path*
+
+echo >&2 "* checkout-cache sans -f"
+git-checkout-cache -a
+case "$?" in
+0)	echo >&2 "*** bug: should not have succeeded." ;;
+*)	echo >&2 "*** ok: failed as expected." ;;
+esac
+$say find path*
+
+echo >&2 "* checkout-cache with -f"
+git-checkout-cache -f -a
+case "$?" in
+0)	echo >&2 "*** ok: succeeded as expected." ;;
+*)	echo >&2 "*** bug: should have succeeded." ;;
+esac
+$say find path*
+if test -f path0 && test -d path1 && test -f path1/file1
+then
+	echo >&2 "*** ok: checked out correctly."
+else
+	echo >&2 "*** bug: checkout failed."
+	exit 1
+fi
Created: t/t1001-checkout-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t1001-checkout-cache.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./t0000.sh
+git-init-db 2>/dev/null || exit
+
+show_files() {
+	find path? -ls |
+	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
+	git-ls-files --stage |
+	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
+	git-ls-tree -r "$1" |
+	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
+}
+
+mkdir path0
+date >path0/file0
+git-update-cache --add path0/file0
+echo >&2 "* initial state: one file under one directory"
+tree1=$(git-write-tree)
+$say show_files $tree1
+
+mkdir path1
+date >path1/file1
+git-update-cache --add path1/file1
+echo >&2 "* two directories with one file each"
+tree2=$(git-write-tree)
+$say show_files $tree2
+
+rm -fr path1
+git-read-tree -m $tree1
+git-checkout-cache -f -a
+echo >&2 "* go back to initial state"
+$say show_files $tree1
+
+ln -s path0 path1
+git-update-cache --add path1
+echo >&2 "* a symlink where the other side would create a directory."
+tree3=$(git-write-tree)
+$say show_files $tree3
+
+# Morten says "Got that?" here.
+
+git-read-tree $tree2
+git-checkout-cache -f -a
+case "$?" in
+0)	echo >&2 "*** ok: succeeded as expected." ;;
+*)	echo >&2 "*** bug: should have succeeded." ;;
+esac
+echo >&2 "* read tree2 and checkout"
+$say show_files $tree2
+
+if test ! -h path0 && test -d path0 &&
+   test ! -h path1 && test -d path1 &&
+   test ! -h path0/file0 && test -f path0/file0 &&
+   test ! -h path1/file1 && test -f path1/file1
+then
+    echo >&2 "*** ok: checked out correctly."
+else
+    echo >&2 "*** bug: did not check out correctly."
+    exit 1
+fi
------------------------------------------------

