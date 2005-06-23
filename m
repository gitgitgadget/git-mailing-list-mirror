From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] Fix to how --merge-order handles multiple roots
Date: Thu, 23 Jun 2005 12:01:12 +1000
Message-ID: <20050623020112.16423.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Jun 23 03:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlGzI-0004t6-RP
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 03:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVFWCDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 22:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVFWCDb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 22:03:31 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:52608 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261994AbVFWCBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 22:01:15 -0400
Received: (qmail 16433 invoked by uid 500); 23 Jun 2005 02:01:12 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch addresses the problem reported by Paul Mackerras such that --merge-order
did not report the last root of a graph with merge of two independent roots.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -488,7 +488,7 @@ static void sort_first_epoch(struct comm
  *
  * Sets the return value to STOP if no further output should be generated.
  */
-static int emit_stack(struct commit_list **stack, emitter_func emitter)
+static int emit_stack(struct commit_list **stack, emitter_func emitter, int include_last)
 {
 	unsigned int seen = 0;
 	int action = CONTINUE;
@@ -496,8 +496,11 @@ static int emit_stack(struct commit_list
 	while (*stack && (action != STOP)) {
 		struct commit *next = pop_commit(stack);
 		seen |= next->object.flags;
-		if (*stack)
+		if (*stack || include_last) {
+			if (!*stack) 
+				next->object.flags |= BOUNDARY;
 			action = (*emitter) (next);
+		}
 	}
 
 	if (*stack) {
@@ -553,7 +556,7 @@ static int sort_in_merge_order(struct co
 		} else {
 			struct commit_list *stack = NULL;
 			sort_first_epoch(next, &stack);
-			action = emit_stack(&stack, emitter);
+			action = emit_stack(&stack, emitter, (base == NULL));
 			next = base;
 		}
 	}
@@ -636,7 +639,7 @@ int sort_list_in_merge_order(struct comm
 			}
 		}
 
-		action = emit_stack(&stack, emitter);
+		action = emit_stack(&stack, emitter, (base==NULL));
 	}
 
 	if (base && (action != STOP)) {
------------
