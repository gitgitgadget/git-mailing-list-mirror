From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/1] Fix --merge-order unit test breaks introduced by 6c88be169881c9223532796bd225e79afaa115e1
Date: Wed, 22 Jun 2005 01:58:46 +1000
Message-ID: <20050621155846.5380.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 21 17:57:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkl7r-0003ua-LX
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 17:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVFUQC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 12:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVFUQC6
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 12:02:58 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:47489 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262169AbVFUP6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2005 11:58:53 -0400
Received: (qmail 5391 invoked by uid 500); 21 Jun 2005 15:58:46 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The sensible cleanup of the in-memory storage order of commit parents broke the --merge-order
code which was dependent on the previous behaviour of parse_commit().

This patch restores the correctness --merge-order behaviour by taking account of the
new behaviour of parse_commit.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Tested on Linus HEAD: 0795495388d703dc84110a9a7917dd6ec9516bb4.
---

 epoch.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -424,19 +424,10 @@ static void mark_ancestors_uninteresting
 static void sort_first_epoch(struct commit *head, struct commit_list **stack)
 {
 	struct commit_list *parents;
-	struct commit_list *reversed_parents = NULL;
 
 	head->object.flags |= VISITED;
 
 	/*
-	 * parse_commit() builds the parent list in reverse order with respect
-	 * to the order of the git-commit-tree arguments. So we need to reverse
-	 * this list to output the oldest (or most "local") commits last.
-	 */
-	for (parents = head->parents; parents; parents = parents->next)
-		commit_list_insert(parents->item, &reversed_parents);
-
-	/*
 	 * TODO: By sorting the parents in a different order, we can alter the
 	 * merge order to show contemporaneous changes in parallel branches
 	 * occurring after "local" changes. This is useful for a developer
@@ -445,8 +436,8 @@ static void sort_first_epoch(struct comm
 	 * changes.
 	 */
 
-	while (reversed_parents) {
-		struct commit *parent = pop_commit(&reversed_parents);
+	for (parents = head->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
 
 		if (head->object.flags & UNINTERESTING) {
 			/*
@@ -470,7 +461,7 @@ static void sort_first_epoch(struct comm
 
 			} else {
 				sort_first_epoch(parent, stack);
-				if (reversed_parents) {
+				if (parents) {
 					/*
 					 * This indicates a possible
 					 * discontinuity it may not be be
------------
