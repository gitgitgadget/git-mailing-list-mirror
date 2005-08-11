From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Trapping exit in tests, using return for errors
Date: Wed, 10 Aug 2005 23:56:21 -0400
Message-ID: <1123732581.18644.37.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 11 05:57:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E34BO-00088f-7U
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 05:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVHKD40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 23:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVHKD4Z
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 23:56:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:20967 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932216AbVHKD4Z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 23:56:25 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E348w-0000Rg-4X
	for git@vger.kernel.org; Wed, 10 Aug 2005 23:54:10 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E34B3-0000i4-T9
	for git@vger.kernel.org; Wed, 10 Aug 2005 23:56:21 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7B3uLID002729
	for git@vger.kernel.org; Wed, 10 Aug 2005 23:56:21 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

I have noticed that "make test" fails without any explanations when the
"merge" utility is missing.  I don't think tests should be silent in
case of failure.

It turned out that the particular test was using "exit" to interrupt the
test in case of an error.  This caused the whole test script to exit.
No further tests would be run even if "--immediate" wasn't specified.
No error message was printed.

This patch does following:

All instances of "exit", "exit 1" and "(exit 1)" in tests have been
replaced with "return 1".  In fact, "(exit 1)" had no effect.

File descriptor 5 is duplicated from file descriptor 1.  This is needed
to print important error messages from tests.

New function test_run_() has been introduced.  Any "return" in the test
would merely cause that function to return without skipping calls to
test_failure_() and test_ok_().  The new function also traps "exit" and
treats it like a fatal error (in case somebody reintroduces "exit" in
the tests).

test_expect_failure() and test_expect_success() check both the result of
eval and the return value of test_run_().  If the later is not 0, it's
always a failure because it indicates the the test didn't complete.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -100,7 +100,7 @@ test_expect_success \
      git-checkout-cache -u -f -q -a &&
      git-update-cache --add yomin &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >4.out || exit
+     git-ls-files --stage >4.out || return 1
      diff -u M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
@@ -114,7 +114,7 @@ test_expect_success \
      git-update-cache --add yomin &&
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >5.out || exit
+     git-ls-files --stage >5.out || return 1
      diff -u M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
@@ -215,7 +215,7 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >14.out || exit
+     git-ls-files --stage >14.out || return 1
      diff -u M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
@@ -229,7 +229,7 @@ test_expect_success \
      git-update-cache --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >15.out || exit
+     git-ls-files --stage >15.out || return 1
      diff -u M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -73,7 +73,7 @@ test_expect_success \
     'rm -f .git/index &&
      git-update-cache --add yomin &&
      git-read-tree -m -u $treeH $treeM &&
-     git-ls-files --stage >4.out || exit
+     git-ls-files --stage >4.out || return 1
      diff --unified=0 M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
@@ -90,7 +90,7 @@ test_expect_success \
      git-update-cache --add yomin &&
      echo yomin yomin >yomin &&
      git-read-tree -m -u $treeH $treeM &&
-     git-ls-files --stage >5.out || exit
+     git-ls-files --stage >5.out || return 1
      diff --unified=0 M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
@@ -192,7 +192,7 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      git-read-tree -m -u $treeH $treeM &&
-     git-ls-files --stage >14.out || exit
+     git-ls-files --stage >14.out || return 1
      diff --unified=0 M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
@@ -212,7 +212,7 @@ test_expect_success \
      git-update-cache --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      git-read-tree -m -u $treeH $treeM &&
-     git-ls-files --stage >15.out || exit
+     git-ls-files --stage >15.out || return 1
      diff --unified=0 M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -120,7 +120,7 @@ test_expect_success \
      git-checkout-cache -u -f -q -a &&
      git-update-cache --add yomin &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >4.out || exit
+     git-ls-files --stage >4.out || return 1
      diff -u M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
@@ -136,7 +136,7 @@ test_expect_success \
      git-update-cache --add yomin &&
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >5.out || exit
+     git-ls-files --stage >5.out || return 1
      diff -u M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
@@ -241,7 +241,7 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >14.out || exit
+     git-ls-files --stage >14.out || return 1
      diff -u M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
@@ -255,7 +255,7 @@ test_expect_success \
      git-update-cache --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >15.out || exit
+     git-ls-files --stage >15.out || return 1
      diff -u M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
@@ -352,7 +352,7 @@ test_expect_success \
      sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
      git-update-cache --add bozbar &&
      read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >22.out || exit
+     git-ls-files --stage >22.out || return 1
      diff -u M.out 22.out >22diff.out
      compare_change 22diff.out &&
      check_cache_at bozbar clean'
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -191,7 +191,7 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git-read-tree $tree_A &&
      git-checkout-cache -f -a &&
-     git-read-tree -m $tree_O || (exit 1)
+     git-read-tree -m $tree_O || return 1
      git-update-cache --refresh >/dev/null ;# this can exit non-zero
      git-diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OA'
@@ -201,7 +201,7 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git-read-tree $tree_B &&
      git-checkout-cache -f -a &&
-     git-read-tree -m $tree_O || (exit 1)
+     git-read-tree -m $tree_O || return 1
      git-update-cache --refresh >/dev/null ;# this can exit non-zero
      git-diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-OB'
@@ -211,7 +211,7 @@ test_expect_success \
     'rm -fr Z [A-Z][A-Z] &&
      git-read-tree $tree_B &&
      git-checkout-cache -f -a &&
-     git-read-tree -m $tree_A || (exit 1)
+     git-read-tree -m $tree_A || return 1
      git-update-cache --refresh >/dev/null ;# this can exit non-zero
      git-diff-files >.test-a &&
      cmp_diff_files_output .test-a .test-recursive-AB'
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -16,7 +16,7 @@ test_expect_success \
      for i in a b c
      do
 	     dd if=/dev/zero bs=4k count=1 | tr "\\0" $i >$i &&
-	     git-update-cache --add $i || exit
+	     git-update-cache --add $i || return 1
      done &&
      cat c >d && echo foo >>d && git-update-cache --add d &&
      tree=`git-write-tree` &&
@@ -29,7 +29,7 @@ test_expect_success \
 	 while read object
 	 do
 	    t=`git-cat-file -t $object` &&
-	    git-cat-file $t $object || exit 1
+	    git-cat-file $t $object || return 1
 	 done <obj-list
      } >expect'
 
@@ -58,7 +58,7 @@ test_expect_success \
      do
          cmp $path ../.git/$path || {
 	     echo $path differs.
-	     exit 1
+	     return 1
 	 }
      done'
 cd $TRASH
@@ -88,7 +88,7 @@ test_expect_success \
      do
          cmp $path ../.git/$path || {
 	     echo $path differs.
-	     exit 1
+	     return 1
 	 }
      done'
 cd $TRASH
@@ -106,7 +106,7 @@ test_expect_success \
 	 while read object
 	 do
 	    t=`git-cat-file -t $object` &&
-	    git-cat-file $t $object || exit 1
+	    git-cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
     diff expect current'
@@ -122,7 +122,7 @@ test_expect_success \
 	 while read object
 	 do
 	    t=`git-cat-file -t $object` &&
-	    git-cat-file $t $object || exit 1
+	    git-cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
     diff expect current'
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 	do
 	    sleep 1 &&
 	    commit=$(echo "Commit #$i" | git-commit-tree $tree -p $parent) &&
-	    parent=$commit || exit
+	    parent=$commit || return 1
 	done &&
 	echo "$commit" >.git/HEAD &&
 	git clone -l ./. victim &&
@@ -31,7 +31,7 @@ test_expect_success setup '
 	do
 	    sleep 1 &&
 	    commit=$(echo "Rebase #$i" | git-commit-tree $tree -p $parent) &&
-	    parent=$commit || exit
+	    parent=$commit || return 1
 	done &&
 	echo "$commit" >.git/HEAD &&
 	echo Rebase &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -63,6 +63,7 @@ do
 	esac
 done
 
+exec 5>&1
 if test "$verbose" = "t"
 then
 	exec 4>&2 3>&1
@@ -96,15 +97,24 @@ test_debug () {
 	test "$debug" == "" || eval "$1"
 }
 
+test_run_ () {
+	trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
+	eval >&3 2>&4 "$1"
+	eval_ret="$?"
+	trap - exit
+	return 0
+}
+
 test_expect_failure () {
 	test "$#" == 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-failure"
 	say >&3 "expecting failure: $2"
-	if eval >&3 2>&4 "$2"
+	test_run_ "$2"
+	if [ "$?" = 0 -a "$eval_ret" != 0 ]
 	then
-		test_failure_ "$@"
-	else
 		test_ok_ "$1"
+	else
+		test_failure_ "$@"
 	fi
 }
 
@@ -112,7 +122,8 @@ test_expect_success () {
 	test "$#" == 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-success"
 	say >&3 "expecting success: $2"
-	if eval >&3 2>&4 "$2"
+	test_run_ "$2"
+	if [ "$?" = 0 -a "$eval_ret" = 0 ]
 	then
 		test_ok_ "$1"
 	else


-- 
Regards,
Pavel Roskin
