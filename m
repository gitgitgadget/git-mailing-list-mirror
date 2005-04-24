From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/5] Add some functions for commit lists
Date: Sat, 23 Apr 2005 20:07:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232003490.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:02:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUa4-0006bk-Q7
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVDXAHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVDXAHT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:07:19 -0400
Received: from iabervon.org ([66.92.72.58]:60678 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262192AbVDXAHB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:07:01 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPUeT-00085Z-00; Sat, 23 Apr 2005 20:07:09 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds a function for inserting an item in a commit list, a function
for sorting a commit list by date, and a function for progressively
scanning a commit history from most recent to least recent.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: commit.c
===================================================================
--- 329aca984ad6d06eb6d2dffae3933f00ccb8df5a/commit.c  (mode:100644 sha1:9f0668eb68cec56a738a58fe930ae0ae2960e2b2)
+++ e09a6d73a7c6c7a8bfb7e7003a34a507ed97a3b6/commit.c  (mode:100644 sha1:911f6435a74b93f6d25c6852d1814fa8dbaf626e)
@@ -63,12 +63,9 @@
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	while (!memcmp(bufptr, "parent ", 7) &&
 	       !get_sha1_hex(bufptr + 7, parent)) {
-		struct commit_list *new_parent = 
-			malloc(sizeof(struct commit_list));
-		new_parent->next = item->parents;
-		new_parent->item = lookup_commit(parent);
-		add_ref(&item->object, &new_parent->item->object);
-		item->parents = new_parent;
+		struct commit *new_parent = lookup_commit(parent);
+		commit_list_insert(new_parent, &item->parents);
+		add_ref(&item->object, &new_parent->object);
 		bufptr += 48;
 	}
 	item->date = parse_commit_date(bufptr);
@@ -76,6 +73,14 @@
 	return 0;
 }
 
+void commit_list_insert(struct commit *item, struct commit_list **list_p)
+{
+	struct commit_list *new_list = malloc(sizeof(struct commit_list));
+	new_list->item = item;
+	new_list->next = *list_p;
+	*list_p = new_list;
+}
+
 void free_commit_list(struct commit_list *list)
 {
 	while (list) {
@@ -84,3 +89,44 @@
 		free(temp);
 	}
 }
+
+static void insert_by_date(struct commit_list **list, struct commit *item)
+{
+	struct commit_list **pp = list;
+	struct commit_list *p;
+	while ((p = *pp) != NULL) {
+		if (p->item->date < item->date) {
+			break;
+		}
+		pp = &p->next;
+	}
+	commit_list_insert(item, pp);
+}
+
+	
+void sort_by_date(struct commit_list **list)
+{
+	struct commit_list *ret = NULL;
+	while (*list) {
+		insert_by_date(&ret, (*list)->item);
+		*list = (*list)->next;
+	}
+	*list = ret;
+}
+
+struct commit *pop_most_recent_commit(struct commit_list **list)
+{
+	struct commit *ret = (*list)->item;
+	struct commit_list *parents = ret->parents;
+	struct commit_list *old = *list;
+
+	*list = (*list)->next;
+	free(old);
+
+	while (parents) {
+		parse_commit(parents->item);
+		insert_by_date(list, parents->item);
+		parents = parents->next;
+	}
+	return ret;
+}
Index: commit.h
===================================================================
--- 329aca984ad6d06eb6d2dffae3933f00ccb8df5a/commit.h  (mode:100644 sha1:4afd27b1095cf9f9203c96db2b9f2b0bba5063d8)
+++ e09a6d73a7c6c7a8bfb7e7003a34a507ed97a3b6/commit.h  (mode:100644 sha1:c8684d1cd07d7c9ed0af06a3f3d9e7b49fbed0a2)
@@ -22,6 +22,15 @@
 
 int parse_commit(struct commit *item);
 
+void commit_list_insert(struct commit *item, struct commit_list **list_p);
+
 void free_commit_list(struct commit_list *list);
 
+void sort_by_date(struct commit_list **list);
+
+/** Removes the first commit from a list sorted by date, and adds all
+ * of its parents.
+ **/
+struct commit *pop_most_recent_commit(struct commit_list **list);
+
 #endif /* COMMIT_H */

