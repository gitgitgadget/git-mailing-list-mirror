From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Clean up read-tree two-way tests.
Date: Fri, 10 Jun 2005 18:34:34 -0700
Message-ID: <7vd5qt7k2d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:30:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgupT-0003xR-FD
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFKBew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFKBew
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:34:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19400 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261503AbVFKBeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 21:34:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611013435.EMES7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 21:34:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is in preparation for "2-way fast-forward emulated with
3-way mechanism" series.  It does not change what the tests for
pure 2-way do.  It only changes how it tests things, to make
reviewing of differences of the two tests easier in later steps.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/t1001-read-tree-m-2way.sh |   77 +++++++++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -22,12 +22,18 @@ In the test, these paths are used:
 '
 . ./test-lib.sh
 
+read_tree_twoway () {
+    git-read-tree -m "$1" "$2" && git-ls-files --stage
+}
+
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 compare_change () {
-	sed >current \
+    	cat current
+	sed -n >current \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
-	    -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
+	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
+	    "$1"
 	diff -u expected current
 }
 
@@ -68,9 +74,9 @@ test_expect_success \
 test_expect_success \
     '1, 2, 3 - no carry forward' \
     'rm -f .git/index &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >1-3.out &&
-     cmp M.out 1-3.out &&
+     diff -u M.out 1-3.out &&
      check_cache_at bozbar dirty &&
      check_cache_at frotz dirty &&
      check_cache_at nitfol dirty'
@@ -81,9 +87,9 @@ test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index &&
      git-update-cache --add yomin &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >4.out || exit
-     diff --unified=0 M.out 4.out >4diff.out
+     diff -u M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
 
@@ -93,9 +99,9 @@ test_expect_success \
      echo yomin >yomin &&
      git-update-cache --add yomin &&
      echo yomin yomin >yomin &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >5.out || exit
-     diff --unified=0 M.out 5.out >5diff.out
+     diff -u M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
 
@@ -103,9 +109,9 @@ test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
      git-update-cache --add frotz &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >6.out &&
-     diff --unified=0 M.out 6.out &&
+     diff -u M.out 6.out &&
      check_cache_at frotz clean'
 
 test_expect_success \
@@ -114,9 +120,9 @@ test_expect_success \
      echo frotz >frotz &&
      git-update-cache --add frotz &&
      echo frotz frotz >frotz &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >7.out &&
-     diff --unified=0 M.out 7.out &&
+     diff -u M.out 7.out &&
      check_cache_at frotz dirty'
 
 test_expect_success \
@@ -124,7 +130,7 @@ test_expect_success \
     'rm -f .git/index &&
      echo frotz frotz >frotz &&
      git-update-cache --add frotz &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 test_expect_success \
     '9 - conflicting addition.' \
@@ -132,16 +138,16 @@ test_expect_success \
      echo frotz frotz >frotz &&
      git-update-cache --add frotz &&
      echo frotz >frotz &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index &&
      echo rezrov >rezrov &&
      git-update-cache --add rezrov &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >10.out &&
-     cmp M.out 10.out'
+     diff -u M.out 10.out'
 
 test_expect_success \
     '11 - dirty path removed.' \
@@ -149,14 +155,14 @@ test_expect_success \
      echo rezrov >rezrov &&
      git-update-cache --add rezrov &&
      echo rezrov rezrov >rezrov &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index &&
      echo rezrov rezrov >rezrov &&
      git-update-cache --add rezrov &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 test_expect_success \
     '13 - unmatching local changes being removed.' \
@@ -164,7 +170,7 @@ test_expect_success \
      echo rezrov rezrov >rezrov &&
      git-update-cache --add rezrov &&
      echo rezrov >rezrov &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 cat >expected <<EOF
 -100644 X 0	nitfol
@@ -176,9 +182,9 @@ test_expect_success \
     'rm -f .git/index &&
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >14.out || exit
-     diff --unified=0 M.out 14.out >14diff.out
+     diff -u M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
 
@@ -188,9 +194,9 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >15.out || exit
-     diff --unified=0 M.out 15.out >15diff.out
+     diff -u M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
 
@@ -199,7 +205,7 @@ test_expect_success \
     'rm -f .git/index &&
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 test_expect_success \
     '17 - conflicting local change.' \
@@ -207,16 +213,16 @@ test_expect_success \
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
      echo bozbar bozbar bozbar >bozbar &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index &&
      echo gnusto >bozbar &&
      git-update-cache --add bozbar &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >18.out &&
-     diff --unified=0 M.out 18.out &&
+     diff -u M.out 18.out &&
      check_cache_at bozbar clean'
 
 test_expect_success \
@@ -225,9 +231,9 @@ test_expect_success \
      echo gnusto >bozbar &&
      git-update-cache --add bozbar &&
      echo gnusto gnusto >bozbar &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >19.out &&
-     diff --unified=0 M.out 19.out &&
+     diff -u M.out 19.out &&
      check_cache_at bozbar dirty'
 
 test_expect_success \
@@ -235,9 +241,9 @@ test_expect_success \
     'rm -f .git/index &&
      echo bozbar >bozbar &&
      git-update-cache --add bozbar &&
-     git-read-tree -m $treeH $treeM &&
+     read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >20.out &&
-     diff --unified=0 M.out 20.out &&
+     diff -u M.out 20.out &&
      check_cache_at bozbar dirty'
 
 test_expect_success \
@@ -246,7 +252,7 @@ test_expect_success \
      echo bozbar >bozbar &&
      git-update-cache --add bozbar &&
      echo gnusto gnusto >bozbar &&
-     if git-read-tree -m $treeH $treeM; then false; else :; fi'
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
@@ -273,9 +279,10 @@ test_expect_success \
      rm -fr DF &&
      echo DF >DF &&
      git-update-cache --add DF &&
-     git-read-tree -m $treeDF $treeDFDF &&
+     read_tree_twoway $treeDF $treeDFDF &&
      git-ls-files --stage >DFDFcheck.out &&
-     diff --unified=0 DFDF.out DFDFcheck.out &&
-     check_cache_at DF/DF dirty'
+     diff -u DFDF.out DFDFcheck.out &&
+     check_cache_at DF/DF dirty &&
+     :'
 
 test_done
------------

