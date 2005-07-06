From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 8/13] Fix handling of duplicates by topological order.
Date: Thu, 07 Jul 2005 02:39:34 +1000
Message-ID: <20050706163934.9947.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 18:49:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqD4X-0006I3-Ku
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 18:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVGFQsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVGFQsK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 12:48:10 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:21377 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262356AbVGFQjr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 12:39:47 -0400
Received: (qmail 9957 invoked by uid 500); 6 Jul 2005 16:39:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


	git-rev-list --topo-order HEAD HEAD

caused a segmentation violation.

This has now been fixed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 commit.c   |   15 +++++++++++----
 commit.h   |    3 +++
 epoch.h    |   13 ++++++-------
 rev-list.c |    8 ++++----
 4 files changed, 24 insertions(+), 15 deletions(-)

60a355172fdf6583465e1c237a3e82af64065332
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -374,11 +374,17 @@ void sort_in_topological_order(struct co
 	struct sort_node * next_nodes;
 	int count = 0;
 
-	/* determine the size of the list */
-	while (next) {
-		next = next->next;
-		count++;
+	/* determine the size of the list and elide duplicates */
+	while (*pptr) {
+		next=*pptr;
+		if (!(next->item->object.flags & DUPCHECK)) {
+			count++;
+			next->item->object.flags |= DUPCHECK;
+			pptr=&next->next;
+		} else
+			*pptr=next->next;
 	}
+	pptr=list;
 	/* allocate an array to help sort the list */
 	nodes = xcalloc(count, sizeof(*nodes));
 	/* link the list to the array */
@@ -387,6 +393,7 @@ void sort_in_topological_order(struct co
 	while (next) {
 		next_nodes->list_item = next;
 		next->item->object.util = next_nodes;
+		next->item->object.flags &= ~DUPCHECK;
 		next_nodes++;
 		next = next->next;
 	}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -4,6 +4,9 @@
 #include "object.h"
 #include "tree.h"
 
+#define DUPCHECK (1u<<0)
+#define LAST_COMMIT_FLAG (DUPCHECK)
+
 struct commit_list {
 	struct commit *item;
 	struct commit_list *next;
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -1,6 +1,6 @@
 #ifndef EPOCH_H
 #define EPOCH_H
-
+#include "commit.h"
 
 // return codes for emitter_func
 #define STOP     0
@@ -10,12 +10,11 @@ typedef int (*emitter_func) (struct comm
 
 int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
 
-#define UNINTERESTING   (1u<<2)
-#define BOUNDARY        (1u<<3)
-#define VISITED         (1u<<4)
-#define DISCONTINUITY   (1u<<5)
-#define DUPCHECK        (1u<<6)
-#define LAST_EPOCH_FLAG (1u<<6)
+#define UNINTERESTING   (LAST_COMMIT_FLAG<<1)
+#define BOUNDARY        (LAST_COMMIT_FLAG<<2)
+#define VISITED         (LAST_COMMIT_FLAG<<3)
+#define DISCONTINUITY   (LAST_COMMIT_FLAG<<4)
+#define LAST_EPOCH_FLAG (LAST_COMMIT_FLAG<<4)
 
 
 #endif	/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -5,10 +5,10 @@
 #include "blob.h"
 #include "epoch.h"
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
-#define COUNTED		(1u << 2)
-#define SHOWN		(LAST_EPOCH_FLAG << 2)
+#define SEEN        (LAST_EPOCH_FLAG << 1)
+#define INTERESTING (LAST_EPOCH_FLAG << 2)
+#define COUNTED     (LAST_EPOCH_FLAG << 3)
+#define SHOWN       (LAST_EPOCH_FLAG << 4)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
------------
