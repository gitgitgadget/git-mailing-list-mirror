From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 13/15] revision.c: discount side branches when computing TREESAME
Date: Thu, 16 May 2013 18:32:39 +0300
Message-ID: <1368718361-27859-14-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0HV-0000lm-C2
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab3EPPjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:42 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:49551 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752256Ab3EPPji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:38 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2013 11:39:38 EDT
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 5F17810540ED
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:16 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:16 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:11 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18173994822764695787
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224579>

Use the BOTTOM flag to define relevance for pruning. Relevant commits
are those that are !UNINTERESTING or BOTTOM, and this allows us to
identify irrelevant side branches (UNINTERESTING && !BOTTOM).

If a merge has relevant parents, and it is TREESAME to them, then do not
let irrelevant parents cause the merge to be treated as !TREESAME.

When considering simplification, don't always include all merges -
merges with exactly one relevant parent can be simplified, if TREESAME
according to the above rule.

These two changes greatly increase simplification in limited, pruned
revision lists.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                        | 171 +++++++++++++++++++++++++++++++++-----
 t/t6019-rev-list-ancestry-path.sh |  12 ++-
 t/t6111-rev-list-treesame.sh      |   8 +-
 3 files changed, 164 insertions(+), 27 deletions(-)

diff --git a/revision.c b/revision.c
index 6607dab..1c75070 100644
--- a/revision.c
+++ b/revision.c
@@ -333,6 +333,80 @@ static int everybody_uninteresting(struct commit_list *orig)
 }
 
 /*
+ * A definition of "relevant" commit that we can use to simplify limited graphs
+ * by eliminating side branches.
+ *
+ * A "relevant" commit is one that is !UNINTERESTING (ie we are including it
+ * in our list), or that is a specified BOTTOM commit. Then after computing
+ * a limited list, during processing we can generally ignore boundary merges
+ * coming from outside the graph, (ie from irrelevant parents), and treat
+ * those merges as if they were single-parent. TREESAME is defined to consider
+ * only relevant parents, if any. If we are TREESAME to our on-graph parents,
+ * we don't care if we were !TREESAME to non-graph parents.
+ *
+ * Treating bottom commits as relevant ensures that a limited graph's
+ * connection to the actual bottom commit is not viewed as a side branch, but
+ * treated as part of the graph. For example:
+ *
+ *   ....Z...A---X---o---o---B
+ *        .     /
+ *         W---Y
+ *
+ * When computing "A..B", the A-X connection is at least as important as
+ * Y-X, despite A being flagged UNINTERESTING.
+ *
+ * And when computing --ancestry-path "A..B", the A-X connection is more
+ * important than Y-X, despite both A and Y being flagged UNINTERESTING.
+ */
+static inline int relevant_commit(struct commit *commit)
+{
+	return (commit->object.flags & (UNINTERESTING | BOTTOM)) != UNINTERESTING;
+}
+
+/*
+ * Return a single relevant commit from a parent list. If we are a TREESAME
+ * commit, and this selects one of our parents, then we can safely simplify to
+ * that parent.
+ */
+static struct commit *one_relevant_parent(const struct rev_info *revs,
+					  struct commit_list *orig)
+{
+	struct commit_list *list = orig;
+	struct commit *relevant = NULL;
+
+	if (!orig)
+		return NULL;
+
+	/*
+	 * For 1-parent commits, or if first-parent-only, then return that
+	 * first parent (even if not "relevant" by the above definition).
+	 * TREESAME will have been set purely on that parent.
+	 */
+	if (revs->first_parent_only || !orig->next)
+		return orig->item;
+
+	/*
+	 * For multi-parent commits, identify a sole relevant parent, if any.
+	 * If we have only one relevant parent, then TREESAME will be set purely
+	 * with regard to that parent, and we can simplify accordingly.
+	 *
+	 * If we have more than one relevant parent, or no relevant parents
+	 * (and multiple irrelevant ones), then we can't select a parent here
+	 * and return NULL.
+	 */
+	while (list) {
+		struct commit *commit = list->item;
+		list = list->next;
+		if (relevant_commit(commit)) {
+			if (relevant)
+				return NULL;
+			relevant = commit;
+		}
+	}
+	return relevant;
+}
+
+/*
  * The goal is to get REV_TREE_NEW as the result only if the
  * diff consists of all '+' (and no other changes), REV_TREE_OLD
  * if the whole diff is removal of old data, and otherwise
@@ -502,27 +576,52 @@ static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
 	if (commit->parents && commit->parents->next) {
 		unsigned n;
 		struct treesame_state *st;
+		struct commit_list *p;
+		unsigned relevant_parents;
+		unsigned relevant_change, irrelevant_change;
 
 		st = lookup_decoration(&revs->treesame, &commit->object);
 		if (!st)
 			die("update_treesame %s", sha1_to_hex(commit->object.sha1));
-		commit->object.flags |= TREESAME;
-		for (n = 0; n < st->nparents; n++) {
-			if (!st->treesame[n]) {
-				commit->object.flags &= ~TREESAME;
-				break;
-			}
+		relevant_parents = 0;
+		relevant_change = irrelevant_change = 0;
+		for (p = commit->parents, n = 0; p; n++, p = p->next) {
+			if (relevant_commit(p->item)) {
+				relevant_change |= !st->treesame[n];
+				relevant_parents++;
+			} else
+				irrelevant_change |= !st->treesame[n];
 		}
+		if (relevant_parents ? relevant_change : irrelevant_change)
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
+	 *    against the first parent (and again we lack treesame[] decoration).
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
+	int relevant_change = 0, irrelevant_change = 0;
+	int relevant_parents, nth_parent;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -546,10 +645,12 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->dense && !commit->parents->next)
 		return;
 
-	for (pp = &commit->parents, nth_parent = 0;
+	for (pp = &commit->parents, nth_parent = 0, relevant_parents = 0;
 	     (parent = *pp) != NULL;
 	     pp = &parent->next, nth_parent++) {
 		struct commit *p = parent->item;
+		if (relevant_commit(p))
+			relevant_parents++;
 
 		if (nth_parent == 1) {
 			/*
@@ -573,7 +674,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			    !revs->simplify_history &&
 			    !(commit->object.flags & UNINTERESTING)) {
 				ts = initialise_treesame(revs, commit);
-				if (!tree_changed)
+				if (!(irrelevant_change || relevant_change))
 					ts->treesame[0] = 1;
 			}
 		}
@@ -619,14 +720,27 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		/* fallthrough */
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
-			tree_changed = 1;
+			if (relevant_commit(p))
+				relevant_change = 1;
+			else
+				irrelevant_change = 1;
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
+	 * commits, it is most useful to define it so that "irrelevant"
+	 * parents cannot make us !TREESAME - if we have any relevant
+	 * parents, then we only consider TREESAMEness with respect to them,
+	 * allowing irrelevant merges from uninteresting branches to be
+	 * simplified away. Only if we have only irrelevant parents do we
+	 * base TREESAME on them. Note that this logic is replicated in
+	 * update_treesame, which should be kept in sync.
+	 */
+	if (relevant_parents ? !relevant_change : !irrelevant_change)
+		commit->object.flags |= TREESAME;
 }
 
 static void commit_list_insert_by_date_cached(struct commit *p, struct commit_list **head,
@@ -998,6 +1112,18 @@ static int limit_list(struct rev_info *revs)
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
@@ -2248,6 +2374,7 @@ static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
 static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
 {
 	struct commit_list *p;
+	struct commit *parent;
 	struct merge_simplify_state *st, *pst;
 	int cnt;
 
@@ -2336,19 +2463,20 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	/*
 	 * A commit simplifies to itself if it is a root, if it is
 	 * UNINTERESTING, if it touches the given paths, or if it is a
-	 * merge and its parents simplify to more than one commit
+	 * merge and its parents don't simplify to one relevant commit
 	 * (the first two cases are already handled at the beginning of
 	 * this function).
 	 *
-	 * Otherwise, it simplifies to what its sole parent simplifies to.
+	 * Otherwise, it simplifies to what its sole relevant parent
+	 * simplifies to.
 	 */
 	if (!cnt ||
 	    (commit->object.flags & UNINTERESTING) ||
 	    !(commit->object.flags & TREESAME) ||
-	    (1 < cnt))
+	    (parent = one_relevant_parent(revs, commit->parents)) == NULL)
 		st->simplified = commit;
 	else {
-		pst = locate_simplify_state(revs, commit->parents->item);
+		pst = locate_simplify_state(revs, parent);
 		st->simplified = pst->simplified;
 	}
 	return tail;
@@ -2445,7 +2573,8 @@ int prepare_revision_walk(struct rev_info *revs)
 		free(list);
 
 	/* Signal whether we need per-parent treesame decoration */
-	if (revs->simplify_merges)
+	if (revs->simplify_merges ||
+	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
@@ -2479,15 +2608,15 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
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
+		if ((p = one_relevant_parent(revs, p->parents)) == NULL)
+			return rewrite_one_ok;
+		*pp = p;
 	}
 }
 
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 5ad96e3..dabebae 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -18,7 +18,8 @@ test_description='--ancestry-path'
 #  --ancestry-path F...I == F H I
 #
 #  G..M -- G.t                 == [nothing - was dropped in "-s ours" merge L]
-#  --ancestry-path G..M -- G.t == H J L
+#  --ancestry-path G..M -- G.t == L
+#  --ancestry-path --simplify-merges G^..M -- G.t == G L
 
 . ./test-lib.sh
 
@@ -101,8 +102,15 @@ test_expect_success 'rev-list G..M -- G.t' '
 '
 
 test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
-	for c in H J L; do echo $c; done >expect &&
+	echo L >expect &&
 	git rev-list --ancestry-path --format=%s G..M -- G.t |
+	sed -e "/^commit /d" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --ancestry-path --simplify-merges G^..M -- G.t' '
+	for c in G L; do echo $c; done >expect &&
+	git rev-list --ancestry-path --simplify-merges --format=%s G^..M -- G.t |
 	sed -e "/^commit /d" |
 	sort >actual &&
 	test_cmp expect actual
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 484b69b..e32b373 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -138,9 +138,9 @@ check_result 'M L G' F..M --first-parent -- file
 # Note that G is pruned when E is the bottom, even if it's the same commit list
 # If we want history since E, then we're quite happy to ignore G that took E.
 check_result 'M L K J I H G' E..M --ancestry-path
-check_outcome failure 'M L J I H' E..M --ancestry-path -- file # includes G
+check_result 'M L J I H' E..M --ancestry-path -- file
 check_outcome failure '(LH)M (K)L (EJ)K (I)J (E)I (E)H' E..M --ancestry-path --parents -- file # includes G
-check_outcome failure '(LH)M (E)H (J)L (I)J (E)I' E..M --ancestry-path --simplify-merges -- file # includes G
+check_result '(LH)M (E)H (J)L (I)J (E)I' E..M --ancestry-path --simplify-merges -- file
 
 # Should still be able to ignore I-J branch in simple log, despite limiting
 # to G.
@@ -167,9 +167,9 @@ check_result 'F D' B..F --full-history -- file
 check_result '(D)F (BA)D' B..F --full-history --parents -- file
 check_result '(B)F' B..F --simplify-merges -- file
 check_result 'F D' B..F --ancestry-path
-check_outcome failure 'F' B..F --ancestry-path -- file # includes D
+check_result 'F' B..F --ancestry-path -- file
 check_outcome failure 'F' B..F --ancestry-path --parents -- file # includes D
-check_outcome failure 'F' B..F --ancestry-path --simplify-merges -- file # includes D
+check_result 'F' B..F --ancestry-path --simplify-merges -- file
 check_result 'F D' B..F --first-parent
 check_result 'F' B..F --first-parent -- file
 
-- 
1.8.3.rc0.28.g4b02ef5
