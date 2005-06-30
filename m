From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Add a topological sort procedure to commit.c [rev 2]
Date: Thu, 30 Jun 2005 17:21:28 +1000
Message-ID: <20050630072128.25225.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 09:14:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DntFj-0005BH-Fp
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 09:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVF3HVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 03:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVF3HVp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 03:21:45 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:35713 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262301AbVF3HVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 03:21:32 -0400
Received: (qmail 25235 invoked by uid 500); 30 Jun 2005 07:21:28 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch introduces an in-place topological sort procedure to commit.c

Given a list of commits, sort_in_topological_order() will perform an in-place
topological sort of that list.

The invariant that applies to the resulting list is:

	a reachable from b => ord(b) < ord(a)

This invariant is weaker than the --merge-order invariant, but is cheaper
to calculate (assuming the list has been identified) and will serve any
purpose where only a minimal topological order guarantee is required.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Note: this patch currently has no observable consequences since nothing
in this patch calls it. A future patch will use this algorithm to provide
an O(n) bisection algorithm as a suggested replacement for the
existing O(n^2) bisection algorithm.

[rev2] 
   * incorporates Junio's questions/comments as commentary, 
   * adds object.util save/restore functionality so that no
     assumption is made about the pre-existing state of object.util 
     upon entry to the procedure.
---

 commit.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h |    5 +++
 2 files changed, 122 insertions(+), 0 deletions(-)

2e031457909e59ac00c3520206256b75a6e08062
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -3,6 +3,27 @@
 #include "commit.h"
 #include "cache.h"
 
+struct sort_node
+{
+	/*
+         * the number of children of the associated commit
+         * that also occur in the list being sorted.
+         */
+	unsigned int indegree;
+
+	/*
+         * reference to original list item that we will re-use
+         * on output.
+         */
+	struct commit_list * list_item;
+
+	/*
+         * copy of original object.util pointer that is saved
+         * during the topological sort.
+         */
+	void * save_util;
+};
+
 const char *commit_type = "commit";
 
 enum cmit_fmt get_commit_format(const char *arg)
@@ -346,3 +367,99 @@ int count_parents(struct commit * commit
         return count;
 }
 
+/*
+ * Performs an in-place topological sort on the list supplied
+ * 
+ * Invariant of resulting list is:
+ *        a reachable from b => ord(b) < ord(a)
+ */
+void sort_in_topological_order(struct commit_list ** list)
+{
+	struct commit_list * next = *list;
+	struct commit_list * work = NULL;
+	struct commit_list ** pptr = list;
+	struct sort_node * nodes;
+	struct sort_node * next_nodes;
+	int count = 0;
+
+	/* determine the size of the list */
+	while (next) {
+		next = next->next;
+		count++;
+	}
+	/* allocate an array to help sort the list */
+	nodes = xcalloc(count, sizeof(*nodes));
+	/* link the list to the array */
+	next_nodes = nodes;
+	next=*list;
+	while (next) {
+		next_nodes->list_item = next;
+		next_nodes->save_util = next->item->object.util;
+		next->item->object.util = next_nodes;
+		next_nodes++;
+		next = next->next;
+	}
+	/* update the indegree */
+	next=*list;
+	while (next) {
+		struct commit_list * parents = next->item->parents;
+		while (parents) {
+			struct commit * parent=parents->item;
+			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			
+			if (pn)
+				pn->indegree++;
+			parents=parents->next;
+		}
+		next=next->next;
+	}
+	/* 
+         * find the tips
+         *
+         * tips are nodes not reachable from any other node in the list 
+         * 
+         * the tips serve as a starting set for the work queue.
+         */
+	next=*list;
+	while (next) {
+		struct sort_node * node = (struct sort_node *)next->item->object.util;
+
+		if (node->indegree == 0) {
+			commit_list_insert(next->item, &work);
+		}
+		next=next->next;
+	}
+	/* process the list in topological order */
+	while (work) {
+		struct commit * work_item = pop_commit(&work);
+		struct sort_node * work_node = (struct sort_node *)work_item->object.util;
+		struct commit_list * parents = work_item->parents;
+
+		while (parents) {
+			struct commit * parent=parents->item;
+			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			
+			if (pn) {
+				/* 
+				 * parents are only enqueed for emission 
+                                 * when all their children have been emitted thereby
+                                 * guaranteeing topological order.
+                                 */
+				pn->indegree--;
+				if (!pn->indegree) 
+					commit_list_insert(parent, &work);
+			}
+			parents=parents->next;
+		}
+		/*
+                 * work_item is a commit all of whose children
+                 * have already been emitted. we can emit it now
+                 * and restore its util pointer.
+                 */
+		*pptr = work_node->list_item;
+		pptr = &(*pptr)->next;
+		*pptr = NULL;
+		work_item->object.util = work_node->save_util;
+	}
+	free(nodes);
+}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -55,4 +55,9 @@ struct commit *pop_most_recent_commit(st
 struct commit *pop_commit(struct commit_list **stack);
 
 int count_parents(struct commit * commit);
+
+/*
+ * Performs an in-place topological sort of list supplied.
+ */
+void sort_in_topological_order(struct commit_list ** list);
 #endif /* COMMIT_H */
------------
