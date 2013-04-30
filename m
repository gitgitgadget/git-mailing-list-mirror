From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 8/8] revision.c: discount UNINTERESTING parents
Date: Tue, 30 Apr 2013 20:26:28 +0300
Message-ID: <1367342788-7795-9-git-send-email-kevin@bracey.fi>
References: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 20:44:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFXd-0006xV-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669Ab3D3Soj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:44:39 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:53043 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760969Ab3D3Soh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:44:37 -0400
Received: from mail414.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 3401AFFA883
	for <git@vger.kernel.org>; Tue, 30 Apr 2013 19:27:11 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Apr 2013 19:27:11 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 30 Apr 2013 19:27:09 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <1367342788-7795-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18369338456154476774
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222986>

The simplification and rewriting logic previously paid little heed to
whether parents were UNINTERESTING, leading to situations where limited
histories could unnecessarily include a lot of irrelevant merges along
the boundary. Tighten up the rules to properly account for limited
lists:

1) If a merge has INTERESTING parents, and it is TREESAME to them, then
do not let UNINTERESTING parents cause the merge to be treated as
!TREESAME. If we match our walked parents, we don't care if we don't
match unwalked parents.

2) Do not let UNINTERESTING parents prevent commits from being
simplified or omitted: merges with exactly 1 INTERESTING parent that
they are TREESAME to can be treated as a non-merge commit.

3) When rewriting parents, we don't need to show all merges - only merges
with 2 or more INTERESTING parents are required to hold topology together.

These changes greatly increase simplification in pruned, limited
revision lists - irrelevant merges from unlisted or partially listed
side branches can be omitted.

These rules paying more attention to UNINTERESTING do add a tricky
wrinkle to behaviour. Because limited revision lists are conventionally
expressed as A..B (ie B ^A), the bottom commit is UNINTERESTING. Thus
its connection to the INTERESTING graph is not privileged over side
branches, and this can lead to its first descendant merge being shown
for no particularly good reason.

See t6019's "--ancestry-path G..M -- G.t" for an example of this effect.
Merges H and J are semantically identical and equally irrelevant, from
the point of view of tracking the history of G.t, but H is shown and J
isn't. Bottom commit G is marked UNINTERESTING, and thus isn't
privileged over E, so H is shown because it differs from E.  Whereas
higher up the graph, I is INTERESTING and thus privileged over F, so we
don't care that J differs from F.

So should we treat bottom commits as "interesting" for the rules above?

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                        | 141 ++++++++++++++++++++++++++++++++------
 t/t6019-rev-list-ancestry-path.sh |  20 ++++--
 2 files changed, 134 insertions(+), 27 deletions(-)

diff --git a/revision.c b/revision.c
index 20c7058..aa814bc 100644
--- a/revision.c
+++ b/revision.c
@@ -333,6 +333,45 @@ static int everybody_uninteresting(struct commit_list *orig)
 }
 
 /*
+ * Compute whether we have only one "interesting" parent. If we are TREESAME,
+ * and this returns a parent, then we can safely simplify to that parent.
+ *
+ * For 1-parent commits, or if first-parent-only, then this returns the only
+ * parent (whether UNINTERESTING or not, that is our "interesting" parent).
+ * TREESAME will have been set purely on that parent.
+ *
+ * For multi-parent commits, identify a sole INTERESTING parent, if any.
+ * If we have only 1 INTERESTING parent, then TREESAME will be set purely
+ * with regard to that parent, and we can choose simplification appropriately.
+ *
+ * If we have more than one INTERESTING parent, or no INTERESTING parents
+ * (and multiple UNINTERESTING ones), then we can't choose a parent to follow,
+ * and we should not be simplified.
+ */
+struct commit *sole_interesting(struct rev_info *revs, struct commit_list *orig)
+{
+	struct commit_list *list = orig;
+	struct commit *interesting = NULL;
+
+	if (!orig)
+		return NULL;
+
+	if (revs->first_parent_only || !orig->next)
+		return orig->item;
+
+	while (list) {
+		struct commit *commit = list->item;
+		list = list->next;
+		if (!(commit->object.flags & UNINTERESTING)) {
+			if (interesting)
+				return NULL;
+			interesting = commit;
+		}
+	}
+	return interesting;
+}
+
+/*
  * The goal is to get REV_TREE_NEW as the result only if the
  * diff consists of all '+' (and no other changes), REV_TREE_OLD
  * if the whole diff is removal of old data, and otherwise
@@ -502,27 +541,53 @@ static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
 	if (commit->parents && commit->parents->next) {
 		unsigned n;
 		struct treesame_state *st;
+		struct commit_list *p;
+		unsigned interesting_parents;
+		unsigned uninteresting_change, interesting_change;
 
 		st = lookup_decoration(&revs->treesame, &commit->object);
 		if (!st)
 			die("update_treesame %s", sha1_to_hex(commit->object.sha1));
-		commit->object.flags |= TREESAME;
-		for (n = 0; n < st->nparents; n++) {
-			if (!st->treesame[n]) {
-				commit->object.flags &= ~TREESAME;
-				break;
+		interesting_parents = 0;
+		uninteresting_change = interesting_change = 0;
+		for (p = commit->parents, n = 0; p; n++, p = p->next) {
+			if (p->item->object.flags & UNINTERESTING)
+				uninteresting_change |= !st->treesame[n];
+			else {
+				interesting_change |= !st->treesame[n];
+				interesting_parents++;
 			}
 		}
+		if (interesting_parents ? interesting_change : uninteresting_change)
+			commit->object.flags &= ~TREESAME;
+		else
+			commit->object.flags |= TREESAME;
 	}
 
 	return commit->object.flags & TREESAME;
 }
 
+static inline int limiting_can_increase_treesame(const struct rev_info *revs)
+{
+	/*
+	 * TREESAME is irrelevant unless prune && dense;
+	 * if simplify_history is set, we can't have a mixture of TREESAME and
+	 *    !TREESAME INTERESTING parents (and we don't have treesame[]
+	 *    decoration anyway);
+	 * if first_parent_only is set, then the TREESAME flag is locked
+	 * against the first parent (and again we lack treesame[] decoration).
+	 */
+	return revs->prune && revs->dense &&
+	       !revs->simplify_history &&
+	       !revs->first_parent_only;
+}
+
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
 	struct treesame_state *ts = NULL;
-	int tree_changed = 0, nth_parent;
+	int uninteresting_change = 0, interesting_change = 0;
+	int interesting_parents, nth_parent;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -546,10 +611,12 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->dense && !commit->parents->next)
 		return;
 
-	for (pp = &commit->parents, nth_parent = 0;
+	for (pp = &commit->parents, nth_parent = 0, interesting_parents = 0;
 	     (parent = *pp) != NULL;
 	     pp = &parent->next, nth_parent++) {
 		struct commit *p = parent->item;
+		if (!(p->object.flags & UNINTERESTING))
+			interesting_parents++;
 
 		if (nth_parent == 1) {
 			/*
@@ -573,7 +640,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			    !revs->simplify_history &&
 			    !(commit->object.flags & UNINTERESTING)) {
 				ts = initialise_treesame(revs, commit);
-				if (!tree_changed)
+				if (!(uninteresting_change || interesting_change))
 					ts->treesame[0] = 1;
 			}
 		}
@@ -619,14 +686,26 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		/* fallthrough */
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
-			tree_changed = 1;
+			if (p->object.flags & UNINTERESTING)
+				uninteresting_change = 1;
+			else
+				interesting_change = 1;
 			continue;
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	if (tree_changed)
-		return;
-	commit->object.flags |= TREESAME;
+
+	/*
+	 * TREESAME is straightforward for single-parent commits. For merge
+	 * commits, it is most useful to define it so that UNINTERESTING
+	 * parents cannot make us !TREESAME - if we have any interesting
+	 * parents, then we only consider TREESAMEness with respect to them,
+	 * allowing a irrelevant merge from UNINTERESTING branches to be
+	 * simplified away. Only if we have only UNINTERESTING parents do we
+	 * base TREESAME on them.
+	 */
+	if (interesting_parents ? !interesting_change : !uninteresting_change)
+		commit->object.flags |= TREESAME;
 }
 
 static void commit_list_insert_by_date_cached(struct commit *p, struct commit_list **head,
@@ -1002,6 +1081,18 @@ static int limit_list(struct rev_info *revs)
 		free_commit_list(bottom);
 	}
 
+	/*
+	 * Check if any commits have become TREESAME by some of their parents
+	 * becoming UNINTERESTING.
+	 */
+	if (limiting_can_increase_treesame(revs))
+		for (list = newlist; list; list = list->next) {
+			struct commit *c = list->item;
+			if (c->object.flags & (UNINTERESTING | TREESAME))
+				continue;
+			update_treesame(revs, c);
+		}
+
 	revs->commits = newlist;
 	return 0;
 }
@@ -2233,6 +2324,7 @@ static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
 static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
 {
 	struct commit_list *p;
+	struct commit *parent;
 	struct merge_simplify_state *st, *pst;
 	int cnt;
 
@@ -2321,19 +2413,20 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	/*
 	 * A commit simplifies to itself if it is a root, if it is
 	 * UNINTERESTING, if it touches the given paths, or if it is a
-	 * merge and its parents simplify to more than one commit
+	 * merge and its parents don't simplify to one interesting commit
 	 * (the first two cases are already handled at the beginning of
 	 * this function).
 	 *
-	 * Otherwise, it simplifies to what its sole parent simplifies to.
+	 * Otherwise, it simplifies to what its sole interesting parent
+	 * simplifies to.
 	 */
 	if (!cnt ||
 	    (commit->object.flags & UNINTERESTING) ||
 	    !(commit->object.flags & TREESAME) ||
-	    (1 < cnt))
+	    (parent = sole_interesting(revs, commit->parents)) == NULL)
 		st->simplified = commit;
 	else {
-		pst = locate_simplify_state(revs, commit->parents->item);
+		pst = locate_simplify_state(revs, parent);
 		st->simplified = pst->simplified;
 	}
 	return tail;
@@ -2430,7 +2523,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		free(list);
 
 	/* Signal whether we need per-parent treesame decoration */
-	if (revs->simplify_merges)
+	if (revs->simplify_merges ||
+	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
@@ -2464,15 +2558,15 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 		if (!revs->limited)
 			if (add_parents_to_list(revs, p, &revs->commits, &cache) < 0)
 				return rewrite_one_error;
-		if (p->parents && p->parents->next)
-			return rewrite_one_ok;
 		if (p->object.flags & UNINTERESTING)
 			return rewrite_one_ok;
 		if (!(p->object.flags & TREESAME))
 			return rewrite_one_ok;
 		if (!p->parents)
 			return rewrite_one_noparents;
-		*pp = p->parents->item;
+		if ((p = sole_interesting(revs, p->parents)) == NULL)
+			return rewrite_one_ok;
+		*pp = p;
 	}
 }
 
@@ -2629,11 +2723,14 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->prune && revs->dense) {
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
+			/* drop root commits */
+			if (!commit->parents)
+				return commit_ignore;
 			/* drop merges unless we want parenthood */
 			if (!want_ancestry(revs))
 				return commit_ignore;
-			/* non-merge - always ignore it */
-			if (!commit->parents || !commit->parents->next)
+			/* exactly one interesting parent - always ignore it */
+			if (sole_interesting(revs, commit->parents))
 				return commit_ignore;
 		}
 	}
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index ebe79ac..be1f90a 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -4,18 +4,19 @@ test_description='--ancestry-path'
 
 #          D---E-------F
 #         /     \       \
-#    B---C---G---H---I---J
+#    B---C-G0-G--H---I---J
 #   /                     \
 #  A-------K---------------L--M
 #
-#  D..M                 == E F G H I J K L M
+#  D..M                 == E F G G0 H I J K L M
 #  --ancestry-path D..M == E F H I J L M
 #
 #  D..M -- M.t                 == M
 #  --ancestry-path D..M -- M.t == M
 #
 #  G..M -- G.t                 == [nothing - was dropped in "-s ours" merge L]
-#  --ancestry-path G..M -- G.t == H J L
+#  --ancestry-path G..M -- G.t == H L  (H shown because both G and E are uninteresting)
+#  --ancestry-path G0..M-- G.t == G L
 
 . ./test-lib.sh
 
@@ -33,6 +34,7 @@ test_expect_success setup '
 	test_commit E &&
 	test_commit F &&
 	git reset --hard C &&
+	test_commit G0 &&
 	test_commit G &&
 	test_merge E H &&
 	test_commit I &&
@@ -44,7 +46,7 @@ test_expect_success setup '
 '
 
 test_expect_success 'rev-list D..M' '
-	for c in E F G H I J K L M; do echo $c; done >expect &&
+	for c in E F G G0 H I J K L M; do echo $c; done >expect &&
 	git rev-list --format=%s D..M |
 	sed -e "/^commit /d" |
 	sort >actual &&
@@ -82,13 +84,21 @@ test_expect_success 'rev-list G..M -- G.t' '
 '
 
 test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
-	for c in H J L; do echo $c; done >expect &&
+	for c in H L; do echo $c; done >expect &&
 	git rev-list --ancestry-path --format=%s G..M -- G.t |
 	sed -e "/^commit /d" |
 	sort >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list --ancestry-path G0..M -- G.t' '
+	for c in G L; do echo $c; done >expect &&
+	git rev-list --ancestry-path --format=%s G0..M -- G.t |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
 #   b---bc
 #  / \ /
 # a   X
-- 
1.8.2.1.632.gd2b1879
