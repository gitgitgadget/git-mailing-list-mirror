From: Don Slutz <slutz@krl.com>
Subject: (unknown)
Date: Mon, 11 May 2009 14:57:12 -0400
Message-ID: <200905111857.n4BIvCNQ002319@krl.krl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 21:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3b9G-00066b-UO
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 21:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757869AbZEKTZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 15:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757698AbZEKTZh
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 15:25:37 -0400
Received: from krl.krl.com ([192.147.32.3]:42939 "EHLO krl.krl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbZEKTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 15:25:28 -0400
X-Greylist: delayed 1681 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2009 15:25:15 EDT
Received: from krl.krl.com (localhost [127.0.0.1])
	by krl.krl.com (8.13.1/8.13.1) with ESMTP id n4BIvDYu002326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 11 May 2009 14:57:13 -0400
Received: (from slutz@localhost)
	by krl.krl.com (8.13.1/8.13.1/Submit) id n4BIvCNQ002319
	for git@vger.kernel.org; Mon, 11 May 2009 14:57:12 -0400
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on krl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118827>

>From 96607bf6ffca78c88278e206ed40dce3abc1d4d9 Mon Sep 17 00:00:00 2001
From: Don Slutz <Don.Slutz@SierraAtlantic.com>
Date: Mon, 11 May 2009 11:58:32 -0400
Subject: [PATCH 3/6] Fix tests to work with core.autocrlf=true

Use the new functions to fix tests.

Signed-off-by: Don Slutz <Don.Slutz@SierraAtlantic.com>
---
 t/t0002-gitfile.sh                        |    3 +-
 t/t2004-checkout-cache-temp.sh            |   42 ++++++++++++++--------------
 t/t2008-checkout-subdir.sh                |   14 +++++-----
 t/t3404-rebase-interactive.sh             |    2 +-
 t/t3410-rebase-preserve-dropped-merges.sh |   12 ++++----
 t/t3413-rebase-hook.sh                    |   32 +++++++++++-----------
 t/t3503-cherry-pick-root.sh               |    2 +-
 t/t3903-stash.sh                          |   12 ++++----
 t/t4102-apply-rename.sh                   |    5 ++-
 t/t4124-apply-ws-rule.sh                  |   23 ++++++++++++---
 t/t4125-apply-ws-fuzz.sh                  |    9 +++++-
 t/t4128-apply-root.sh                     |    8 +++---
 t/t4150-am.sh                             |    4 +-
 t/t4252-am-options.sh                     |   16 ++++++++---
 t/t5000-tar-tree.sh                       |   12 +++++---
 t/t5001-archive-attr.sh                   |    3 ++
 t/t5520-pull.sh                           |   12 ++++----
 t/t7003-filter-branch.sh                  |    4 +-
 t/t7201-co.sh                             |    2 +-
 t/t7402-submodule-rebase.sh               |    4 +-
 t/t7610-mergetool.sh                      |    6 ++--
 t/t7800-difftool.sh                       |   13 +++++----
 t/t9700-perl-git.sh                       |    2 +-
 23 files changed, 139 insertions(+), 103 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index cb14425..3762714 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -60,7 +60,8 @@ test_expect_success 'final setup + check rev-parse --git-dir' '
 
 test_expect_success 'check hash-object' '
 	echo "foo" >bar &&
-	SHA=$(cat bar | git hash-object -w --stdin) &&
+	SHA=$(cat bar | git hash-object -w --stdin --path=bar) &&
+	test_debug "echo SHA=$SHA" &&
 	objck $SHA
 '
 
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 36cca14..ce4c584 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -44,7 +44,7 @@ test $(wc -l <out) = 1 &&
 test $(cut "-d	" -f2 out) = path1 &&
 p=$(cut "-d	" -f1 out) &&
 test -f $p &&
-test $(cat $p) = tree1path1'
+test_cat_eq $p tree1path1'
 
 test_expect_success \
 'checkout all stage 0 to temporary files' '
@@ -57,7 +57,7 @@ do
 	test $(grep $f out | cut "-d	" -f2) = $f &&
 	p=$(grep $f out | cut "-d	" -f1) &&
 	test -f $p &&
-	test $(cat $p) = tree1$f
+	test_cat_eq $p tree1$f
 done'
 
 test_expect_success \
@@ -73,7 +73,7 @@ test $(wc -l <out) = 1 &&
 test $(cut "-d	" -f2 out) = path1 &&
 p=$(cut "-d	" -f1 out) &&
 test -f $p &&
-test $(cat $p) = tree2path1'
+test_cat_eq $p tree2path1'
 
 test_expect_success \
 'checkout all stage 2 to temporary files' '
@@ -85,7 +85,7 @@ do
 	test $(grep $f out | cut "-d	" -f2) = $f &&
 	p=$(grep $f out | cut "-d	" -f1) &&
 	test -f $p &&
-	test $(cat $p) = tree2$f
+	test_cat_eq $p tree2$f
 done'
 
 test_expect_success \
@@ -104,9 +104,9 @@ cut "-d	" -f1 out | (read s1 s2 s3 &&
 test -f $s1 &&
 test -f $s2 &&
 test -f $s3 &&
-test $(cat $s1) = tree1path1 &&
-test $(cat $s2) = tree2path1 &&
-test $(cat $s3) = tree3path1)'
+test_cat_eq $s1 tree1path1 &&
+test_cat_eq $s2 tree2path1 &&
+test_cat_eq $s3 tree3path1)'
 
 test_expect_success \
 'checkout some stages/one file to temporary files' '
@@ -118,8 +118,8 @@ cut "-d	" -f1 out | (read s1 s2 s3 &&
 test $s1 = . &&
 test -f $s2 &&
 test -f $s3 &&
-test $(cat $s2) = tree2path2 &&
-test $(cat $s3) = tree3path2)'
+test_cat_eq $s2 tree2path2 &&
+test_cat_eq $s3 tree3path2)'
 
 test_expect_success \
 'checkout all stages/all files to temporary files' '
@@ -138,9 +138,9 @@ grep path1 out | cut "-d	" -f1 | (read s1 s2 s3 &&
 test -f $s1 &&
 test -f $s2 &&
 test -f $s3 &&
-test $(cat $s1) = tree1path1 &&
-test $(cat $s2) = tree2path1 &&
-test $(cat $s3) = tree3path1)'
+test_cat_eq $s1 tree1path1 &&
+test_cat_eq $s2 tree2path1 &&
+test_cat_eq $s3 tree3path1)'
 
 test_expect_success \
 '-- path2: no stage 1, have stage 2 and 3' '
@@ -149,8 +149,8 @@ grep path2 out | cut "-d	" -f1 | (read s1 s2 s3 &&
 test $s1 = . &&
 test -f $s2 &&
 test -f $s3 &&
-test $(cat $s2) = tree2path2 &&
-test $(cat $s3) = tree3path2)'
+test_cat_eq $s2 tree2path2 &&
+test_cat_eq $s3 tree3path2)'
 
 test_expect_success \
 '-- path3: no stage 2, have stage 1 and 3' '
@@ -159,8 +159,8 @@ grep path3 out | cut "-d	" -f1 | (read s1 s2 s3 &&
 test -f $s1 &&
 test $s2 = . &&
 test -f $s3 &&
-test $(cat $s1) = tree1path3 &&
-test $(cat $s3) = tree3path3)'
+test_cat_eq $s1 tree1path3 &&
+test_cat_eq $s3 tree3path3)'
 
 test_expect_success \
 '-- path4: no stage 3, have stage 1 and 3' '
@@ -169,8 +169,8 @@ grep path4 out | cut "-d	" -f1 | (read s1 s2 s3 &&
 test -f $s1 &&
 test -f $s2 &&
 test $s3 = . &&
-test $(cat $s1) = tree1path4 &&
-test $(cat $s2) = tree2path4)'
+test_cat_eq $s1 tree1path4 &&
+test_cat_eq $s2 tree2path4)'
 
 test_expect_success \
 '-- asubdir/path5: no stage 2 and 3 have stage 1' '
@@ -179,7 +179,7 @@ grep asubdir/path5 out | cut "-d	" -f1 | (read s1 s2 s3 &&
 test -f $s1 &&
 test $s2 = . &&
 test $s3 = . &&
-test $(cat $s1) = tree1asubdir/path5)'
+test_cat_eq $s1 tree1asubdir/path5)'
 
 test_expect_success \
 'checkout --temp within subdir' '
@@ -191,7 +191,7 @@ test_expect_success \
  test -f ../$s1 &&
  test $s2 = . &&
  test $s3 = . &&
- test $(cat ../$s1) = tree1asubdir/path5)
+ test_cat_eq ../$s1 tree1asubdir/path5)
 )'
 
 test_expect_success SYMLINKS \
@@ -207,6 +207,6 @@ test $(wc -l <out) = 1 &&
 test $(cut "-d	" -f2 out) = a &&
 p=$(cut "-d	" -f1 out) &&
 test -f $p &&
-test $(cat $p) = b'
+test_cat_eq $p b'
 
 test_done
diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index 3e098ab..7933197 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -27,14 +27,14 @@ test_expect_success 'remove and restore with relative path' '
 		cd dir1 &&
 		rm ../file0 &&
 		git checkout HEAD -- ../file0 &&
-		test "base" = "$(cat ../file0)" &&
+		test_eq_cat base ../file0 &&
 		rm ../dir2/file2 &&
 		git checkout HEAD -- ../dir2/file2 &&
-		test "bonjour" = "$(cat ../dir2/file2)" &&
+		test_eq_cat bonjour ../dir2/file2 &&
 		rm ../file0 ./file1 &&
 		git checkout HEAD -- .. &&
-		test "base" = "$(cat ../file0)" &&
-		test "hello" = "$(cat file1)"
+		test_eq_cat base ../file0 &&
+		test_eq_cat hello file1
 	)
 
 '
@@ -43,7 +43,7 @@ test_expect_success 'checkout with empty prefix' '
 
 	rm file0 &&
 	git checkout HEAD -- file0 &&
-	test "base" = "$(cat file0)"
+	test_eq_cat base file0
 
 '
 
@@ -51,10 +51,10 @@ test_expect_success 'checkout with simple prefix' '
 
 	rm dir1/file1 &&
 	git checkout HEAD -- dir1 &&
-	test "hello" = "$(cat dir1/file1)" &&
+	test_eq_cat hello dir1/file1 &&
 	rm dir1/file1 &&
 	git checkout HEAD -- dir1/file1 &&
-	test "hello" = "$(cat dir1/file1)"
+	test_eq_cat hello dir1/file1
 
 '
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c32ff66..6990c77 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -162,7 +162,7 @@ test_expect_success 'squash' '
 	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
 	echo "******************************" &&
 	FAKE_LINES="1 squash 2" git rebase -i --onto master HEAD~2 &&
-	test B = $(cat file7) &&
+	test_eq_cat B file7 &&
 	test $(git rev-parse HEAD^) = $(git rev-parse master)
 '
 
diff --git a/t/t3410-rebase-preserve-dropped-merges.sh b/t/t3410-rebase-preserve-dropped-merges.sh
index c49143a..a044962 100755
--- a/t/t3410-rebase-preserve-dropped-merges.sh
+++ b/t/t3410-rebase-preserve-dropped-merges.sh
@@ -52,9 +52,9 @@ test_expect_success 'skip same-resolution merges with -p' '
 	test_commit K file7 file7 &&
 	git rebase -i -p L &&
 	test $(git rev-parse HEAD^^) = $(git rev-parse L) &&
-	test "23" = "$(cat file1)" &&
-	test "I" = "$(cat file6)" &&
-	test "file7" = "$(cat file7)"
+	test_eq_cat 23 file1 &&
+	test_eq_cat I file6 &&
+	test_eq_cat file7 file7
 '
 
 # A - B - C - D - E
@@ -77,9 +77,9 @@ test_expect_success 'keep different-resolution merges with -p' '
 	git add file1 &&
 	git rebase --continue &&
 	test $(git rev-parse HEAD^^^) = $(git rev-parse L2) &&
-	test "234" = "$(cat file1)" &&
-	test "I" = "$(cat file6)" &&
-	test "file7" = "$(cat file7)"
+	test_eq_cat 234 file1 &&
+	test_eq_cat I file6 &&
+	test_eq_cat file7 file7
 '
 
 test_done
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 098b755..ac9ad05 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -27,14 +27,14 @@ test_expect_success 'rebase' '
 	git checkout test &&
 	git reset --hard side &&
 	git rebase master &&
-	test "z$(cat git)" = zworld
+	test_cat_eq git world
 '
 
 test_expect_success 'rebase -i' '
 	git checkout test &&
 	git reset --hard side &&
 	EDITOR=true git rebase -i master &&
-	test "z$(cat git)" = zworld
+	test_cat_eq git world
 '
 
 test_expect_success 'setup pre-rebase hook' '
@@ -50,8 +50,8 @@ test_expect_success 'pre-rebase hook gets correct input (1)' '
 	git checkout test &&
 	git reset --hard side &&
 	git rebase master &&
-	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,
+	test_cat_eq git world &&
+	test_cat_eq .git/PRE-REBASE-INPUT master,
 
 '
 
@@ -59,8 +59,8 @@ test_expect_success 'pre-rebase hook gets correct input (2)' '
 	git checkout test &&
 	git reset --hard side &&
 	git rebase master test &&
-	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test_cat_eq git world &&
+	test_cat_eq .git/PRE-REBASE-INPUT master,test
 '
 
 test_expect_success 'pre-rebase hook gets correct input (3)' '
@@ -68,16 +68,16 @@ test_expect_success 'pre-rebase hook gets correct input (3)' '
 	git reset --hard side &&
 	git checkout master &&
 	git rebase master test &&
-	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test_cat_eq git world &&
+	test_cat_eq .git/PRE-REBASE-INPUT master,test
 '
 
 test_expect_success 'pre-rebase hook gets correct input (4)' '
 	git checkout test &&
 	git reset --hard side &&
 	EDITOR=true git rebase -i master &&
-	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,
+	test_cat_eq git world &&
+	test_cat_eq .git/PRE-REBASE-INPUT master,
 
 '
 
@@ -85,8 +85,8 @@ test_expect_success 'pre-rebase hook gets correct input (5)' '
 	git checkout test &&
 	git reset --hard side &&
 	EDITOR=true git rebase -i master test &&
-	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test_cat_eq git world &&
+	test_cat_eq .git/PRE-REBASE-INPUT master,test
 '
 
 test_expect_success 'pre-rebase hook gets correct input (6)' '
@@ -94,8 +94,8 @@ test_expect_success 'pre-rebase hook gets correct input (6)' '
 	git reset --hard side &&
 	git checkout master &&
 	EDITOR=true git rebase -i master test &&
-	test "z$(cat git)" = zworld &&
-	test "z$(cat .git/PRE-REBASE-INPUT)" = zmaster,test
+	test_cat_eq git world &&
+	test_cat_eq .git/PRE-REBASE-INPUT master,test
 '
 
 test_expect_success 'setup pre-rebase hook that fails' '
@@ -132,7 +132,7 @@ test_expect_success 'rebase --no-verify overrides pre-rebase (1)' '
 	git reset --hard side &&
 	git rebase --no-verify master &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
-	test "z$(cat git)" = zworld
+	test_cat_eq git world
 '
 
 test_expect_success 'rebase --no-verify overrides pre-rebase (2)' '
@@ -140,7 +140,7 @@ test_expect_success 'rebase --no-verify overrides pre-rebase (2)' '
 	git reset --hard side &&
 	EDITOR=true git rebase --no-verify -i master &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
-	test "z$(cat git)" = zworld
+	test_cat_eq git world
 '
 
 test_done
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index b0faa29..dfcd72a 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 test_expect_success 'cherry-pick a root commit' '
 
 	git cherry-pick master &&
-	test first = $(cat file1)
+	test_eq_cat first file1
 
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7484cbe..7c1e169 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -49,7 +49,7 @@ test_expect_success 'apply stashed changes' '
 	test_tick &&
 	git commit -m other-file &&
 	git stash apply &&
-	test 3 = $(cat file) &&
+	test_eq_cat 3 file &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file)
 '
@@ -61,7 +61,7 @@ test_expect_success 'apply stashed changes (including index)' '
 	test_tick &&
 	git commit -m other-file &&
 	git stash apply --index &&
-	test 3 = $(cat file) &&
+	test_eq_cat 3 file &&
 	test 2 = $(git show :file) &&
 	test 1 = $(git show HEAD:file)
 '
@@ -83,7 +83,7 @@ test_expect_success 'drop top stash' '
 	git stash list > stashlist2 &&
 	diff stashlist1 stashlist2 &&
 	git stash apply &&
-	test 3 = $(cat file) &&
+	test_eq_cat 3 file &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file)
 '
@@ -97,13 +97,13 @@ test_expect_success 'drop middle stash' '
 	git stash drop stash@{1} &&
 	test 2 = $(git stash list | wc -l) &&
 	git stash apply &&
-	test 9 = $(cat file) &&
+	test_eq_cat 9 file &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file) &&
 	git reset --hard &&
 	git stash drop &&
 	git stash apply &&
-	test 3 = $(cat file) &&
+	test_eq_cat 3 file &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file)
 '
@@ -111,7 +111,7 @@ test_expect_success 'drop middle stash' '
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
-	test 3 = $(cat file) &&
+	test_eq_cat 3 file &&
 	test 1 = $(git show :file) &&
 	test 1 = $(git show HEAD:file) &&
 	test 0 = $(git stash list | wc -l)
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index 1597965..5c7300d 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -43,7 +43,7 @@ test_expect_success FILEMODE validate \
 
 test_expect_success 'apply reverse' \
     'git apply -R --index --stat --summary --apply test-patch &&
-     test "$(cat foo)" = "This is foo"'
+     test_cat_eq foo "This is foo"'
 
 cat >test-patch <<\EOF
 diff --git a/foo b/bar
@@ -59,6 +59,7 @@ EOF
 
 test_expect_success 'apply copy' \
     'git apply --index --stat --summary --apply test-patch &&
-     test "$(cat bar)" = "This is bar" -a "$(cat foo)" = "This is foo"'
+     test_cat_eq bar "This is bar" &&
+     test_cat_eq foo "This is foo"'
 
 test_done
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index f83322e..3933dd9 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -38,13 +38,19 @@ apply_patch () {
 	git apply "$@"
 }
 
+remove_cr () {
+	tr '\015' Q <"$1" | sed -e 's/Q$//'
+}
+
 test_fix () {
 
 	# fix should not barf
 	apply_patch --whitespace=fix || return 1
 
+	test_debug "echo patch applied: [$1]"
 	# find touched lines
-	diff file target | sed -n -e "s/^> //p" >fixed
+	remove_cr target >target1
+	diff file target1 | sed -n -e "s/^> //p" >fixed
 
 	# the changed lines are all expeced to change
 	fixed_cnt=$(wc -l <fixed)
@@ -52,6 +58,7 @@ test_fix () {
 	'') expect_cnt=$fixed_cnt ;;
 	?*) expect_cnt=$(grep "[$1]" <fixed | wc -l) ;;
 	esac
+	test_debug "echo fixed: $fixed_cnt vs $expect_cnt"
 	test $fixed_cnt -eq $expect_cnt || return 1
 
 	# and we are not missing anything
@@ -59,12 +66,14 @@ test_fix () {
 	'') expect_cnt=0 ;;
 	?*) expect_cnt=$(grep "[$1]" <file | wc -l) ;;
 	esac
+	test_debug "echo missing: $fixed_cnt vs $expect_cnt"
 	test $fixed_cnt -eq $expect_cnt || return 1
 
 	# Get the patch actually applied
 	git diff-files -p target >fixed-patch
 	test -s fixed-patch && return 0
 
+	test_debug "echo failed to apply, try and fix"
 	# Make sure it is complaint-free
 	>target
 	git apply --whitespace=error-all <fixed-patch
@@ -85,14 +94,16 @@ test_expect_success setup '
 test_expect_success 'whitespace=nowarn, default rule' '
 
 	apply_patch --whitespace=nowarn &&
-	diff file target
+	remove_cr target >target1 &&
+	diff file target1
 
 '
 
 test_expect_success 'whitespace=warn, default rule' '
 
 	apply_patch --whitespace=warn &&
-	diff file target
+	remove_cr target >target1 &&
+	diff file target1
 
 '
 
@@ -108,7 +119,8 @@ test_expect_success 'whitespace=error-all, no rule' '
 
 	git config core.whitespace -trailing,-space-before,-indent &&
 	apply_patch --whitespace=error-all &&
-	diff file target
+	remove_cr target >target1 &&
+	diff file target1
 
 '
 
@@ -117,7 +129,8 @@ test_expect_success 'whitespace=error-all, no rule (attribute)' '
 	git config --unset core.whitespace &&
 	echo "target -whitespace" >.gitattributes &&
 	apply_patch --whitespace=error-all &&
-	diff file target
+	remove_cr target >target1 &&
+	diff file target1
 
 '
 
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index 3b471b6..c02fe08 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -4,6 +4,10 @@ test_description='applying patch that has broken whitespaces in context'
 
 . ./test-lib.sh
 
+remove_cr () {
+	tr '\015' Q <"$1" | sed -e 's/Q$//'
+}
+
 test_expect_success setup '
 
 	>file &&
@@ -91,12 +95,13 @@ test_expect_success 'withfix (backward)' '
 
 	sed -e /h/d file-fixed >fixed-head &&
 	sed -e /h/d file >file-head &&
-	test_cmp fixed-head file-head &&
+	remove_cr file-head >file-head1
+	diff fixed-head file-head1 &&
 
 	sed -n -e /h/p file-fixed >fixed-tail &&
 	sed -n -e /h/p file >file-tail &&
 
-	! test_cmp fixed-tail file-tail
+	! diff fixed-tail file-tail
 
 '
 
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index 8f6aea4..a03a9c8 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -27,7 +27,7 @@ test_expect_success 'apply --directory -p (1)' '
 
 	git apply --directory=some/sub -p3 --index patch &&
 	test Bello = $(git show :some/sub/dir/file) &&
-	test Bello = $(cat some/sub/dir/file)
+	test_eq_cat Bello some/sub/dir/file
 
 '
 
@@ -36,7 +36,7 @@ test_expect_success 'apply --directory -p (2) ' '
 	git reset --hard initial &&
 	git apply --directory=some/sub/ -p3 --index patch &&
 	test Bello = $(git show :some/sub/dir/file) &&
-	test Bello = $(cat some/sub/dir/file)
+	test_eq_cat Bello some/sub/dir/file
 
 '
 
@@ -54,7 +54,7 @@ test_expect_success 'apply --directory (new file)' '
 	git reset --hard initial &&
 	git apply --directory=some/sub/dir/ --index patch &&
 	test content = $(git show :some/sub/dir/newfile) &&
-	test content = $(cat some/sub/dir/newfile)
+	test_eq_cat content some/sub/dir/newfile
 '
 
 cat > patch << EOF
@@ -89,7 +89,7 @@ test_expect_success 'apply --directory (quoted filename)' '
 	git reset --hard initial &&
 	git apply --directory=some/sub/dir/ --index patch &&
 	test content = $(git show :some/sub/dir/quotefile) &&
-	test content = $(cat some/sub/dir/quotefile)
+	test_eq_cat content some/sub/dir/quotefile
 '
 
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index d6ebbae..27570b7 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -190,7 +190,7 @@ test_expect_success 'am --skip works' '
 	git am --skip &&
 	! test -d .git/rebase-apply &&
 	test -z "$(git diff lorem2^^ -- file)" &&
-	test goodbye = "$(cat another)"
+	test_eq_cat goodbye another
 '
 
 test_expect_success 'am --resolved works' '
@@ -201,7 +201,7 @@ test_expect_success 'am --resolved works' '
 	git add file &&
 	git am --resolved &&
 	! test -d .git/rebase-apply &&
-	test goodbye = "$(cat another)"
+	test_eq_cat goodbye another
 '
 
 test_expect_success 'am takes patches from a Pine mailbox' '
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index f603c1b..342fc1a 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -3,6 +3,10 @@
 test_description='git am with options and not losing them'
 . ./test-lib.sh
 
+remove_cr () {
+	tr '\015' Q <"$1" | sed -e 's/Q$//'
+}
+
 tm="$TEST_DIRECTORY/t4252"
 
 test_expect_success setup '
@@ -20,7 +24,8 @@ test_expect_success 'interrupted am --whitespace=fix' '
 	test_must_fail git am --whitespace=fix "$tm"/am-test-1-? &&
 	git am --skip &&
 	grep 3 file-1 &&
-	grep "^Six$" file-2
+	remove_cr file-2 >file-2a &&
+	grep "^Six$" file-2a
 '
 
 test_expect_success 'interrupted am -C1' '
@@ -29,7 +34,8 @@ test_expect_success 'interrupted am -C1' '
 	test_must_fail git am -C1 "$tm"/am-test-2-? &&
 	git am --skip &&
 	grep 3 file-1 &&
-	grep "^Three$" file-2
+	remove_cr file-2 >file-2a &&
+	grep "^Three$" file-2a
 '
 
 test_expect_success 'interrupted am -p2' '
@@ -38,7 +44,8 @@ test_expect_success 'interrupted am -p2' '
 	test_must_fail git am -p2 "$tm"/am-test-3-? &&
 	git am --skip &&
 	grep 3 file-1 &&
-	grep "^Three$" file-2
+	remove_cr file-2 >file-2a &&
+	grep "^Three$" file-2a
 '
 
 test_expect_success 'interrupted am -C1 -p2' '
@@ -47,7 +54,8 @@ test_expect_success 'interrupted am -C1 -p2' '
 	test_must_fail git am -p2 -C1 "$tm"/am-test-4-? &&
 	git am --skip &&
 	grep 3 file-1 &&
-	grep "^Three$" file-2
+	remove_cr file-2 >file-2a &&
+	grep "^Three$" file-2a
 '
 
 test_expect_success 'interrupted am --directory="frotz nitfol"' '
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index abb41b0..28d6291 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,6 +25,8 @@ commit id embedding:
 '
 
 . ./test-lib.sh
+autocrlf=$(git config core.autocrlf)
+
 UNZIP=${UNZIP:-unzip}
 
 SUBSTFORMAT=%H%n
@@ -66,6 +68,8 @@ test_expect_success \
     'git clone --bare . bare.git &&
      cp .git/info/attributes bare.git/info/attributes'
 
+test ! -z "$autocrlf" && (cd bare.git; git config core.autocrlf $autocrlf)
+
 test_expect_success \
     'remove ignored file' \
     'rm a/ignored'
@@ -118,7 +122,7 @@ test_expect_success \
 
 test_expect_success \
     'validate file contents' \
-    'diff -r a b/a'
+    'diff -rb a b/a'
 
 test_expect_success \
     'git tar-tree with prefix' \
@@ -135,7 +139,7 @@ test_expect_success \
 
 test_expect_success \
     'validate file contents with prefix' \
-    'diff -r a c/prefix/a'
+    'diff -rb a c/prefix/a'
 
 test_expect_success \
     'create archives with substfiles' \
@@ -203,7 +207,7 @@ test_expect_success UNZIP \
 
 test_expect_success UNZIP \
     'validate file contents' \
-    'diff -r a d/a'
+    'diff -rb a d/a'
 
 test_expect_success \
     'git archive --format=zip with prefix' \
@@ -220,7 +224,7 @@ test_expect_success UNZIP \
 
 test_expect_success UNZIP \
     'validate file contents with prefix' \
-    'diff -r a e/prefix/a'
+    'diff -rb a e/prefix/a'
 
 test_expect_success \
     'git archive --list outside of a git repo' \
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 426b319..2efa018 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -3,6 +3,7 @@
 test_description='git archive attribute tests'
 
 . ./test-lib.sh
+autocrlf=$(git config core.autocrlf)
 
 SUBSTFORMAT=%H%n
 
@@ -39,6 +40,8 @@ test_expect_success 'setup' '
 	cp .git/info/attributes bare/info/attributes
 '
 
+test ! -z "$autocrlf" && (cd bare; git config core.autocrlf $autocrlf)
+
 test_expect_success 'git archive' '
 	git archive HEAD >archive.tar &&
 	(mkdir archive && cd archive && "$TAR" xf -) <archive.tar
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 725771f..4d4e7ac 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -49,9 +49,9 @@ test_expect_success 'test . as a remote' '
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
-	test `cat file` = file &&
+	test_cat_eq file file &&
 	git pull &&
-	test `cat file` = updated
+	test_cat_eq file updated
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -60,9 +60,9 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git commit -a -m modified &&
 	git checkout copy &&
 	git reset --hard HEAD^ &&
-	test `cat file` = file &&
+	test_cat_eq file file &&
 	git pull . second &&
-	test `cat file` = modified
+	test_cat_eq file modified
 '
 
 test_expect_success '--rebase' '
@@ -99,8 +99,8 @@ test_expect_success '--rebase with rebased upstream' '
 	echo file > file2 &&
 	git commit -m to-rebase file2 &&
 	git pull --rebase me copy &&
-	test "conflicting modification" = "$(cat file)" &&
-	test file = $(cat file2)
+	test_eq_cat "conflicting modification" file &&
+	test_eq_cat file file2
 
 '
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 329c851..c6e9fb5 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -72,7 +72,7 @@ test_expect_success 'test that the file was renamed' '
 	test d = "$(git show HEAD:doh --)" &&
 	! test -f d &&
 	test -f doh &&
-	test d = "$(cat doh)"
+	test_eq_cat d doh
 '
 
 test_expect_success 'rewrite, renaming a specific directory' '
@@ -85,7 +85,7 @@ test_expect_success 'test that the directory was renamed' '
 	test -d diroh &&
 	! test -d diroh/dir &&
 	test -f diroh/d &&
-	test dir/d = "$(cat diroh/d)"
+	test_eq_cat dir/d diroh/d
 '
 
 git tag oldD HEAD~4
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index bdb808a..62f58eb 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -434,7 +434,7 @@ test_expect_success 'checkout unmerged stage' '
 	test_cmp expect filf &&
 	test_cmp expect file &&
 	git checkout --theirs file &&
-	test ztheirside = "z$(cat file)"
+	test_eq_cat theirside file
 '
 
 test_expect_success 'checkout with --merge' '
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index f919c8d..8e5d747 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -80,11 +80,11 @@ test_expect_success 'stash with a dirty submodule' '
 	echo new > file &&
 	CURRENT=$(cd submodule && git rev-parse HEAD) &&
 	git stash &&
-	test new != $(cat file) &&
+	test_ne_cat new file &&
 	test submodule = $(git diff --name-only) &&
 	test $CURRENT = $(cd submodule && git rev-parse HEAD) &&
 	git stash apply &&
-	test new = $(cat file) &&
+	test_eq_cat new file &&
 	test $CURRENT = $(cd submodule && git rev-parse HEAD)
 
 '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index e768c3e..bf39e45 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -45,9 +45,9 @@ test_expect_success 'custom mergetool' '
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
-    test "$(cat file1)" = "master updated" &&
-    test "$(cat file2)" = "master new" &&
-    test "$(cat subdir/file3)" = "master new sub" &&
+    test_cat_eq file1 "master updated" &&
+    test_cat_eq file2 "master new" &&
+    test_cat_eq subdir/file3 "master new sub" &&
     git commit -m "branch1 resolved with mergetool"
 '
 
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ebdccf9..b95069a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -35,11 +35,12 @@ restore_test_defaults()
 	unset GIT_DIFFTOOL_PROMPT
 	unset GIT_DIFFTOOL_NO_PROMPT
 	git config diff.tool test-tool &&
-	git config difftool.test-tool.cmd 'cat $LOCAL'
+	git config difftool.test-tool.cmd "tr '\015' '\012' <\$LOCAL"
 }
 
 prompt_given()
 {
+	test_debug "echo prompt_given:$1"
 	prompt="$1"
 	test "$prompt" = "Hit return to launch 'test-tool': branch"
 }
@@ -59,7 +60,7 @@ test_expect_success 'setup' '
 # Configure a custom difftool.<tool>.cmd and use it
 test_expect_success 'custom commands' '
 	restore_test_defaults &&
-	git config difftool.test-tool.cmd "cat \$REMOTE" &&
+	git config difftool.test-tool.cmd "tr '\''\015'\'' '\''\012'\'' <\$REMOTE" &&
 
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "master" &&
@@ -136,7 +137,7 @@ test_expect_success 'GIT_DIFFTOOL_PROMPT variable' '
 	GIT_DIFFTOOL_PROMPT=true &&
 	export GIT_DIFFTOOL_PROMPT &&
 
-	prompt=$(echo | git difftool --prompt branch | tail -1) &&
+	prompt=$(echo | git difftool --prompt branch | head -3 | tail -1) &&
 	prompt_given "$prompt" &&
 
 	restore_test_defaults
@@ -166,7 +167,7 @@ test_expect_success 'difftool.prompt can overridden with -y' '
 test_expect_success 'difftool.prompt can overridden with --prompt' '
 	git config difftool.prompt false &&
 
-	prompt=$(echo | git difftool --prompt branch | tail -1) &&
+	prompt=$(echo | git difftool --prompt branch | head -3 | tail -1) &&
 	prompt_given "$prompt" &&
 
 	restore_test_defaults
@@ -179,7 +180,7 @@ test_expect_success 'difftool last flag wins' '
 
 	restore_test_defaults &&
 
-	prompt=$(echo | git difftool --no-prompt --prompt branch | tail -1) &&
+	prompt=$(echo | git difftool --no-prompt --prompt branch | head -3 | tail -1) &&
 	prompt_given "$prompt" &&
 
 	restore_test_defaults
@@ -190,7 +191,7 @@ test_expect_success 'difftool last flag wins' '
 test_expect_success 'difftool + mergetool config variables' '
 	remove_config_vars
 	git config merge.tool test-tool &&
-	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
+	git config mergetool.test-tool.cmd "tr '\''\015'\'' '\''\012'\'' <\$LOCAL" &&
 
 	diff=$(git difftool --no-prompt branch) &&
 	test "$diff" = "branch" &&
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b4ca244..76f741f 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -42,7 +42,7 @@ test_expect_success \
      git config --add test.int 2k
      '
 
-test_external_without_stderr \
+test_external_with_only_warning \
     'Perl API' \
     perl "$TEST_DIRECTORY"/t9700/test.pl
 
-- 
1.6.3.15.g49878
