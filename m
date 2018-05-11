Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36941F406
	for <e@80x24.org>; Fri, 11 May 2018 18:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEKSCa (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 14:02:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:36384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751169AbeEKSC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 14:02:29 -0400
Received: (qmail 16688 invoked by uid 109); 11 May 2018 18:02:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 18:02:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7939 invoked by uid 111); 11 May 2018 18:02:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 14:02:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 14:02:27 -0400
Date:   Fri, 11 May 2018 14:02:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] mark_parents_uninteresting(): replace list with stack
Message-ID: <20180511180227.GC12543@sigill.intra.peff.net>
References: <20180511180029.GA11290@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180511180029.GA11290@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The mark_parents_uninteresting() function uses two loops:
an outer one to process our queue of pending parents, and an
inner one to process first-parent chains. This is a clever
optimization from 941ba8db57 (Eliminate recursion in
setting/clearing marks in commit list, 2012-01-14) to limit
the number of linked-list allocations when following
single-parent chains.

Unfortunately, this makes the result a little hard to read.
Let's replace the list with a stack. Then we don't have to
worry about doing this double-loop optimization, as we'll
just reuse the top element of the stack as we pop/push.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff makes a lot more sense with "-w".

 revision.c | 67 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/revision.c b/revision.c
index cee4f3a4b4..89ff9a99ce 100644
--- a/revision.c
+++ b/revision.c
@@ -92,38 +92,57 @@ void mark_tree_uninteresting(struct tree *tree)
 	mark_tree_contents_uninteresting(tree);
 }
 
-void mark_parents_uninteresting(struct commit *commit)
+struct commit_stack {
+	struct commit **items;
+	size_t nr, alloc;
+};
+#define COMMIT_STACK_INIT { NULL, 0, 0 }
+
+static void commit_stack_push(struct commit_stack *stack, struct commit *commit)
 {
-	struct commit_list *parents = NULL, *l;
+	ALLOC_GROW(stack->items, stack->nr + 1, stack->alloc);
+	stack->items[stack->nr++] = commit;
+}
 
-	for (l = commit->parents; l; l = l->next)
-		commit_list_insert(l->item, &parents);
+static struct commit *commit_stack_pop(struct commit_stack *stack)
+{
+	return stack->nr ? stack->items[--stack->nr] : NULL;
+}
 
-	while (parents) {
-		struct commit *commit = pop_commit(&parents);
+static void commit_stack_clear(struct commit_stack *stack)
+{
+	FREE_AND_NULL(stack->items);
+	stack->nr = stack->alloc = 0;
+}
 
-		while (commit) {
-			if (commit->object.flags & UNINTERESTING)
-				break;
+void mark_parents_uninteresting(struct commit *commit)
+{
+	struct commit_stack pending = COMMIT_STACK_INIT;
+	struct commit_list *l;
 
-			commit->object.flags |= UNINTERESTING;
+	for (l = commit->parents; l; l = l->next)
+		commit_stack_push(&pending, l->item);
 
-			/*
-			 * Normally we haven't parsed the parent
-			 * yet, so we won't have a parent of a parent
-			 * here. However, it may turn out that we've
-			 * reached this commit some other way (where it
-			 * wasn't uninteresting), in which case we need
-			 * to mark its parents recursively too..
-			 */
-			if (!commit->parents)
-				break;
+	while (pending.nr > 0) {
+		struct commit *commit = commit_stack_pop(&pending);
 
-			for (l = commit->parents->next; l; l = l->next)
-				commit_list_insert(l->item, &parents);
-			commit = commit->parents->item;
-		}
+		if (commit->object.flags & UNINTERESTING)
+			return;
+		commit->object.flags |= UNINTERESTING;
+
+		/*
+		 * Normally we haven't parsed the parent
+		 * yet, so we won't have a parent of a parent
+		 * here. However, it may turn out that we've
+		 * reached this commit some other way (where it
+		 * wasn't uninteresting), in which case we need
+		 * to mark its parents recursively too..
+		 */
+		for (l = commit->parents; l; l = l->next)
+			commit_stack_push(&pending, l->item);
 	}
+
+	commit_stack_clear(&pending);
 }
 
 static void add_pending_object_with_path(struct rev_info *revs,
-- 
2.17.0.988.gec4b43b3e5

