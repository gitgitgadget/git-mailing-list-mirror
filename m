From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/3] Make it possible to not clobber object.util in sort_in_topological_order (take 2)
Date: Fri, 10 Mar 2006 10:21:37 +0100
Message-ID: <20060310092137.24015.45112.stgit@c165>
References: <20060310092135.24015.26510.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 10 10:22:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHdog-00041E-7s
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 10:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWCJJVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 04:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWCJJVo
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 04:21:44 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:61829 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751408AbWCJJVn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 04:21:43 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 61F244103; Fri, 10 Mar 2006 10:37:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FHdoX-0006Fj-00; Fri, 10 Mar 2006 10:21:37 +0100
To: git@vger.kernel.org
In-Reply-To: <20060310092135.24015.26510.stgit@c165>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17464>




Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 commit.c |   30 ++++++++++++++++++++++++------
 commit.h |   16 +++++++++++++++-
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 06d5439..013683a 100644
--- a/commit.c
+++ b/commit.c
@@ -569,11 +569,29 @@ int count_parents(struct commit * commit
         return count;
 }
 
+void topo_sort_default_setter(struct commit *c, void *data)
+{
+	c->object.util = data;
+}
+
+void *topo_sort_default_getter(struct commit *c)
+{
+	return c->object.util;
+}
+
 /*
  * Performs an in-place topological sort on the list supplied.
  */
 void sort_in_topological_order(struct commit_list ** list, int lifo)
 {
+	sort_in_topological_order_fn(list, lifo, topo_sort_default_setter,
+				     topo_sort_default_getter);
+}
+
+void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
+				  topo_sort_set_fn_t setter,
+				  topo_sort_get_fn_t getter)
+{
 	struct commit_list * next = *list;
 	struct commit_list * work = NULL, **insert;
 	struct commit_list ** pptr = list;
@@ -596,7 +614,7 @@ void sort_in_topological_order(struct co
 	next=*list;
 	while (next) {
 		next_nodes->list_item = next;
-		next->item->object.util = next_nodes;
+		setter(next->item, next_nodes);
 		next_nodes++;
 		next = next->next;
 	}
@@ -606,7 +624,7 @@ void sort_in_topological_order(struct co
 		struct commit_list * parents = next->item->parents;
 		while (parents) {
 			struct commit * parent=parents->item;
-			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			struct sort_node * pn = (struct sort_node *) getter(parent);
 			
 			if (pn)
 				pn->indegree++;
@@ -624,7 +642,7 @@ void sort_in_topological_order(struct co
 	next=*list;
 	insert = &work;
 	while (next) {
-		struct sort_node * node = (struct sort_node *)next->item->object.util;
+		struct sort_node * node = (struct sort_node *) getter(next->item);
 
 		if (node->indegree == 0) {
 			insert = &commit_list_insert(next->item, insert)->next;
@@ -637,12 +655,12 @@ void sort_in_topological_order(struct co
 		sort_by_date(&work);
 	while (work) {
 		struct commit * work_item = pop_commit(&work);
-		struct sort_node * work_node = (struct sort_node *)work_item->object.util;
+		struct sort_node * work_node = (struct sort_node *) getter(work_item);
 		struct commit_list * parents = work_item->parents;
 
 		while (parents) {
 			struct commit * parent=parents->item;
-			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			struct sort_node * pn = (struct sort_node *) getter(parent);
 			
 			if (pn) {
 				/* 
@@ -667,7 +685,7 @@ void sort_in_topological_order(struct co
 		*pptr = work_node->list_item;
 		pptr = &(*pptr)->next;
 		*pptr = NULL;
-		work_item->object.util = NULL;
+		setter(work_item, NULL);
 	}
 	free(nodes);
 }
diff --git a/commit.h b/commit.h
index 70a7c75..15c798a 100644
--- a/commit.h
+++ b/commit.h
@@ -65,15 +65,29 @@ int count_parents(struct commit * commit
 /*
  * Performs an in-place topological sort of list supplied.
  *
- * Pre-conditions:
+ * Pre-conditions for sort_in_topological_order:
  *   all commits in input list and all parents of those
  *   commits must have object.util == NULL
  *        
+ * Pre-conditions for sort_in_topological_order_fn:
+ *   all commits in input list and all parents of those
+ *   commits must have getter(commit) == NULL
+ *
  * Post-conditions: 
  *   invariant of resulting list is:
  *      a reachable from b => ord(b) < ord(a)
  *   in addition, when lifo == 0, commits on parallel tracks are
  *   sorted in the dates order.
  */
+
+typedef void (*topo_sort_set_fn_t)(struct commit*, void *data);
+typedef void* (*topo_sort_get_fn_t)(struct commit*);
+
+void topo_sort_default_setter(struct commit *c, void *data);
+void *topo_sort_default_getter(struct commit *c);
+
 void sort_in_topological_order(struct commit_list ** list, int lifo);
+void sort_in_topological_order_fn(struct commit_list ** list, int lifo,
+				  topo_sort_set_fn_t setter,
+				  topo_sort_get_fn_t getter);
 #endif /* COMMIT_H */
