From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add test suite and an example.
Date: Thu, 12 May 2005 17:20:34 -0700
Message-ID: <7vk6m4asdp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 02:14:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNoV-0008Ot-4T
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVEMAVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVEMAVj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:21:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:21749 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262189AbVEMAUl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 20:20:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513002035.SHT7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 20:20:35 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds t/ directory to host test suite, a test helper
libarary and a basic set of tests that has already helped
finding a bug introduced when we added symlink support.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Note: please make sure chmod +x t*.sh after applying before committing.

t/t0000-basic.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
t/test-lib.sh    |  118 ++++++++++++++++++++++++++++++++++++++++++++++++
2 files changed, 251 insertions(+)
t/t0000-basic.sh (. --> 100755)
t/test-lib.sh (. --> 100755)

--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -0,0 +1,133 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Test the very basics part #1.
+
+The rest of the test suite does not check the basic operation of git
+plumbing commands to work very carefully.  Their job is to concentrate
+on tricky features that caused bugs in the past to detect regression.
+
+This test runs very basic features, like registering things in cache,
+writing tree, etc.
+
+Note that this test *deliberately* hard-codes many expected object
+IDs.  When object ID computation changes, like in the previous case of
+swapping compression and hashing order, the person who is making the
+modification *should* take notice and update the test vectors here.
+'
+. ./test-lib.sh
+
+################################################################
+# init-db has been done in an empty repository.
+# make sure it is empty.
+
+find .git/objects -type f -print >should-be-empty
+test_expect_success 'cmp -s /dev/null should-be-empty'
+
+# also it should have 256 subdirectories.  257 is counting "objects"
+find .git/objects -type d -print >full-of-directories
+test_expect_success 'test "$(wc -l full-of-directories | sed -e "s/ .*//")" = 257'
+
+################################################################
+# Basics of the basics
+
+# updating a new file without --add should fail.
+test_expect_failure 'git-update-cache should-be-empty'
+
+# and with --add it should succeed, even if it is empty (it used to fail).
+test_expect_success 'git-update-cache --add should-be-empty'
+
+test_expect_success 'tree=$(git-write-tree)'
+
+# we know the shape and contents of the tree and know the object ID for it.
+test_expect_success 'test "$tree" = 7bb943559a305bdd6bdee2cef6e5df2413c3d30a'
+
+# Removing paths.
+rm -f should-be-empty full-of-directories
+test_expect_failure 'git-update-cache should-be-empty'
+test_expect_success 'git-update-cache --remove should-be-empty'
+
+# Empty tree can be written with recent write-tree.
+test_expect_success 'tree=$(git-write-tree)'
+test_expect_success 'test "$tree" = 4b825dc642cb6eb9a060e54bf8d69288fbee4904'
+
+# Various types of objects
+mkdir path2 path3 path3/subp3
+for p in path0 path2/file2 path3/file3 path3/subp3/file3
+do
+    echo "hello $p" >$p
+    ln -s "hello $p" ${p}sym
+done
+test_expect_success 'find path* ! -type d -print0 | xargs -0 -r git-update-cache --add'
+
+# Show them and see that matches what we expect.
+test_expect_success 'git-ls-files --stage >current'
+
+cat >expected <<\EOF
+100644 f87290f8eb2cbbea7857214459a0739927eab154 0 path0
+120000 15a98433ae33114b085f3eb3bb03b832b3180a01 0 path0sym
+100644 3feff949ed00a62d9f7af97c15cd8a30595e7ac7 0 path2/file2
+120000 d8ce161addc5173867a3c3c730924388daedbc38 0 path2/file2sym
+100644 0aa34cae68d0878578ad119c86ca2b5ed5b28376 0 path3/file3
+120000 8599103969b43aff7e430efea79ca4636466794f 0 path3/file3sym
+100644 00fb5908cb97c2564a9783c0c64087333b3b464f 0 path3/subp3/file3
+120000 6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c 0 path3/subp3/file3sym
+EOF
+test_expect_success 'diff current expected'
+
+test_expect_success 'tree=$(git-write-tree)'
+test_expect_success 'test "$tree" = 087704a96baf1c2d1c869a8b084481e121c88b5b'
+
+test_expect_success 'git-ls-tree $tree >current'
+cat >expected <<\EOF
+100644	blob	f87290f8eb2cbbea7857214459a0739927eab154	path0
+120000	blob	15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
+040000	tree	58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
+040000	tree	21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
+EOF
+test_expect_success 'diff current expected'
+
+test_expect_success 'git-ls-tree -r $tree >current'
+cat >expected <<\EOF
+100644	blob	f87290f8eb2cbbea7857214459a0739927eab154	path0
+120000	blob	15a98433ae33114b085f3eb3bb03b832b3180a01	path0sym
+040000	tree	58a09c23e2ca152193f2786e06986b7b6712bdbe	path2
+100644	blob	3feff949ed00a62d9f7af97c15cd8a30595e7ac7	path2/file2
+120000	blob	d8ce161addc5173867a3c3c730924388daedbc38	path2/file2sym
+040000	tree	21ae8269cacbe57ae09138dcc3a2887f904d02b3	path3
+100644	blob	0aa34cae68d0878578ad119c86ca2b5ed5b28376	path3/file3
+120000	blob	8599103969b43aff7e430efea79ca4636466794f	path3/file3sym
+040000	tree	3c5e5399f3a333eddecce7a9b9465b63f65f51e2	path3/subp3
+100644	blob	00fb5908cb97c2564a9783c0c64087333b3b464f	path3/subp3/file3
+120000	blob	6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c	path3/subp3/file3sym
+EOF
+test_expect_success 'diff current expected'
+
+################################################################
+# read-tree followed by write-tree should be idempotent
+
+rm .git/index
+test_expect_success 'git-read-tree $tree &&
+test -f .git/index &&
+newtree=$(git-write-tree) &&
+test "$newtree" = "$tree"'
+
+cat >expected <<\EOF
+*100644->100644	blob	f87290f8eb2cbbea7857214459a0739927eab154->0000000000000000000000000000000000000000	path0
+*120000->120000	blob	15a98433ae33114b085f3eb3bb03b832b3180a01->0000000000000000000000000000000000000000	path0sym
+*100644->100644	blob	3feff949ed00a62d9f7af97c15cd8a30595e7ac7->0000000000000000000000000000000000000000	path2/file2
+*120000->120000	blob	d8ce161addc5173867a3c3c730924388daedbc38->0000000000000000000000000000000000000000	path2/file2sym
+*100644->100644	blob	0aa34cae68d0878578ad119c86ca2b5ed5b28376->0000000000000000000000000000000000000000	path3/file3
+*120000->120000	blob	8599103969b43aff7e430efea79ca4636466794f->0000000000000000000000000000000000000000	path3/file3sym
+*100644->100644	blob	00fb5908cb97c2564a9783c0c64087333b3b464f->0000000000000000000000000000000000000000	path3/subp3/file3
+*120000->120000	blob	6649a1ebe9e9f1c553b66f5a6e74136a07ccc57c->0000000000000000000000000000000000000000	path3/subp3/file3sym
+EOF
+test_expect_success 'git-diff-files >current && cmp -s current expected'
+
+test_expect_success 'git-update-cache --refresh'
+
+test_expect_success 'git-diff-files >current && cmp -s current /dev/null'
+
+test_done
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+# For repeatability, reset the environment to known value.
+LANG=C
+TZ=UTC
+export LANG TZ
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
+# test_description='Description of this test...
+# This test checks if command xyzzy does the right thing...
+# '
+# . ./test-lib.sh
+
+error () {
+	echo >&2 "* error: $*"
+	exit 1
+}
+
+say () {
+	echo "* $*"
+}
+
+case "${test_description}" in
+'')
+	error "test script did not set test_description." ;;
+esac
+
+while case "$#" in 0) break;; esac
+do
+	case "$1" in
+	-d|--d|--de|--deb|--debu|--debug)
+		debug=t; shift ;;
+	-h|--h|--he|--hel|--help)
+		say "$test_description"
+		exit 0
+		;;
+	*)
+		break ;;
+	esac
+done
+test_failure=0
+
+test_debug () {
+	case "$debug" in '') ;; ?*) eval "$*" ;; esac
+}
+
+test_ok () {
+	say "$@"
+}
+
+test_failure () {
+	say "***BAD*** $@"
+	test_failure=1;
+}
+
+test_expect_failure () {
+	say "expecting failure: $1"
+	eval "$1"
+	case $? in
+	0)	test_failure "did not fail as expected." ;;
+	*) 	test_ok "failed as expected." ;;
+	esac
+}
+
+test_expect_success () {
+	say "expecting success: $1"
+	eval "$1"
+	case $? in
+	0) 	test_ok "succeeded as expected." ;;
+	*)	test_failure "did not succeed as expected." ;;
+	esac
+}
+
+test_done () {
+	case "$test_failure" in
+	0)	
+		# we could:
+		# cd .. && rm -fr trash
+		# but that means we forbid any tests that use their own
+		# subdirectory from calling test_done without coming back
+		# to where they started from.
+		exit 0 ;;
+	*)	exit 1 ;;
+	esac
+}
+
+# Test the binaries we have just built.  The tests are kept in
+# t/ subdirectory and are run in trash subdirectory.
+PATH=$(pwd)/..:$PATH
+
+# Test repository
+test=trash
+rm -fr "$test"
+mkdir "$test"
+cd "$test"
+git-init-db 2>/dev/null || error "cannot run git-init-db"
------------------------------------------------

