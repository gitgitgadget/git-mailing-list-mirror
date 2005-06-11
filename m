From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] read-tree --emu23.
Date: Fri, 10 Jun 2005 18:36:08 -0700
Message-ID: <7v7jh17jzr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:32:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dguqz-00042x-F3
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFKBgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVFKBgZ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:36:25 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46549 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261504AbVFKBgK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 21:36:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611013610.FHLK550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 21:36:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This new flag causes two-way fast forward to internally use the
three-way merge mechanism.  This behaviour is intended to offer
a better fast forward semantics when used in a dirty work tree.

The new test t1005 is parallel to the existing t1001 "pure
2-way" tests, but some parts that are commented out would fail.
These failures are due to three-way merge enforcing too strict
index requirements for cases that could succeed.  This problem
will be addressed by later patches.

Without even changing three-way mechanism, the --emu23 two-way
fast forward already gives the user an easier-to-handle merge
result when a file that "merged head" updates has local
modifications.  This is demonstrated as "case 16" test in t1005.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 read-tree.c                       |   81 +++++++++++++++++++++++++++++++++++--
 t/t1001-read-tree-m-2way.sh       |   44 ++++++++++++++++----
 2 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -210,6 +210,58 @@ static int twoway_merge(struct cache_ent
 }
 
 /*
+ * Two-way merge emulated with three-way merge.
+ *
+ * This treats "read-tree -m H M" by transforming it internally
+ * into "read-tree -m H I+H M", where I+H is a tree that would
+ * contain the contents of the current index file, overlayed on
+ * top of H.  Unlike the traditional two-way merge, this leaves
+ * the stages in the resulting index file and lets the user resolve
+ * the merge conflicts using standard tools for three-way merge.
+ *
+ * This function is just to set-up such an arrangement, and the
+ * actual merge uses threeway_merge() function.
+ */
+static void setup_emu23(void)
+{
+	/* stage0 contains I, stage1 H, stage2 M.
+	 * move stage2 to stage3, and create stage2 entries
+	 * by scanning stage0 and stage1 entries.
+	 */
+	int i, namelen, size;
+	struct cache_entry *ce, *stage2;
+
+	for (i = 0; i < active_nr; i++) {
+		ce = active_cache[i];
+		if (ce_stage(ce) != 2)
+			continue;
+		/* hoist them up to stage 3 */
+		namelen = ce_namelen(ce);
+		ce->ce_flags = create_ce_flags(namelen, 3);
+	}
+
+	for (i = 0; i < active_nr; i++) {
+		ce = active_cache[i];
+		if (ce_stage(ce) > 1)
+			continue;
+		namelen = ce_namelen(ce);
+		size = cache_entry_size(namelen);
+		stage2 = xmalloc(size);
+		memcpy(stage2, ce, size);
+		stage2->ce_flags = create_ce_flags(namelen, 2);
+		if (add_cache_entry(stage2, ADD_CACHE_OK_TO_ADD) < 0)
+			die("cannot merge index and our head tree");
+
+		/* We are done with this name, so skip to next name */
+		while (i < active_nr &&
+		       ce_namelen(active_cache[i]) == namelen &&
+		       !memcmp(active_cache[i]->name, ce->name, namelen))
+			i++;
+		i--; /* compensate for the loop control */
+	}
+}
+
+/*
  * One-way merge.
  *
  * The rule is:
@@ -315,7 +367,7 @@ static struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
-	int i, newfd, merge, reset;
+	int i, newfd, merge, reset, emu23;
 	unsigned char sha1[20];
 
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
@@ -324,6 +376,7 @@ int main(int argc, char **argv)
 
 	merge = 0;
 	reset = 0;
+	emu23 = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -335,7 +388,7 @@ int main(int argc, char **argv)
 
 		/* This differs from "-m" in that we'll silently ignore unmerged entries */
 		if (!strcmp(arg, "--reset")) {
-			if (stage || merge)
+			if (stage || merge || emu23)
 				usage(read_tree_usage);
 			reset = 1;
 			merge = 1;
@@ -345,7 +398,7 @@ int main(int argc, char **argv)
 
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
-			if (stage || merge)
+			if (stage || merge || emu23)
 				usage(read_tree_usage);
 			if (read_cache_unmerged())
 				die("you need to resolve your current index first");
@@ -353,6 +406,17 @@ int main(int argc, char **argv)
 			merge = 1;
 			continue;
 		}
+
+		/* "-emu23" uses 3-way merge logic to perform fast-forward */
+		if (!strcmp(arg, "--emu23")) {
+			if (stage || merge || emu23)
+				usage(read_tree_usage);
+			if (read_cache_unmerged())
+				die("you need to resolve your current index first");
+			merge = emu23 = stage = 1;
+			continue;
+		}
+
 		if (get_sha1(arg, sha1) < 0)
 			usage(read_tree_usage);
 		if (stage > 3)
@@ -369,9 +433,18 @@ int main(int argc, char **argv)
 			[2] = twoway_merge,
 			[3] = threeway_merge,
 		};
+		merge_fn_t fn;
+
 		if (stage < 2 || stage > 4)
 			die("just how do you expect me to merge %d trees?", stage-1);
-		merge_cache(active_cache, active_nr, merge_function[stage-1]);
+		if (emu23 && stage != 3)
+			die("--emu23 takes only two trees");
+		fn = merge_function[stage-1];
+		if (stage == 3 && emu23) { 
+			setup_emu23();
+			fn = merge_function[3];
+		}
+		merge_cache(active_cache, active_nr, fn);
 	}
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_index_file(&cache_file))
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1005-read-tree-m-2way-emu23.sh
similarity index 86%
copy from t/t1001-read-tree-m-2way.sh
copy to t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-test_description='Two way merge with read-tree -m $H $M
+test_description='Two way merge with read-tree --emu23 $H $M
 
 This test tries two-way merge (aka fast forward with carry forward).
 
@@ -23,7 +23,10 @@ In the test, these paths are used:
 . ./test-lib.sh
 
 read_tree_twoway () {
-    git-read-tree -m "$1" "$2" && git-ls-files --stage
+    git-read-tree --emu23 "$1" "$2" &&
+    git-ls-files --stage &&
+    git-merge-cache git-merge-one-file-script -a &&
+    git-ls-files --stage
 }
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
@@ -51,6 +54,12 @@ check_cache_at () {
 	esac
 }
 
+check_stages () {
+    cat >expected_stages
+    git-ls-files --stage | sed -e "s/ $_x40 / X /" >current_stages
+    diff -u expected_stages current_stages
+}
+
 test_expect_success \
     setup \
     'echo frotz >frotz &&
@@ -78,7 +87,7 @@ test_expect_success \
      git-ls-files --stage >1-3.out &&
      diff -u M.out 1-3.out &&
      check_cache_at bozbar dirty &&
-     check_cache_at frotz dirty &&
+     check_cache_at frotz clean && # different from pure 2-way
      check_cache_at nitfol dirty'
 
 echo '+100644 X 0	yomin' >expected
@@ -93,7 +102,9 @@ test_expect_success \
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
 
-test_expect_success \
+# "read-tree -m H I+H M" where !H && !M; so (I+H) not being up-to-date
+# should not matter, but without #3ALT this does not work.
+: test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
      echo yomin >yomin &&
@@ -105,7 +116,10 @@ test_expect_success \
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
 
-test_expect_success \
+# "read-tree -m H I+H M" where !H && M && (I+H) == M, so this should
+# succeed (even the entry is clean), but without #5ALT this does not
+# work.
+: test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
      git-update-cache --add frotz &&
@@ -114,7 +128,9 @@ test_expect_success \
      diff -u M.out 6.out &&
      check_cache_at frotz clean'
 
-test_expect_success \
+# Exactly the same pattern as above but with dirty cache.  This also
+# should succeed, but without #5ALT it does not.
+: test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
      echo frotz >frotz &&
@@ -200,12 +216,24 @@ test_expect_success \
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
 
+# This is different from straight 2-way merge in that it leaves
+# three stages of bozbar in the index file without failing, so
+# the user can run git-diff-stages to examine the situation.
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
      echo bozbar bozbar >bozbar &&
      git-update-cache --add bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
+     git-read-tree --emu23 $treeH $treeM &&
+     check_stages' <<\EOF
+100644 X 1	bozbar
+100644 X 2	bozbar
+100644 X 3	bozbar
+100644 X 3	frotz
+100644 X 0	nitfol
+100644 X 1	rezrov
+100644 X 2	rezrov
+EOF
 
 test_expect_success \
     '17 - conflicting local change.' \
@@ -282,7 +310,7 @@ test_expect_success \
      read_tree_twoway $treeDF $treeDFDF &&
      git-ls-files --stage >DFDFcheck.out &&
      diff -u DFDF.out DFDFcheck.out &&
-     check_cache_at DF/DF dirty &&
+     check_cache_at DF/DF clean && # different from pure 2-way
      :'
 
 test_done
------------

