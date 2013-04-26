From: Kevin Bracey <kevin@bracey.fi>
Subject: [RFC/PATCH 1/3] revision.c: tighten up TREESAME handling of merges
Date: Fri, 26 Apr 2013 22:31:56 +0300
Message-ID: <1367004718-30048-1-git-send-email-kevin@bracey.fi>
References: <517AD304.6020807@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 21:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoNV-00011B-CC
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274Ab3DZTcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:32:13 -0400
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:34900 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756836Ab3DZTcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:32:11 -0400
Received: from mail422.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id AA506FF8FE6
	for <git@vger.kernel.org>; Fri, 26 Apr 2013 21:32:09 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Apr 2013 21:32:20 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 26 Apr 2013 21:32:18 +0200
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.1.632.gd2b1879
In-Reply-To: <517AD304.6020807@bracey.fi>
X-Ovh-Tracer-Id: 15438902474500313310
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrgeejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222562>

Historically TREESAME was set on a commit if it was TREESAME to _any_ of
its parents. This is not optimal, as such a merge could still be worth
showing, particularly if it is an odd "-s ours" merge that (possibly
accidentally) dropped a change. And the problem is further compounded by
the fact that simplify_merges could drop the actual parent that a commit
was TREESAME to, leaving it as a normal commit marked TREESAME that
isn't actually TREESAME to its remaining parent.

This commit redefines TREESAME to be true only if a commit is TREESAME to
_all_ of its parents. This doesn't affect either the default
simplify_history behaviour (because partially TREESAME merges are turned
into normal commits), or full-history with parent rewriting (because all
merges are output). But it does affect other modes.

It also modifies simplify_merges to recalculate TREESAME after removing
a parent. This is achieved by storing per-parent TREESAME flags on the
initial scan, so the combined flag can be easily recomputed.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt |   2 +-
 revision.c                         | 220 ++++++++++++++++++++++++++++++++-----
 revision.h                         |   1 +
 3 files changed, 192 insertions(+), 31 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 3bdbf5e..380db48 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -413,7 +413,7 @@ parent lines.
 	I  A  B  N  D  O
 -----------------------------------------------------------------------
 +
-`P` and `M` were excluded because they are TREESAME to a parent.  `E`,
+`P` and `M` were excluded because they are TREESAME to both parents.  `E`,
 `C` and `B` were all walked, but only `B` was !TREESAME, so the others
 do not appear.
 +
diff --git a/revision.c b/revision.c
index a67b615..176eb7b 100644
--- a/revision.c
+++ b/revision.c
@@ -429,10 +429,85 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 	return retval >= 0 && (tree_difference == REV_TREE_SAME);
 }
 
+struct treesame_state {
+	unsigned int nparents;
+	unsigned char treesame[FLEX_ARRAY];
+};
+
+static struct treesame_state *initialise_treesame(struct rev_info *revs, struct commit *commit)
+{
+	unsigned n = commit_list_count(commit->parents);
+	struct treesame_state *st = xcalloc(1, sizeof(*st) + n);
+	st->nparents = n;
+	add_decoration(&revs->treesame, &commit->object, st);
+	return st;
+}
+
+static int compact_treesame(struct rev_info *revs, struct commit *commit, unsigned parent)
+{
+	struct treesame_state *st = lookup_decoration(&revs->treesame, &commit->object);
+	int old_same;
+
+	if (!st || parent >= st->nparents)
+		die("compact_treesame %u", parent);
+
+	/* Can be useful to indicate sameness of removed parent */
+	old_same = st->treesame[parent];
+
+	memmove(st->treesame + parent,
+		st->treesame + parent + 1,
+		st->nparents - parent - 1);
+
+	/* If we've just become a non-merge commit, update TREESAME
+	 * immediately, in case we trigger an early-exit optimisation.
+	 * (Note that there may be a mismatch between commit->parents and the
+	 * treesame_state at this stage, as we may be in mid-rewrite).
+	 * If still a merge, defer update until update_treesame().
+	 */
+	switch (--st->nparents) {
+	case 0:
+		if (rev_same_tree_as_empty(revs, commit))
+			commit->object.flags |= TREESAME;
+		else
+			commit->object.flags &= ~TREESAME;
+		break;
+	case 1:
+		if (st->treesame[0] && revs->dense)
+			commit->object.flags |= TREESAME;
+		else
+			commit->object.flags &= ~TREESAME;
+		break;
+	}
+
+	return old_same;
+}
+
+static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
+{
+	/* If 0 or 1 parents, TREESAME should be valid already */
+	if (commit->parents && commit->parents->next) {
+		int n = 0;
+		struct treesame_state *st;
+
+		st = lookup_decoration(&revs->treesame, &commit->object);
+		if (!st) die("update_treesame");
+		commit->object.flags |= TREESAME;
+		for (n = 0; n < st->nparents; n++) {
+			if (!st->treesame[n]) {
+				commit->object.flags &= ~TREESAME;
+				break;
+			}
+		}
+	}
+
+	return commit->object.flags & TREESAME;
+}
+
 static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list **pp, *parent;
-	int tree_changed = 0, tree_same = 0, nth_parent = 0;
+	struct treesame_state *ts = NULL;
+	int tree_changed = 0, nth_parent = 0;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -456,25 +531,38 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->dense && !commit->parents->next)
 		return;
 
-	pp = &commit->parents;
-	while ((parent = *pp) != NULL) {
+	for (pp = &commit->parents;
+	     (parent = *pp) != NULL;
+	     pp = &parent->next, nth_parent++) {
 		struct commit *p = parent->item;
 
-		/*
-		 * Do not compare with later parents when we care only about
-		 * the first parent chain, in order to avoid derailing the
-		 * traversal to follow a side branch that brought everything
-		 * in the path we are limited to by the pathspec.
-		 */
-		if (revs->first_parent_only && nth_parent++)
-			break;
+		if (nth_parent == 1) {
+			/*
+			 * Do not compare with later parents when we care only about
+			 * the first parent chain, in order to avoid derailing the
+			 * traversal to follow a side branch that brought everything
+			 * in the path we are limited to by the pathspec.
+			 */
+			if (revs->first_parent_only)
+				break;
+			/*
+			 * If this is going to remain a merge, and it's
+			 * interesting, remember per-parent treesame for
+			 * simplify_merges().
+			 */
+			if (revs->simplify_merges && !(p->object.flags & UNINTERESTING)) {
+				ts = initialise_treesame(revs, commit);
+				if (!tree_changed)
+					ts->treesame[0] = 1;
+
+			}
+		}
 		if (parse_commit(p) < 0)
 			die("cannot simplify commit %s (because of %s)",
 			    sha1_to_hex(commit->object.sha1),
 			    sha1_to_hex(p->object.sha1));
 		switch (rev_compare_tree(revs, p, commit)) {
 		case REV_TREE_SAME:
-			tree_same = 1;
 			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
@@ -482,7 +570,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 * to lose the other branches of this
 				 * merge, so we just keep going.
 				 */
-				pp = &parent->next;
+				if (ts)
+					ts->treesame[nth_parent] = 1;
 				continue;
 			}
 			parent->next = NULL;
@@ -511,12 +600,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		case REV_TREE_OLD:
 		case REV_TREE_DIFFERENT:
 			tree_changed = 1;
-			pp = &parent->next;
 			continue;
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha1));
 	}
-	if (tree_changed && !tree_same)
+	if (tree_changed)
 		return;
 	commit->object.flags |= TREESAME;
 }
@@ -773,6 +861,9 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
 	 * NEEDSWORK: decide if we want to remove parents that are
 	 * not marked with TMP_MARK from commit->parents for commits
 	 * in the resulting list.  We may not want to do that, though.
+	 *
+	 * Maybe it should be considered if we are TREESAME to such
+	 * parents - now possible with stored per-parent flags.
 	 */
 
 	/*
@@ -1930,28 +2021,32 @@ static void add_child(struct rev_info *revs, struct commit *parent, struct commi
 	l->next = add_decoration(&revs->children, &parent->object, l);
 }
 
-static int remove_duplicate_parents(struct commit *commit)
+static int remove_duplicate_parents(struct rev_info *revs, struct commit *commit)
 {
+	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
 	struct commit_list **pp, *p;
 	int surviving_parents;
 
 	/* Examine existing parents while marking ones we have seen... */
 	pp = &commit->parents;
+	surviving_parents = 0;
 	while ((p = *pp) != NULL) {
 		struct commit *parent = p->item;
 		if (parent->object.flags & TMP_MARK) {
 			*pp = p->next;
+			if (ts)
+				compact_treesame(revs, commit, surviving_parents);
 			continue;
 		}
 		parent->object.flags |= TMP_MARK;
+		surviving_parents++;
 		pp = &p->next;
 	}
-	/* count them while clearing the temporary mark */
-	surviving_parents = 0;
+	/* clear the temporary mark */
 	for (p = commit->parents; p; p = p->next) {
 		p->item->object.flags &= ~TMP_MARK;
-		surviving_parents++;
 	}
+	/* no update_treesame() - removing duplicates can't affect TREESAME */
 	return surviving_parents;
 }
 
@@ -1971,6 +2066,70 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
 	return st;
 }
 
+static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list *h = reduce_heads(commit->parents);
+	int i = 0, marked = 0;
+	struct commit_list *po, *pn;
+
+	/* Want these for sanity only */
+	int orig_cnt = commit_list_count(commit->parents);
+	int cnt = commit_list_count(h);
+
+	/* Not ready to remove items yet, just mark them for now, based
+	 * on the output of reduce_heads(). reduce_heads outputs the reduced
+	 * set in its original order, so this isn't too hard.
+	 */
+	po = commit->parents;
+	pn = h;
+	while (po) {
+		if (pn && po->item == pn->item) {
+			pn=pn->next;
+			i++;
+		}
+		else {
+			po->item->object.flags |= TMP_MARK;
+			marked++;
+		}
+		po=po->next;
+	}
+
+	if (i != cnt || cnt+marked != orig_cnt)
+		die("mark_redundant_parents %d %d %d %d", orig_cnt, cnt, i, marked);
+
+	free_commit_list(h);
+
+	return marked;
+}
+
+static int remove_marked_parents(struct rev_info *revs, struct commit *commit)
+{
+	struct treesame_state *ts = lookup_decoration(&revs->treesame, &commit->object);
+	struct commit_list **pp, *p;
+	int n, removed = 0;
+
+	pp = &commit->parents;
+	n = 0;
+	while ((p = *pp) != NULL) {
+		struct commit *parent = p->item;
+		if (parent->object.flags & TMP_MARK) {
+			parent->object.flags &= ~TMP_MARK;
+			compact_treesame(revs, commit, n);
+			*pp = p->next;
+			free(p);
+			removed++;
+			continue;
+		}
+		pp = &p->next;
+		n++;
+	}
+
+	if (removed)
+		update_treesame(revs, commit);
+
+	return removed;
+}
+
 static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
 {
 	struct commit_list *p;
@@ -2015,7 +2174,9 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	}
 
 	/*
-	 * Rewrite our list of parents.
+	 * Rewrite our list of parents. Note that this cannot
+	 * affect our TREESAME flags in anyway - a commit is
+	 * always TREESAME to its simplification.
 	 */
 	for (p = commit->parents; p; p = p->next) {
 		pst = locate_simplify_state(revs, p->item);
@@ -2027,31 +2188,30 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	if (revs->first_parent_only)
 		cnt = 1;
 	else
-		cnt = remove_duplicate_parents(commit);
+		cnt = remove_duplicate_parents(revs, commit);
 
 	/*
 	 * It is possible that we are a merge and one side branch
 	 * does not have any commit that touches the given paths;
-	 * in such a case, the immediate parents will be rewritten
-	 * to different commits.
+	 * in such a case, the immediate parent from that branch
+	 * will be rewritten to be the merge base.
 	 *
 	 *      o----X		X: the commit we are looking at;
 	 *     /    /		o: a commit that touches the paths;
 	 * ---o----'
 	 *
-	 * Further reduce the parents by removing redundant parents.
+	 * Detect and simplify this case.
 	 */
 	if (1 < cnt) {
-		struct commit_list *h = reduce_heads(commit->parents);
-		cnt = commit_list_count(h);
-		free_commit_list(commit->parents);
-		commit->parents = h;
+		int marked = mark_redundant_parents(revs, commit);
+		if (marked)
+			remove_marked_parents(revs, commit);
 	}
 
 	/*
 	 * A commit simplifies to itself if it is a root, if it is
 	 * UNINTERESTING, if it touches the given paths, or if it is a
-	 * merge and its parents simplifies to more than one commits
+	 * merge and its parents simplify to more than one commit
 	 * (the first two cases are already handled at the beginning of
 	 * this function).
 	 *
@@ -2218,7 +2378,7 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 		}
 		pp = &parent->next;
 	}
-	remove_duplicate_parents(commit);
+	remove_duplicate_parents(revs, commit);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 01bd2b7..1abe57b 100644
--- a/revision.h
+++ b/revision.h
@@ -167,6 +167,7 @@ struct rev_info {
 	struct reflog_walk_info *reflog_info;
 	struct decoration children;
 	struct decoration merge_simplification;
+	struct decoration treesame;
 
 	/* notes-specific options: which refs to show */
 	struct display_notes_opt notes_opt;
-- 
1.8.2.1.632.gd2b1879
