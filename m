From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/2] Remove emu23, fix entry order
Date: Fri, 2 Sep 2005 02:05:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509020202030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 08:03:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB4dI-0003AQ-Ey
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 08:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVIBGB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 02:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVIBGB5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 02:01:57 -0400
Received: from iabervon.org ([66.92.72.58]:59921 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030243AbVIBGB4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 02:01:56 -0400
Received: (qmail 22745 invoked by uid 1000); 2 Sep 2005 02:05:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Sep 2005 02:05:43 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8006>

A few things to improve testing. I'll clean up the series as a whole once 
it's tested.

This removes the emu23 tests; I think that the only DF conflict tests were 
in that set, however, so these should be fished out and added to something 
else.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 read-tree.c                       |   89 +++-----
 t/t1005-read-tree-m-2way-emu23.sh |  422 -------------------------------------
 2 files changed, 37 insertions(+), 474 deletions(-)
 delete mode 100755 t/t1005-read-tree-m-2way-emu23.sh

63092a4dfb2042e8fc21260b2f315b01e9163940
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -9,7 +9,6 @@
 #include "tree.h"
 
 static int merge = 0;
-static int emu23 = 0;
 static int update = 0;
 
 static struct object_list *trees = NULL;
@@ -19,19 +18,39 @@ typedef int (*merge_fn_t)(struct cache_e
 			  int df_conflicts_2,
 			  int df_conflicts_3);
 
+static int entcmp(char *name1, int dir1, char *name2, int dir2)
+{
+	int len1 = strlen(name1);
+	int len2 = strlen(name2);
+	int len = len1 < len2 ? len1 : len2;
+	int ret = memcmp(name1, name2, len);
+	unsigned char c1, c2;
+	if (ret)
+		return ret;
+	c1 = name1[len];
+	c2 = name2[len];
+	if (!c1 && dir1)
+		c1 = '/';
+	if (!c2 && dir2)
+		c2 = '/';
+	ret = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
+	if (c1 && c2 && !ret)
+		ret = len1 - len2;
+	return ret;
+}
+
 static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 			    const char *base, merge_fn_t fn, 
 			    int file2, int file3, int *indpos)
 {
 	int baselen = strlen(base);
 	int src_size = len + 1;
-	if (emu23)
-		src_size++;
 	if (src_size > 4)
 		src_size = 4;
 	do {
 		int i;
 		char *first = NULL;
+		int firstdir = 0;
 		int pathlen;
 		unsigned ce_size;
 		int dir2 = 0;
@@ -73,11 +92,23 @@ static int unpack_trees_rec(struct tree_
 			}
 		}
 
+		/*
+		if (first)
+			printf("%s\n", first);
+		*/
+
 		for (i = 0; i < len; i++) {
 			if (!posns[i])
 				continue;
-			if (!first || strcmp(first, posns[i]->name) > 0)
+			/*
+			printf("%d %s\n", i + 1, posns[i]->name);
+			*/
+			if (!first || entcmp(first, firstdir,
+					     posns[i]->name, 
+					     posns[i]->directory) > 0) {
 				first = posns[i]->name;
+				firstdir = posns[i]->directory;
+			}
 		}
 		/* No name means we're done */
 		if (!first)
@@ -94,19 +125,6 @@ static int unpack_trees_rec(struct tree_
 			       src_size);
 			src[0] = active_cache[*indpos];
 			remove_cache_entry_at(*indpos);
-			if (emu23) {
-				// we need this in stage 2 as well as stage 0
-				struct cache_entry *copy =
-					xmalloc(ce_size);
-				memcpy(copy, src[0], ce_size);
-				copy->ce_flags = 
-					create_ce_flags(baselen + pathlen, 2);
-				if (dir2 || file2) {
-					die("cannot merge index and our head tree");
-				}
-				src[2] = copy;
-				subfile2 = 1;
-			}
 		}
 
 		for (i = 0; i < len; i++) {
@@ -125,8 +143,6 @@ static int unpack_trees_rec(struct tree_
 			} else {
 				ce_stage = i + merge;
 			}
-			if (emu23 && ce_stage == 2)
-				ce_stage = 3;
 
 			if (posns[i]->directory) {
 				if (!subposns) {
@@ -137,8 +153,6 @@ static int unpack_trees_rec(struct tree_
 				parse_tree(posns[i]->item.tree);
 				subposns[i] = posns[i]->item.tree->entries;
 				posns[i] = posns[i]->next;
-				if (emu23 && ce_stage == 1)
-					dir2 = 1;
 				if (ce_stage == 2)
 					dir2 = 1;
 				if (ce_stage == 3)
@@ -168,19 +182,6 @@ static int unpack_trees_rec(struct tree_
 			}
 
 			memcpy(ce->sha1, posns[i]->item.any->sha1, 20);
-			if (ce_stage == 1 && emu23 && !src[2]) {
-				// we need this in stage 2 as well as stage 1
-				struct cache_entry *copy =
-					xmalloc(ce_size);
-				memcpy(copy, ce, ce_size);
-				copy->ce_flags = 
-					create_ce_flags(baselen + pathlen, 2);
-				if (dir2 || file2) {
-					die("cannot merge index and our head tree");
-				}
-				src[2] = copy;
-				subfile2 = 1;
-			}
 			src[ce_stage] = ce;
 			posns[i] = posns[i]->next;
 		}
@@ -601,7 +602,6 @@ int main(int argc, char **argv)
 
 	merge = 0;
 	reset = 0;
-	emu23 = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -613,7 +613,7 @@ int main(int argc, char **argv)
 
 		/* This differs from "-m" in that we'll silently ignore unmerged entries */
 		if (!strcmp(arg, "--reset")) {
-			if (stage || merge || emu23)
+			if (stage || merge)
 				usage(read_tree_usage);
 			reset = 1;
 			merge = 1;
@@ -624,7 +624,7 @@ int main(int argc, char **argv)
 
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
-			if (stage || merge || emu23)
+			if (stage || merge)
 				usage(read_tree_usage);
 			if (read_cache_unmerged())
 				die("you need to resolve your current index first");
@@ -633,16 +633,6 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		/* "-emu23" uses 3-way merge logic to perform fast-forward */
-		if (!strcmp(arg, "--emu23")) {
-			if (stage || merge || emu23)
-				usage(read_tree_usage);
-			if (read_cache_unmerged())
-				die("you need to resolve your current index first");
-			merge = emu23 = stage = 1;
-			continue;
-		}
-
 		if (get_sha1(arg, sha1) < 0)
 			usage(read_tree_usage);
 		if (list_tree(sha1) < 0)
@@ -660,12 +650,7 @@ int main(int argc, char **argv)
 
 		if (stage < 2)
 			die("just how do you expect me to merge %d trees?", stage-1);
-		if (emu23 && stage != 3)
-			die("--emu23 takes only two trees");
 		fn = merge_function[stage-1];
-		if (stage == 3 && emu23) { 
-			fn = merge_function[3];
-		}
 	}
 	unpack_trees(fn);
 	if (write_cache(newfd, active_cache, active_nr) ||
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
deleted file mode 100755
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ /dev/null
@@ -1,422 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-
-test_description='Two way merge with read-tree --emu23 $H $M
-
-This test tries two-way merge (aka fast forward with carry forward).
-
-There is the head (called H) and another commit (called M), which is
-simply ahead of H.  The index and the work tree contains a state that
-is derived from H, but may also have local changes.  This test checks
-all the combinations described in the two-tree merge "carry forward"
-rules, found in <Documentation/git-rev-tree.txt>.
-
-In the test, these paths are used:
-        bozbar  - in H, stays in M, modified from bozbar to gnusto
-        frotz   - not in H added in M
-        nitfol  - in H, stays in M unmodified
-        rezrov  - in H, deleted in M
-        yomin   - not in H nor M
-'
-. ./test-lib.sh
-
-read_tree_twoway () {
-    git-read-tree --emu23 "$1" "$2" &&
-    git-ls-files --stage &&
-    git-merge-cache git-merge-one-file-script -a &&
-    git-ls-files --stage
-}
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-compare_change () {
-	sed -n >current \
-	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
-	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
-	    "$1"
-	diff -u expected current
-}
-
-check_cache_at () {
-	clean_if_empty=`git-diff-files "$1"`
-	case "$clean_if_empty" in
-	'')  echo "$1: clean" ;;
-	?*)  echo "$1: dirty" ;;
-	esac
-	case "$2,$clean_if_empty" in
-	clean,)		:     ;;
-	clean,?*)	false ;;
-	dirty,)		false ;;
-	dirty,?*)	:     ;;
-	esac
-}
-
-check_stages () {
-    cat >expected_stages
-    git-ls-files --stage | sed -e "s/ $_x40 / X /" >current_stages
-    diff -u expected_stages current_stages
-}
-
-cat >bozbar-old <<\EOF
-This is a sample file used in two-way fast forward merge
-tests.  Its second line ends with a magic word bozbar
-which will be modified by the merged head to gnusto.
-It has some extra lines so that external tools can
-successfully merge independent changes made to later
-lines (such as this one), avoiding line conflicts.
-EOF
-
-sed -e 's/bozbar/gnusto (earlier bozbar)/' bozbar-old >bozbar-new
-
-test_expect_success \
-    setup \
-    'echo frotz >frotz &&
-     echo nitfol >nitfol &&
-     cat bozbar-old >bozbar &&
-     echo rezrov >rezrov &&
-     echo yomin >yomin &&
-     git-update-cache --add nitfol bozbar rezrov &&
-     treeH=`git-write-tree` &&
-     echo treeH $treeH &&
-     git-ls-tree $treeH &&
-
-     cat bozbar-new >bozbar &&
-     git-update-cache --add frotz bozbar --force-remove rezrov &&
-     git-ls-files --stage >M.out &&
-     treeM=`git-write-tree` &&
-     echo treeM $treeM &&
-     git-ls-tree $treeM &&
-     git-diff-tree $treeH $treeM'
-
-# "read-tree -m H I+H M" but I is empty so this is "read-tree -m H H M".
-#
-# bozbar [O && A && B && O==A && O!=B (#14) ==> B] take M by read-tree
-# frotz  [!O && !A && B (#2) ==> B]                take M by read-tree
-# nitfol [O && A && B && O==A && O==B (#15) ==> B] take M by read-tree
-# rezrov [O && A && !B && O==A (#10) ==> no merge] removed by script
-#
-# Earlier one did not have #2ALT so taking M was done by the script,
-# which also updated the work tree and making frotz clean.  With #2ALT,
-# this is resolved by read-tree itself and the path is left dirty
-# because we are not testing "read-tree -u --emu23".
-test_expect_success \
-    '1, 2, 3 - no carry forward' \
-    'rm -f .git/index &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >1-3.out &&
-     diff -u M.out 1-3.out &&
-     check_cache_at bozbar dirty &&
-     check_cache_at frotz dirty && # same as pure 2-way again.
-     check_cache_at nitfol dirty'
-
-echo '+100644 X 0	yomin' >expected
-
-test_expect_success \
-    '4 - carry forward local addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     git-update-cache --add yomin &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >4.out || return 1
-     diff -u M.out 4.out >4diff.out
-     compare_change 4diff.out expected &&
-     check_cache_at yomin clean'
-
-# "read-tree -m H I+H M" where !H && !M; so (I+H) not being up-to-date
-# should not matter.  Thanks to #3ALT, this is now possible.
-test_expect_success \
-    '5 - carry forward local addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo yomin >yomin &&
-     git-update-cache --add yomin &&
-     echo yomin yomin >yomin &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >5.out || return 1
-     diff -u M.out 5.out >5diff.out
-     compare_change 5diff.out expected &&
-     check_cache_at yomin dirty'
-
-# "read-tree -m H I+H M" where !H && M && (I+H) == M, so this should
-# succeed (even the entry is clean), now thanks to #5ALT.
-test_expect_success \
-    '6 - local addition already has the same.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     git-update-cache --add frotz &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >6.out &&
-     diff -u M.out 6.out &&
-     check_cache_at frotz clean'
-
-# Exactly the same pattern as above but with dirty cache.  This also
-# should succeed, now thanks to #5ALT.
-test_expect_success \
-    '7 - local addition already has the same.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo frotz >frotz &&
-     git-update-cache --add frotz &&
-     echo frotz frotz >frotz &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >7.out &&
-     diff -u M.out 7.out &&
-     check_cache_at frotz dirty'
-
-test_expect_success \
-    '8 - conflicting addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo frotz frotz >frotz &&
-     git-update-cache --add frotz &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '9 - conflicting addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo frotz frotz >frotz &&
-     git-update-cache --add frotz &&
-     echo frotz >frotz &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '10 - path removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >10.out &&
-     diff -u M.out 10.out'
-
-test_expect_success \
-    '11 - dirty path removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     echo rezrov rezrov >rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '12 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '13 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     echo rezrov >rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-cat >expected <<EOF
--100644 X 0	nitfol
-+100644 X 0	nitfol
-EOF
-
-test_expect_success \
-    '14 - unchanged in two heads.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo nitfol nitfol >nitfol &&
-     git-update-cache --add nitfol &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >14.out || return 1
-     diff -u M.out 14.out >14diff.out
-     compare_change 14diff.out expected &&
-     check_cache_at nitfol clean'
-
-test_expect_success \
-    '15 - unchanged in two heads.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo nitfol nitfol >nitfol &&
-     git-update-cache --add nitfol &&
-     echo nitfol nitfol nitfol >nitfol &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >15.out || return 1
-     diff -u M.out 15.out >15diff.out
-     compare_change 15diff.out expected &&
-     check_cache_at nitfol dirty'
-
-# This is different from straight 2-way merge in that it leaves
-# three stages of bozbar in the index file without failing, so
-# the user can run git-diff-stages to examine the situation.
-# With #2ALT, frotz is resolved internally.
-test_expect_success \
-    '16 - conflicting local change.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo bozbar bozbar >bozbar &&
-     git-update-cache --add bozbar &&
-     git-read-tree --emu23 $treeH $treeM &&
-     check_stages' <<\EOF
-100644 X 1	bozbar
-100644 X 2	bozbar
-100644 X 3	bozbar
-100644 X 0	frotz
-100644 X 0	nitfol
-100644 X 1	rezrov
-100644 X 2	rezrov
-EOF
-
-test_expect_success \
-    '17 - conflicting local change.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo bozbar bozbar >bozbar &&
-     git-update-cache --add bozbar &&
-     echo bozbar bozbar bozbar >bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '18 - local change already having a good result.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-new >bozbar &&
-     git-update-cache --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >18.out &&
-     diff -u M.out 18.out &&
-     check_cache_at bozbar clean'
-
-test_expect_success \
-    '19 - local change already having a good result, further modified.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-new >bozbar &&
-     git-update-cache --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >19.out &&
-     diff -u M.out 19.out &&
-     check_cache_at bozbar dirty'
-
-test_expect_success \
-    '20 - no local change, use new tree.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-old >bozbar &&
-     git-update-cache --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >20.out &&
-     diff -u M.out 20.out &&
-     check_cache_at bozbar dirty'
-
-test_expect_success \
-    '21 - no local change, dirty cache.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-old >bozbar &&
-     git-update-cache --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-echo '-100644 X 0	bozbar
-+100644 X 0	bozbar' >expected
-
-# This fails with straight two-way fast forward, but emu23
-# can merge them.
-test_expect_success \
-    '22 - local change cache updated.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
-     git-update-cache --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >22.out || return 1
-     diff -u M.out 22.out >22diff.out
-     compare_change 22diff.out &&
-     check_cache_at bozbar clean'
-
-# Also make sure we did not break DF vs DF/DF case.
-test_expect_success \
-    'DF vs DF/DF case setup.' \
-    'rm -f .git/index &&
-     echo DF >DF &&
-     git-update-cache --add DF &&
-     treeDF=`git-write-tree` &&
-     echo treeDF $treeDF &&
-     git-ls-tree $treeDF &&
-     git-ls-files --stage >DF.out
-
-     rm -f DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git-update-cache --add --remove DF DF/DF &&
-     treeDFDF=`git-write-tree` &&
-     echo treeDFDF $treeDFDF &&
-     git-ls-tree $treeDFDF &&
-     git-ls-files --stage >DFDF.out'
-
-test_expect_success \
-    'DF vs DF/DF case test (#1)' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     echo DF >DF &&
-     git-update-cache --add DF &&
-     read_tree_twoway $treeDF $treeDFDF &&
-     git-ls-files --stage >DFDFcheck.out &&
-     diff -u DFDF.out DFDFcheck.out &&
-     check_cache_at DF/DF clean && # different from pure 2-way
-     :'
-
-# The other way around
-test_expect_success \
-    'DF vs DF/DF case test (#2)' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git-update-cache --add DF/DF &&
-     read_tree_twoway $treeDFDF $treeDF &&
-     git-ls-files --stage >DFDFcheck.out &&
-     diff -u DF.out DFDFcheck.out &&
-     check_cache_at DF clean && # different from pure 2-way
-     :'
-
-# Emu23 can grok I having more than H.  Make sure we did not
-# botch the conflict tests (fixed).
-test_expect_success \
-    'DF vs DF/DF case test (#3).' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git-update-cache --add DF/DF &&
-     # This should fail because I and H have a conflict
-     # at DF.
-     if git-read-tree --emu23 $treeDF $treeDFDF
-     then false
-     else true
-     fi'
-
-test_done
