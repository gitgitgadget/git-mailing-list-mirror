From: Jeff King <peff@peff.net>
Subject: [PATCH] limit_list: avoid quadratic behavior from still_interesting
Date: Fri, 17 Apr 2015 18:11:04 -0400
Message-ID: <20150417221104.GA8806@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 00:11:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjETi-0000rt-F1
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 00:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbbDQWLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 18:11:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:46981 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbbDQWLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 18:11:07 -0400
Received: (qmail 22948 invoked by uid 102); 17 Apr 2015 22:11:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 17:11:07 -0500
Received: (qmail 6518 invoked by uid 107); 17 Apr 2015 22:11:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 18:11:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 18:11:04 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267395>

When we are limiting a rev-list traversal due to
UNINTERESTING refs, we have to walk down the tips (both
interesting and uninteresting) to find where they intersect.
We keep a queue of commits to examine, pop commits off
the queue one by one, and potentially add their parents.  The
size of the queue will naturally fluctuate based on the
"width" of the history graph; i.e., the number of
simultaneous lines of development. But for the most part it
will stay in the same ballpark as the initial number of tips
we fed, shrinking over time (as we hit common ancestors of
the tips). So roughly speaking, if we start with `N` tips,
we'll spend much of the time with a queue around `N` items.

For each UNINTERESTING commit we pop, we call
still_interesting to check whether marking its parents as
UNINTERESTING has made the whole queue uninteresting (in
which case we can quit early).  Because the queue is stored
as a linked list, this is `O(N)`, where `N` is the number of
items in the queue. So processing a queue with `N` commits
marked UNINTERESTING (and one or more interesting commits)
will take `O(N^2)`.

If you feed a lot of positive tips, this isn't a problem.
They aren't UNINTERESTING, so they don't incur the
still_interesting check.  It also isn't a problem if you
traverse from an interesting tip to some UNINTERESTING
bases. We order the queue by recency, so the interesting
commits stay at the front of the queue as we walk down them.
The linear check can exit early as soon as it sees one
interesting commit left in the queue.

But if you want to know whether an older commit is reachable
from a set of newer tips, we end up processing in the
opposite direction: from the UNINTERESTING ones down to the
interesting one. This may happen when we call:

  git rev-list $commits --not --all

in check_everything_connected after a fetch. If we fetched
something much older than most of our refs, and if we have a
large number of refs, the traversal cost is dominated by the
quadratic behavior.

These commands simulate the connectivity check of such a
fetch, when you have `$n` distinct refs in the receiver:

    # positive ref is 100,000 commits deep
    git rev-list --all | head -100000 | tail -1 >input

    # huge number of more recent negative refs
    git rev-list --all | head -$n | sed s/^/^/ >>input

    time git rev-list --stdin <input

Here are timings for various `n` on the linux.git
repository. The `n=1` case provides a baseline for just
walking the commits, which lets us see the still_interesting
overhead. The times marked with `+` subtract that baseline
to show just the extra time growth due to the large number
of refs. The `x` numbers show the slowdown of the adjusted
time versus the prior trial.

       n  | before                 | after
    --------------------------------------------------------
        1 | 0.991s                 | 0.848s
    10000 | 1.120s (+0.129s)       | 0.885s (+0.037s)
    20000 | 1.451s (+0.460s, 3.5x) | 0.923s (+0.075s, 2.0x)
    40000 | 2.731s (+1.740s, 3.8x) | 0.994s (+0.146s, 1.9x)
    80000 | 8.235s (+7.244s, 4.2x) | 1.123s (+0.275s, 1.9x)

Each trial doubles `n`, so you can see the quadratic (`4x`)
behavior before this patch. Afterwards, we have a roughly
linear relationship.

The implementation is fairly straightforward. Whenever we do
the linear search, we cache the interesting commit we find,
and next time check it before doing another linear search.
If that commit is removed from the list or becomes
UNINTERESTING itself, then we fall back to the linear
search. This is very similar to the trick used by fce87ae
(Fix quadratic performance in rewrite_one., 2008-07-12).

I considered and rejected several possible alternatives:

  1. Keep a count of UNINTERESTING commits in the queue.
     This requires managing the count not only when removing
     an item from the queue, but also when marking an item
     as UNINTERESTING. That requires touching the other
     functions which mark commits, and would require knowing
     quickly which commits are in the queue (lookup in the
     queue is linear, so we would need an auxiliary
     structure or to also maintain an IN_QUEUE flag in each
     commit object).

  2. Keep a separate list of interesting commits. Drop items
     from it when they are dropped from the queue, or if
     they become UNINTERESTING. This again suffers from
     extra complexity to maintain the list, not to mention
     CPU and memory.

  3. Use a better data structure for the queue. This is
     something that could help the fix in fce87ae, because
     we order the queue by recency, and it is about
     inserting quickly in recency order. So a normal
     priority queue would help there. But here, we cannot
     disturb the order of the queue, which makes things
     harder. We really do need an auxiliary index to track
     the flag we care about, which is basically option (2)
     above.

The "cache" trick is simple, and the numbers above show that
it works well in practice. This is because the length of
time it takes to find an interesting commit is proportional
to the length of time it will remain cached (i.e., if we
have to walk a long way to find it, it also means we have to
pop a lot of elements in the queue until we get rid of it
and have to find another interesting commit).

The worst case is still quadratic, though. We could have `N`
uninteresting commits at the front of the queue, followed by
`N` interesting commits, where commit `i` has parent `i+N`.
When we pop commit `i`, we will notice that the parent of
the next commit, `i+1+N` is still interesting and cache it.
But then handling commit `i+1`, we will mark its parent
`i+1+N` uninteresting, and immediately invalidate our cache.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this should help me retain my crown for average number of
commit-message lines per commit.

To solve the quadratic case at the bottom, we could re-start the linear
search right after the cached commit, and then wrap around. It's not too
hard to do (we'd just have to cache the commit_list instead of the
commit), but I'm not convinced it doesn't just open up new pathological
cases.  Since the case I described above seems rather ridiculous in
practice, and because it would introduce complexity, I decided not to
pursue it.

 revision.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 6399a04..7ddbaa0 100644
--- a/revision.c
+++ b/revision.c
@@ -345,14 +345,24 @@ static struct commit *handle_commit(struct rev_info *revs,
 	die("%s is unknown object", name);
 }
 
-static int everybody_uninteresting(struct commit_list *orig)
+static int everybody_uninteresting(struct commit_list *orig,
+				   struct commit **interesting_cache)
 {
 	struct commit_list *list = orig;
+
+	if (*interesting_cache) {
+		struct commit *commit = *interesting_cache;
+		if (!(commit->object.flags & UNINTERESTING))
+			return 0;
+	}
+
 	while (list) {
 		struct commit *commit = list->item;
 		list = list->next;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
+		if (interesting_cache)
+			*interesting_cache = commit;
 		return 0;
 	}
 	return 1;
@@ -940,7 +950,8 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 /* How many extra uninteresting commits we want to see.. */
 #define SLOP 5
 
-static int still_interesting(struct commit_list *src, unsigned long date, int slop)
+static int still_interesting(struct commit_list *src, unsigned long date, int slop,
+			     struct commit **interesting_cache)
 {
 	/*
 	 * No source list at all? We're definitely done..
@@ -959,7 +970,7 @@ static int still_interesting(struct commit_list *src, unsigned long date, int sl
 	 * Does the source list still have interesting commits in
 	 * it? Definitely not done..
 	 */
-	if (!everybody_uninteresting(src))
+	if (!everybody_uninteresting(src, interesting_cache))
 		return SLOP;
 
 	/* Ok, we're closing in.. */
@@ -1078,6 +1089,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
 	struct commit_list *bottom = NULL;
+	struct commit *interesting_cache = NULL;
 
 	if (revs->ancestry_path) {
 		bottom = collect_bottom_commits(list);
@@ -1094,6 +1106,9 @@ static int limit_list(struct rev_info *revs)
 		list = list->next;
 		free(entry);
 
+		if (commit == interesting_cache)
+			interesting_cache = NULL;
+
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
 		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
@@ -1102,7 +1117,7 @@ static int limit_list(struct rev_info *revs)
 			mark_parents_uninteresting(commit);
 			if (revs->show_all)
 				p = &commit_list_insert(commit, p)->next;
-			slop = still_interesting(list, date, slop);
+			slop = still_interesting(list, date, slop, &interesting_cache);
 			if (slop)
 				continue;
 			/* If showing all, add the whole pending list to the end */
-- 
2.4.0.rc2.384.g7297a4a
