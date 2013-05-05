From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v3 5/9] revision.c: Make --full-history consider more merges
Date: Sun,  5 May 2013 18:32:53 +0300
Message-ID: <1367767977-14513-6-git-send-email-kevin@bracey.fi>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 17:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ16p-00025T-JE
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 17:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab3EEPoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 11:44:10 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:48694 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751899Ab3EEPoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 11:44:00 -0400
Received: from mail636.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 324D1DC18EB
	for <git@vger.kernel.org>; Sun,  5 May 2013 17:33:06 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 5 May 2013 17:33:11 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 5 May 2013 17:33:09 +0200
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g682c2d9
In-Reply-To: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 8913749564338311395
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedriedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedriedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223410>

History simplification previously always treated merges as TREESAME
if they were TREESAME to any parent.

While this was consistent with the default behaviour, this could be
extremely unhelpful when searching detailed history, and could not be
overridden. For example, if a merge had ignored a change, as if by "-s
ours", then:

  git log -m -p --full-history -Schange file

would successfully locate "change"'s addition but would not locate the
merge that resolved against it.

Futher, simplify_merges could drop the actual parent that a commit
was TREESAME to, leaving it as a normal commit marked TREESAME that
isn't actually TREESAME to its remaining parent.

Now redefine a commit's TREESAME flag to be true only if a commit is
TREESAME to _all_ of its parents. This doesn't affect either the default
simplify_history behaviour (because partially TREESAME merges are turned
into normal commits), or full-history with parent rewriting (because all
merges are output). But it does affect other modes. The clearest
difference is that --full-history will show more merges - sufficient to
ensure that -m -p --full-history log searches can really explain every
change to the file, including those changes' ultimate fate in merges.

Also modify simplify_merges to recalculate TREESAME after removing
a parent. This is achieved by storing per-parent TREESAME flags on the
initial scan, so the combined flag can be easily recomputed.

This fixes some t6111 failures, but creates a couple of new ones -
we are now showing some merges that don't need to be shown.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt |   6 +-
 revision.c                         | 241 ++++++++++++++++++++++++++++++++-----
 revision.h                         |   1 +
 t/t6019-rev-list-ancestry-path.sh  |   2 +-
 t/t6111-rev-list-treesame.sh       |  20 +--
 5 files changed, 226 insertions(+), 44 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 50bbff7..1dad341 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -409,10 +409,10 @@ parent lines.
 	the example, we get
 +
 -----------------------------------------------------------------------
-	I  A  B  N  D  O
+	I  A  B  N  D  O  P
 -----------------------------------------------------------------------
 +
-`P` and `M` were excluded because they are TREESAME to a parent.  `E`,
+`M` was excluded because it is TREESAME to both parents.  `E`,
 `C` and `B` were all walked, but only `B` was !TREESAME, so the others
 do not appear.
 +
@@ -440,7 +440,7 @@ themselves.  This results in
 Compare to '\--full-history' without rewriting above.  Note that `E`
 was pruned away because it is TREESAME, but the parent list of P was
 rewritten to contain `E`'s parent `I`.  The same happened for `C` and
-`N`.  Note also that `P` was included despite being TREESAME.
+`N`.
 
 In addition to the above settings, you can change whether TREESAME
 affects inclusion:
diff --git a/revision.c b/revision.c
index a67b615..c88ded8 100644
--- a/revision.c
+++ b/revision.c
@@ -429,10 +429,100 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
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
+/*
+ * Must be called immediately after removing the nth_parent from a commit's
+ * parent list, if we are maintaining the per-parent treesame[] decoration.
+ * This does not recalculate the master TREESAME flag - update_treesame()
+ * should be called to update it after a sequence of treesame[] modifications
+ * that may have affected it.
+ */
+static int compact_treesame(struct rev_info *revs, struct commit *commit, unsigned nth_parent)
+{
+	struct treesame_state *st;
+	int old_same;
+
+	if (!commit->parents) {
+		/*
+		 * Have just removed the only parent from a non-merge.
+		 * Different handling, as we lack decoration.
+		 */
+		if (nth_parent != 0)
+			die("compact_treesame %u", nth_parent);
+		old_same = !!(commit->object.flags & TREESAME);
+		if (rev_same_tree_as_empty(revs, commit))
+			commit->object.flags |= TREESAME;
+		else
+			commit->object.flags &= ~TREESAME;
+		return old_same;
+	}
+
+	st = lookup_decoration(&revs->treesame, &commit->object);
+	if (!st || nth_parent >= st->nparents)
+		die("compact_treesame %u", nth_parent);
+
+	old_same = st->treesame[nth_parent];
+	memmove(st->treesame + nth_parent,
+		st->treesame + nth_parent + 1,
+		st->nparents - nth_parent - 1);
+
+	/*
+	 * If we've just become a non-merge commit, update TREESAME
+	 * immediately, and remove the no-longer-needed decoration.
+	 * If still a merge, defer update until update_treesame().
+	 */
+	if (--st->nparents == 1) {
+		if (commit->parents->next)
+			die("compact_treesame parents mismatch");
+		if (st->treesame[0] && revs->dense)
+			commit->object.flags |= TREESAME;
+		else
+			commit->object.flags &= ~TREESAME;
+		free(add_decoration(&revs->treesame, &commit->object, NULL));
+	}
+
+	return old_same;
+}
+
+static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
+{
+	if (commit->parents && commit->parents->next) {
+		unsigned n;
+		struct treesame_state *st;
+
+		st = lookup_decoration(&revs->treesame, &commit->object);
+		if (!st)
+			die("update_treesame %s", sha1_to_hex(commit->object.sha1));
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
+	int tree_changed = 0, nth_parent;
 
 	/*
 	 * If we don't do pruning, everything is interesting
@@ -456,25 +546,43 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->dense && !commit->parents->next)
 		return;
 
-	pp = &commit->parents;
-	while ((parent = *pp) != NULL) {
+	for (pp = &commit->parents, nth_parent = 0;
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
+			 * This our second loop iteration - so we now know
+			 * we're dealing with a merge.
+			 *
+			 * Do not compare with later parents when we care only about
+			 * the first parent chain, in order to avoid derailing the
+			 * traversal to follow a side branch that brought everything
+			 * in the path we are limited to by the pathspec.
+			 */
+			if (revs->first_parent_only)
+				break;
+			/*
+			 * If this will remain a potentially-simplifiable
+			 * merge, remember per-parent treesame if needed.
+			 * Initialise the array with the comparison from our
+			 * first iteration.
+			 */
+			if (revs->treesame.name &&
+			    !revs->simplify_history &&
+			    !(commit->object.flags & UNINTERESTING)) {
+				ts = initialise_treesame(revs, commit);
+				if (!tree_changed)
+					ts->treesame[0] = 1;
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
@@ -482,7 +590,8 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 				 * to lose the other branches of this
 				 * merge, so we just keep going.
 				 */
-				pp = &parent->next;
+				if (ts)
+					ts->treesame[nth_parent] = 1;
 				continue;
 			}
 			parent->next = NULL;
@@ -511,12 +620,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
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
@@ -1930,28 +2038,32 @@ static void add_child(struct rev_info *revs, struct commit *parent, struct commi
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
 
@@ -1971,6 +2083,70 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
 	return st;
 }
 
+static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list *h = reduce_heads(commit->parents);
+	int i = 0, marked = 0;
+	struct commit_list *po, *pn;
+
+	/* Want these for sanity-checking only */
+	int orig_cnt = commit_list_count(commit->parents);
+	int cnt = commit_list_count(h);
+
+	/*
+	 * Not ready to remove items yet, just mark them for now, based
+	 * on the output of reduce_heads(). reduce_heads outputs the reduced
+	 * set in its original order, so this isn't too hard.
+	 */
+	po = commit->parents;
+	pn = h;
+	while (po) {
+		if (pn && po->item == pn->item) {
+			pn = pn->next;
+			i++;
+		} else {
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
+	struct commit_list **pp, *p;
+	int nth_parent, removed = 0;
+
+	pp = &commit->parents;
+	nth_parent = 0;
+	while ((p = *pp) != NULL) {
+		struct commit *parent = p->item;
+		if (parent->object.flags & TMP_MARK) {
+			parent->object.flags &= ~TMP_MARK;
+			*pp = p->next;
+			free(p);
+			removed++;
+			compact_treesame(revs, commit, nth_parent);
+			continue;
+		}
+		pp = &p->next;
+		nth_parent++;
+	}
+
+	/* Removing parents can only increase TREESAMEness */
+	if (removed && !(commit->object.flags & TREESAME))
+		update_treesame(revs, commit);
+
+	return nth_parent;
+}
+
 static struct commit_list **simplify_one(struct rev_info *revs, struct commit *commit, struct commit_list **tail)
 {
 	struct commit_list *p;
@@ -2015,7 +2191,9 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	}
 
 	/*
-	 * Rewrite our list of parents.
+	 * Rewrite our list of parents. Note that this cannot
+	 * affect our TREESAME flags in any way - a commit is
+	 * always TREESAME to its simplification.
 	 */
 	for (p = commit->parents; p; p = p->next) {
 		pst = locate_simplify_state(revs, p->item);
@@ -2027,31 +2205,30 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
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
+			cnt = remove_marked_parents(revs, commit);
 	}
 
 	/*
 	 * A commit simplifies to itself if it is a root, if it is
 	 * UNINTERESTING, if it touches the given paths, or if it is a
-	 * merge and its parents simplifies to more than one commits
+	 * merge and its parents simplify to more than one commit
 	 * (the first two cases are already handled at the beginning of
 	 * this function).
 	 *
@@ -2159,6 +2336,10 @@ int prepare_revision_walk(struct rev_info *revs)
 	if (!revs->leak_pending)
 		free(list);
 
+	/* Signal whether we need per-parent treesame decoration */
+	if (revs->simplify_merges)
+		revs->treesame.name = "treesame";
+
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
@@ -2218,7 +2399,7 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
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
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 86ef908..ebe79ac 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -81,7 +81,7 @@ test_expect_success 'rev-list G..M -- G.t' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-list --ancestry-path G..M -- G.t' '
+test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
 	for c in H J L; do echo $c; done >expect &&
 	git rev-list --ancestry-path --format=%s G..M -- G.t |
 	sed -e "/^commit /d" |
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 602c02d..efc2442 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -102,9 +102,9 @@ check_result 'M L K J I H G F E D C B A'
 check_result 'M H L K J I G E F D C B A' --topo-order
 check_result 'M L H B A' -- file
 check_result 'M L H B A' --parents -- file
-check_outcome failure 'M L J I H G F D B A' --full-history -- file # drops G
+check_result 'M L J I H G F D B A' --full-history -- file
 check_result 'M L K J I H G F D B A' --full-history --parents -- file
-check_outcome failure 'M H L J I G F B A' --simplify-merges -- file # drops G
+check_result 'M H L J I G F B A' --simplify-merges -- file
 check_result 'M L K G F D B A' --first-parent
 check_result 'M L G F B A' --first-parent -- file
 
@@ -113,11 +113,11 @@ check_result 'M L K J I H G E' F..M
 check_result 'M H L K J I G E' F..M --topo-order
 check_result 'M L H' F..M -- file
 check_result 'M L H' F..M --parents -- file # L+H's parents rewritten to B, so more useful than it may seem
-check_outcome failure 'M L J I H G' F..M --full-history -- file # drops G
+check_result 'M L J I H G' F..M --full-history -- file
 check_result 'M L K J I H G' F..M --full-history --parents -- file
-check_outcome failure 'M H L J I G' F..M --simplify-merges -- file # drops G
+check_result 'M H L J I G' F..M --simplify-merges -- file
 check_result 'M L K J I H G' F..M --ancestry-path
-check_outcome failure 'M L J I H G' F..M --ancestry-path -- file # drops G
+check_result 'M L J I H G' F..M --ancestry-path -- file
 check_result 'M L K J I H G' F..M --ancestry-path --parents -- file
 check_result 'M H L J I G' F..M --ancestry-path --simplify-merges -- file
 check_result 'M L K G' F..M --first-parent
@@ -126,7 +126,7 @@ check_result 'M L G' F..M --first-parent -- file
 # Note that G is pruned when E is the bottom, even if it's the same commit list
 # If we want history since E, then we're quite happy to ignore G that took E.
 check_result 'M L K J I H G' E..M --ancestry-path
-check_result 'M L J I H' E..M --ancestry-path -- file
+check_outcome failure 'M L J I H' E..M --ancestry-path -- file # includes G
 check_outcome failure 'M L K J I H' E..M --ancestry-path --parents -- file
 check_outcome failure 'M H L J I' E..M --ancestry-path --simplify-merges -- file # includes G
 
@@ -149,13 +149,13 @@ check_result 'M H L J I' G..M --ancestry-path --simplify-merges -- file
 # But --full-history shouldn't drop D on its own - without simplification,
 # we can't decide if the merge from INTERESTING commit C was sensible.
 check_result 'F D C' B..F
-check_result 'F' B..F -- file
+check_outcome failure 'F' B..F -- file # includes D
 check_outcome failure 'F' B..F --parents -- file # includes D
-check_outcome failure 'F D' B..F --full-history -- file # drops D prematurely
+check_result 'F D' B..F --full-history -- file
 check_result 'F D' B..F --full-history --parents -- file
 check_result 'F' B..F --simplify-merges -- file
 check_result 'F D' B..F --ancestry-path
-check_result 'F' B..F --ancestry-path -- file
+check_outcome failure 'F' B..F --ancestry-path -- file # includes D
 check_outcome failure 'F' B..F --ancestry-path --parents -- file # includes D
 check_outcome failure 'F' B..F --ancestry-path --simplify-merges -- file # includes D
 check_result 'F D' B..F --first-parent
@@ -170,7 +170,7 @@ check_outcome failure 'F D B' C..F --full-history -- file # drops D
 check_result 'F D B' C..F --full-history --parents -- file
 check_result 'F D B' C..F --simplify-merges -- file
 check_result 'F D' C..F --ancestry-path
-check_outcome failure 'F D' C..F --ancestry-path -- file # drops D
+check_result 'F D' C..F --ancestry-path -- file
 check_result 'F D' C..F --ancestry-path --parents -- file
 check_result 'F D' C..F --ancestry-path --simplify-merges -- file
 check_result 'F D B' C..F --first-parent
-- 
1.8.3.rc0.28.g682c2d9
