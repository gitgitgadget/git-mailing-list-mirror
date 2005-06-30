From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] Add a topological sort procedure to commit.c
Date: Thu, 30 Jun 2005 15:58:21 +1000
Message-ID: <20050630055821.1329.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 30 07:53:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnrzT-0004VY-Bv
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 07:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVF3GAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 02:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVF3F7d
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 01:59:33 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:30080 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262858AbVF3F61 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 01:58:27 -0400
Received: (qmail 1340 invoked by uid 500); 30 Jun 2005 05:58:21 -0000
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
---

 commit.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit.h |    5 ++++
 2 files changed, 87 insertions(+), 0 deletions(-)

9beb76a20443b8d5ee6010bf0bd55344e5b39546
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -3,6 +3,12 @@
 #include "commit.h"
 #include "cache.h"
 
+struct sort_node
+{
+	unsigned int indegree;
+	struct commit_list * list_item;
+};
+
 const char *commit_type = "commit";
 
 enum cmit_fmt get_commit_format(const char *arg)
@@ -346,3 +352,79 @@ int count_parents(struct commit * commit
         return count;
 }
 
+/*
+ * Performs an in-place topological sort on the list supplied
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
+	nodes = xmalloc(sizeof(*nodes) * count);
+	/* link the list to the array */
+	next_nodes = nodes;
+	next=*list;
+	while (next) {
+		next_nodes->list_item = next;
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
+	/* find the roots */
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
+				pn->indegree--;
+				if (!pn->indegree) 
+					commit_list_insert(parent, &work);
+			}
+			parents=parents->next;
+		}
+		*pptr = work_node->list_item;
+		work_node->list_item->next = NULL;
+		pptr = &(*pptr)->next;
+		work_item->object.util = NULL;
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
