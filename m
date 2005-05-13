From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Test recent additions to core GIT.
Date: Thu, 12 May 2005 17:22:02 -0700
Message-ID: <7vbr7gasb9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 02:14:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNpA-0008Rx-1a
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVEMAW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVEMAW0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:22:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7166 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262190AbVEMAWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 20:22:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513002201.GTQY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 20:22:01 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a set of tests I used to verify recently made changes.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Note: Please do not forget chmod +x t/t*.sh after applying
*** before committing.

t/t0100-environment-names.sh |   84 +++++++++++++++++++++++++++++++++++++++++++
t/t0200-update-cache.sh      |   47 ++++++++++++++++++++++++
t/t0400-ls-files.sh          |   29 ++++++++++++++
t/t0500-ls-files.sh          |   55 ++++++++++++++++++++++++++++
t/t1000-checkout-cache.sh    |   54 +++++++++++++++++++++++++++
t/t1001-checkout-cache.sh    |   76 ++++++++++++++++++++++++++++++++++++++
6 files changed, 345 insertions(+)
t/t0100-environment-names.sh (. --> 100755)
t/t0200-update-cache.sh (. --> 100755)
t/t0400-ls-files.sh (. --> 100755)
t/t0500-ls-files.sh (. --> 100755)
t/t1000-checkout-cache.sh (. --> 100755)
t/t1001-checkout-cache.sh (. --> 100755)

--- a/t/t0100-environment-names.sh
+++ b/t/t0100-environment-names.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='general environment name warning test.
+
+This test makes sure that use of deprecated environment variables
+trigger the warnings from gitenv().'
+
+env_vars='GIT_AUTHOR_DATE:AUTHOR_DATE
+GIT_AUTHOR_EMAIL:AUTHOR_EMAIL
+GIT_AUTHOR_NAME:AUTHOR_NAME
+GIT_COMMITTER_EMAIL:COMMIT_AUTHOR_EMAIL
+GIT_COMMITTER_NAME:COMMIT_AUTHOR_NAME
+GIT_ALTERNATE_OBJECT_DIRECTORIES:SHA1_FILE_DIRECTORIES
+GIT_OBJECT_DIRECTORY:SHA1_FILE_DIRECTORY
+'
+
+. ./test-lib.sh
+
+export_them () {
+	for ev in $env_vars
+	do
+		new=$(expr "$ev" : '\(.*\):')
+		old=$(expr "$ev" : '.*:\(.*\)')
+		# Build and eval the following:
+		# case "${VAR+set}" in set) export VAR;; esac
+		evstr='case "${'$new'+set}" in set) export '$new';; esac'
+		eval "$evstr"
+		evstr='case "${'$old'+set}" in set) export '$old';; esac'
+		eval "$evstr"
+	done
+}
+
+date >path0
+git-update-cache --add path0
+tree=$(git-write-tree)
+
+AUTHOR_DATE='Wed May 11 23:55:18 2005'
+AUTHOR_EMAIL='author@example.xz'
+AUTHOR_NAME='A U Thor'
+COMMIT_AUTHOR_EMAIL='author@example.xz'
+COMMIT_AUTHOR_NAME='A U Thor'
+SHA1_FILE_DIRECTORY=.git/objects
+
+export_them
+
+test_debug 'echo with only old variables exported.'
+
+echo 'foo' | git-commit-tree $tree >/dev/null 2>errmsg
+cat >expected-err <<\EOF
+warning: Attempting to use SHA1_FILE_DIRECTORY
+warning: GIT environment variables have been renamed.
+warning: Please adjust your scripts and environment.
+warning: old AUTHOR_DATE => new GIT_AUTHOR_DATE
+warning: old AUTHOR_EMAIL => new GIT_AUTHOR_EMAIL
+warning: old AUTHOR_NAME => new GIT_AUTHOR_NAME
+warning: old COMMIT_AUTHOR_EMAIL => new GIT_COMMITTER_EMAIL
+warning: old COMMIT_AUTHOR_NAME => new GIT_COMMITTER_NAME
+warning: old SHA1_FILE_DIRECTORY => new GIT_OBJECT_DIRECTORY
+EOF
+sed -ne '/^warning: /p' <errmsg >generated-err
+test_debug 'cat errmsg'
+test_expect_success 'cmp generated-err expected-err'
+
+test_debug 'echo with new variables exported.'
+
+for ev in $env_vars
+do
+	new=$(expr "$ev" : '\(.*\):')
+	old=$(expr "$ev" : '.*:\(.*\)')
+	# Build and eval the following:
+	# NEWENV=$OLDENV
+	evstr="$new=\$$old"
+	eval "$evstr"
+done
+export_them
+echo 'foo' | git-commit-tree $tree >/dev/null 2>errmsg
+sed -ne '/^warning: /p' <errmsg >generated-err
+test_debug 'cat errmsg'
+test_expect_success 'cmp generated-err /dev/null'
+
+test_done
--- a/t/t0200-update-cache.sh
+++ b/t/t0200-update-cache.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-update-cache nonsense-path test.
+
+This test creates the following structure in the cache:
+
+    path0       - a file
+    path1       - a symlink
+    path2/file2 - a file in a directory
+    path3/file3 - a file in a directory
+
+and tries to git-update-cache --add the following:
+
+    path0/file0 - a file in a directory
+    path1/file1 - a file in a directory
+    path2       - a file
+    path3       - a symlink
+
+All of the attempts should fail.
+'
+
+. ./test-lib.sh
+
+mkdir path2 path3
+date >path0
+ln -s xyzzy path1
+date >path2/file2
+date >path3/file3
+
+git-update-cache --add -- path0 path1 path2/file2 path3/file3
+
+rm -fr path?
+
+mkdir path0 path1
+date >path2
+ln -s frotz path3
+date >path0/file0
+date >path1/file1
+
+for p in path0/file0 path1/file1 path2 path3
+do
+	test_expect_failure "git-update-cache --add -- $p"
+done
+test_done
--- a/t/t0400-ls-files.sh
+++ b/t/t0400-ls-files.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-ls-files test (--others should pick up symlinks).
+
+This test runs git-ls-files --others with the following on the
+filesystem.
+
+    path0       - a file
+    path1	- a symlink
+    path2/file2 - a file in a directory
+'
+. ./test-lib.sh
+
+date >path0
+ln -s xyzzy path1
+mkdir path2
+date >path2/file2
+git-ls-files --others >.output
+cat >.expected <<EOF
+path0
+path1
+path2/file2
+EOF
+
+test_expect_success 'diff .output .expected'
+test_done
--- a/t/t0500-ls-files.sh
+++ b/t/t0500-ls-files.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-ls-files -k flag test.
+
+This test prepares the following in the cache:
+
+    path0       - a file
+    path1       - a symlink
+    path2/file2 - a file in a directory
+    path3/file3 - a file in a directory
+
+and the following on the filesystem:
+
+    path0/file0 - a file in a directory
+    path1/file1 - a file in a directory
+    path2       - a file
+    path3       - a symlink
+    path4	- a file
+    path5	- a symlink
+    path6/file6 - a file in a directory
+
+git-ls-files -k should report that existing filesystem
+objects except path4, path5 and path6/file6 to be killed.
+'
+. ./test-lib.sh
+
+date >path0
+ln -s xyzzy path1
+mkdir path2 path3
+date >path2/file2
+date >path3/file3
+git-update-cache --add -- path0 path1 path?/file?
+
+rm -fr path?
+date >path2
+ln -s frotz path3
+ln -s nitfol path5
+mkdir path0 path1 path6
+date >path0/file0
+date >path1/file1
+date >path6/file6
+
+git-ls-files -k >.output
+cat >.expected <<EOF
+path0/file0
+path1/file1
+path2
+path3
+EOF
+
+test_expect_success 'diff .output .expected'
+test_done
--- a/t/t1000-checkout-cache.sh
+++ b/t/t1000-checkout-cache.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-checkout-cache test.
+
+This test registers the following filesystem structure in the
+cache:
+
+    path0       - a file
+    path1/file1 - a file in a directory
+
+And then tries to checkout in a work tree that has the following:
+
+    path0/file0 - a file in a directory
+    path1       - a file
+
+The git-checkout-cache command should fail when attempting to checkout
+path0, finding it is occupied by a directory, and path1/file1, finding
+path1 is occupied by a non-directory.  With "-f" flag, it should remove
+the conflicting paths and succeed.
+'
+. ./test-lib.sh
+
+date >path0
+mkdir path1
+date >path1/file1
+git-update-cache --add path0 path1/file1
+test_debug 'git-ls-files --stage'
+
+rm -fr path0 path1
+mkdir path0
+date >path0/file0
+date >path1
+test_debug 'git-ls-files --stage'
+test_debug 'find path*'
+
+test_expect_failure 'git-checkout-cache -a'
+test_debug 'find path*'
+
+test_expect_success 'git-checkout-cache -f -a'
+test_debug 'find path*'
+
+if test -f path0 && test -d path1 && test -f path1/file1
+then
+	test_ok "checkout successful"
+else
+	test_failure "checkout failed"
+fi
+
+test_done
+
+
--- a/t/t1001-checkout-cache.sh
+++ b/t/t1001-checkout-cache.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-checkout-cache test.
+
+This test registers the following filesystem structure in the cache:
+
+    path0/file0	- a file in a directory
+    path1/file1 - a file in a directory
+
+and attempts to check it out when the work tree has:
+
+    path0/file0 - a file in a directory
+    path1       - a symlink pointing at "path0"
+
+Checkout cache should fail to extract path1/file1 because the leading
+path path1 is occupied by a non-directory.  With "-f" it should remove
+the symlink path1 and create directory path1 and file path1/file1.
+'
+. ./test-lib.sh
+
+show_files() {
+	# show filesystem files, just [-dl] for type and name
+	find path? -ls |
+	sed -e 's/^[0-9]* * [0-9]* * \([-bcdl]\)[^ ]* *[0-9]* *[^ ]* *[^ ]* *[0-9]* [A-Z][a-z][a-z] [0-9][0-9] [^ ]* /fs: \1 /'
+	# what's in the cache, just mode and name
+	git-ls-files --stage |
+	sed -e 's/^\([0-9]*\) [0-9a-f]* [0-3] /ca: \1 /'
+	# what's in the tree, just mode and name.
+	git-ls-tree -r "$1" |
+	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
+}
+
+mkdir path0
+date >path0/file0
+git-update-cache --add path0/file0
+tree1=$(git-write-tree)
+test_debug 'show_files $tree1'
+
+mkdir path1
+date >path1/file1
+git-update-cache --add path1/file1
+tree2=$(git-write-tree)
+test_debug 'show_files $tree2'
+
+rm -fr path1
+git-read-tree -m $tree1
+git-checkout-cache -f -a
+test_debug 'show_files $tree1'
+
+ln -s path0 path1
+git-update-cache --add path1
+tree3=$(git-write-tree)
+test_debug 'show_files $tree3'
+
+# Morten says "Got that?" here.
+# Test begins.
+
+git-read-tree $tree2
+test_expect_success 'git-checkout-cache -f -a'
+test_debug show_files $tree2
+
+if test ! -h path0 && test -d path0 &&
+   test ! -h path1 && test -d path1 &&
+   test ! -h path0/file0 && test -f path0/file0 &&
+   test ! -h path1/file1 && test -f path1/file1
+then
+    test_ok "checked out correctly."
+else
+    test_failure "did not check out correctly."
+fi
+
+test_done
+
------------------------------------------------

