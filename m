From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 4/7] Move two general purpose commit-related functions into commit.[ch]
Date: Tue, 14 Jun 2005 12:04:40 +1000
Message-ID: <20050614020440.23311.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 14 04:03:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0lF-0006tk-Mg
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 04:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFNCHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 22:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFNCHY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 22:07:24 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:5761 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261393AbVFNCEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 22:04:43 -0400
Received: (qmail 23321 invoked by uid 500); 14 Jun 2005 02:04:40 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Moved is_parent_of and move_commit from epoch.c into commit.c

is_parent_of returns a non-zero value if the left argument
is a parent of the right argument. 

move_commit implements the slightly complicated pointer
arithmetic required to remove an element from the middle
of a singly-linked list. It is moved into commit.c
because a future change to rev-list.c will need to
use logic originally implemented in epoch.c

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 commit.c |   23 +++++++++++++++++++++++
 commit.h |   31 +++++++++++++++++++++++++++++++
 epoch.c  |   31 ++-----------------------------
 3 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -374,3 +374,26 @@ struct commit_list * copy_parents_in_hea
 	}
 	return result;
 }
+
+int is_parent_of(struct commit *parent, struct commit *child)
+{
+	struct commit_list *parents;
+
+	for (parents = child->parents; parents; parents = parents->next)
+		if (parent==parents->item)
+			return 1;
+	return 0;
+}
+
+/**
+ * pre-condition: src && dst && *src && !(*dst)
+ * post-condition: result && !(*result) && src && dst && *dst
+ */
+struct commit_list ** move_commit(struct commit_list ** dst, struct commit_list ** src)
+{
+	*dst = *src;
+	*src = (*src)->next;
+	(*dst)->next = NULL;
+	return &(*dst)->next;
+}
+
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -84,4 +84,35 @@ int copy_author(struct commit * commit, 
  * they are finished with it.
  */
 struct commit_list * copy_parents_in_header_order(struct commit * commit);
+
+/*
+ * Return a non-zero value if "commit" is a parent of "child", zero otherwise.
+ */
+int is_parent_of(struct commit *commit, struct commit *child);
+
+
+/**
+ * Move an item pointed to by *src_ptr onto the tail of a list pointed 
+ * to by dst_tail and return the updated tail pointer. *src_ptr is 
+ * updated to refer to the next element on the source list 
+ * or NULL if there is no such element.
+ *
+ * Example:
+ * 
+ * struct commit_list * src = ...;
+ * struct commit_list * dst = NULL;
+ * struct commit_list ** dst_tail = &dst;
+ * struct commit_list ** src_ptr = &src;
+ * 
+ * while (*src_ptr) {
+ *       if (is_moveable(*src_ptr)) {
+ *                dst_tail = move_commit(dst_tail, src_ptr);
+ *       else {
+ *                src_ptr=&(*src_ptr)->next;
+ *       }
+ * }
+ */
+struct commit_list ** move_commit(struct commit_list ** dst_tail, struct commit_list ** src_ptr);
+
 #endif /* COMMIT_H */
+
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -417,19 +417,6 @@ static int find_next_epoch_boundary(stru
 }
 
 /*
- * Returns non-zero if parent is known to be a parent of child.
- */
-static int is_parent_of(struct commit *parent, struct commit *child)
-{
-	struct commit_list *parents;
-
-	for (parents = child->parents; parents; parents = parents->next)
-		if (parent==parents->item)
-			return 1;
-	return 0;
-}
-
-/*
  * Marks all interesting, visited commits reachable from this commit
  * as uninteresting. We stop recursing when we reach the epoch boundary,
  * an unvisited node or a node that has already been marked uninteresting.
@@ -544,21 +531,6 @@ static struct commit_list ** copy_and_st
 	return (struct commit_list **)&commit->object.util;
 }
 
-/**
- * Move an item pointed to by *src onto the tail of a list pointed to by dst
- * and return the updated tail pointer. *src is updated to refer to the
- * next element on the source list or NULL if there is no such element.
- */
-static struct commit_list ** move(struct commit_list ** dst, struct commit_list ** src)
-{
-        ASSERT(*src, "*src is never NULL", NULL);
-	ASSERT(!*dst || !(*dst)->next, "*dst is NULL or (*dst)->next is NULL", NULL);
-	*dst = *src;
-	*src = (*src)->next;
-	(*dst)->next = NULL;
-	return &(*dst)->next;
-}
-
 /*
  * Sort a list of commits in local first order. A commit is "local" 
  * if any of its ancestors (except the base) causes (*local_test)() to 
@@ -603,7 +575,7 @@ static unsigned int sort_local_branches_
 		 * Move local items onto their own list.
                  */
 		if (IS_LOCAL(item))
-			local_tail = move(local_tail, non_local_ptr);
+			local_tail = move_commit(local_tail, non_local_ptr);
 		else
 			non_local_ptr = &(*non_local_ptr)->next;
 	}
@@ -790,3 +762,4 @@ int traverse_from_list(struct commit_lis
 		ret = traverse_from_head(base, traversal);
 	return ret;
 }
+
------------
