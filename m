From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Simplification - remove unnecessary list reversal from epoch.c
Date: Thu, 07 Jul 2005 12:27:14 +1000
Message-ID: <20050707022714.31167.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 04:29:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqM8h-0005Rj-Ck
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 04:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVGGC2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 22:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVGGC2v
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 22:28:51 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:13443 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261438AbVGGC1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 22:27:17 -0400
Received: (qmail 31177 invoked by uid 500); 7 Jul 2005 02:27:14 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Since --merge-order is the only thing that cares about the rev-list
parse order, change the rev-list list to match the parse order
and remove the corresponding compensating reversal from epoch.c.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
[PATCH] Move SEEN flag into epoch.h, replace use of VISITED flag with SEEN flag
---

 epoch.c    |   26 ++++++++++++--------------
 rev-list.c |    3 ++-
 2 files changed, 14 insertions(+), 15 deletions(-)

198b131890a2c6fc98ce4c151dc20bd4f548acf0
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -580,37 +580,35 @@ int sort_list_in_merge_order(struct comm
 	struct commit *base;
 	int ret = 0;
 	int action = CONTINUE;
-	struct commit_list *reversed = NULL;
+	struct commit_list *next = NULL;
 
-	for (; list; list = list->next) {
-		list->item->object.flags &= ~(SEEN|BOUNDARY|DISCONTINUITY);
-		commit_list_insert(list->item, &reversed);
-	}
+	for (next=list; next; next = next->next)
+		next->item->object.flags &= ~(SEEN|BOUNDARY|DISCONTINUITY);
 
-	if (!reversed)
+	if (!list)
 		return ret;
-	else if (!reversed->next) {
+	else if (!list->next) {
 		/*
 		 * If there is only one element in the list, we can sort it
 		 * using sort_in_merge_order.
 		 */
-		base = reversed->item;
+		base = list->item;
 	} else {
 		/*
 		 * Otherwise, we search for the base of the list.
 		 */
-		ret = find_base_for_list(reversed, &base);
+		ret = find_base_for_list(list, &base);
 		if (ret)
 			return ret;
 		if (base)
 			base->object.flags |= BOUNDARY;
 
-		while (reversed) {
-			struct commit * next = pop_commit(&reversed);
+		for (next=list; next; next=next->next) {
+			struct commit * next_item = next->item;
 
-			if (!(next->object.flags & SEEN) && next!=base) {
-				sort_first_epoch(next, &stack);
-				if (reversed) {
+			if (!(next_item->object.flags & SEEN) && next_item!=base) {
+				sort_first_epoch(next_item, &stack);
+				if (next) {
 					/*
 					 * If we have more commits 
 					 * to push, then the first
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -407,6 +407,7 @@ static struct commit *get_commit_referen
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
+	struct commit_list **list_tail = &list;
 	int i, limited = 0;
 
 	for (i = 1 ; i < argc; i++) {
@@ -484,7 +485,7 @@ int main(int argc, char **argv)
 		if (commit->object.flags & SEEN)
 			continue;
 		commit->object.flags |= SEEN;
-		commit_list_insert(commit, &list);
+		list_tail = &commit_list_insert(commit, list_tail)->next;
 	}
 
 	if (!merge_order) {		
------------
