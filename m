From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 1/2] Simplify topo-sort logic
Date: Fri, 2 Nov 2007 13:32:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0711021331420.3342@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org> 
 <18212.13862.637991.30536@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org> 
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com> 
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> 
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:33:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3Cw-00025L-Ne
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXKBUdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbXKBUdU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:33:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43549 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802AbXKBUdT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 16:33:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2KWwfw028758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Nov 2007 13:32:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA2KWwp7009758;
	Fri, 2 Nov 2007 13:32:58 -0700
In-Reply-To: <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
X-Spam-Status: No, hits=-5.63 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_64,J_CHICKENPOX_75,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63172>


.. by not using quite so much indirection.

This currently grows the "struct commit" a bit, which could be avoided by 
using a union for "util" and "indegree" (the topo-sort used to use "util" 
anyway, so you cannot use them together), but for now the goal of this was 
to simplify, not optimize.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 commit.c   |  150 +++++++++++++++++++++---------------------------------------
 commit.h   |   20 +--------
 revision.c |    7 +--
 revision.h |    4 +-
 4 files changed, 55 insertions(+), 126 deletions(-)

diff --git a/commit.c b/commit.c
index ac24266..c155a49 100644
--- a/commit.c
+++ b/commit.c
@@ -9,22 +9,6 @@
 
 int save_commit_buffer = 1;
 
-struct sort_node
-{
-	/*
-	 * the number of children of the associated commit
-	 * that also occur in the list being sorted.
-	 */
-	unsigned int indegree;
-
-	/*
-	 * reference to original list item that we will re-use
-	 * on output.
-	 */
-	struct commit_list * list_item;
-
-};
-
 const char *commit_type = "commit";
 
 static struct cmt_fmt_map {
@@ -1150,69 +1134,38 @@ struct commit *pop_commit(struct commit_list **stack)
 	return item;
 }
 
-void topo_sort_default_setter(struct commit *c, void *data)
-{
-	c->util = data;
-}
-
-void *topo_sort_default_getter(struct commit *c)
-{
-	return c->util;
-}
-
 /*
  * Performs an in-place topological sort on the list supplied.
  */
 void sort_in_topological_order(struct commit_list ** list, int lifo)
 {
-	sort_in_topological_order_fn(list, lifo, topo_sort_default_setter,
-				     topo_sort_default_getter);
-}
-
-void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
-				  topo_sort_set_fn_t setter,
-				  topo_sort_get_fn_t getter)
-{
-	struct commit_list * next = *list;
-	struct commit_list * work = NULL, **insert;
-	struct commit_list ** pptr = list;
-	struct sort_node * nodes;
-	struct sort_node * next_nodes;
-	int count = 0;
-
-	/* determine the size of the list */
-	while (next) {
-		next = next->next;
-		count++;
-	}
+	struct commit_list *next, *orig = *list;
+	struct commit_list *work, **insert;
+	struct commit_list **pptr;
 
-	if (!count)
+	if (!orig)
 		return;
-	/* allocate an array to help sort the list */
-	nodes = xcalloc(count, sizeof(*nodes));
-	/* link the list to the array */
-	next_nodes = nodes;
-	next=*list;
-	while (next) {
-		next_nodes->list_item = next;
-		setter(next->item, next_nodes);
-		next_nodes++;
-		next = next->next;
+	*list = NULL;
+
+	/* Mark them and clear the indegree */
+	for (next = orig; next; next = next->next) {
+		struct commit *commit = next->item;
+		commit->object.flags |= TOPOSORT;
+		commit->indegree = 0;
 	}
+
 	/* update the indegree */
-	next=*list;
-	while (next) {
+	for (next = orig; next; next = next->next) {
 		struct commit_list * parents = next->item->parents;
 		while (parents) {
-			struct commit * parent=parents->item;
-			struct sort_node * pn = (struct sort_node *) getter(parent);
+			struct commit *parent = parents->item;
 
-			if (pn)
-				pn->indegree++;
-			parents=parents->next;
+			if (parent->object.flags & TOPOSORT)
+				parent->indegree++;
+			parents = parents->next;
 		}
-		next=next->next;
 	}
+
 	/*
 	 * find the tips
 	 *
@@ -1220,55 +1173,56 @@ void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
 	 *
 	 * the tips serve as a starting set for the work queue.
 	 */
-	next=*list;
+	work = NULL;
 	insert = &work;
-	while (next) {
-		struct sort_node * node = (struct sort_node *) getter(next->item);
+	for (next = orig; next; next = next->next) {
+		struct commit *commit = next->item;
 
-		if (node->indegree == 0) {
-			insert = &commit_list_insert(next->item, insert)->next;
-		}
-		next=next->next;
+		if (!commit->indegree)
+			insert = &commit_list_insert(commit, insert)->next;
 	}
 
 	/* process the list in topological order */
 	if (!lifo)
 		sort_by_date(&work);
+
+	pptr = list;
+	*list = NULL;
 	while (work) {
-		struct commit * work_item = pop_commit(&work);
-		struct sort_node * work_node = (struct sort_node *) getter(work_item);
-		struct commit_list * parents = work_item->parents;
+		struct commit *commit;
+		struct commit_list *parents, *work_item;
 
-		while (parents) {
-			struct commit * parent=parents->item;
-			struct sort_node * pn = (struct sort_node *) getter(parent);
-
-			if (pn) {
-				/*
-				 * parents are only enqueued for emission
-				 * when all their children have been emitted thereby
-				 * guaranteeing topological order.
-				 */
-				pn->indegree--;
-				if (!pn->indegree) {
-					if (!lifo)
-						insert_by_date(parent, &work);
-					else
-						commit_list_insert(parent, &work);
-				}
+		work_item = work;
+		work = work_item->next;
+		work_item->next = NULL;
+
+		commit = work_item->item;
+		for (parents = commit->parents; parents ; parents = parents->next) {
+			struct commit *parent=parents->item;
+
+			if (!(parent->object.flags & TOPOSORT))
+				continue;
+
+			/*
+			 * parents are only enqueued for emission
+			 * when all their children have been emitted thereby
+			 * guaranteeing topological order.
+			 */
+			if (!--parent->indegree) {
+				if (!lifo)
+					insert_by_date(parent, &work);
+				else
+					commit_list_insert(parent, &work);
 			}
-			parents=parents->next;
 		}
 		/*
 		 * work_item is a commit all of whose children
 		 * have already been emitted. we can emit it now.
 		 */
-		*pptr = work_node->list_item;
-		pptr = &(*pptr)->next;
-		*pptr = NULL;
-		setter(work_item, NULL);
+		commit->object.flags &= ~TOPOSORT;
+		*pptr = work_item;
+		pptr = &work_item->next;
 	}
-	free(nodes);
 }
 
 /* merge-base stuff */
diff --git a/commit.h b/commit.h
index b661503..7c71471 100644
--- a/commit.h
+++ b/commit.h
@@ -14,6 +14,7 @@ struct commit_list {
 struct commit {
 	struct object object;
 	void *util;
+	unsigned int indegree;
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
@@ -82,31 +83,12 @@ void clear_commit_marks(struct commit *commit, unsigned int mark);
 /*
  * Performs an in-place topological sort of list supplied.
  *
- * Pre-conditions for sort_in_topological_order:
- *   all commits in input list and all parents of those
- *   commits must have object.util == NULL
- *
- * Pre-conditions for sort_in_topological_order_fn:
- *   all commits in input list and all parents of those
- *   commits must have getter(commit) == NULL
- *
- * Post-conditions:
  *   invariant of resulting list is:
  *      a reachable from b => ord(b) < ord(a)
  *   in addition, when lifo == 0, commits on parallel tracks are
  *   sorted in the dates order.
  */
-
-typedef void (*topo_sort_set_fn_t)(struct commit*, void *data);
-typedef void* (*topo_sort_get_fn_t)(struct commit*);
-
-void topo_sort_default_setter(struct commit *c, void *data);
-void *topo_sort_default_getter(struct commit *c);
-
 void sort_in_topological_order(struct commit_list ** list, int lifo);
-void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
-				  topo_sort_set_fn_t setter,
-				  topo_sort_get_fn_t getter);
 
 struct commit_graft {
 	unsigned char sha1[20];
diff --git a/revision.c b/revision.c
index e76da0d..e85b4af 100644
--- a/revision.c
+++ b/revision.c
@@ -677,9 +677,6 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->prune_fn = NULL;
 	revs->prune_data = NULL;
 
-	revs->topo_setter = topo_sort_default_setter;
-	revs->topo_getter = topo_sort_default_getter;
-
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
 	diff_setup(&revs->diffopt);
@@ -1303,9 +1300,7 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (limit_list(revs) < 0)
 			return -1;
 	if (revs->topo_order)
-		sort_in_topological_order_fn(&revs->commits, revs->lifo,
-					     revs->topo_setter,
-					     revs->topo_getter);
+		sort_in_topological_order(&revs->commits, revs->lifo);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 98a0a8f..1f64576 100644
--- a/revision.h
+++ b/revision.h
@@ -10,6 +10,7 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
+#define TOPOSORT	(1u<<9)	/* In the active toposort list.. */
 
 struct rev_info;
 struct log_info;
@@ -96,9 +97,6 @@ struct rev_info {
 	struct diff_options diffopt;
 	struct diff_options pruning;
 
-	topo_sort_set_fn_t topo_setter;
-	topo_sort_get_fn_t topo_getter;
-
 	struct reflog_walk_info *reflog_info;
 };
 
