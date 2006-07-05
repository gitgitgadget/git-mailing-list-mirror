From: Junio C Hamano <junkio@cox.net>
Subject: merge-base: update the clean-up postprocessing
Date: Tue, 04 Jul 2006 19:07:04 -0700
Message-ID: <7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
References: <44AB0948.9070606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 04:07:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxwnT-0003YW-6u
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 04:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWGECHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 22:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWGECHH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 22:07:07 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53675 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932447AbWGECHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 22:07:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060705020705.JYVV12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 22:07:05 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23335>

This is "for concepts" only -- it still seems to have bugs
somewhere to break other tests, although it passes your new
tests.
-- >8 --
This removes the "contaminate the well even more" approach
taken in the current merge-base postprosessing code.  Instead,
when there are more than one merge-base results, we compute the
merge-base between them and see if one is a fast-forward of the
other, in which case the ancestor is removed from the result.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This is on top of Johannes/Rene's merge-base work (in "next").

 commit.c |  279 ++++++++++++++++++++------------------------------------------
 1 files changed, 89 insertions(+), 190 deletions(-)

diff --git a/commit.c b/commit.c
index c6bf10d..1bd6dca 100644
--- a/commit.c
+++ b/commit.c
@@ -854,6 +854,7 @@ void sort_in_topological_order_fn(struct
 #define PARENT1		(1u<< 8)
 #define PARENT2		(1u<< 9)
 #define STALE		(1u<<10)
+#define RESULT		(1u<<11)
 
 static struct commit *interesting(struct commit_list *list)
 {
@@ -867,183 +868,42 @@ static struct commit *interesting(struct
 	return NULL;
 }
 
-/*
- * A pathological example of how this thing works.
- *
- * Suppose we had this commit graph, where chronologically
- * the timestamp on the commit are A <= B <= C <= D <= E <= F
- * and we are trying to figure out the merge base for E and F
- * commits.
- *
- *                  F
- *                 / \
- *            E   A   D
- *             \ /   /
- *              B   /
- *               \ /
- *                C
- *
- * First we push E and F to list to be processed.  E gets bit 1
- * and F gets bit 2.  The list becomes:
- *
- *     list=F(2) E(1), result=empty
- *
- * Then we pop F, the newest commit, from the list.  Its flag is 2.
- * We scan its parents, mark them reachable from the side that F is
- * reachable from, and push them to the list:
- *
- *     list=E(1) D(2) A(2), result=empty
- *
- * Next pop E and do the same.
- *
- *     list=D(2) B(1) A(2), result=empty
- *
- * Next pop D and do the same.
- *
- *     list=C(2) B(1) A(2), result=empty
- *
- * Next pop C and do the same.
- *
- *     list=B(1) A(2), result=empty
- *
- * Now it is B's turn.  We mark its parent, C, reachable from B's side,
- * and push it to the list:
- *
- *     list=C(3) A(2), result=empty
- *
- * Now pop C and notice it has flags==3.  It is placed on the result list,
- * and the list now contains:
- *
- *     list=A(2), result=C(3)
- *
- * We pop A and do the same.
- *
- *     list=B(3), result=C(3)
- *
- * Next, we pop B and something very interesting happens.  It has flags==3
- * so it is also placed on the result list, and its parents are marked
- * stale, retroactively, and placed back on the list:
- *
- *    list=C(7), result=C(7) B(3)
- *
- * Now, list does not have any interesting commit.  So we find the newest
- * commit from the result list that is not marked stale.  Which is
- * commit B.
- *
- *
- * Another pathological example how this thing used to fail to mark an
- * ancestor of a merge base as STALE before we introduced the
- * postprocessing phase (mark_reachable_commits).
- *
- *		  2
- *		  H
- *	    1    / \
- *	    G   A   \
- *	    |\ /     \
- *	    | B       \
- *	    |  \       \
- *	     \  C       F
- *	      \  \     /
- *	       \  D   /
- *		\ |  /
- *		 \| /
- *		  E
- *
- *	 list			A B C D E F G H
- *	 G1 H2			- - - - - - 1 2
- *	 H2 E1 B1		- 1 - - 1 - 1 2
- *	 F2 E1 B1 A2		2 1 - - 1 2 1 2
- *	 E3 B1 A2		2 1 - - 3 2 1 2
- *	 B1 A2			2 1 - - 3 2 1 2
- *	 C1 A2			2 1 1 - 3 2 1 2
- *	 D1 A2			2 1 1 1 3 2 1 2
- *	 A2			2 1 1 1 3 2 1 2
- *	 B3			2 3 1 1 3 2 1 2
- *	 C7			2 3 7 1 3 2 1 2
- *
- * At this point, unfortunately, everybody in the list is
- * stale, so we fail to complete the following two
- * steps to fully marking stale commits.
- *
- *	 D7			2 3 7 7 3 2 1 2
- *	 E7			2 3 7 7 7 2 1 2
- *
- * and we ended up showing E as an interesting merge base.
- * The postprocessing phase re-injects C and continues traversal
- * to contaminate D and E.
- */
-
-static void mark_reachable_commits(struct commit_list *result,
-				   struct commit_list *list)
-{
-	struct commit_list *tmp;
-
-	/*
-	 * Postprocess to fully contaminate the well.
-	 */
-	for (tmp = result; tmp; tmp = tmp->next) {
-		struct commit *c = tmp->item;
-		/* Reinject stale ones to list,
-		 * so we can scan their parents.
-		 */
-		if (c->object.flags & STALE)
-			commit_list_insert(c, &list);
-	}
-	while (list) {
-		struct commit *c = list->item;
-		struct commit_list *parents;
-
-		tmp = list;
-		list = list->next;
-		free(tmp);
-
-		/* Anything taken out of the list is stale, so
-		 * mark all its parents stale.  We do not
-		 * parse new ones (we already parsed all the relevant
-		 * ones).
-		 */
-		parents = c->parents;
-		while (parents) {
-			struct commit *p = parents->item;
-			parents = parents->next;
-			if (!(p->object.flags & STALE)) {
-				p->object.flags |= STALE;
-				commit_list_insert(p, &list);
-			}
-		}
-	}
-}
-
-struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2,
-                                    int cleanup)
+static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
-	struct commit_list *tmp = NULL;
 
-	if (rev1 == rev2)
-		return commit_list_insert(rev1, &result);
+	if (one == two)
+		/* We do not mark this even with RESULT so we do not
+		 * have to clean it up.
+		 */
+		return commit_list_insert(one, &result);
 
-	parse_commit(rev1);
-	parse_commit(rev2);
+	parse_commit(one);
+	parse_commit(two);
 
-	rev1->object.flags |= PARENT1;
-	rev2->object.flags |= PARENT2;
-	insert_by_date(rev1, &list);
-	insert_by_date(rev2, &list);
+	one->object.flags |= PARENT1;
+	two->object.flags |= PARENT2;
+	insert_by_date(one, &list);
+	insert_by_date(two, &list);
 
 	while (interesting(list)) {
-		struct commit *commit = list->item;
+		struct commit *commit;
 		struct commit_list *parents;
-		int flags = commit->object.flags
-			& (PARENT1 | PARENT2 | STALE);
+		struct commit_list *n;
+		int flags;
 
-		tmp = list;
-		list = list->next;
-		free(tmp);
-		if (flags == (PARENT1 | PARENT2)) {
-			insert_by_date(commit, &result);
+		commit = list->item;
+		n = list->next;
+		free(list);
+		list = n;
 
+		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
+		if (flags == (PARENT1 | PARENT2)) {
+			if (!(commit->object.flags & RESULT)) {
+				commit->object.flags |= RESULT;
+				insert_by_date(commit, &result);
+			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
 		}
@@ -1059,35 +919,74 @@ struct commit_list *get_merge_bases(stru
 		}
 	}
 
-	if (!result)
-		goto finish;
-
-	if (result->next && list)
-		mark_reachable_commits(result, list);
+	/* Clean up the result to remove stale ones */
+	list = result; result = NULL;
+	while (list) {
+		struct commit_list *n = list->next;
+		if (!(list->item->object.flags & STALE))
+			insert_by_date(list->item, &result);
+		free(list);
+		list = n;
+	}
+	return result;
+}
 
-	/* cull duplicates */
-	for (tmp = result, list = NULL; tmp; ) {
-		struct commit *commit = tmp->item;
-		struct commit_list *next = tmp->next;
-		if (commit->object.flags & STALE) {
-			if (list != NULL)
-				list->next = next;
-			free(tmp);
-		} else {
-			if (list == NULL)
-				result = tmp;
-			list = tmp;
-			commit->object.flags |= STALE;
+struct commit_list *get_merge_bases(struct commit *one,
+				    struct commit *two,
+                                    int cleanup)
+{
+	struct commit_list *result = merge_bases(one, two);
+	struct commit_list *list;
+	struct commit **rslt;
+	unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
+	int cnt, i, j;
+
+	if (one == two)
+		return result;
+	if (!result || !result->next) {
+		if (cleanup) {
+			clear_commit_marks(one, all_flags);
+			clear_commit_marks(two, all_flags);
 		}
-
-		tmp = next;
+		return result;
 	}
 
- finish:
-	if (cleanup) {
-		clear_commit_marks(rev1, PARENT1 | PARENT2 | STALE);
-		clear_commit_marks(rev2, PARENT1 | PARENT2 | STALE);
+	/* There are more than one */
+	cnt = 0;
+	list = result;
+	while (list) {
+		list = list->next;
+		cnt++;
+	}
+	rslt = xcalloc(cnt, sizeof(*rslt));
+	for (list = result, i = 0; list; list = list->next)
+		rslt[i] = list->item;
+	free_commit_list(result);
+
+	clear_commit_marks(one, all_flags);
+	clear_commit_marks(two, all_flags);
+	for (i = 0; i < cnt - 1; i++) {
+		for (j = i+1; j < cnt; j++) {
+			if (!rslt[i] || !rslt[j])
+				continue;
+			result = merge_bases(rslt[i], rslt[j]);
+			clear_commit_marks(rslt[i], all_flags);
+			clear_commit_marks(rslt[j], all_flags);
+			for (list = result; list; list = list->next) {
+				if (rslt[i] == list->item)
+					rslt[i] = NULL;
+				if (rslt[j] == list->item)
+					rslt[j] = NULL;
+			}
+		}
 	}
 
+	/* Surviving ones in rslt[] are the independent results */
+	result = NULL;
+	for (i = 0; i < cnt; i++) {
+		if (rslt[i])
+			insert_by_date(rslt[i], &result);
+	}
+	free(rslt);
 	return result;
 }
-- 
1.4.1.g7993
