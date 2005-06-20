From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 5/7] Prevent git-rev-list --merge-order producing duplicates in the output
Date: Mon, 20 Jun 2005 12:29:36 +1000
Message-ID: <20050620022936.28620.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:26:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBz7-0006tv-Ak
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFTCbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFTCbk
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:31:40 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:19843 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261404AbVFTC3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:38 -0400
Received: (qmail 28630 invoked by uid 500); 20 Jun 2005 02:29:36 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


If a is reachable from b, then git-rev-list --merge-order b a would
produce a duplicate output of b.

This causes a problem for an upcoming version of gitk since it
breaks the --merge-order ordering invariant.

This patch fixes the problem for the --merge-order switch. A subsequent
patch will fix the problem for the non --merge-order switch.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -621,20 +621,27 @@ int sort_list_in_merge_order(struct comm
 			base->object.flags |= BOUNDARY;
 
 		while (reversed) {
-			sort_first_epoch(pop_commit(&reversed), &stack);
-			if (reversed) {
-				/*
-				 * If we have more commits to push, then the
-				 * first push for the next parent may (or may
-				 * not) represent a discontinuity with respect
-				 * to the parent currently on the top of
-				 * the stack.
-				 *
-				 * Mark it for checking here, and check it
-				 * with the next push. See sort_first_epoch()
-				 * for more details.
-				 */
-				stack->item->object.flags |= DISCONTINUITY;
+			struct commit * next = pop_commit(&reversed);
+
+			if (!(next->object.flags & VISITED)) {
+				sort_first_epoch(next, &stack);
+				if (reversed) {
+					/*
+					 * If we have more commits 
+					 * to push, then the first
+					 * push for the next parent may 
+					 * (or may * not) represent a 
+					 * discontinuity with respect
+					 * to the parent currently on 
+					 * the top of the stack.
+					 *
+					 * Mark it for checking here, 
+					 * and check it with the next 
+					 * push. See sort_first_epoch()
+					 * for more details.
+					 */
+					stack->item->object.flags |= DISCONTINUITY;
+				}
 			}
 		}
 
------------
