From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/6] Swap order of insert_by_date arguments
Date: Wed, 06 Jul 2005 17:51:14 +1000
Message-ID: <20050706075114.3970.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 10:00:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq4p7-0005K5-Vq
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 10:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVGFH72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 03:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVGFH72
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 03:59:28 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:25731 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262166AbVGFHvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 03:51:21 -0400
Received: (qmail 3980 invoked by uid 500); 6 Jul 2005 07:51:14 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Swap the order of insert_by_date arguments so that it
matches the order of commit_list_insert.

This patch anticipates a future change which will call the
function via a pointer.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 commit.c   |    8 ++++----
 commit.h   |    6 +++++-
 epoch.c    |    4 ++--
 rev-list.c |    2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

486d4dee9772a59b955574951e8d4946b75cf9fa
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -147,7 +147,7 @@ void free_commit_list(struct commit_list
 	}
 }
 
-void insert_by_date(struct commit_list **list, struct commit *item)
+struct commit_list * insert_by_date(struct commit *item, struct commit_list **list)
 {
 	struct commit_list **pp = list;
 	struct commit_list *p;
@@ -157,7 +157,7 @@ void insert_by_date(struct commit_list *
 		}
 		pp = &p->next;
 	}
-	commit_list_insert(item, pp);
+	return commit_list_insert(item, pp);
 }
 
 	
@@ -165,7 +165,7 @@ void sort_by_date(struct commit_list **l
 {
 	struct commit_list *ret = NULL;
 	while (*list) {
-		insert_by_date(&ret, (*list)->item);
+		insert_by_date((*list)->item, &ret);
 		*list = (*list)->next;
 	}
 	*list = ret;
@@ -186,7 +186,7 @@ struct commit *pop_most_recent_commit(st
 		parse_commit(commit);
 		if (!(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
-			insert_by_date(list, commit);
+			insert_by_date(commit, list);
 		}
 		parents = parents->next;
 	}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -44,7 +44,11 @@ enum cmit_fmt {
 extern enum cmit_fmt get_commit_format(const char *arg);
 extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const char *msg, unsigned long len, char *buf, unsigned long space);
 
-void insert_by_date(struct commit_list **list, struct commit *item);
+/*
+ * Inserts item into the list specified in most recent commit date first order.
+ * A pointer to the most recently inserted item is returned.
+ */
+struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -255,11 +255,11 @@ static int find_base_for_list(struct com
 
 				if (!parent_node) {
 					parent_node = new_mass_counter(parent, &distribution);
-					insert_by_date(&pending, parent);
+					insert_by_date(parent, &pending);
 					commit_list_insert(parent, &cleaner);
 				} else {
 					if (!compare(&parent_node->pending, get_zero()))
-						insert_by_date(&pending, parent);
+						insert_by_date(parent, &pending);
 					add(&parent_node->pending, &parent_node->pending, &distribution);
 				}
 			}
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -483,7 +483,7 @@ int main(int argc, char **argv)
 		if (!commit)
 			continue;
 		if (!merge_order) 
-			insert_by_date(&list, commit);
+			insert_by_date(commit, &list);
 		else 
 			commit_list_insert(commit, &list);
 	}
------------
