From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into a git work-dir
Date: Sat, 22 Nov 2008 13:33:34 -0800
Message-ID: <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 22 22:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L408e-0000kL-CR
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 22:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbYKVVdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbYKVVdj
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 16:33:39 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:34947 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752876AbYKVVdi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Nov 2008 16:33:38 -0500
Received: (qmail 89384 invoked from network); 22 Nov 2008 21:33:37 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp109.sbc.mail.mud.yahoo.com with SMTP; 22 Nov 2008 21:33:37 -0000
X-YMail-OSG: JA.l4SkVM1kmjyvFsPC72dp2FOOCfL0dmLDI77iiAIkONRQE8GFemo78cGJE04vACKHni_z8EeGMeZVCRN6lfqMeIpRhsKOFAIfb1sWq3PvGC6d42okK0yDxdyYRm.R6tfZQnRXS0V9eBO_Fv3oB74xuWdBfmgFk030dxSzYBzLdcUjI
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L406g-0000DS-8C; Sat, 22 Nov 2008 13:33:34 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <cover.1226759762.git.marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101557>

* Change "git rev-parse --show-cdup" to print a full path instead of
  a series of "../" when it prints anything
* Added a special case to support some existing scripts that rely
  on --show-cdup's prior behavior of printing a blank line when in
  the work-tree root
* Add some tests for "git rev-parse --show-cdup" in existing scenarios
  and add a symlinked scenario that failed before this fix
* Add a test for "git pull" in a symlinked directory that failed
  before this fix, plus constrasting already working scenarios

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---

I suggested use of realpath() but then realized that git seems to
chdir to the work-dir before processing the "--show-cdup" option,
so getcwd() is a simpler option.  

By changing rev-parse instead of cd_to_toplevel, the fix will
help shell scripts that call rev-parse directly as well.  Hopefully
the change from "../" to /full/path/to/work-dir will not be too
disruptive -- no tests fail at least.

 builtin-rev-parse.c     |   25 ++++++++++++-----
 t/t1501-worktree.sh     |   53 ++++++++++++++++++++++++++-----------
 t/t5521-pull-symlink.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 23 deletions(-)
 create mode 100755 t/t5521-pull-symlink.sh

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 81d5a6f..9cf5f82 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -536,14 +536,25 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 						printf("%s\n", work_tree);
 					continue;
 				}
-				while (pfx) {
-					pfx = strchr(pfx, '/');
-					if (pfx) {
-						pfx++;
-						printf("../");
-					}
+				/*
+				 * An empty line tells some scripts they are at
+				 * the work dir's root.  For example,
+				 * rebase --interactive.
+				 */
+				if (!prefix) {
+					putchar('\n');
+					continue;
 				}
-				putchar('\n');
+				/*
+				 * A full path is less ambiguous than ../ when
+				 * the shell arrived at it's cwd via a symlink.
+				 * Otherwise the shell's "cd" may choose the
+				 * symbolic parent.
+				 */
+				static char cwd[PATH_MAX];
+				if (!getcwd(cwd, PATH_MAX))
+					die("unable to get current working directory");
+				printf("%s\n", cwd);
 				continue;
 			}
 			if (!strcmp(arg, "--git-dir")) {
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index f6a6f83..7e83c81 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -22,15 +22,35 @@ test_rev_parse() {
 	shift
 	[ $# -eq 0 ] && return
 
+	test_expect_success "$name: cdup" \
+	"test '$1' = \"\$(git rev-parse --show-cdup)\""
+	shift
+	[ $# -eq 0 ] && return
+
 	test_expect_success "$name: prefix" \
 	"test '$1' = \"\$(git rev-parse --show-prefix)\""
 	shift
 	[ $# -eq 0 ] && return
 }
 
+D="$(pwd)"
+
 EMPTY_TREE=$(git write-tree)
-mkdir -p work/sub/dir || exit 1
-mv .git repo.git || exit 1
+mkdir -p repo/sub/dir || exit 1
+ln -s repo/sub/dir lnk || exit 1
+mv .git repo/ || exit 1
+work="$(pwd)/repo"
+cd lnk
+
+say "worktree is parent of symlink"
+test_rev_parse 'symlink'      false false true "$work" sub/dir/
+cd "$D"
+
+
+mv repo/.git repo.git || exit 1
+mv repo work || exit 1
+rm lnk || exit 1
+work="$(pwd)/work"
 
 say "core.worktree = relative path"
 GIT_DIR=repo.git
@@ -38,26 +58,26 @@ GIT_CONFIG="$(pwd)"/$GIT_DIR/config
 export GIT_DIR GIT_CONFIG
 unset GIT_WORK_TREE
 git config core.worktree ../work
-test_rev_parse 'outside'      false false false
+test_rev_parse 'outside'      false false false "$work"
 cd work || exit 1
 GIT_DIR=../repo.git
 GIT_CONFIG="$(pwd)"/$GIT_DIR/config
-test_rev_parse 'inside'       false false true ''
+test_rev_parse 'inside'       false false true '' ''
 cd sub/dir || exit 1
 GIT_DIR=../../../repo.git
 GIT_CONFIG="$(pwd)"/$GIT_DIR/config
-test_rev_parse 'subdirectory' false false true sub/dir/
+test_rev_parse 'subdirectory' false false true "$work" sub/dir/
 cd ../../.. || exit 1
 
 say "core.worktree = absolute path"
 GIT_DIR=$(pwd)/repo.git
 GIT_CONFIG=$GIT_DIR/config
 git config core.worktree "$(pwd)/work"
-test_rev_parse 'outside'      false false false
+test_rev_parse 'outside'      false false false "$work"
 cd work || exit 1
-test_rev_parse 'inside'       false false true ''
+test_rev_parse 'inside'       false false true '' ''
 cd sub/dir || exit 1
-test_rev_parse 'subdirectory' false false true sub/dir/
+test_rev_parse 'subdirectory' false false true "$work" sub/dir/
 cd ../../.. || exit 1
 
 say "GIT_WORK_TREE=relative path (override core.worktree)"
@@ -66,30 +86,31 @@ GIT_CONFIG=$GIT_DIR/config
 git config core.worktree non-existent
 GIT_WORK_TREE=work
 export GIT_WORK_TREE
-test_rev_parse 'outside'      false false false
+test_rev_parse 'outside'      false false false "$work"
 cd work || exit 1
 GIT_WORK_TREE=.
-test_rev_parse 'inside'       false false true ''
+test_rev_parse 'inside'       false false true '' ''
 cd sub/dir || exit 1
 GIT_WORK_TREE=../..
-test_rev_parse 'subdirectory' false false true sub/dir/
+test_rev_parse 'subdirectory' false false true "$work" sub/dir/
 cd ../../.. || exit 1
 
 mv work repo.git/work
+work="$(pwd)/repo.git/work"
 
 say "GIT_WORK_TREE=absolute path, work tree below git dir"
 GIT_DIR=$(pwd)/repo.git
 GIT_CONFIG=$GIT_DIR/config
 GIT_WORK_TREE=$(pwd)/repo.git/work
-test_rev_parse 'outside'              false false false
+test_rev_parse 'outside'              false false false "$work"
 cd repo.git || exit 1
-test_rev_parse 'in repo.git'              false true  false
+test_rev_parse 'in repo.git'              false true  false "$work"
 cd objects || exit 1
-test_rev_parse 'in repo.git/objects'      false true  false
+test_rev_parse 'in repo.git/objects'      false true  false "$work"
 cd ../work || exit 1
-test_rev_parse 'in repo.git/work'         false true true ''
+test_rev_parse 'in repo.git/work'         false true true '' ''
 cd sub/dir || exit 1
-test_rev_parse 'in repo.git/sub/dir' false true true sub/dir/
+test_rev_parse 'in repo.git/sub/dir' false true true "$work" sub/dir/
 cd ../../../.. || exit 1
 
 test_expect_success 'repo finds its work tree' '
diff --git a/t/t5521-pull-symlink.sh b/t/t5521-pull-symlink.sh
new file mode 100755
index 0000000..f18fec7
--- /dev/null
+++ b/t/t5521-pull-symlink.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='pulling from symlinked subdir'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+# The scenario we are building:
+#
+#   trash\ directory/
+#     clone-repo/
+#       subdir/
+#         bar
+#     subdir-link -> clone-repo/subdir/
+#
+# The working directory is subdir-link.
+#
+test_expect_success setup '
+
+    mkdir subdir &&
+    touch subdir/bar &&
+    git add subdir/bar &&
+    git commit -m empty &&
+    git clone . clone-repo &&
+    # demonstrate that things work without the symlink
+    test_debug "cd clone-repo/subdir/ && git pull; cd ../.." &&
+    ln -s clone-repo/subdir/ subdir-link &&
+    cd subdir-link/ &&
+    test_debug "set +x"
+'
+
+# From subdir-link, pulling should work as it does from
+# clone-repo/subdir/.
+#
+# Instead, the error pull gave was:
+#
+#   fatal: 'origin': unable to chdir or not a git archive
+#   fatal: The remote end hung up unexpectedly
+#
+# because git would find the .git/config for the "trash directory"
+# repo, not for the clone-repo repo.  The "trash directory" repo
+# had no entry for origin.  Git found the wrong .git because
+# git rev-parse --show-cdup printed a path relative to
+# clone-repo/subdir/, not subdir-link/.  Git rev-parse --show-cdup
+# used the correct .git, but when the git pull shell script did
+# "cd `git rev-parse --show-cdup`", it ended up in the wrong
+# directory.  Shell "cd" works a little different from chdir() in C.
+# Bash's "cd -P" works like chdir() in C.
+#
+test_expect_success 'pulling from symlinked subdir' '
+
+    git pull
+'
+
+# Prove that the remote end really is a repo, and other commands
+# work fine in this context.
+#
+test_debug "
+    test_expect_success 'pushing from symlinked subdir' '
+
+        git push
+    '
+"
+cd "$D"
+
+test_done
-- 
1.6.0.3
