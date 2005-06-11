From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] read-tree: fix too strong index requirement #5ALT
Date: Fri, 10 Jun 2005 18:37:47 -0700
Message-ID: <7v1x797jx0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:34:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgusg-00049f-9j
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFKBiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVFKBiK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:38:10 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7933 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261508AbVFKBht (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 21:37:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611013749.TOJP16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 21:37:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes too strong index requirement 3-way merge enforces in
one case: the same file is added in both branches.

In this case, the original code insisted that if the index file
has that path, it must match our branch and be up-to-date.
However in this particular case, it only has to match it, and
can be dirty.  We just need to make sure that we keep the
work-tree copy instead of checking out the merge result.

The resolution of such a path, however, cannot be left to
outside script, because we will not keep the original stage0
entries for unmerged paths when read-tree finishes, and at that
point, the knowledge of "if we resolve it to match the new file
added in both branches, the merge succeeds and the work tree
would not lose information, but we should _not_ update the work
tree from the resulting index file" is lost.  For this reason,
the now code needs to resolve this case (#5ALT) internally.

This affects some existing tests in the test suite, but all in
positive ways.  In t1000 (3-way test), this #5ALT case now gets
one stage0 entry, instead of an identical stage2 and stage3
entry pair, for such a path, and one test that checked for merge
failure (because the test assumed the "stricter-than-necessary"
behaviour) does not have to fail anymore.  In t1005 (emu23
test), two tests that involves a case where the work tree
already had a change introduced in the upstream (aka "merged
head"), the merge succeeds instead of failing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 read-tree.c                       |   20 ++++++++++++++++++--
 t/t1000-read-tree-m-3way.sh       |   17 +++++++++--------
 t/t1005-read-tree-m-2way-emu23.sh |    9 ++++-----
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -102,7 +102,7 @@ static void reject_merge(struct cache_en
 	die("Entry '%s' would be overwritten by merge. Cannot merge.", ce->name);
 }
 
-static int merged_entry(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst)
+static int merged_entry_internal(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst, int allow_dirty)
 {
 	merge->ce_flags |= htons(CE_UPDATE);
 	if (old) {
@@ -115,7 +115,7 @@ static int merged_entry(struct cache_ent
 		 */
 		if (same(old, merge)) {
 			*merge = *old;
-		} else {
+		} else if (!allow_dirty) {
 			verify_uptodate(old);
 		}
 	}
@@ -124,6 +124,16 @@ static int merged_entry(struct cache_ent
 	return 1;
 }
 
+static int merged_entry_allow_dirty(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst)
+{
+	return merged_entry_internal(merge, old, dst, 1);
+}
+
+static int merged_entry(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst)
+{
+	return merged_entry_internal(merge, old, dst, 0);
+}
+
 static int deleted_entry(struct cache_entry *ce, struct cache_entry *old, struct cache_entry **dst)
 {
 	if (old)
@@ -140,6 +150,12 @@ static int threeway_merge(struct cache_e
 	struct cache_entry *merge;
 	int count;
 
+	/* #5ALT */
+	if (!a && b && c && same(b, c)) {
+		if (old && !same(b, old))
+			return -1;
+		return merged_entry_allow_dirty(b, old, dst);
+	}
 	/*
 	 * If we have an entry in the index cache ("old"), then we want
 	 * to make sure that it matches any entries in stage 2 ("first
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -75,7 +75,8 @@ In addition:
 . ../lib-read-tree-m-3way.sh
 
 ################################################################
-# This is the "no trivial merge unless all three exists" table.
+# Trivial "majority when 3 stages exist" merge plus #5ALT trivial
+# merge.
 
 cat >expected <<\EOF
 100644 X 2	AA
@@ -88,8 +89,7 @@ cat >expected <<\EOF
 100644 X 3	DM
 100644 X 1	DN
 100644 X 3	DN
-100644 X 2	LL
-100644 X 3	LL
+100644 X 0	LL
 100644 X 1	MD
 100644 X 2	MD
 100644 X 1	MM
@@ -289,23 +289,24 @@ test_expect_failure \
      git-read-tree -m $tree_O $tree_A $tree_B"
 
 test_expect_success \
-    '5 - must match and be up-to-date in !O && A && B && A==B case.' \
+    '5 - must match in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      git-update-cache --add LL &&
      git-read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '5 (fail) - must match and be up-to-date in !O && A && B && A==B case.' \
+test_expect_success \
+    '5 - must match in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      git-update-cache --add LL &&
      echo extra >>LL &&
-     git-read-tree -m $tree_O $tree_A $tree_B"
+     git-read-tree -m $tree_O $tree_A $tree_B &&
+     check_result"
 
 test_expect_failure \
-    '5 (fail) - must match and be up-to-date in !O && A && B && A==B case.' \
+    '5 (fail) - must match A in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      echo extra >>LL &&
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ b/t/t1005-read-tree-m-2way-emu23.sh
@@ -117,9 +117,8 @@ test_expect_success \
      check_cache_at yomin dirty'
 
 # "read-tree -m H I+H M" where !H && M && (I+H) == M, so this should
-# succeed (even the entry is clean), but without #5ALT this does not
-# work.
-: test_expect_success \
+# succeed (even the entry is clean), now thanks to #5ALT.
+test_expect_success \
     '6 - local addition already has the same.' \
     'rm -f .git/index &&
      git-update-cache --add frotz &&
@@ -129,8 +128,8 @@ test_expect_success \
      check_cache_at frotz clean'
 
 # Exactly the same pattern as above but with dirty cache.  This also
-# should succeed, but without #5ALT it does not.
-: test_expect_success \
+# should succeed, now thanks to #5ALT.
+test_expect_success \
     '7 - local addition already has the same.' \
     'rm -f .git/index &&
      echo frotz >frotz &&
------------

