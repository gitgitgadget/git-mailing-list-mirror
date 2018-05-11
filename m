Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E8D1F406
	for <e@80x24.org>; Fri, 11 May 2018 18:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeEKSDR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:03:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:36394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751052AbeEKSDR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:03:17 -0400
Received: (qmail 16733 invoked by uid 109); 11 May 2018 18:03:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 18:03:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7957 invoked by uid 111); 11 May 2018 18:03:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 14:03:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 14:03:15 -0400
Date:   Fri, 11 May 2018 14:03:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] mark_parents_uninteresting(): avoid most allocation
Message-ID: <20180511180314.GD12543@sigill.intra.peff.net>
References: <20180511180029.GA11290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511180029.GA11290@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 941ba8db57 (Eliminate recursion in setting/clearing
marks in commit list, 2012-01-14) used a clever double-loop
to avoid allocations for single-parent chains of history.
However, it did so only when following parents of parents
(which was an uncommon case), and _always_ incurred at least
one allocation to populate the list of pending parents in
the first place.

We can turn this into zero-allocation in the common case by
iterating directly over the initial parent list, and then
following up on any pending items we might have discovered.

Signed-off-by: Jeff King <peff@peff.net>
---
Again, try "-w" for more readability.

 revision.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/revision.c b/revision.c
index 89ff9a99ce..cbe041128e 100644
--- a/revision.c
+++ b/revision.c
@@ -115,32 +115,38 @@ static void commit_stack_clear(struct commit_stack *stack)
 	stack->nr = stack->alloc = 0;
 }
 
-void mark_parents_uninteresting(struct commit *commit)
+static void mark_one_parent_uninteresting(struct commit *commit,
+					  struct commit_stack *pending)
 {
-	struct commit_stack pending = COMMIT_STACK_INIT;
 	struct commit_list *l;
 
+	if (commit->object.flags & UNINTERESTING)
+		return;
+	commit->object.flags |= UNINTERESTING;
+
+	/*
+	 * Normally we haven't parsed the parent
+	 * yet, so we won't have a parent of a parent
+	 * here. However, it may turn out that we've
+	 * reached this commit some other way (where it
+	 * wasn't uninteresting), in which case we need
+	 * to mark its parents recursively too..
+	 */
 	for (l = commit->parents; l; l = l->next)
-		commit_stack_push(&pending, l->item);
+		commit_stack_push(pending, l->item);
+}
 
-	while (pending.nr > 0) {
-		struct commit *commit = commit_stack_pop(&pending);
+void mark_parents_uninteresting(struct commit *commit)
+{
+	struct commit_stack pending = COMMIT_STACK_INIT;
+	struct commit_list *l;
 
-		if (commit->object.flags & UNINTERESTING)
-			return;
-		commit->object.flags |= UNINTERESTING;
+	for (l = commit->parents; l; l = l->next)
+		mark_one_parent_uninteresting(l->item, &pending);
 
-		/*
-		 * Normally we haven't parsed the parent
-		 * yet, so we won't have a parent of a parent
-		 * here. However, it may turn out that we've
-		 * reached this commit some other way (where it
-		 * wasn't uninteresting), in which case we need
-		 * to mark its parents recursively too..
-		 */
-		for (l = commit->parents; l; l = l->next)
-			commit_stack_push(&pending, l->item);
-	}
+	while (pending.nr > 0)
+		mark_one_parent_uninteresting(commit_stack_pop(&pending),
+					      &pending);
 
 	commit_stack_clear(&pending);
 }
-- 
2.17.0.988.gec4b43b3e5
