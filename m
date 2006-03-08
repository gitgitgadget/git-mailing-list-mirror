From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/3] Make it possible to not clobber object.util in sort_in_topological_order
Date: Wed, 8 Mar 2006 23:59:05 +0100
Message-ID: <20060308225905.GB461@c165.ib.student.liu.se>
References: <20060308225412.GA461@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 08 23:59:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH7cd-0006pk-AE
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 23:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWCHW7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 17:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWCHW7I
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 17:59:08 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:43394 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1030239AbWCHW7G
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 17:59:06 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id DADCA40FF; Thu,  9 Mar 2006 00:14:37 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FH7cX-00008a-00; Wed, 08 Mar 2006 23:59:05 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060308225412.GA461@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17389>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 commit.c |   27 +++++++++++++++++++++------
 commit.h |    9 +++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 06d5439..2552ffd 100644
--- a/commit.c
+++ b/commit.c
@@ -569,11 +569,26 @@ int count_parents(struct commit * commit
         return count;
 }
 
+void default_setter(struct commit* c, void* data)
+{
+	c->object.util = data;
+}
+
+void* default_getter(struct commit* c)
+{
+	return c->object.util;
+}
+
 /*
  * Performs an in-place topological sort on the list supplied.
  */
 void sort_in_topological_order(struct commit_list ** list, int lifo)
 {
+	sort_in_topological_order_fun(list, lifo, default_setter, default_getter);
+}
+
+void sort_in_topological_order_fun(struct commit_list ** list, int lifo, set_fn_t setter, get_fn_t getter)
+{
 	struct commit_list * next = *list;
 	struct commit_list * work = NULL, **insert;
 	struct commit_list ** pptr = list;
@@ -596,7 +611,7 @@ void sort_in_topological_order(struct co
 	next=*list;
 	while (next) {
 		next_nodes->list_item = next;
-		next->item->object.util = next_nodes;
+		setter(next->item, next_nodes);
 		next_nodes++;
 		next = next->next;
 	}
@@ -606,7 +621,7 @@ void sort_in_topological_order(struct co
 		struct commit_list * parents = next->item->parents;
 		while (parents) {
 			struct commit * parent=parents->item;
-			struct sort_node * pn = (struct sort_node *)parent->object.util;
+			struct sort_node * pn = (struct sort_node *) getter(parent);
 			
 			if (pn)
 				pn->indegree++;
@@ -624,7 +639,7 @@ void sort_in_topological_order(struct co
 	next=*list;
 	insert = &work;
 	while (next) {
-		struct sort_node * node = (struct sort_node *)next->item->object.util;
+		struct sort_node * node = (struct sort_node *) getter(next->item);
 
 		if (node->indegree == 0) {
 			insert = &commit_list_insert(next->item, insert)->next;
@@ -637,12 +652,12 @@ void sort_in_topological_order(struct co
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
@@ -667,7 +682,7 @@ void sort_in_topological_order(struct co
 		*pptr = work_node->list_item;
 		pptr = &(*pptr)->next;
 		*pptr = NULL;
-		work_item->object.util = NULL;
+		setter(work_item, NULL);
 	}
 	free(nodes);
 }
diff --git a/commit.h b/commit.h
index 70a7c75..0be61eb 100644
--- a/commit.h
+++ b/commit.h
@@ -76,4 +76,13 @@ int count_parents(struct commit * commit
  *   sorted in the dates order.
  */
 void sort_in_topological_order(struct commit_list ** list, int lifo);
+
+typedef void (*set_fn_t)(struct commit*, void* data);
+typedef void* (*get_fn_t)(struct commit*);
+
+void default_setter(struct commit* c, void* data);
+void* default_getter(struct commit* c);
+
+void sort_in_topological_order(struct commit_list ** list, int lifo);
+void sort_in_topological_order_fun(struct commit_list ** list, int lifo, set_fn_t, get_fn_t);
 #endif /* COMMIT_H */
