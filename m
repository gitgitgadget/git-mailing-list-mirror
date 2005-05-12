From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Test suite
Date: Wed, 11 May 2005 17:01:34 -0700
Message-ID: <7vu0l9nwgx.fsf_-_@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
	<7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
	<20050511224044.GI22686@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW12u-0004TH-1E
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVELACs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVELACs
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:02:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18056 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261336AbVELABq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:01:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512000134.LRHG20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 20:01:34 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511224044.GI22686@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 00:40:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Commit    1da683e1247046796a094c4917bc0c4591530272
Author    Junio C Hamano <junkio@cox.net>, Wed May 11 16:59:35 2005 -0700
Committer Junio C Hamano <junkio@cox.net>, Wed May 11 16:59:35 2005 -0700

Test suite: infrastructure and examples.

This adds the test suite infrastructure with two example tests.
The current git-checkout-cache the example tests would fail this
test and will be corrected in a separate patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Created: t/t1000-checkout-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t1000-checkout-cache.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./test-lib.sh
+test_description "$@" 'git-checkout-cache test.
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
Created: t/t1001-checkout-cache.sh (mode:100755)
--- /dev/null
+++ b/t/t1001-checkout-cache.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+. ./test-lib.sh
+test_description "$@" 'git-checkout-cache test.
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
Created: t/test-lib.sh (mode:100755)
--- /dev/null
+++ b/t/test-lib.sh
@@ -0,0 +1,106 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+# For repeatability, reset the environment to known value.
+export LANG C
+export TZ UTC
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
+# Each test should start with something like this, after copyright notices:
+#
+# . ./testlib.sh
+# test_description "$@" 'Description of this test...
+# This test checks if command xyzzy does the right thing...
+# '
+#
+
+test_description () {
+	while case "$#" in 0) break;; esac
+	do
+		case "$1" in
+		-d|--d|--de|--deb|--debu|--debug)
+			debug=t; shift ;;
+		-h|--h|--he|--hel|--help)
+			eval echo '"$'$#'"'
+			exit 0
+			;;
+		*)
+			break ;;
+		esac
+	done
+	test_failure=0
+}
+
+say () {
+	echo "* $*"
+}
+
+test_debug () {
+	case "$debug" in '') ;; ?*) eval "$*" ;; esac
+}
+
+test_ok () {
+	echo "* $*";
+}
+
+test_failure () {
+	echo "* $*";
+	test_failure=1;
+}
+
+test_expect_failure () {
+	say "expecting failure: $1"
+	eval "$1"
+	case $? in
+	0)	test_failure "did not fail as expected" ;;
+	*) 	test_ok "failed as expected" ;;
+	esac
+}
+
+test_expect_success () {
+	say "expecting success: $1"
+	eval "$1"
+	case $? in
+	0) 	test_ok "succeeded as expected" ;;
+	*)	test_failure "did not succeed as expected" ;;
+	esac
+}
+
+test_done () {
+	case "$test_failure" in
+	0)	exit 0 ;;
+	'')	echo "*** test script did not start with test_description";
+		exit 2 ;;
+	*)	exit 1 ;;
+	esac
+}
+
+# Test the binaries we have just built.  The tests are kept in
+# t/ subdirectory and are run in test-repo subdirectory.
+PATH=$(pwd)/..:$PATH
+
+# Test repository
+test=test-repo
+rm -fr "$test"
+mkdir "$test"
+cd "$test"
+git-init-db 2>/dev/null || error "cannot run git-init-db"
------------------------------------------------

