From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] move get_merge_bases() to core lib; use it in merge-recursive
Date: Thu, 29 Jun 2006 15:17:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291517010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060627223249.GA8177@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 15:17:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvwOo-0007U9-6T
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 15:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWF2NRf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 09:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWF2NRf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 09:17:35 -0400
Received: from mail.gmx.de ([213.165.64.21]:45744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750704AbWF2NRe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 09:17:34 -0400
Received: (qmail invoked by alias); 29 Jun 2006 13:17:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 29 Jun 2006 15:17:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060627223249.GA8177@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22861>


most of this patch is just a "sub-file rename", i.e. moving code
literally (sue me, SCO!) from merge-base.c to commit.c.

---
 commit.c          |  240 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h          |    2 
 merge-base.c      |  238 -----------------------------------------------------
 merge-recursive.c |   23 ++---
 4 files changed, 250 insertions(+), 253 deletions(-)

diff --git a/commit.c b/commit.c
index 946615d..891c6d0 100644
--- a/commit.c
+++ b/commit.c
@@ -842,3 +842,243 @@ void sort_in_topological_order_fn(struct
 	}
 	free(nodes);
 }
+
+/* merge-rebase stuff */
+
+#define PARENT1 1
+#define PARENT2 2
+#define UNINTERESTING 4
+
+static struct commit *interesting(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+		list = list->next;
+		if (commit->object.flags & UNINTERESTING)
+			continue;
+		return commit;
+	}
+	return NULL;
+}
+
+/*
+ * A pathological example of how this thing works.
+ *
+ * Suppose we had this commit graph, where chronologically
+ * the timestamp on the commit are A <= B <= C <= D <= E <= F
+ * and we are trying to figure out the merge base for E and F
+ * commits.
+ *
+ *                  F
+ *                 / \
+ *            E   A   D
+ *             \ /   /  
+ *              B   /
+ *               \ /
+ *                C
+ *
+ * First we push E and F to list to be processed.  E gets bit 1
+ * and F gets bit 2.  The list becomes:
+ *
+ *     list=F(2) E(1), result=empty
+ *
+ * Then we pop F, the newest commit, from the list.  Its flag is 2.
+ * We scan its parents, mark them reachable from the side that F is
+ * reachable from, and push them to the list:
+ *
+ *     list=E(1) D(2) A(2), result=empty
+ *
+ * Next pop E and do the same.
+ *
+ *     list=D(2) B(1) A(2), result=empty
+ *
+ * Next pop D and do the same.
+ *
+ *     list=C(2) B(1) A(2), result=empty
+ *
+ * Next pop C and do the same.
+ *
+ *     list=B(1) A(2), result=empty
+ *
+ * Now it is B's turn.  We mark its parent, C, reachable from B's side,
+ * and push it to the list:
+ *
+ *     list=C(3) A(2), result=empty
+ *
+ * Now pop C and notice it has flags==3.  It is placed on the result list,
+ * and the list now contains:
+ *
+ *     list=A(2), result=C(3)
+ *
+ * We pop A and do the same.
+ * 
+ *     list=B(3), result=C(3)
+ *
+ * Next, we pop B and something very interesting happens.  It has flags==3
+ * so it is also placed on the result list, and its parents are marked
+ * uninteresting, retroactively, and placed back on the list:
+ *
+ *    list=C(7), result=C(7) B(3)
+ * 
+ * Now, list does not have any interesting commit.  So we find the newest
+ * commit from the result list that is not marked uninteresting.  Which is
+ * commit B.
+ *
+ *
+ * Another pathological example how this thing used to fail to mark an
+ * ancestor of a merge base as UNINTERESTING before we introduced the
+ * postprocessing phase (mark_reachable_commits).
+ *
+ *		  2
+ *		  H
+ *	    1    / \
+ *	    G   A   \
+ *	    |\ /     \ 
+ *	    | B       \
+ *	    |  \       \
+ *	     \  C       F
+ *	      \  \     / 
+ *	       \  D   /   
+ *		\ |  /
+ *		 \| /
+ *		  E
+ *
+ *	 list			A B C D E F G H
+ *	 G1 H2			- - - - - - 1 2
+ *	 H2 E1 B1		- 1 - - 1 - 1 2
+ *	 F2 E1 B1 A2		2 1 - - 1 2 1 2
+ *	 E3 B1 A2		2 1 - - 3 2 1 2
+ *	 B1 A2			2 1 - - 3 2 1 2
+ *	 C1 A2			2 1 1 - 3 2 1 2
+ *	 D1 A2			2 1 1 1 3 2 1 2
+ *	 A2			2 1 1 1 3 2 1 2
+ *	 B3			2 3 1 1 3 2 1 2
+ *	 C7			2 3 7 1 3 2 1 2
+ *
+ * At this point, unfortunately, everybody in the list is
+ * uninteresting, so we fail to complete the following two
+ * steps to fully marking uninteresting commits.
+ *
+ *	 D7			2 3 7 7 3 2 1 2
+ *	 E7			2 3 7 7 7 2 1 2
+ *
+ * and we ended up showing E as an interesting merge base.
+ * The postprocessing phase re-injects C and continues traversal
+ * to contaminate D and E.
+ */
+
+static void mark_reachable_commits(struct commit_list *result,
+				   struct commit_list *list)
+{
+	struct commit_list *tmp;
+
+	/*
+	 * Postprocess to fully contaminate the well.
+	 */
+	for (tmp = result; tmp; tmp = tmp->next) {
+		struct commit *c = tmp->item;
+		/* Reinject uninteresting ones to list,
+		 * so we can scan their parents.
+		 */
+		if (c->object.flags & UNINTERESTING)
+			commit_list_insert(c, &list);
+	}
+	while (list) {
+		struct commit *c = list->item;
+		struct commit_list *parents;
+
+		tmp = list;
+		list = list->next;
+		free(tmp);
+
+		/* Anything taken out of the list is uninteresting, so
+		 * mark all its parents uninteresting.  We do not
+		 * parse new ones (we already parsed all the relevant
+		 * ones).
+		 */
+		parents = c->parents;
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			if (!(p->object.flags & UNINTERESTING)) {
+				p->object.flags |= UNINTERESTING;
+				commit_list_insert(p, &list);
+			}
+		}
+	}
+}
+
+struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2)
+{
+	struct commit_list *list = NULL;
+	struct commit_list *result = NULL;
+	struct commit_list *tmp = NULL;
+
+	if (rev1 == rev2)
+		return commit_list_insert(rev1, &result);
+
+	parse_commit(rev1);
+	parse_commit(rev2);
+
+	rev1->object.flags |= PARENT1;
+	rev2->object.flags |= PARENT2;
+	insert_by_date(rev1, &list);
+	insert_by_date(rev2, &list);
+
+	while (interesting(list)) {
+		struct commit *commit = list->item;
+		struct commit_list *parents;
+		int flags = commit->object.flags
+			& (PARENT1 | PARENT2 | UNINTERESTING);
+
+		tmp = list;
+		list = list->next;
+		free(tmp);
+		if (flags == (PARENT1 | PARENT2)) {
+			insert_by_date(commit, &result);
+
+			/* Mark parents of a found merge uninteresting */
+			flags |= UNINTERESTING;
+		}
+		parents = commit->parents;
+		while (parents) {
+			struct commit *p = parents->item;
+			parents = parents->next;
+			if ((p->object.flags & flags) == flags)
+				continue;
+			parse_commit(p);
+			p->object.flags |= flags;
+			insert_by_date(p, &list);
+		}
+	}
+
+	if (!result)
+		return NULL;
+
+	if (result->next && list)
+		mark_reachable_commits(result, list);
+
+	/* cull duplicates */
+	for (tmp = result, list = NULL; tmp; ) {
+		struct commit *commit = tmp->item;
+		struct commit_list *next = tmp->next;
+		if (commit->object.flags & UNINTERESTING) {
+			if (list != NULL)
+				list->next = next;
+			free(tmp);
+		} else {
+			if (list == NULL)
+				result = tmp;
+			list = tmp;
+			commit->object.flags |= UNINTERESTING;
+		}
+
+		tmp = next;
+	}
+
+	/* reset flags */
+	clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
+	clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
+
+	return result;
+}
diff --git a/commit.h b/commit.h
index 7c9ca3f..89b9dad 100644
--- a/commit.h
+++ b/commit.h
@@ -105,4 +105,6 @@ struct commit_graft *read_graft_line(cha
 int register_commit_graft(struct commit_graft *, int);
 int read_graft_file(const char *graft_file);
 
+extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
+
 #endif /* COMMIT_H */
diff --git a/merge-base.c b/merge-base.c
index 7d87c20..b41f76c 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -2,244 +2,6 @@ #include <stdlib.h>
 #include "cache.h"
 #include "commit.h"
 
-#define PARENT1 1
-#define PARENT2 2
-#define UNINTERESTING 4
-
-static struct commit *interesting(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		list = list->next;
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		return commit;
-	}
-	return NULL;
-}
-
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
- * uninteresting, retroactively, and placed back on the list:
- *
- *    list=C(7), result=C(7) B(3)
- * 
- * Now, list does not have any interesting commit.  So we find the newest
- * commit from the result list that is not marked uninteresting.  Which is
- * commit B.
- *
- *
- * Another pathological example how this thing used to fail to mark an
- * ancestor of a merge base as UNINTERESTING before we introduced the
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
- * uninteresting, so we fail to complete the following two
- * steps to fully marking uninteresting commits.
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
-		/* Reinject uninteresting ones to list,
-		 * so we can scan their parents.
-		 */
-		if (c->object.flags & UNINTERESTING)
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
-		/* Anything taken out of the list is uninteresting, so
-		 * mark all its parents uninteresting.  We do not
-		 * parse new ones (we already parsed all the relevant
-		 * ones).
-		 */
-		parents = c->parents;
-		while (parents) {
-			struct commit *p = parents->item;
-			parents = parents->next;
-			if (!(p->object.flags & UNINTERESTING)) {
-				p->object.flags |= UNINTERESTING;
-				commit_list_insert(p, &list);
-			}
-		}
-	}
-}
-
-struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2)
-{
-	struct commit_list *list = NULL;
-	struct commit_list *result = NULL;
-	struct commit_list *tmp = NULL;
-
-	if (rev1 == rev2)
-		return commit_list_insert(rev1, &result);
-
-	parse_commit(rev1);
-	parse_commit(rev2);
-
-	rev1->object.flags |= PARENT1;
-	rev2->object.flags |= PARENT2;
-	insert_by_date(rev1, &list);
-	insert_by_date(rev2, &list);
-
-	while (interesting(list)) {
-		struct commit *commit = list->item;
-		struct commit_list *parents;
-		int flags = commit->object.flags
-			& (PARENT1 | PARENT2 | UNINTERESTING);
-
-		tmp = list;
-		list = list->next;
-		free(tmp);
-		if (flags == (PARENT1 | PARENT2)) {
-			insert_by_date(commit, &result);
-
-			/* Mark parents of a found merge uninteresting */
-			flags |= UNINTERESTING;
-		}
-		parents = commit->parents;
-		while (parents) {
-			struct commit *p = parents->item;
-			parents = parents->next;
-			if ((p->object.flags & flags) == flags)
-				continue;
-			parse_commit(p);
-			p->object.flags |= flags;
-			insert_by_date(p, &list);
-		}
-	}
-
-	if (!result)
-		return NULL;
-
-	if (result->next && list)
-		mark_reachable_commits(result, list);
-
-	/* cull duplicates */
-	for (tmp = result, list = NULL; tmp; ) {
-		struct commit *commit = tmp->item;
-		struct commit_list *next = tmp->next;
-		if (commit->object.flags & UNINTERESTING) {
-			if (list != NULL)
-				list->next = next;
-			free(tmp);
-		} else {
-			if (list == NULL)
-				result = tmp;
-			list = tmp;
-			commit->object.flags |= UNINTERESTING;
-		}
-
-		tmp = next;
-	}
-
-	/* reset flags */
-	clear_commit_marks(rev1, PARENT1 | PARENT2 | UNINTERESTING);
-	clear_commit_marks(rev2, PARENT1 | PARENT2 | UNINTERESTING);
-
-	return result;
-}
-
 static int show_all = 0;
 
 static int merge_base(struct commit *rev1, struct commit *rev2)
diff --git a/merge-recursive.c b/merge-recursive.c
index 9bbb426..c0de38a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -186,22 +186,15 @@ struct merge_result merge(struct node *h
 		node_list_insert(ancestor, &ca);
 	else {
 		struct node_list **pca = &ca;
-		char cmd[100];
-		sprintf(cmd, "git-merge-base --all %s %s",
-			node_hex_sha1(h1),
-			node_hex_sha1(h2));
-		FILE *fp = popen(cmd, "r");
-		while (!feof(fp)) {
-			unsigned char sha1[20];
-			int ch;
-			if (fget_sha1(sha1, fp, &ch) == 0) {
-				struct node *n;
-				n = node_alloc(lookup_commit(sha1));
-				node_list_insert(n, pca);
-				pca = &(*pca)->next;
-			}
+		struct commit_list *iter, *merge_bases
+			= get_merge_bases(h1->commit, h2->commit);
+
+		for (iter = merge_bases; iter; iter = iter->next) {
+			struct node *n = node_alloc(iter->item);
+			node_list_insert(n, pca);
+			pca = &(*pca)->next;
 		}
-		pclose(fp);
+		free_commit_list(merge_bases);
 	}
 
 	output("found %u common ancestor(s):", node_list_count(ca));
-- 
1.4.1.rc1.g87c00-dirty
