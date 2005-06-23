From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add more tests for read-tree --emu23.
Date: Thu, 23 Jun 2005 16:25:14 -0700
Message-ID: <7vmzpgejvp.fsf@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlb1N-0004CA-6J
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVFWX21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVFWX20
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:28:26 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51131 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262743AbVFWXZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:25:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232515.NOJV17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:25:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Jun 2005 16:20:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds more tests for --emu23.  One is to show how it can
carry forward more local changes than the straightforward
two-way fast forward, and another is to show the recent
overeager optimization of directory/file conflict check broke
things, which will be fixed in the next commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 t/t1001-read-tree-m-2way.sh       |   70 +++++++++++++++++++++++++---
 t/t1005-read-tree-m-2way-emu23.sh |   94 ++++++++++++++++++++++++++++++++++---
 2 files changed, 150 insertions(+), 14 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -29,7 +29,6 @@ read_tree_twoway () {
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 compare_change () {
-    	cat current
 	sed -n >current \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
@@ -51,11 +50,22 @@ check_cache_at () {
 	esac
 }
 
+cat >bozbar-old <<\EOF
+This is a sample file used in two-way fast forward merge
+tests.  Its second line ends with a magic word bozbar
+which will be modified by the merged head to gnusto.
+It has some extra lines so that external tools can
+successfully merge independent changes made to later
+lines (such as this one), avoiding line conflicts.
+EOF
+
+sed -e 's/bozbar/gnusto (earlier bozbar)/' bozbar-old >bozbar-new
+
 test_expect_success \
     setup \
     'echo frotz >frotz &&
      echo nitfol >nitfol &&
-     echo bozbar >bozbar &&
+     cat bozbar-old >bozbar &&
      echo rezrov >rezrov &&
      echo yomin >yomin &&
      git-update-cache --add nitfol bozbar rezrov &&
@@ -63,7 +73,7 @@ test_expect_success \
      echo treeH $treeH &&
      git-ls-tree $treeH &&
 
-     echo gnusto >bozbar &&
+     cat bozbar-new >bozbar &&
      git-update-cache --add frotz bozbar --force-remove rezrov &&
      git-ls-files --stage >M.out &&
      treeM=`git-write-tree` &&
@@ -86,6 +96,8 @@ echo '+100644 X 0	yomin' >expected
 test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      git-update-cache --add yomin &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >4.out || exit
@@ -96,6 +108,8 @@ test_expect_success \
 test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo yomin >yomin &&
      git-update-cache --add yomin &&
      echo yomin yomin >yomin &&
@@ -108,6 +122,8 @@ test_expect_success \
 test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      git-update-cache --add frotz &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >6.out &&
@@ -117,6 +133,8 @@ test_expect_success \
 test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo frotz >frotz &&
      git-update-cache --add frotz &&
      echo frotz frotz >frotz &&
@@ -128,6 +146,8 @@ test_expect_success \
 test_expect_success \
     '8 - conflicting addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo frotz frotz >frotz &&
      git-update-cache --add frotz &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
@@ -135,6 +155,8 @@ test_expect_success \
 test_expect_success \
     '9 - conflicting addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo frotz frotz >frotz &&
      git-update-cache --add frotz &&
      echo frotz >frotz &&
@@ -143,6 +165,8 @@ test_expect_success \
 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov >rezrov &&
      git-update-cache --add rezrov &&
      read_tree_twoway $treeH $treeM &&
@@ -152,6 +176,8 @@ test_expect_success \
 test_expect_success \
     '11 - dirty path removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov >rezrov &&
      git-update-cache --add rezrov &&
      echo rezrov rezrov >rezrov &&
@@ -160,6 +186,8 @@ test_expect_success \
 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git-update-cache --add rezrov &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
@@ -167,6 +195,8 @@ test_expect_success \
 test_expect_success \
     '13 - unmatching local changes being removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git-update-cache --add rezrov &&
      echo rezrov >rezrov &&
@@ -180,6 +210,8 @@ EOF
 test_expect_success \
     '14 - unchanged in two heads.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      read_tree_twoway $treeH $treeM &&
@@ -191,6 +223,8 @@ test_expect_success \
 test_expect_success \
     '15 - unchanged in two heads.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
@@ -203,6 +237,8 @@ test_expect_success \
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
@@ -210,6 +246,8 @@ test_expect_success \
 test_expect_success \
     '17 - conflicting local change.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
      echo bozbar bozbar bozbar >bozbar &&
@@ -218,7 +256,9 @@ test_expect_success \
 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index &&
-     echo gnusto >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-new >bozbar &&
      git-update-cache --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >18.out &&
@@ -228,7 +268,9 @@ test_expect_success \
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
     'rm -f .git/index &&
-     echo gnusto >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-new >bozbar &&
      git-update-cache --add bozbar &&
      echo gnusto gnusto >bozbar &&
      read_tree_twoway $treeH $treeM &&
@@ -239,7 +281,9 @@ test_expect_success \
 test_expect_success \
     '20 - no local change, use new tree.' \
     'rm -f .git/index &&
-     echo bozbar >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-old >bozbar &&
      git-update-cache --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >20.out &&
@@ -249,11 +293,23 @@ test_expect_success \
 test_expect_success \
     '21 - no local change, dirty cache.' \
     'rm -f .git/index &&
-     echo bozbar >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-old >bozbar &&
      git-update-cache --add bozbar &&
      echo gnusto gnusto >bozbar &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
+# This fails with straight two-way fast forward.
+test_expect_success \
+    '22 - local change cache updated.' \
+    'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
+     git-update-cache --add bozbar &&
+     if read_tree_twoway $treeH $treeM; then false; else :; fi'
+
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
     'DF vs DF/DF case setup.' \
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -32,7 +32,6 @@ read_tree_twoway () {
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 compare_change () {
-    	cat current
 	sed -n >current \
 	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
 	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
@@ -60,11 +59,22 @@ check_stages () {
     diff -u expected_stages current_stages
 }
 
+cat >bozbar-old <<\EOF
+This is a sample file used in two-way fast forward merge
+tests.  Its second line ends with a magic word bozbar
+which will be modified by the merged head to gnusto.
+It has some extra lines so that external tools can
+successfully merge independent changes made to later
+lines (such as this one), avoiding line conflicts.
+EOF
+
+sed -e 's/bozbar/gnusto (earlier bozbar)/' bozbar-old >bozbar-new
+
 test_expect_success \
     setup \
     'echo frotz >frotz &&
      echo nitfol >nitfol &&
-     echo bozbar >bozbar &&
+     cat bozbar-old >bozbar &&
      echo rezrov >rezrov &&
      echo yomin >yomin &&
      git-update-cache --add nitfol bozbar rezrov &&
@@ -72,7 +82,7 @@ test_expect_success \
      echo treeH $treeH &&
      git-ls-tree $treeH &&
 
-     echo gnusto >bozbar &&
+     cat bozbar-new >bozbar &&
      git-update-cache --add frotz bozbar --force-remove rezrov &&
      git-ls-files --stage >M.out &&
      treeM=`git-write-tree` &&
@@ -106,6 +116,8 @@ echo '+100644 X 0	yomin' >expected
 test_expect_success \
     '4 - carry forward local addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      git-update-cache --add yomin &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >4.out || exit
@@ -118,6 +130,8 @@ test_expect_success \
 test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo yomin >yomin &&
      git-update-cache --add yomin &&
      echo yomin yomin >yomin &&
@@ -132,6 +146,8 @@ test_expect_success \
 test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      git-update-cache --add frotz &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >6.out &&
@@ -143,6 +159,8 @@ test_expect_success \
 test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo frotz >frotz &&
      git-update-cache --add frotz &&
      echo frotz frotz >frotz &&
@@ -154,6 +172,8 @@ test_expect_success \
 test_expect_success \
     '8 - conflicting addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo frotz frotz >frotz &&
      git-update-cache --add frotz &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
@@ -161,6 +181,8 @@ test_expect_success \
 test_expect_success \
     '9 - conflicting addition.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo frotz frotz >frotz &&
      git-update-cache --add frotz &&
      echo frotz >frotz &&
@@ -169,6 +191,8 @@ test_expect_success \
 test_expect_success \
     '10 - path removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov >rezrov &&
      git-update-cache --add rezrov &&
      read_tree_twoway $treeH $treeM &&
@@ -178,6 +202,8 @@ test_expect_success \
 test_expect_success \
     '11 - dirty path removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov >rezrov &&
      git-update-cache --add rezrov &&
      echo rezrov rezrov >rezrov &&
@@ -186,6 +212,8 @@ test_expect_success \
 test_expect_success \
     '12 - unmatching local changes being removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git-update-cache --add rezrov &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
@@ -193,6 +221,8 @@ test_expect_success \
 test_expect_success \
     '13 - unmatching local changes being removed.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo rezrov rezrov >rezrov &&
      git-update-cache --add rezrov &&
      echo rezrov >rezrov &&
@@ -206,6 +236,8 @@ EOF
 test_expect_success \
     '14 - unchanged in two heads.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      read_tree_twoway $treeH $treeM &&
@@ -217,6 +249,8 @@ test_expect_success \
 test_expect_success \
     '15 - unchanged in two heads.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo nitfol nitfol >nitfol &&
      git-update-cache --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
@@ -233,6 +267,8 @@ test_expect_success \
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
      git-read-tree --emu23 $treeH $treeM &&
@@ -249,6 +285,8 @@ EOF
 test_expect_success \
     '17 - conflicting local change.' \
     'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
      echo bozbar bozbar bozbar >bozbar &&
@@ -257,7 +295,9 @@ test_expect_success \
 test_expect_success \
     '18 - local change already having a good result.' \
     'rm -f .git/index &&
-     echo gnusto >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-new >bozbar &&
      git-update-cache --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >18.out &&
@@ -267,7 +307,9 @@ test_expect_success \
 test_expect_success \
     '19 - local change already having a good result, further modified.' \
     'rm -f .git/index &&
-     echo gnusto >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-new >bozbar &&
      git-update-cache --add bozbar &&
      echo gnusto gnusto >bozbar &&
      read_tree_twoway $treeH $treeM &&
@@ -278,7 +320,9 @@ test_expect_success \
 test_expect_success \
     '20 - no local change, use new tree.' \
     'rm -f .git/index &&
-     echo bozbar >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-old >bozbar &&
      git-update-cache --add bozbar &&
      read_tree_twoway $treeH $treeM &&
      git-ls-files --stage >20.out &&
@@ -288,11 +332,31 @@ test_expect_success \
 test_expect_success \
     '21 - no local change, dirty cache.' \
     'rm -f .git/index &&
-     echo bozbar >bozbar &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     cat bozbar-old >bozbar &&
      git-update-cache --add bozbar &&
      echo gnusto gnusto >bozbar &&
      if read_tree_twoway $treeH $treeM; then false; else :; fi'
 
+echo '-100644 X 0	bozbar
++100644 X 0	bozbar' >expected
+
+# This fails with straight two-way fast forward, but emu23
+# can merge them.
+test_expect_success \
+    '22 - local change cache updated.' \
+    'rm -f .git/index &&
+     git-read-tree $treeH &&
+     git-checkout-cache -u -f -q -a &&
+     sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
+     git-update-cache --add bozbar &&
+     read_tree_twoway $treeH $treeM &&
+     git-ls-files --stage >22.out || exit
+     diff -u M.out 22.out >22diff.out
+     compare_change 22diff.out &&
+     check_cache_at bozbar clean'
+
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
     'DF vs DF/DF case setup.' \
@@ -324,4 +388,20 @@ test_expect_success \
      check_cache_at DF/DF clean && # different from pure 2-way
      :'
 
+# Emu23 can grok I having more than H.  Make sure we did not
+# botch the conflict tests (Linus code botches this test).
+test_expect_success \
+    'DF vs DF/DF case test (#2).' \
+    'rm -f .git/index &&
+     rm -fr DF &&
+     mkdir DF &&
+     echo DF/DF >DF/DF &&
+     git-update-cache --add DF/DF &&
+     # This should fail because I and H have a conflict
+     # at DF.
+     if git-read-tree --emu23 $treeDF $treeDFDF
+     then true  ;# should be false
+     else false ;# should be true
+     fi'
+
 test_done
------------

