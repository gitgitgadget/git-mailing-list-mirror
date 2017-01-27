Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27BF31F437
	for <e@80x24.org>; Fri, 27 Jan 2017 22:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbdA0WGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 17:06:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:46101 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbdA0WFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 17:05:49 -0500
Received: (qmail 500 invoked by uid 109); 27 Jan 2017 22:05:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 22:05:38 +0000
Received: (qmail 17606 invoked by uid 111); 27 Jan 2017 22:05:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:05:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 17:05:36 -0500
Date:   Fri, 27 Jan 2017 17:05:36 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] pack-objects: convert recursion to iteration in
 break_delta_chain()
Message-ID: <20170127220536.7ndkryakx6xh4vid@sigill.intra.peff.net>
References: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The break_delta_chain() function is recursive over the depth
of a given delta chain, which can lead to possibly running
out of stack space. Normally delta depth is quite small, but
if there _is_ a pathological case, this is where we would
find and fix it, so we should be more careful.

We can do it without recursion at all, but there's a little
bit of cleverness needed to do so. It's easiest to explain
by covering the less-clever strategies first.

The obvious thing to try is just keeping our own stack on
the heap. Whenever we would recurse, push the new entry onto
the stack and loop instead. But this gets tricky; when we
see an ACTIVE entry, we need to care if we just pushed it
(in which case it's a cycle) or if we just popped it (in
which case we dealt with its bases, and no we need to clear
the ACTIVE flag and compute its depth).

You can hack around that in various ways, like keeping a
"just pushed" flag, but the logic gets muddled. However, we
can observe that we do all of our pushes first, and then all
of our pops afterwards. In other words, we can do this in
two passes. First dig down to the base, stopping when we see
a cycle, and pushing each item onto our stack.  Then pop the
stack elements, clearing the ACTIVE flag and computing the
depth for each.

This works, and is reasonably elegant. However, why do we
need the stack for the second pass? We can just walk the
delta pointers again. There's one complication. Popping the
stack went over our list in reverse, so we could compute the
depth of each entry by incrementing the depth of its base,
which we will have just computed.  To go forward in the
second pass, we have to compute the total depth on the way
down, and then assign it as we go.

This patch implements this final strategy, because it not
only keeps the memory off the stack, but it eliminates it
entirely. Credit for the cleverness in that approach goes to
Michael Haggerty; bugs are mine.

Signed-off-by: Jeff King <peff@peff.net>
---
The diff is nearly impossible to read, so I'd recommend just looking at
the end result. I tried to document the tricky parts with comments.
There are a few parts that could be made more terse, but I screwed it up
so many times while writing it that I decided to do it in a way that
carefully documents all of the assumptions.

 builtin/pack-objects.c | 129 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 99 insertions(+), 30 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2b08c8121..c7af47548 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1579,48 +1579,117 @@ static void drop_reused_delta(struct object_entry *entry)
  */
 static void break_delta_chains(struct object_entry *entry)
 {
-	/* If it's not a delta, it can't be part of a cycle. */
-	if (!entry->delta) {
-		entry->dfs_state = DFS_DONE;
-		return;
-	}
+	/*
+	 * The actual depth of each object we will write is stored as an int,
+	 * as it cannot exceed our int "depth" limit. But before we break
+	 * changes based no that limit, we may potentially go as deep as the
+	 * number of objects, which is elsewhere bounded to a uint32_t.
+	 */
+	uint32_t total_depth;
+	struct object_entry *cur, *next;
+
+	for (cur = entry, total_depth = 0;
+	     cur;
+	     cur = cur->delta, total_depth++) {
+		if (cur->dfs_state == DFS_DONE) {
+			/*
+			 * We've already seen this object and know it isn't
+			 * part of a cycle. We do need to append its depth
+			 * to our count.
+			 */
+			total_depth += cur->depth;
+			break;
+		}
 
-	switch (entry->dfs_state) {
-	case DFS_NONE:
 		/*
-		 * This is the first time we've seen the object. We mark it as
-		 * part of the active potential cycle and recurse.
+		 * We break cycles before looping, so an ACTIVE state (or any
+		 * other cruft which made its way into the state variable)
+		 * is a bug.
 		 */
-		entry->dfs_state = DFS_ACTIVE;
-		break_delta_chains(entry->delta);
+		if (cur->dfs_state != DFS_NONE)
+			die("BUG: confusing delta dfs state in first pass: %d",
+			    cur->dfs_state);
 
 		/*
-		 * Once we've recursed, our base (if we still have one) knows
-		 * its depth, so we can compute ours (and check it against
-		 * the limit).
+		 * Now we know this is the first time we've seen the object. If
+		 * it's not a delta, we're done traversing, but we'll mark it
+		 * done to save time on future traversals.
 		 */
-		if (entry->delta) {
-			entry->depth = entry->delta->depth + 1;
-			if (entry->depth > depth)
-				drop_reused_delta(entry);
+		if (!cur->delta) {
+			cur->dfs_state = DFS_DONE;
+			break;
 		}
 
-		entry->dfs_state = DFS_DONE;
-		break;
+		/*
+		 * Mark ourselves as active and see if the next step causes
+		 * us to cycle to another active object. It's important to do
+		 * this _before_ we loop, because it impacts where we make the
+		 * cut, and thus how our total_depth counter works.
+		 * E.g., We may see a partial loop like:
+		 *
+		 *   A -> B -> C -> D -> B
+		 *
+		 * Cutting B->C breaks the cycle. But now the depth of A is
+		 * only 1, and our total_depth counter is at 3. The size of the
+		 * error is always one less than the size of the cycle we
+		 * broke. Commits C and D were "lost" from A's chain.
+		 *
+		 * If we instead cut D->B, then the depth of A is correct at 3.
+		 * We keep all commits in the chain that we examined.
+		 */
+		cur->dfs_state = DFS_ACTIVE;
+		if (cur->delta->dfs_state == DFS_ACTIVE) {
+			drop_reused_delta(cur);
+			cur->dfs_state = DFS_DONE;
+			break;
+		}
+	}
 
-	case DFS_DONE:
-		/* object already examined, and not part of a cycle */
-		break;
+	/*
+	 * And now that we've gone all the way to the bottom of the chain, we
+	 * need to clear the active flags and set the depth fields as
+	 * appropriate. Unlike the loop above, which can quit when it drops a
+	 * delta, we need to keep going to look for more depth cuts. So we need
+	 * an extra "next" pointer to keep going after we reset cur->delta.
+	 */
+	for (cur = entry; cur; cur = next) {
+		next = cur->delta;
 
-	case DFS_ACTIVE:
 		/*
-		 * We found a cycle that needs broken. It would be correct to
-		 * break any link in the chain, but it's convenient to
-		 * break this one.
+		 * We should have a chain of zero or more ACTIVE states down to
+		 * a final DONE. We can quit after the DONE, because either it
+		 * has no bases, or we've already handled them in a previous
+		 * call.
 		 */
-		drop_reused_delta(entry);
-		entry->dfs_state = DFS_DONE;
-		break;
+		if (cur->dfs_state == DFS_DONE)
+			break;
+		else if (cur->dfs_state != DFS_ACTIVE)
+			die("BUG: confusing delta dfs state in second pass: %d",
+			    cur->dfs_state);
+
+		/*
+		 * If the total_depth is more than depth, then we need to snip
+		 * the chain into two or more smaller chains that don't exceed
+		 * the maximum depth. Most of the resulting chains will contain
+		 * (depth + 1) entries (i.e., depth deltas plus one base), and
+		 * the last chain (i.e., the one containing entry) will contain
+		 * whatever entries are left over, namely
+		 * (total_depth % (depth + 1)) of them.
+		 *
+		 * Since we are iterating towards decreasing depth, we need to
+		 * decrement total_depth as we go, and we need to write to the
+		 * entry what its final depth will be after all of the
+		 * snipping. Since we're snipping into chains of length (depth
+		 * + 1) entries, the final depth of an entry will be its
+		 * original depth modulo (depth + 1). Any time we encounter an
+		 * entry whose final depth is supposed to be zero, we snip it
+		 * from its delta base, thereby making it so.
+		 */
+		cur->depth = (total_depth--) % (depth + 1);
+		if (!cur->depth)
+			drop_reused_delta(cur);
+
+		cur->dfs_state = DFS_DONE;
 	}
 }
 
-- 
2.11.0.914.gb3b960f50
