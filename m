Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C0120248
	for <e@80x24.org>; Thu,  4 Apr 2019 01:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDDBlL (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:41:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:46248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDBlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:41:11 -0400
Received: (qmail 18578 invoked by uid 109); 4 Apr 2019 01:41:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 01:41:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13201 invoked by uid 111); 4 Apr 2019 01:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 21:41:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 21:41:09 -0400
Date:   Wed, 3 Apr 2019 21:41:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?QmrDtnJu?= Pettersson A 
        <bjorn.a.pettersson@ericsson.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] revision: use a prio_queue to hold rewritten parents
Message-ID: <20190404014108.GC4409@sigill.intra.peff.net>
References: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
 <20190402132756.GB13141@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190402132756.GB13141@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 02, 2019 at 09:27:56AM -0400, Jeff King wrote:

> On Tue, Apr 02, 2019 at 11:31:59AM +0000, Björn Pettersson A wrote:
> 
> > Example:
> > 
> > Run "git log --parents" for an old file (bswap.ll), and a brand new file (dummy).
> 
> Interesting case. I was able to reproduce it here pretty easily, and I
> have a start on a solution below.

After a bit of pondering and some experimentation, I think this is the
right direction. Here's that patch again (with a few minor tweaks), and
an excessively long commit message which I hope explains everything.

Thanks for a very interesting case (and with an easy reproduction
recipe!).

-- >8 --
Subject: [PATCH] revision: use a prio_queue to hold rewritten parents

This patch fixes a quadratic list insertion in rewrite_one() when
pathspec limiting is combined with --parents. What happens is something
like this:

  1. We see that some commit X touches the path, so we try to rewrite
     its parents.

  2. rewrite_one() loops forever, rewriting parents, until it finds a
     relevant parent (or hits the root and decides there are none). The
     heavy lifting is done by process_parent(), which uses
     try_to_simplify_commit() to drop parents.

  3. process_parent() puts any intermediate parents into the
     &revs->commits list, inserting by commit date as usual.

So if commit X is recent, and then there's a large chunk of history that
doesn't touch the path, we may add a lot of commits to &revs->commits.
And insertion by commit date is O(n) in the worst case, making the whole
thing quadratic.

We tried to deal with this long ago in fce87ae538 (Fix quadratic
performance in rewrite_one., 2008-07-12). In that scheme, we cache the
oldest commit in the list; if the new commit to be added is older, we
can start our linear traversal there. This often works well in practice
because parents are older than their descendants, and thus we tend to
add older and older commits as we traverse.

But this isn't guaranteed, and in fact there's a simple case where it is
not: merges. Imagine we look at the first parent of a merge and see a
very old commit (let's say 3 years old). And on the second parent, as we
go back 3 years in history, we might have many commits. That one
first-parent commit has polluted our oldest-commit cache; it will remain
the oldest while we traverse a huge chunk of history, during which we
have to fall back to the slow, linear method of adding to the list.

Naively, one might imagine that instead of caching the oldest commit,
we'd start at the last-added one. But that just makes some cases faster
while making others slower (and indeed, while it made a real-world test
case much faster, it does quite poorly in the perf test include here).
Fundamentally, these are just heuristics; our worst case is still
quadratic, and some cases will approach that.

Instead, let's use a data structure with better worst-case performance.
Swapping out revs->commits for something else would have repercussions
all over the code base, but we can take advantage of one fact: for the
rewrite_one() case, nobody actually needs to see those commits in
revs->commits until we've finished generating the whole list.

That leaves us with two obvious options:

  1. We can generate the list _unordered_, which should be O(n), and
     then sort it afterwards, which would be O(n log n) total. This is
     "sort-after" below.

  2. We can insert the commits into a separate data structure, like a
     priority queue. This is "prio-queue" below.

I expected that sort-after would be the fastest (since it saves us the
extra step of copying the items into the linked list), but surprisingly
the prio-queue seems to be a bit faster.

Here are timings for the new p0001.6 for all three techniques across a
few repositories, as compared to master:

master              cache-last                sort-after              prio-queue
--------------------------------------------------------------------------------------------
GIT_PERF_REPO=git.git
0.52(0.50+0.02)      0.53(0.51+0.02)  +1.9%   0.37(0.33+0.03) -28.8%  0.37(0.32+0.04) -28.8%

GIT_PERF_REPO=linux.git
20.81(20.74+0.07)   20.31(20.24+0.07) -2.4%   0.94(0.86+0.07) -95.5%  0.91(0.82+0.09) -95.6%

GIT_PERF_REPO=llvm-project.git
83.67(83.57+0.09)    4.23(4.15+0.08) -94.9%   3.21(3.15+0.06) -96.2%  2.98(2.91+0.07) -96.4%

A few items to note:

  - the cache-list tweak does improve the bad case for llvm-project.git
    that started my digging into this problem. But it performs terribly
    on linux.git, barely helping at all.

  - the sort-after and prio-queue techniques work well. They approach
    the timing for running without --parents at all, which is what you'd
    expect (see below for more data).

  - prio-queue just barely outperforms sort-after. As I said, I'm not
    really sure why this is the case, but it is. You can see it even
    more prominently in this real-world case on llvm-project.git:

      git rev-list --parents 07ef786652e7 -- llvm/test/CodeGen/Generic/bswap.ll

    where prio-queue routinely outperforms sort-after by about 7%. One
    guess is that the prio-queue may just be more efficient because it
    uses a compact array.

There are three new perf tests:

  - "rev-list --parents" gives us a baseline for running with --parents.
    This isn't sped up meaningfully here, because the bad case is
    triggered only with simplification. But it's good to make sure we
    don't screw it up (now, or in the future).

  - "rev-list -- dummy" gives us a baseline for just traversing with
    pathspec limiting. This gives a lower bound for the next test (and
    it's also a good thing for us to be checking in general for
    regressions, since we don't seem to have any existing tests).

  - "rev-list --parents -- dummy" shows off the problem (and our fix)

Here are the timings for those three on llvm-project.git, before and
after the fix:

Test                                 master              prio-queue
------------------------------------------------------------------------------
0001.3: rev-list --parents           2.24(2.12+0.12)     2.22(2.11+0.11) -0.9%
0001.5: rev-list -- dummy            2.89(2.82+0.07)     2.92(2.89+0.03) +1.0%
0001.6: rev-list --parents -- dummy  83.67(83.57+0.09)   2.98(2.91+0.07) -96.4%

Changes in the first two are basically noise, and you can see we
approach our lower bound in the final one.

Note that we can't fully get rid of the list argument from
process_parents(). Other callers do have lists, and it would be hard to
convert them. They also don't seem to have this problem (probably
because they actually remove items from the list as they loop, meaning
it doesn't grow so large in the first place). So this basically just
drops the "cache_ptr" parameter (which was used only by the one caller
we're fixing here) and replaces it with a prio_queue. Callers are free
to use either data structure, depending on what they're prepared to
handle.

Reported-by: Björn Pettersson A <bjorn.a.pettersson@ericsson.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c               | 58 +++++++++++++++++++++++++---------------
 t/perf/p0001-rev-list.sh | 18 +++++++++++++
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/revision.c b/revision.c
index eb8e51bc63..8e500441d9 100644
--- a/revision.c
+++ b/revision.c
@@ -911,26 +911,11 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		commit->object.flags |= TREESAME;
 }
 
-static void commit_list_insert_by_date_cached(struct commit *p, struct commit_list **head,
-		    struct commit_list *cached_base, struct commit_list **cache)
-{
-	struct commit_list *new_entry;
-
-	if (cached_base && p->date < cached_base->item->date)
-		new_entry = commit_list_insert_by_date(p, &cached_base->next);
-	else
-		new_entry = commit_list_insert_by_date(p, head);
-
-	if (cache && (!*cache || p->date < (*cache)->item->date))
-		*cache = new_entry;
-}
-
 static int process_parents(struct rev_info *revs, struct commit *commit,
-			   struct commit_list **list, struct commit_list **cache_ptr)
+			   struct commit_list **list, struct prio_queue *queue)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
-	struct commit_list *cached_base = cache_ptr ? *cache_ptr : NULL;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -966,7 +951,9 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 				continue;
 			p->object.flags |= SEEN;
 			if (list)
-				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+				commit_list_insert_by_date(p, list);
+			if (queue)
+				prio_queue_put(queue, p);
 		}
 		return 0;
 	}
@@ -1006,7 +993,9 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
 			if (list)
-				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+				commit_list_insert_by_date(p, list);
+			if (queue)
+				prio_queue_put(queue, p);
 		}
 		if (revs->first_parent_only)
 			break;
@@ -3341,14 +3330,14 @@ int prepare_revision_walk(struct rev_info *revs)
 	return 0;
 }
 
-static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
+static enum rewrite_result rewrite_one_1(struct rev_info *revs,
+					 struct commit **pp,
+					 struct prio_queue *queue)
 {
-	struct commit_list *cache = NULL;
-
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			if (process_parents(revs, p, &revs->commits, &cache) < 0)
+			if (process_parents(revs, p, NULL, queue) < 0)
 				return rewrite_one_error;
 		if (p->object.flags & UNINTERESTING)
 			return rewrite_one_ok;
@@ -3362,6 +3351,31 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	}
 }
 
+static void merge_queue_into_list(struct prio_queue *q, struct commit_list **list)
+{
+	while (q->nr) {
+		struct commit *item = prio_queue_peek(q);
+		struct commit_list *p = *list;
+
+		if (p && p->item->date >= item->date)
+			list = &p->next;
+		else {
+			p = commit_list_insert(item, list);
+			list = &p->next; /* skip newly added item */
+			prio_queue_get(q); /* pop item */
+		}
+	}
+}
+
+static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
+{
+	struct prio_queue queue = { compare_commits_by_commit_date };
+	enum rewrite_result ret = rewrite_one_1(revs, pp, &queue);
+	merge_queue_into_list(&queue, &revs->commits);
+	clear_prio_queue(&queue);
+	return ret;
+}
+
 int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	rewrite_parent_fn_t rewrite_parent)
 {
diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
index ebf172401b..3042a85666 100755
--- a/t/perf/p0001-rev-list.sh
+++ b/t/perf/p0001-rev-list.sh
@@ -14,6 +14,24 @@ test_perf 'rev-list --all --objects' '
 	git rev-list --all --objects >/dev/null
 '
 
+test_perf 'rev-list --parents' '
+	git rev-list --parents HEAD >/dev/null
+'
+
+test_expect_success 'create dummy file' '
+	echo unlikely-to-already-be-there >dummy &&
+	git add dummy &&
+	git commit -m dummy
+'
+
+test_perf 'rev-list -- dummy' '
+	git rev-list HEAD -- dummy
+'
+
+test_perf 'rev-list --parents -- dummy' '
+	git rev-list --parents HEAD -- dummy
+'
+
 test_expect_success 'create new unreferenced commit' '
 	commit=$(git commit-tree HEAD^{tree} -p HEAD) &&
 	test_export commit
-- 
2.21.0.714.gd1be1d035b

