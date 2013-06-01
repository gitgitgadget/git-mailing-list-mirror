From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 05/11] tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial cases)
Date: Sat,  1 Jun 2013 11:34:24 +0200
Message-ID: <3c8aaaa4ad606d2afb7c110a28c119792caa8aba.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiDX-0002Lv-G7
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086Ab3FAJfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:35:07 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:7425 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754874Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 415F613004A
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4B3F419F5E5
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226118>

There are many instances where the treatment of symbolic links in the
object model and the algorithms are tested, but where it is not
necessary to actually have a symbolic link in the worktree. Make
adjustments to the tests and remove the SYMLINKS prerequisite when
appropriate in trivial cases, where "trivial" means:

- merely a replacement of 'ln -s a b' to test_ln_s or of
  'ln -s a b && git add b' to test_ln_s_add is needed;

- a test for symbolic link on the file system can be split off (and
  remains protected by SYMLINKS);

- existing code is equivalent to test_ln_s[_add].

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
The changes in t9500-gitweb-* were not tested on a system that does not
have SYMLINKS.

 t/t1004-read-tree-m-u-wf.sh            |  7 +++---
 t/t2001-checkout-cache-clash.sh        |  7 +++---
 t/t2003-checkout-cache-mkdir.sh        |  8 +++----
 t/t2004-checkout-cache-temp.sh         |  5 ++---
 t/t2007-checkout-symlink.sh            | 12 +++++------
 t/t2021-checkout-overwrite.sh          | 12 +++++++----
 t/t2200-add-update.sh                  |  5 ++---
 t/t3000-ls-files-others.sh             |  7 +-----
 t/t3010-ls-files-killed-modified.sh    | 19 ++++-------------
 t/t3700-add.sh                         | 15 ++++++-------
 t/t3903-stash.sh                       | 39 ++++++++++++++++++++++++----------
 t/t4008-diff-break-rewrite.sh          | 12 +++++------
 t/t4011-diff-symlink.sh                | 23 +++++++++++---------
 t/t4030-diff-textconv.sh               |  8 +++----
 t/t4115-apply-symlink.sh               | 10 ++++-----
 t/t4122-apply-symlink-inside.sh        |  8 +++----
 t/t7001-mv.sh                          | 18 ++++++++++------
 t/t7607-merge-overwrite.sh             |  5 ++---
 t/t8006-blame-textconv.sh              | 14 +++++-------
 t/t8007-cat-file-textconv.sh           | 10 ++++-----
 t/t9350-fast-export.sh                 |  5 ++---
 t/t9500-gitweb-standalone-no-errors.sh | 15 +++++--------
 22 files changed, 126 insertions(+), 138 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index b3ae7d5..3e72aff 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -158,7 +158,7 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 
 '
 
-test_expect_success SYMLINKS 'funny symlink in work tree' '
+test_expect_success 'funny symlink in work tree' '
 
 	git reset --hard &&
 	git checkout -b sym-b side-b &&
@@ -170,15 +170,14 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '
 	rm -fr a &&
 	git checkout -b sym-a side-a &&
 	mkdir -p a &&
-	ln -s ../b a/b &&
-	git add a/b &&
+	test_ln_s_add ../b a/b &&
 	git commit -m "we add a/b" &&
 
 	read_tree_u_must_succeed -m -u sym-a sym-a sym-b
 
 '
 
-test_expect_success SYMLINKS,SANITY 'funny symlink in work tree, un-unlink-able' '
+test_expect_success SANITY 'funny symlink in work tree, un-unlink-able' '
 
 	rm -fr a b &&
 	git reset --hard &&
diff --git a/t/t2001-checkout-cache-clash.sh b/t/t2001-checkout-cache-clash.sh
index 98aa73e..1fc8e63 100755
--- a/t/t2001-checkout-cache-clash.sh
+++ b/t/t2001-checkout-cache-clash.sh
@@ -59,10 +59,9 @@ test_expect_success \
     'git read-tree -m $tree1 && git checkout-index -f -a'
 test_debug 'show_files $tree1'
 
-test_expect_success SYMLINKS \
-    'git update-index --add a symlink.' \
-    'ln -s path0 path1 &&
-     git update-index --add path1'
+test_expect_success \
+    'add a symlink' \
+    'test_ln_s_add path0 path1'
 test_expect_success \
     'writing tree out with git write-tree' \
     'tree3=$(git write-tree)'
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index ff163cf..bd17ba2 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -19,10 +19,10 @@ test_expect_success 'setup' '
 	git update-index --add path0 path1/file1
 '
 
-test_expect_success SYMLINKS 'have symlink in place where dir is expected.' '
+test_expect_success 'have symlink in place where dir is expected.' '
 	rm -fr path0 path1 &&
 	mkdir path2 &&
-	ln -s path2 path1 &&
+	test_ln_s path2 path1 &&
 	git checkout-index -f -a &&
 	test ! -h path1 && test -d path1 &&
 	test -f path1/file1 && test ! -f path2/file1
@@ -79,10 +79,10 @@ test_expect_success SYMLINKS 'use --prefix=tmp/orary- where tmp is a symlink' '
 	test -h tmp
 '
 
-test_expect_success SYMLINKS 'use --prefix=tmp- where tmp-path1 is a symlink' '
+test_expect_success 'use --prefix=tmp- where tmp-path1 is a symlink' '
 	rm -fr path0 path1 path2 tmp* &&
 	mkdir tmp1 &&
-	ln -s tmp1 tmp-path1 &&
+	test_ln_s tmp1 tmp-path1 &&
 	git checkout-index --prefix=tmp- -f -a &&
 	test -f tmp-path0 &&
 	test ! -h tmp-path1 &&
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 0f4b289..f171a55 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -194,11 +194,10 @@ test_expect_success \
  test $(cat ../$s1) = tree1asubdir/path5)
 )'
 
-test_expect_success SYMLINKS \
+test_expect_success \
 'checkout --temp symlink' '
 rm -f path* .merge_* out .git/index &&
-ln -s b a &&
-git update-index --add a &&
+test_ln_s_add b a &&
 t4=$(git write-tree) &&
 rm -f .git/index &&
 git read-tree $t4 &&
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index e6f59f1..fc9aad5 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -6,7 +6,7 @@ test_description='git checkout to switch between branches with symlink<->dir'
 
 . ./test-lib.sh
 
-test_expect_success SYMLINKS setup '
+test_expect_success setup '
 
 	mkdir frotz &&
 	echo hello >frotz/filfre &&
@@ -25,25 +25,25 @@ test_expect_success SYMLINKS setup '
 
 	git rm --cached frotz/filfre &&
 	mv frotz xyzzy &&
-	ln -s xyzzy frotz &&
-	git add xyzzy/filfre frotz &&
+	test_ln_s_add xyzzy frotz &&
+	git add xyzzy/filfre &&
 	test_tick &&
 	git commit -m "side moves frotz/ to xyzzy/ and adds frotz->xyzzy/"
 
 '
 
-test_expect_success SYMLINKS 'switch from symlink to dir' '
+test_expect_success 'switch from symlink to dir' '
 
 	git checkout master
 
 '
 
-test_expect_success SYMLINKS 'Remove temporary directories & switch to master' '
+test_expect_success 'Remove temporary directories & switch to master' '
 	rm -fr frotz xyzzy nitfol &&
 	git checkout -f master
 '
 
-test_expect_success SYMLINKS 'switch from dir to symlink' '
+test_expect_success 'switch from dir to symlink' '
 
 	git checkout side
 
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index 5da63e9..c2ada7d 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -29,21 +29,25 @@ test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 	test -f a/b
 '
 
-test_expect_success SYMLINKS 'create a commit where dir a/b changed to symlink' '
+test_expect_success 'create a commit where dir a/b changed to symlink' '
 
 	rm -rf a/b &&	# cleanup if previous test failed
 	git checkout -f -b symlink start &&
 	rm -rf a/b &&
-	ln -s foo a/b &&
 	git add -A &&
+	test_ln_s_add foo a/b &&
 	git commit -m "dir to symlink"
 '
 
-test_expect_success SYMLINKS 'checkout commit with dir must not remove untracked a/b' '
+test_expect_success 'checkout commit with dir must not remove untracked a/b' '
 
 	git rm --cached a/b &&
 	git commit -m "un-track the symlink" &&
-	test_must_fail git checkout start &&
+	test_must_fail git checkout start
+'
+
+test_expect_success SYMLINKS 'the symlink remained' '
+
 	test -h a/b
 '
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index b2bd419..9bf2bdf 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -96,11 +96,10 @@ test_expect_success 'non-limited update in subdir leaves root alone' '
 	test_cmp expect actual
 '
 
-test_expect_success SYMLINKS 'replace a file with a symlink' '
+test_expect_success 'replace a file with a symlink' '
 
 	rm foo &&
-	ln -s top foo &&
-	git add -u -- foo
+	test_ln_s_add top foo
 
 '
 
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 88be904..563ac7f 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -19,12 +19,7 @@ filesystem.
 
 test_expect_success 'setup ' '
 	date >path0 &&
-	if test_have_prereq SYMLINKS
-	then
-		ln -s xyzzy path1
-	else
-		date >path1
-	fi &&
+	test_ln_s xyzzy path1 &&
 	mkdir path2 path3 path4 &&
 	date >path2/file2 &&
 	date >path2-junk &&
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 2d0ff2d..310e0a2 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -39,12 +39,7 @@ modified without reporting path9 and path10.
 
 test_expect_success 'git update-index --add to add various paths.' '
 	date >path0 &&
-	if test_have_prereq SYMLINKS
-	then
-		ln -s xyzzy path1
-	else
-		date > path1
-	fi &&
+	test_ln_s_add xyzzy path1 &&
 	mkdir path2 path3 &&
 	date >path2/file2 &&
 	date >path3/file3 &&
@@ -52,20 +47,14 @@ test_expect_success 'git update-index --add to add various paths.' '
 	date >path8 &&
 	: >path9 &&
 	date >path10 &&
-	git update-index --add -- path0 path1 path?/file? path7 path8 path9 path10 &&
+	git update-index --add -- path0 path?/file? path7 path8 path9 path10 &&
 	rm -fr path?	# leave path10 alone
 '
 
 test_expect_success 'git ls-files -k to show killed files.' '
 	date >path2 &&
-	if test_have_prereq SYMLINKS
-	then
-		ln -s frotz path3 &&
-		ln -s nitfol path5
-	else
-		date >path3 &&
-		date >path5
-	fi &&
+	test_ln_s frotz path3 &&
+	test_ln_s nitfol path5 &&
 	mkdir path0 path1 path6 &&
 	date >path0/file0 &&
 	date >path1/file1 &&
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 874b3a6..aab86e8 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -30,10 +30,9 @@ test_expect_success \
 	 *) echo fail; git ls-files --stage xfoo1; (exit 1);;
 	 esac'
 
-test_expect_success SYMLINKS 'git add: filemode=0 should not get confused by symlink' '
+test_expect_success 'git add: filemode=0 should not get confused by symlink' '
 	rm -f xfoo1 &&
-	ln -s foo xfoo1 &&
-	git add xfoo1 &&
+	test_ln_s_add foo xfoo1 &&
 	case "`git ls-files --stage xfoo1`" in
 	120000" "*xfoo1) echo pass;;
 	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
@@ -51,21 +50,19 @@ test_expect_success \
 	 *) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	 esac'
 
-test_expect_success SYMLINKS 'git add: filemode=0 should not get confused by symlink' '
+test_expect_success 'git add: filemode=0 should not get confused by symlink' '
 	rm -f xfoo2 &&
-	ln -s foo xfoo2 &&
-	git update-index --add xfoo2 &&
+	test_ln_s_add foo xfoo2 &&
 	case "`git ls-files --stage xfoo2`" in
 	120000" "*xfoo2) echo pass;;
 	*) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	esac
 '
 
-test_expect_success SYMLINKS \
+test_expect_success \
 	'git update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
-	 ln -s xfoo2 xfoo3 &&
-	 git update-index --add xfoo3 &&
+	 test_ln_s_add xfoo2 xfoo3 &&	# runs git update-index --add
 	 case "`git ls-files --stage xfoo3`" in
 	 120000" "*xfoo3) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo3; (exit 1);;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..8ff039b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -336,41 +336,58 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
 
 # This test creates a commit with a symlink used for the following tests
 
-test_expect_success SYMLINKS 'stash symlink to file' '
+test_expect_success 'stash symlink to file' '
 	git reset --hard &&
-	ln -s file filelink &&
-	git add filelink &&
+	test_ln_s_add file filelink &&
 	git commit -m "Add symlink" &&
 	rm filelink &&
 	cp file filelink &&
-	git stash save "symlink to file" &&
+	git stash save "symlink to file"
+'
+
+test_expect_success SYMLINKS 'this must have re-created the symlink' '
 	test -h filelink &&
-	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac &&
+	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac
+'
+
+test_expect_success 'unstash must re-create the file' '
 	git stash apply &&
 	! test -h filelink &&
 	test bar = "$(cat file)"
 '
 
-test_expect_success SYMLINKS 'stash symlink to file (stage rm)' '
+test_expect_success 'stash symlink to file (stage rm)' '
 	git reset --hard &&
 	git rm filelink &&
 	cp file filelink &&
-	git stash save "symlink to file (stage rm)" &&
+	git stash save "symlink to file (stage rm)"
+'
+
+test_expect_success SYMLINKS 'this must have re-created the symlink' '
 	test -h filelink &&
-	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac &&
+	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac
+'
+
+test_expect_success 'unstash must re-create the file' '
 	git stash apply &&
 	! test -h filelink &&
 	test bar = "$(cat file)"
 '
 
-test_expect_success SYMLINKS 'stash symlink to file (full stage)' '
+test_expect_success 'stash symlink to file (full stage)' '
 	git reset --hard &&
 	rm filelink &&
 	cp file filelink &&
 	git add filelink &&
-	git stash save "symlink to file (full stage)" &&
+	git stash save "symlink to file (full stage)"
+'
+
+test_expect_success SYMLINKS 'this must have re-created the symlink' '
 	test -h filelink &&
-	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac &&
+	case "$(ls -l filelink)" in *" filelink -> file") :;; *) false;; esac
+'
+
+test_expect_success 'unstash must re-create the file' '
 	git stash apply &&
 	! test -h filelink &&
 	test bar = "$(cat file)"
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 73b4a24..27e98a8 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -99,11 +99,11 @@ test_expect_success \
     'validate result of -B -M (#4)' \
     'compare_diff_raw expected current'
 
-test_expect_success SYMLINKS \
+test_expect_success \
     'make file0 into something completely different' \
     'rm -f file0 &&
-     ln -s frotz file0 &&
-     git update-index file0 file1'
+     test_ln_s_add frotz file0 &&
+     git update-index file1'
 
 test_expect_success \
     'run diff with -B' \
@@ -114,7 +114,7 @@ cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M100	file1
 EOF
 
-test_expect_success SYMLINKS \
+test_expect_success \
     'validate result of -B (#5)' \
     'compare_diff_raw expected current'
 
@@ -129,7 +129,7 @@ cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 R	file0	file1
 EOF
 
-test_expect_success SYMLINKS \
+test_expect_success \
     'validate result of -B -M (#6)' \
     'compare_diff_raw expected current'
 
@@ -144,7 +144,7 @@ cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M	file1
 EOF
 
-test_expect_success SYMLINKS \
+test_expect_success \
     'validate result of -M (#7)' \
     'compare_diff_raw expected current'
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index f0d5041..3888519 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,7 +9,7 @@ test_description='Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-test_expect_success SYMLINKS 'diff new symlink and file' '
+test_expect_success 'diff new symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	new file mode 120000
@@ -27,22 +27,25 @@ test_expect_success SYMLINKS 'diff new symlink and file' '
 	@@ -0,0 +1 @@
 	+xyzzy
 	EOF
-	ln -s xyzzy frotz &&
-	echo xyzzy >nitfol &&
+
+	# the empty tree
 	git update-index &&
 	tree=$(git write-tree) &&
-	git update-index --add frotz nitfol &&
+
+	test_ln_s_add xyzzy frotz &&
+	echo xyzzy >nitfol &&
+	git update-index --add nitfol &&
 	GIT_DIFF_OPTS=--unified=0 git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff unchanged symlink and file'  '
+test_expect_success 'diff unchanged symlink and file'  '
 	tree=$(git write-tree) &&
 	git update-index frotz nitfol &&
 	test -z "$(git diff-index --name-only $tree)"
 '
 
-test_expect_success SYMLINKS 'diff removed symlink and file' '
+test_expect_success 'diff removed symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	deleted file mode 120000
@@ -66,12 +69,12 @@ test_expect_success SYMLINKS 'diff removed symlink and file' '
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
+test_expect_success 'diff identical, but newly created symlink and file' '
 	>expected &&
 	rm -f frotz nitfol &&
 	echo xyzzy >nitfol &&
 	test-chmtime +10 nitfol &&
-	ln -s xyzzy frotz &&
+	test_ln_s xyzzy frotz &&
 	git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current &&
 
@@ -80,7 +83,7 @@ test_expect_success SYMLINKS 'diff identical, but newly created symlink and file
 	compare_diff_patch expected current
 '
 
-test_expect_success SYMLINKS 'diff different symlink and file' '
+test_expect_success 'diff different symlink and file' '
 	cat >expected <<-\EOF &&
 	diff --git a/frotz b/frotz
 	index 7c465af..df1db54 120000
@@ -100,7 +103,7 @@ test_expect_success SYMLINKS 'diff different symlink and file' '
 	+yxyyz
 	EOF
 	rm -f frotz &&
-	ln -s yxyyz frotz &&
+	test_ln_s yxyyz frotz &&
 	echo yxyyz >nitfol &&
 	git diff-index -M -p $tree >current &&
 	compare_diff_patch expected current
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 53ec330..f75f46f 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -139,12 +139,10 @@ index 0000000..67be421
 +frotz
 \ No newline at end of file
 EOF
-# make a symlink the hard way that works on symlink-challenged file systems
+
 test_expect_success 'textconv does not act on symlinks' '
-	printf frotz > file &&
-	git add file &&
-	git ls-files -s | sed -e s/100644/120000/ |
-		git update-index --index-info &&
+	rm -f file &&
+	test_ln_s_add frotz file &&
 	git commit -m typechange &&
 	git show >diff &&
 	find_diff <diff >actual &&
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index 7674dd2..872fcda 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -9,18 +9,16 @@ test_description='git apply symlinks and partial files
 
 . ./test-lib.sh
 
-test_expect_success SYMLINKS setup '
+test_expect_success setup '
 
-	ln -s path1/path2/path3/path4/path5 link1 &&
-	git add link? &&
+	test_ln_s_add path1/path2/path3/path4/path5 link1 &&
 	git commit -m initial &&
 
 	git branch side &&
 
 	rm -f link? &&
 
-	ln -s htap6 link1 &&
-	git update-index link? &&
+	test_ln_s_add htap6 link1 &&
 	git commit -m second &&
 
 	git diff-tree -p HEAD^ HEAD >patch  &&
@@ -37,7 +35,7 @@ test_expect_success SYMLINKS 'apply symlink patch' '
 
 '
 
-test_expect_success SYMLINKS 'apply --index symlink patch' '
+test_expect_success 'apply --index symlink patch' '
 
 	git checkout -f side &&
 	git apply --index patch &&
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 3940737..70b3a06 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -10,11 +10,11 @@ lecho () {
 	done
 }
 
-test_expect_success SYMLINKS setup '
+test_expect_success setup '
 
 	mkdir -p arch/i386/boot arch/x86_64 &&
 	lecho 1 2 3 4 5 >arch/i386/boot/Makefile &&
-	ln -s ../i386/boot arch/x86_64/boot &&
+	test_ln_s_add ../i386/boot arch/x86_64/boot &&
 	git add . &&
 	test_tick &&
 	git commit -m initial &&
@@ -31,7 +31,7 @@ test_expect_success SYMLINKS setup '
 
 '
 
-test_expect_success SYMLINKS apply '
+test_expect_success apply '
 
 	git checkout test &&
 	git diff --exit-code test &&
@@ -40,7 +40,7 @@ test_expect_success SYMLINKS apply '
 
 '
 
-test_expect_success SYMLINKS 'check result' '
+test_expect_success 'check result' '
 
 	git diff --exit-code master &&
 	git diff --exit-code --cached master &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a845b15..101816e 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -218,13 +218,13 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 
 rm -f dirty dirty2
 
-test_expect_success SYMLINKS 'git mv should overwrite symlink to a file' '
+test_expect_success 'git mv should overwrite symlink to a file' '
 
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
-	ln -s moved symlink &&
-	git add moved symlink &&
+	test_ln_s_add moved symlink &&
+	git add moved &&
 	test_must_fail git mv moved symlink &&
 	git mv -f moved symlink &&
 	! test -e moved &&
@@ -237,22 +237,26 @@ test_expect_success SYMLINKS 'git mv should overwrite symlink to a file' '
 
 rm -f moved symlink
 
-test_expect_success SYMLINKS 'git mv should overwrite file with a symlink' '
+test_expect_success 'git mv should overwrite file with a symlink' '
 
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
-	ln -s moved symlink &&
-	git add moved symlink &&
+	test_ln_s_add moved symlink &&
+	git add moved &&
 	test_must_fail git mv symlink moved &&
 	git mv -f symlink moved &&
 	! test -e symlink &&
-	test -h moved &&
 	git update-index --refresh &&
 	git diff-files --quiet
 
 '
 
+test_expect_success SYMLINKS 'check moved symlink' '
+
+	test -h moved
+'
+
 rm -f moved symlink
 
 test_done
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 6547eb8..758a623 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -141,11 +141,10 @@ test_expect_success SYMLINKS 'will not overwrite untracked symlink in leading pa
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-test_expect_success SYMLINKS 'will not be confused by symlink in leading path' '
+test_expect_success 'will not be confused by symlink in leading path' '
 	git reset --hard c0 &&
 	rm -rf sub &&
-	ln -s sub2 sub &&
-	git add sub &&
+	test_ln_s_add sub2 sub &&
 	git commit -m ln &&
 	git checkout sub
 '
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index bf6caa4..7683515 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -18,17 +18,13 @@ test_expect_success 'setup ' '
 	echo "bin: test number 0" >zero.bin &&
 	echo "bin: test 1" >one.bin &&
 	echo "bin: test number 2" >two.bin &&
-	if test_have_prereq SYMLINKS; then
-		ln -s one.bin symlink.bin
-	fi &&
+	test_ln_s_add one.bin symlink.bin &&
 	git add . &&
 	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
 	echo "bin: test 1 version 2" >one.bin &&
 	echo "bin: test number 2 version 2" >>two.bin &&
-	if test_have_prereq SYMLINKS; then
-		rm symlink.bin &&
-		ln -s two.bin symlink.bin
-	fi &&
+	rm -f symlink.bin &&
+	test_ln_s_add two.bin symlink.bin &&
 	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
 '
 
@@ -135,7 +131,7 @@ test_expect_success SYMLINKS 'blame --textconv (on symlink)' '
 
 # cp two.bin three.bin  and make small tweak
 # (this will direct blame -C -C three.bin to consider two.bin and symlink.bin)
-test_expect_success SYMLINKS 'make another new commit' '
+test_expect_success 'make another new commit' '
 	cat >three.bin <<\EOF &&
 bin: test number 2
 bin: test number 2 version 2
@@ -146,7 +142,7 @@ EOF
 	GIT_AUTHOR_NAME=Number4 git commit -a -m Fourth --date="2010-01-01 23:00:00"
 '
 
-test_expect_success SYMLINKS 'blame on last commit (-C -C, symlink)' '
+test_expect_success 'blame on last commit (-C -C, symlink)' '
 	git blame -C -C three.bin >blame &&
 	find_blame <blame >result &&
 	cat >expected <<\EOF &&
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index 78a0085..b95e102 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -12,9 +12,7 @@ chmod +x helper
 
 test_expect_success 'setup ' '
 	echo "bin: test" >one.bin &&
-	if test_have_prereq SYMLINKS; then
-		ln -s one.bin symlink.bin
-	fi &&
+	test_ln_s_add one.bin symlink.bin &&
 	git add . &&
 	GIT_AUTHOR_NAME=Number1 git commit -a -m First --date="2010-01-01 18:00:00" &&
 	echo "bin: test version 2" >one.bin &&
@@ -72,14 +70,14 @@ test_expect_success 'cat-file --textconv on previous commit' '
 	test_cmp expected result
 '
 
-test_expect_success SYMLINKS 'cat-file without --textconv (symlink)' '
+test_expect_success 'cat-file without --textconv (symlink)' '
 	git cat-file blob :symlink.bin >result &&
 	printf "%s" "one.bin" >expected
 	test_cmp expected result
 '
 
 
-test_expect_success SYMLINKS 'cat-file --textconv on index (symlink)' '
+test_expect_success 'cat-file --textconv on index (symlink)' '
 	! git cat-file --textconv :symlink.bin 2>result &&
 	cat >expected <<\EOF &&
 fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
@@ -87,7 +85,7 @@ EOF
 	test_cmp expected result
 '
 
-test_expect_success SYMLINKS 'cat-file --textconv on HEAD (symlink)' '
+test_expect_success 'cat-file --textconv on HEAD (symlink)' '
 	! git cat-file --textconv HEAD:symlink.bin 2>result &&
 	cat >expected <<EOF &&
 fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink.bin
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 2471bc6..34c2d8f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -396,7 +396,7 @@ test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
-test_expect_success SYMLINKS 'directory becomes symlink'        '
+test_expect_success 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
 	(
@@ -408,8 +408,7 @@ test_expect_success SYMLINKS 'directory becomes symlink'        '
 		git add foo/world bar/world &&
 		git commit -q -mone &&
 		git rm -r foo &&
-		ln -s bar foo &&
-		git add foo &&
+		test_ln_s_add bar foo &&
 		git commit -q -mtwo
 	) &&
 	(
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6783c14..6fca193 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -156,10 +156,10 @@ test_expect_success \
 	 git commit -a -m "File renamed." &&
 	 gitweb_run "p=.git;a=commitdiff"'
 
-test_expect_success SYMLINKS \
+test_expect_success \
 	'commitdiff(0): file to symlink' \
 	'rm renamed_file &&
-	 ln -s file renamed_file &&
+	 test_ln_s_add file renamed_file &&
 	 git commit -a -m "File to symlink." &&
 	 gitweb_run "p=.git;a=commitdiff"'
 
@@ -212,15 +212,14 @@ test_expect_success \
 # ----------------------------------------------------------------------
 # commitdiff testing (taken from t4114-apply-typechange.sh)
 
-test_expect_success SYMLINKS 'setup typechange commits' '
+test_expect_success 'setup typechange commits' '
 	echo "hello world" > foo &&
 	echo "hi planet" > bar &&
 	git update-index --add foo bar &&
 	git commit -m initial &&
 	git branch initial &&
 	rm -f foo &&
-	ln -s bar foo &&
-	git update-index foo &&
+	test_ln_s_add bar foo &&
 	git commit -m "foo symlinked to bar" &&
 	git branch foo-symlinked-to-bar &&
 	rm -f foo &&
@@ -361,11 +360,7 @@ test_expect_success \
 	 echo "Changed" >> 04-rename-to &&
 	 test_chmod +x 05-mode-change &&
 	 rm -f 06-file-or-symlink &&
-	 if test_have_prereq SYMLINKS; then
-		ln -s 01-change 06-file-or-symlink
-	 else
-		printf %s 01-change > 06-file-or-symlink
-	 fi &&
+	 test_ln_s_add 01-change 06-file-or-symlink &&
 	 echo "Changed and have mode changed" > 07-change-mode-change	&&
 	 test_chmod +x 07-change-mode-change &&
 	 git commit -a -m "Large commit" &&
-- 
1.8.3.rc1.32.g8b61cbb
