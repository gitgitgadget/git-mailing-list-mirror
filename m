From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Move SEEN flag into epoch.h, replace use of VISITED flag with SEEN flag
Date: Thu, 07 Jul 2005 12:11:20 +1000
Message-ID: <20050707021120.20027.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 04:18:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqLxZ-0004XQ-0Y
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 04:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVGGCOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 22:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVGGCNE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 22:13:04 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:15746 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262412AbVGGCLX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 22:11:23 -0400
Received: (qmail 20037 invoked by uid 500); 7 Jul 2005 02:11:20 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


SEEN and VISITED do the same thing.

This change moves the SEEN flag into epoch.h, then replaces
uses of VISITED with SEEN and removes the definition
of the VISITED flag.

The merge-order code needs to clear the SEEN flag
set by the argument parsing to ensure correct
operation. So it clears that one and, for completeness,
BOUNDARY and DISCONTINUITY too.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c    |   14 ++++++++------
 epoch.h    |    4 +---
 rev-list.c |    5 ++---
 3 files changed, 11 insertions(+), 12 deletions(-)

54a391ba7e4f96ce08ecb7da82941519b8a14c30
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -387,7 +387,7 @@ static void push_onto_merge_order_stack(
 static void mark_ancestors_uninteresting(struct commit *commit)
 {
 	unsigned int flags = commit->object.flags;
-	int visited = flags & VISITED;
+	int visited = flags & SEEN;
 	int boundary = flags & BOUNDARY;
 	int uninteresting = flags & UNINTERESTING;
 	struct commit_list *next;
@@ -425,7 +425,7 @@ static void sort_first_epoch(struct comm
 {
 	struct commit_list *parents;
 
-	head->object.flags |= VISITED;
+	head->object.flags |= SEEN;
 
 	/*
 	 * TODO: By sorting the parents in a different order, we can alter the
@@ -450,14 +450,14 @@ static void sort_first_epoch(struct comm
 			mark_ancestors_uninteresting(parent);
 		}
 
-		if (!(parent->object.flags & VISITED)) {
+		if (!(parent->object.flags & SEEN)) {
 			if (parent->object.flags & BOUNDARY) {
 				if (*stack) {
 					die("something else is on the stack - %s",
 					    sha1_to_hex((*stack)->item->object.sha1));
 				}
 				push_onto_merge_order_stack(stack, parent);
-				parent->object.flags |= VISITED;
+				parent->object.flags |= SEEN;
 
 			} else {
 				sort_first_epoch(parent, stack);
@@ -582,8 +582,10 @@ int sort_list_in_merge_order(struct comm
 	int action = CONTINUE;
 	struct commit_list *reversed = NULL;
 
-	for (; list; list = list->next)
+	for (; list; list = list->next) {
+		list->item->object.flags &= ~(SEEN|BOUNDARY|DISCONTINUITY);
 		commit_list_insert(list->item, &reversed);
+	}
 
 	if (!reversed)
 		return ret;
@@ -606,7 +608,7 @@ int sort_list_in_merge_order(struct comm
 		while (reversed) {
 			struct commit * next = pop_commit(&reversed);
 
-			if (!(next->object.flags & VISITED) && next!=base) {
+			if (!(next->object.flags & SEEN) && next!=base) {
 				sort_first_epoch(next, &stack);
 				if (reversed) {
 					/*
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -13,9 +13,7 @@ int sort_list_in_merge_order(struct comm
 /* Low bits are used by rev-list */
 #define UNINTERESTING   (1u<<10)
 #define BOUNDARY        (1u<<11)
-#define VISITED         (1u<<12)
+#define SEEN            (1u<<12)
 #define DISCONTINUITY   (1u<<13)
-#define LAST_EPOCH_FLAG (1u<<14)
-
 
 #endif	/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -5,9 +5,8 @@
 #include "blob.h"
 #include "epoch.h"
 
-#define SEEN		(1u << 0)
-#define INTERESTING	(1u << 1)
-#define COUNTED		(1u << 2)
+#define INTERESTING	(1u << 0)
+#define COUNTED		(1u << 1)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
------------
