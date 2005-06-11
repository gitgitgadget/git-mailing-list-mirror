From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/3] Finish making --emu23 equivalent to pure 2-way merge.
Date: Sat, 11 Jun 2005 02:50:51 -0700
Message-ID: <7voeadxlvo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 11:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh2Zw-00018E-BP
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 11:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVFKJvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 05:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFKJvT
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 05:51:19 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:10675 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261661AbVFKJux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 05:50:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611095052.JKPX8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Jun 2005 05:50:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds #3ALT rule (and #2ALT rule for symmetry) to the
read-tree 3-way merge logic that collapses paths that are added
only in one branch and not in the other internally.

This makes --emu23 to succeed in the last remaining case where
the pure 2-way merge succeeded and earlier one failed.  Running
diff between t1001 and t1005 test scripts shows that the only
difference between the two is that --emu23 can leave the states
into separate stages so that the user can use usual 3-way merge
resolution techniques to carry forward the local changes when
pure 2-way merge would have refused to run.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This is leftover bits from the earlier 3-piece series.

 read-tree.c                       |  137 ++++++++++++++++++++++++++++++++++++-
 t/t1000-read-tree-m-3way.sh       |   32 +++++----
 t/t1005-read-tree-m-2way-emu23.sh |   20 ++++-
 3 files changed, 168 insertions(+), 21 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -143,7 +143,72 @@ static int deleted_entry(struct cache_en
 	return 1;
 }
 
-static int threeway_merge(struct cache_entry *stages[4], struct cache_entry **dst)
+static int causes_df_conflict(struct cache_entry *ce, int stage,
+			      struct cache_entry **dst_,
+			      struct cache_entry **next_,
+			      int tail)
+{
+	/* This is called during the merge operation and walking
+	 * the active_cache[] array is messy, because it is in the
+	 * middle of overlapping copy operation.  The invariants
+	 * are:
+	 * (1) active_cache points at the first (zeroth) entry.
+	 * (2) up to dst pointer are resolved entries.
+	 * (3) from the next pointer (head-inclusive) to the tail
+	 *     of the active_cache array have the remaining paths
+	 *     to be processed.  There can be a gap between dst
+	 *     and next.  Note that next is called "src" in the
+	 *     merge_cache() function, and tail is the original
+	 *     end of active_cache array when merge_cache() started.
+	 * (4) the path corresponding to *ce is not found in (2)
+	 *     or (3).  It is in the gap.
+	 *
+	 *  active_cache -----......+++++++++++++.
+	 *                    ^dst  ^next        ^tail
+	 */
+	int i, next, dst;
+	const char *path = ce->name;
+	int namelen = ce_namelen(ce);
+
+	next = next_ - active_cache;
+	dst = dst_ - active_cache;
+
+	for (i = 0; i < tail; i++) {
+		int entlen, len;
+		const char *one, *two;
+		if (dst <= i && i < next)
+			continue;
+		ce = active_cache[i];
+		if (ce_stage(ce) != stage)
+			continue;
+		/* If ce->name is a prefix of path, then path is a file
+		 * that hangs underneath ce->name, which is bad.
+		 * If path is a prefix of ce->name, then it is the
+		 * other way around which also is bad.
+		 */
+		entlen = ce_namelen(ce);
+		if (namelen == entlen)
+			continue;
+		if (namelen < entlen) {
+			len = namelen;
+			one = path;
+			two = ce->name;
+		} else {
+			len = entlen;
+			one = ce->name;
+			two = path;
+		}
+		if (memcmp(one, two, len))
+			continue;
+		if (two[len] == '/')
+			return 1;
+	}
+	return 0;
+}
+
+static int threeway_merge(struct cache_entry *stages[4],
+			  struct cache_entry **dst,
+			  struct cache_entry **next, int tail)
 {
 	struct cache_entry *old = stages[0];
 	struct cache_entry *a = stages[1], *b = stages[2], *c = stages[3];
@@ -156,6 +221,65 @@ static int threeway_merge(struct cache_e
 			return -1;
 		return merged_entry_allow_dirty(b, old, dst);
 	}
+	/* #2ALT and #3ALT */
+	if (!a && (!!b != !!c)) {
+		/*
+		 * The reason we need to worry about directory/file
+		 * conflicts only in #2ALT and #3ALT case is this:
+		 *
+		 * (1) For all other cases that read-tree internally
+		 *     resolves a path, we always have such a path in
+		 *     *both* stage2 and stage3 when we begin.
+		 *     Traditionally, the behaviour has been even
+		 *     stricter and we did not resolve a path without
+		 *     initially being in all of stage1, 2, and 3.
+		 *
+		 * (2) When read-tree finishes, all resolved paths (i.e.
+		 *     the paths that are in stage0) must have come from
+		 *     either stage2 or stage3.  It is not possible to
+		 *     have a stage0 path as a result of a merge if
+		 *     neither stage2 nor stage3 had that path.
+		 *
+		 * (3) It is guaranteed that just after reading the
+		 *     stages, each stage cannot have directory/file
+		 *     conflicts on its own, because they are populated
+		 *     by reading hierarchy of a tree.  Combined with
+		 *     (1) and (2) above, this means that no matter what
+		 *     combination of paths we take from stage2 and
+		 *     stage3 as a result of a merge, they cannot cause
+		 *     a directory/file conflict situation (otherwise
+		 *     the "guilty" path would have already had such a
+		 *     conflict in the original stage, either stage2
+		 *     or stage3).  Although its stage2 is synthesized
+		 *     by overlaying the current index on top of "our
+		 *     head" tree, --emu23 case also has this guarantee,
+		 *     by calling add_cache_entry() to create such stage2
+		 *     entries.
+		 *
+		 * (4) Only #2ALT and #3ALT lack the guarantee (1).
+		 *     They resolve paths that exist only in stage2
+		 *     or stage3.  The stage2 tree may have a file DF
+		 *     while stage3 tree may have a file DF/DF.  If
+		 *     #2ALT and #3ALT rules happen to apply to both
+		 *     of them, we would end up having DF (coming from
+		 *     stage2) and DF/DF (from stage3) in the result.
+		 *     When we attempt to resolve a path that exists
+		 *     only in stage2, we need to make sure there is
+		 *     no path that would conflict with it in stage3
+		 *     and vice versa.
+		 */
+		if (c) { /* #2ALT */
+			if (!causes_df_conflict(c, 2, dst, next, tail) &&
+			    (!old || same(c, old)))
+				return merged_entry_allow_dirty(c, old, dst);
+		}
+		else { /* #3ALT */
+			if (!causes_df_conflict(b, 3, dst, next, tail) &&
+			    (!old || same(b, old)))
+				return merged_entry_allow_dirty(b, old, dst);
+		}
+		/* otherwise we will apply the original rule */
+	}
 	/*
 	 * If we have an entry in the index cache ("old"), then we want
 	 * to make sure that it matches any entries in stage 2 ("first
@@ -186,7 +310,8 @@ static int threeway_merge(struct cache_e
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
  */
-static int twoway_merge(struct cache_entry **src, struct cache_entry **dst)
+static int twoway_merge(struct cache_entry **src, struct cache_entry **dst,
+			struct cache_entry **next, int tail)
 {
 	struct cache_entry *current = src[0];
 	struct cache_entry *oldtree = src[1], *newtree = src[2];
@@ -283,7 +408,8 @@ static void setup_emu23(void)
  * The rule is:
  * - take the stat information from stage0, take the data from stage1
  */
-static int oneway_merge(struct cache_entry **src, struct cache_entry **dst)
+static int oneway_merge(struct cache_entry **src, struct cache_entry **dst,
+			struct cache_entry **next, int tail)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
@@ -324,11 +450,12 @@ static void check_updates(struct cache_e
 	}
 }
 
-typedef int (*merge_fn_t)(struct cache_entry **, struct cache_entry **);
+typedef int (*merge_fn_t)(struct cache_entry **, struct cache_entry **, struct cache_entry **, int);
 
 static void merge_cache(struct cache_entry **src, int nr, merge_fn_t fn)
 {
 	struct cache_entry **dst = src;
+	int tail = nr;
 
 	while (nr) {
 		int entries;
@@ -346,7 +473,7 @@ static void merge_cache(struct cache_ent
 				break;
 		}
 
-		entries = fn(stages, dst);
+		entries = fn(stages, dst, src, tail);
 		if (entries < 0)
 			reject_merge(name);
 		dst += entries;
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -75,13 +75,13 @@ In addition:
 . ../lib-read-tree-m-3way.sh
 
 ################################################################
-# Trivial "majority when 3 stages exist" merge plus #5ALT trivial
-# merge.
+# Trivial "majority when 3 stages exist" merge plus #2ALT, #3ALT
+# and #5ALT trivial merges.
 
 cat >expected <<\EOF
 100644 X 2	AA
 100644 X 3	AA
-100644 X 2	AN
+100644 X 0	AN
 100644 X 1	DD
 100644 X 3	DF
 100644 X 2	DF/DF
@@ -96,7 +96,7 @@ cat >expected <<\EOF
 100644 X 2	MM
 100644 X 3	MM
 100644 X 0	MN
-100644 X 3	NA
+100644 X 0	NA
 100644 X 1	ND
 100644 X 2	ND
 100644 X 0	NM
@@ -107,7 +107,7 @@ cat >expected <<\EOF
 100644 X 3	TT
 100644 X 2	Z/AA
 100644 X 3	Z/AA
-100644 X 2	Z/AN
+100644 X 0	Z/AN
 100644 X 1	Z/DD
 100644 X 1	Z/DM
 100644 X 3	Z/DM
@@ -119,7 +119,7 @@ cat >expected <<\EOF
 100644 X 2	Z/MM
 100644 X 3	Z/MM
 100644 X 0	Z/MN
-100644 X 3	Z/NA
+100644 X 0	Z/NA
 100644 X 1	Z/ND
 100644 X 2	Z/ND
 100644 X 0	Z/NM
@@ -233,23 +233,31 @@ test_expect_failure \
      git-update-cache --add XX &&
      git-read-tree -m $tree_O $tree_A $tree_B"
 
-test_expect_failure \
-    '2 - must not have an entry not in A.' \
+test_expect_success \
+    '2 - must match B in !O && !A && B case.' \
+    "rm -f .git/index NA &&
+     cp .orig-B/NA NA &&
+     git-update-cache --add NA &&
+     git-read-tree -m $tree_O $tree_A $tree_B"
+
+test_expect_success \
+    '2 - matching B alone is OK in !O && !A && B case.' \
     "rm -f .git/index NA &&
      cp .orig-B/NA NA &&
      git-update-cache --add NA &&
+     echo extra >>NA &&
      git-read-tree -m $tree_O $tree_A $tree_B"
 
 test_expect_success \
-    '3 - must match and be up-to-date in !O && A && !B case.' \
+    '3 - must match A in !O && A && !B case.' \
     "rm -f .git/index AN &&
      cp .orig-A/AN AN &&
      git-update-cache --add AN &&
      git-read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '3 (fail) - must match and be up-to-date in !O && A && !B case.' \
+test_expect_success \
+    '3 - matching A alone is OK in !O && A && !B case.' \
     "rm -f .git/index AN &&
      cp .orig-A/AN AN &&
      git-update-cache --add AN &&
@@ -257,7 +265,7 @@ test_expect_failure \
      git-read-tree -m $tree_O $tree_A $tree_B"
 
 test_expect_failure \
-    '3 (fail) - must match and be up-to-date in !O && A && !B case.' \
+    '3 (fail) - must match A in !O && A && !B case.' \
     "rm -f .git/index AN &&
      cp .orig-A/AN AN &&
      echo extra >>AN &&
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -80,6 +80,17 @@ test_expect_success \
      git-ls-tree $treeM &&
      git-diff-tree $treeH $treeM'
 
+# "read-tree -m H I+H M" but I is empty so this is "read-tree -m H H M".
+#
+# bozbar [O && A && B && O==A && O!=B (#14) ==> B] take M by read-tree
+# frotz  [!O && !A && B (#2) ==> B]                take M by read-tree
+# nitfol [O && A && B && O==A && O==B (#15) ==> B] take M by read-tree
+# rezrov [O && A && !B && O==A (#10) ==> no merge] removed by script
+#
+# Earlier one did not have #2ALT so taking M was done by the script,
+# which also updated the work tree and making frotz clean.  With #2ALT,
+# this is resolved by read-tree itself and the path is left dirty
+# because we are not testing "read-tree -u --emu23".
 test_expect_success \
     '1, 2, 3 - no carry forward' \
     'rm -f .git/index &&
@@ -87,7 +98,7 @@ test_expect_success \
      git-ls-files --stage >1-3.out &&
      diff -u M.out 1-3.out &&
      check_cache_at bozbar dirty &&
-     check_cache_at frotz clean && # different from pure 2-way
+     check_cache_at frotz dirty && # same as pure 2-way again.
      check_cache_at nitfol dirty'
 
 echo '+100644 X 0	yomin' >expected
@@ -103,8 +114,8 @@ test_expect_success \
      check_cache_at yomin clean'
 
 # "read-tree -m H I+H M" where !H && !M; so (I+H) not being up-to-date
-# should not matter, but without #3ALT this does not work.
-: test_expect_success \
+# should not matter.  Thanks to #3ALT, this is now possible.
+test_expect_success \
     '5 - carry forward local addition.' \
     'rm -f .git/index &&
      echo yomin >yomin &&
@@ -218,6 +229,7 @@ test_expect_success \
 # This is different from straight 2-way merge in that it leaves
 # three stages of bozbar in the index file without failing, so
 # the user can run git-diff-stages to examine the situation.
+# With #2ALT, frotz is resolved internally.
 test_expect_success \
     '16 - conflicting local change.' \
     'rm -f .git/index &&
@@ -228,7 +240,7 @@ test_expect_success \
 100644 X 1	bozbar
 100644 X 2	bozbar
 100644 X 3	bozbar
-100644 X 3	frotz
+100644 X 0	frotz
 100644 X 0	nitfol
 100644 X 1	rezrov
 100644 X 2	rezrov
------------

