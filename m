Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC1220248
	for <e@80x24.org>; Tue,  2 Apr 2019 13:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfDBN17 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 09:27:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:44208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726716AbfDBN17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 09:27:59 -0400
Received: (qmail 28980 invoked by uid 109); 2 Apr 2019 13:27:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Apr 2019 13:27:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23072 invoked by uid 111); 2 Apr 2019 13:28:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Apr 2019 09:28:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2019 09:27:56 -0400
Date:   Tue, 2 Apr 2019 09:27:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?QmrDtnJu?= Pettersson A 
        <bjorn.a.pettersson@ericsson.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bad performance when using git log --parents (used by gitk)
Message-ID: <20190402132756.GB13141@sigill.intra.peff.net>
References: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 02, 2019 at 11:31:59AM +0000, Björn Pettersson A wrote:

> Example:
> 
> Run "git log --parents" for an old file (bswap.ll), and a brand new file (dummy).

Interesting case. I was able to reproduce it here pretty easily, and I
have a start on a solution below.

> So for bswap.ll it takes about 190/5 = 38 times longer time to run "git log --parents",
> and for the new dummy file it takes 205/4 = 51 times longer time, when using the new repo.
> 
> The size of the llvm-project repo is a little bit larger (since we have merged
> several project, so the number of commits increases from ~180000 to ~310000, but I doubt
> that such an increase should affect the time for git log --parents by a factor of 50.

Yeah, I'd expect it to take about twice as long (having to sort through
about twice as much tree data), which is what I see without --parents.

> From what I understand --parents can take some time, but I see huge
> degradation when using our new repo compared to the old.

I wouldn't normally expect --parents to take a long time. Most of the
time for your command should be going to opening up trees to see if they
touched the file in question.

I don't think there's anything wrong with the new repo compared to the
old. They just happen to have different access patterns.

Poking at your case in perf and gdb, it looks like a resurgence of our
old friend, the accidentally-quadratic commit_list_insert_by_date. The
backtrace where we spend most of our time looks like this:

  #0  commit_list_insert_by_date_cached (...) at revision.c:919
  #1  0x000055555572c860 in process_parents (...) at revision.c:1009
  #2  0x0000555555733cc6 in rewrite_one (...) at revision.c:3351
  #3  0x0000555555733d98 in rewrite_parents (...) at revision.c:3371
  #4  0x0000555555734906 in simplify_commit (...) at revision.c:3625
  #5  0x0000555555734c17 in get_revision_1 (...) at revision.c:3691

And that explains your observation that you don't see any output.
Normally Git tries to stream the commits as it finds them, but it
literally spends all of its time trying to find the next viable parent
of that first commit before it can print it. And there are a ton of such
commits in your examples, because they each are touched by only one
commit relatively near the tip of our traversal (so basically we end up
going through the entire history looking for another parent before
deciding there isn't one).

The root of the issue is that we keep the queue of commits to be shown
in a linked list, and then insert new ones by date. Naively, this is
quadratic in the number of commits. We tried to deal with that long ago
in fce87ae538 (Fix quadratic performance in rewrite_one., 2008-07-12).

That commit caches the oldest item we've added, which makes a good
heuristic starting point for inserting the next one, as time tends to go
backwards as we traverse.

But that heuristic seems to behave poorly for your case, presumably
because you have merges which jump around a lot in time (I'm guessing
there, based on the fact that you said you merged several projects
together).

If I tweak the heuristic to just always cache the last-added item,
rather than the oldest, like so:

diff --git a/revision.c b/revision.c
index eb8e51bc63..492c4247c4 100644
--- a/revision.c
+++ b/revision.c
@@ -921,7 +921,7 @@ static void commit_list_insert_by_date_cached(struct commit *p, struct commit_li
 	else
 		new_entry = commit_list_insert_by_date(p, head);
 
-	if (cache && (!*cache || p->date < (*cache)->item->date))
+	if (cache)
 		*cache = new_entry;
 }
 

I get much better performance:

  $ time git log --parents -- llvm/test/CodeGen/Generic/bswap.ll >/dev/null
  real	0m5.674s
  user	0m5.546s
  sys	0m0.128s

But there are two issues, still. One is that I'm not sure if that might
be hurting other cases. It works for your case because hitting one old
commit doesn't permanently adjust our cache into a useless position.

And two, 5.6s is still not as cheap as it is without --parents:

  $ time git log -- llvm/test/CodeGen/Generic/bswap.ll >/dev/null
  real	0m4.200s
  user	0m4.043s
  sys	0m0.156s

I think the right solution is scrap this heuristic hackery and use a
real priority queue (which we didn't have readily available back in
2008). The patch below does that, and gives me similar performance to
the non-parents case:

  $ time git log --parents -- llvm/test/CodeGen/Generic/bswap.ll >/dev/null
  real	0m4.356s
  user	0m4.208s
  sys	0m0.148s

It's a little hacky because other parts of the code use lists, so:

  - the underlying process_parents() handles either case, since there's
    another caller which wants its results in a list

  - we can't convert &revs->commits to prio_queue, because that would
    have huge fallouts all over the code base (and in particular, it
    sometimes does want to do in-order traversal, so something like a
    skip-list would actually be a better data structure). So we end up
    doing our local computation using the queue, and then dumping the
    results back into the list. I don't _think_ anybody needs to see
    those commits in &revs->commits while we're walking the parents.

As an aside, I notice that the parent-rewriting always uses commit
timestamps for ordering (even before my patch). I suspect this may
interact in a funny way with --topo-order or --date-order, but any such
bugs would be the same before or after this patch.

---
diff --git a/revision.c b/revision.c
index eb8e51bc63..96bac876a6 100644
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
+		if (p && p->item->date > item->date)
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
