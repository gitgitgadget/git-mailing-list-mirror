From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2.1 8/8] revision.c: discount side branches when computing TREESAME
Date: Thu,  2 May 2013 20:58:08 +0300
Message-ID: <1367517488-11052-1-git-send-email-kevin@bracey.fi>
References: <5182A7CC.4040009@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 19:58:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxmI-0003Ed-H7
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442Ab3EBR6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:58:42 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:43156 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932435Ab3EBR6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:58:40 -0400
X-Greylist: delayed 172443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2013 13:58:40 EDT
Received: from mail173.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 664AEFFA741
	for <git@vger.kernel.org>; Thu,  2 May 2013 19:58:39 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 2 May 2013 19:58:27 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 2 May 2013 19:58:25 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <5182A7CC.4040009@bracey.fi>
X-Ovh-Tracer-Id: 12195747792175141086
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrheekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223242>

Add a BOTTOM flag to commit objects, and use it to define priority for
pruning. Priority commits are those that are !UNINTERESTING or BOTTOM,
and this allows us to identify irrelevant side branches (UNINTERESTING
&& !BOTTOM).

If a merge has priority parents, and it is TREESAME to them, then do
not let non-priority parents cause the merge to be treated as
!TREESAME.

When considering simplification, don't always include all merges -
merges with exactly 1 priority parent can be simplified, if TREESAME
according to the above rule.

These two changes greatly increase simplification in limited revision
lists - irrelevant merges from unlisted commits can be omitted.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                        | 210 ++++++++++++++++++++++++++++++++------
 revision.h                        |   3 +-
 t/t6019-rev-list-ancestry-path.sh |  12 ++-
 3 files changed, 188 insertions(+), 37 deletions(-)

diff --git a/revision.c b/revision.c
index ddaed33..2a7f08d 100644
--- a/revision.c
+++ b/revision.c
@@ -333,6 +333,76 @@ static int everybody_uninteresting(struct commit_list *orig)
 }
 
 /*
+ * A definition of "priority" commit that we can use to simplify limited graphs
+ * by eliminating side branches.
+ *
+ * A "priority" commit is one that is !UNINTERESTING (ie we are including it
+ * in our list), or that is a specified BOTTOM commit. Then after computing
+ * a limited list, during processing we can generally ignore boundary merges
+ * coming from outside the graph, (ie from non-priority parents), and treat
+ * those merges as if they were single-parent. TREESAME is defined to consider
+ * only priority parents, if any. If we are TREESAME to our on-graph parents,
+ * we don't care if we were !TREESAME to non-graph parents.
+ *
+ * Including bottom commits in "priority" ensures that a limited graph's
+ * connection to the actual bottom commit is not viewed as an uninteresting
+ * side branch, but treated as part of the graph. For example:
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
+static inline int priority_commit(struct commit *commit)
+{
+	return (commit->object.flags & (UNINTERESTING | BOTTOM)) != UNINTERESTING;
+}
+
+/*
+ * Return a single priority commit from a parent list. If we are a TREESAME
+ * commit, and this selects one of our parents, then we can safely simplify to
+ * that parent.
+ *
+ * For 1-parent commits, or if first-parent-only, then this returns the only
+ * parent. TREESAME will have been set purely on that parent.
+ *
+ * For multi-parent commits, identify a sole priority parent, if any.
+ * If we have only one priority parent, then TREESAME will be set purely
+ * with regard to that parent, and we can choose simplification appropriately.
+ *
+ * If we have more than one priority parent, or no priority parents
+ * (and multiple non-priority ones), then we can't select a parent here and
+ * return NULL.
+ */
+struct commit *priority_select_parent(struct rev_info *revs, struct commit_list *orig)
+{
+	struct commit_list *list = orig;
+	struct commit *priority = NULL;
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
+		if (priority_commit(commit)) {
+			if (priority)
+				return NULL;
+			priority = commit;
+		}
+	}
+	return priority;
+}
+
+/*
  * The goal is to get REV_TREE_NEW as the result only if the
  * diff consists of all '+' (and no other changes), REV_TREE_OLD
  * if the whole diff is removal of old data, and otherwise
@@ -502,17 +572,28 @@ static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
 	if (commit->parents && commit->parents->next) {
 		unsigned n;
 		struct treesame_state *st;
+		struct commit_list *p;
+		unsigned priority_parents;
+		unsigned priority_change, nonpriority_change;
 
 		st = lookup_decoration(&revs->treesame, &commit->object);
 		if (!st)
 			die("update_treesame %s", sha1_to_hex(commit->object.sha1));
-		commit->object.flags |= TREESAME;
-		for (n = 0; n < st->nparents; n++) {
-			if (!st->treesame[n]) {
-				commit->object.flags &= ~TREESAME;
-				break;
-			}
+		priority_parents = 0;
+		priority_change = nonpriority_change = 0;
+		for (p = commit->parents, n = 0; p; n++, p = p->next) {
+			if (priority_commit(p->item)) {
+				priority_change |= !st->treesame[n];
+				priority_parents++;
+			} else
+				nonpriority_change |= !st->treesame[n];
 		}
+		//fprintf(stderr, "=>%s has %d priority parents; %d %d\n", sha1_to_hex(commit->object.sha1),
+		//		priority_parents, priority_change, nonpriority_change);
+		if (priority_parents ? priority_change : nonpriority_change)
+			commit->object.flags &= ~TREESAME;
+		else
+			commit->object.flags |= TREESAME;
 	}
 
 	return commit->object.flags & TREESAME;
@@ -522,7 +603,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
 	struct treesame_state *ts = NULL;
-	int tree_changed = 0, nth_parent;
+	int priority_change = 0, nonpriority_change = 0;
+	int priority_parents, nth_parent;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -546,10 +628,12 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->dense && !commit->parents->next)
 		return;
 
-	for (pp = &commit->parents, nth_parent = 0;
+	for (pp = &commit->parents, nth_parent = 0, priority_parents = 0;
 	     (parent = *pp) != NULL;
 	     pp = &parent->next, nth_parent++) {
 		struct commit *p = parent->item;
+		if (priority_commit(p))
+			priority_parents++;
 
 		if (nth_parent == 1) {
 			/*
@@ -564,8 +648,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			if (revs->first_parent_only)
 				break;
 			/*
-			 * If this is going to remain a merge, and it's
-			 * interesting, prepare to remember per-parent treesame
+			 * If this will remain a potentially-simplifiable
+			 * merge, prepare to remember per-parent treesame
 			 * if needed. Initialise the array with our comparison
 			 * from the first iteration.
 			 */
@@ -573,7 +657,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			    !revs->simplify_history &&
 			    !(commit->object.flags & UNINTERESTING)) {
 				ts = initialise_treesame(revs, commit);
-				if (!tree_changed)
+				if (!(nonpriority_change || priority_change))
 					ts->treesame[0] = 1;
 			}
 		}
@@ -583,7 +667,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			    sha1_to_hex(p->object.sha1));
 		switch (rev_compare_tree(revs, p, commit)) {
 		case REV_TREE_SAME:
-			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
+			if (!revs->simplify_history || !priority_commit(p)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
@@ -619,14 +703,31 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		/* fallthrough */
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
-			tree_changed = 1;
+			if (priority_commit(p))
+				priority_change = 1;
+			else
+				nonpriority_change = 1;
 			continue;
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	if (tree_changed)
-		return;
-	commit->object.flags |= TREESAME;
+
+	//fprintf(stderr, "%s has %d priority parents; %d %d\n",
+	//		sha1_to_hex(commit->object.sha1),
+	//		priority_parents, priority_change, nonpriority_change);
+
+	/*
+	 * TREESAME is straightforward for single-parent commits. For merge
+	 * commits, it is most useful to define it so that "non-priority"
+	 * parents cannot make us !TREESAME - if we have any priority
+	 * parents, then we only consider TREESAMEness with respect to them,
+	 * allowing irrelevant merges from uninteresting branches to be
+	 * simplified away. Only if we have only nonpriority parents do we
+	 * base TREESAME on them. Note that this logic is replicated in
+	 * update_treesame, which should be kept in sync.
+	 */
+	if (priority_parents ? !priority_change : !nonpriority_change)
+		commit->object.flags |= TREESAME;
 }
 
 static void commit_list_insert_by_date_cached(struct commit *p, struct commit_list **head,
@@ -1007,6 +1108,23 @@ static int limit_list(struct rev_info *revs)
 		free_commit_list(bottom);
 	}
 
+	/*
+	 * Check if any commits have become TREESAME by some of their parents
+	 * becoming UNINTERESTING. Note that TREESAME is irrelevant unless
+	 * prune && dense; if simplify_history is set, we can't have a mixture
+	 * of TREESAME and !TREESAME INTERESTING parents, so this can't happen
+	 * (and we don't have treesame[] decoration anyway); if first_parent_only
+	 * is set, then the TREESAME flag is locked against the first parent
+	 * (and again we lack treesame[] decoration).
+	 */
+	if (revs->prune && revs->dense && !revs->simplify_history && !revs->first_parent_only)
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
@@ -1020,6 +1138,16 @@ static void add_rev_cmdline(struct rev_info *revs,
 	struct rev_cmdline_info *info = &revs->cmdline;
 	int nr = info->nr;
 
+	/*
+	 * Total hack, but at least doing it here means we're consistent
+	 * with collect_bottom_commits(). But if we just flagged BOTTOM
+	 * commits before this, could we ditch this entire function?
+	 */
+	if (item->type == OBJ_COMMIT && (flags & UNINTERESTING)) {
+		item->flags |= BOTTOM;
+		flags |= BOTTOM;
+	}
+
 	ALLOC_GROW(info->rev, nr + 1, info->alloc);
 	info->rev[nr].item = item;
 	info->rev[nr].name = name;
@@ -1999,10 +2127,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->topo_order)
 		revs->limited = 1;
 
-	/* Signal whether we need per-parent treesame decoration */
-	if (revs->simplify_merges)
-		revs->treesame.name = "treesame";
-
 	if (revs->prune_data.nr) {
 		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
@@ -2242,6 +2366,7 @@ static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
 static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
 {
 	struct commit_list *p;
+	struct commit *parent;
 	struct merge_simplify_state *st, *pst;
 	int cnt;
 
@@ -2320,29 +2445,32 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	 */
 	if (1 < cnt) {
 		int marked = mark_redundant_parents(revs, commit);
+		//fprintf(stderr, "%s has %d parents, removing %d redundant", sha1_to_hex(commit->object.sha1), cnt, marked);
 		marked += mark_treesame_root_parents(revs, commit);
 		if (marked)
 			marked -= leave_one_treesame_to_parent(revs, commit);
 		if (marked)
 			cnt = remove_marked_parents(revs, commit);
+		//fprintf(stderr, ", final=%d\n", cnt);
 	}
 
 	/*
 	 * A commit simplifies to itself if it is a root, if it is
 	 * UNINTERESTING, if it touches the given paths, or if it is a
-	 * merge and its parents simplify to more than one commit
+	 * merge and its parents don't simplify to one priority commit
 	 * (the first two cases are already handled at the beginning of
 	 * this function).
 	 *
-	 * Otherwise, it simplifies to what its sole parent simplifies to.
+	 * Otherwise, it simplifies to what its sole priority parent
+	 * simplifies to.
 	 */
 	if (!cnt ||
 	    (commit->object.flags & UNINTERESTING) ||
 	    !(commit->object.flags & TREESAME) ||
-	    (1 < cnt))
+	    (parent = priority_select_parent(revs, commit->parents)) == NULL)
 		st->simplified = commit;
 	else {
-		pst = locate_simplify_state(revs, commit->parents->item);
+		pst = locate_simplify_state(revs, parent);
 		st->simplified = pst->simplified;
 	}
 	return tail;
@@ -2438,6 +2566,10 @@ int prepare_revision_walk(struct rev_info *revs)
 	if (!revs->leak_pending)
 		free(list);
 
+	/* Signal whether we need per-parent treesame decoration */
+	if (revs->simplify_merges || revs->limited)
+		revs->treesame.name = "treesame";
+
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
@@ -2469,15 +2601,15 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
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
+		if ((p = priority_select_parent(revs, p->parents)) == NULL)
+			return rewrite_one_ok;
+		*pp = p;
 	}
 }
 
@@ -2621,10 +2753,7 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->min_age != -1 && (commit->date > revs->min_age))
 		return commit_ignore;
 	if (revs->min_parents || (revs->max_parents >= 0)) {
-		int n = 0;
-		struct commit_list *p;
-		for (p = commit->parents; p; p = p->next)
-			n++;
+		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
 		    ((revs->max_parents >= 0) && (n > revs->max_parents)))
 			return commit_ignore;
@@ -2634,12 +2763,25 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->prune && revs->dense) {
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
+			int n;
+			struct commit_list *p;
 			/* drop merges unless we want parenthood */
 			if (!want_ancestry(revs))
 				return commit_ignore;
-			/* non-merge - always ignore it */
-			if (!commit->parents || !commit->parents->next)
-				return commit_ignore;
+			/*
+			 * If we want ancestry, then need to keep any merge
+			 * between INTERESTING commits to tie together topology.
+			 * This is purely a topology question, so we do not
+			 * care about merges from UNINTERESTING commits at the
+			 * boundary, or necessarily about merges from BOTTOM
+			 * (although a parent being BOTTOM will have impacted
+			 * the TREESAME determination above).
+			 */
+			for (n = 0, p = commit->parents; p; p = p->next)
+				if (!(p->item->object.flags & UNINTERESTING))
+					if (++n >= 2)
+						return commit_show;
+			return commit_ignore;
 		}
 	}
 	return commit_show;
diff --git a/revision.h b/revision.h
index 1abe57b..765630a 100644
--- a/revision.h
+++ b/revision.h
@@ -15,7 +15,8 @@
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
 #define PATCHSAME	(1u<<9)
-#define ALL_REV_FLAGS	((1u<<10)-1)
+#define BOTTOM		(1u<<10)
+#define ALL_REV_FLAGS	((1u<<11)-1)
 
 #define DECORATE_SHORT_REFS	1
 #define DECORATE_FULL_REFS	2
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index ebe79ac..c5a412c 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -15,7 +15,8 @@ test_description='--ancestry-path'
 #  --ancestry-path D..M -- M.t == M
 #
 #  G..M -- G.t                 == [nothing - was dropped in "-s ours" merge L]
-#  --ancestry-path G..M -- G.t == H J L
+#  --ancestry-path G..M -- G.t == L
+#  --ancestry-path --simplify-merges G^..M -- G.t == G L
 
 . ./test-lib.sh
 
@@ -82,8 +83,15 @@ test_expect_success 'rev-list G..M -- G.t' '
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
-- 
1.8.2.1.632.gd2b1879
