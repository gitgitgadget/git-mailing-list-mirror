Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539733A7F68
	for <git@vger.kernel.org>; Mon, 25 May 2026 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691688; cv=none; b=MEK9+9VxqNbpgTjzrEnQkonOoQWTYoEEeSd8ADlJIo/MYXB7eZAap5KgaPiYdcVIDQetWP7nm0QJHYtyp0mkYAaA4D6f7RDDpuQsjXMDj8w2ifO/qTfjzARLVVMLa7FTQUc10hJv8e6I/FZYd3yRao2nCGjbu3H2bDTpuLagzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691688; c=relaxed/simple;
	bh=D8cmSdTDIOFsHGQCsSmH3W2Iq23S/WCY3rmkVi5iaQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhBhKemT4nz2hIMmg9//TAji95OrRwwU/9qO/+lUxWrTjL65d3nhAXVYuQlTsxdwyeJyRE/m+BHbpOL6xbuCVYHZ2yA26Xh4g4hdkp1xgCjtfMdRKWa3KyjdR3qGKaZTcJffZV4XoVDiz1YhXbkinFDZBaH3cmfOSAd+CPO4bOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FzjDRj4Z; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FzjDRj4Z"
Received: (qmail 9979 invoked by uid 106); 25 May 2026 06:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=D8cmSdTDIOFsHGQCsSmH3W2Iq23S/WCY3rmkVi5iaQc=; b=FzjDRj4Z3upa5T9unpa/lMAl/qG+sSivxFDo2NhZXuWdlXPlnfNa1XG0lz+EGCkMvN7iMhOlxPc2p1TB5xln1h678gmhjBAUP6k2kzKJGPNnY03epHGFuKiyq/kn6AyhiG+UbxEJMd0egISUBS9HJhB1Aw9xfZWOpINdI+U5hFACjjp9E8uRogdpraDoeclohyGNzvjMRkzLqmX4L3yqJv/sbF1zOa8NWbtbr565XHRXR/Em6HqXnVSjBClTUAfq0MKtaLdfmkQFGoCkMN5TObwyyXvBJotjNzqPDdOkoW9N/fZsWXnY+jZ3tkqSIqoLp3hE/DE1nDeoaAnCRlhsLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 06:47:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13493 invoked by uid 111); 25 May 2026 06:48:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 02:48:00 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 02:47:55 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 0/3] commit-reach: replace queue_has_nonstale with a
 counter
Message-ID: <20260525064755.GA2737798@coredump.intra.peff.net>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2124.git.1779644541.gitgitgadget@gmail.com>

On Sun, May 24, 2026 at 05:42:17PM +0000, Kristofer Karlsson via GitGitGadget wrote:

> paint_down_to_common() and ahead_behind() terminate when every commit in
> their priority queue is STALE. The current check, queue_has_nonstale(), does
> an O(n) linear scan of the queue on every iteration, costing O(n*m) total
> where n is the queue size and m is the number of commits processed. This
> series replaces that scan with an O(1) counter.

We faced a similar problem in limit_list() but solved it a bit
differently (mostly because I was worried about keeping the counter up
to date in all cases).

It's described in more detail in b6e8a3b540 (limit_list: avoid quadratic
behavior from still_interesting, 2015-04-17), but the general idea is to
just cache the interesting element we found, and invalidate the cache
when it gets removed from the queue or gets marked UNINTERESTING.

The equivalent code for the STALE flag here is something like this:

diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..d1621be89f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -39,12 +39,25 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	return 0;
 }
 
-static int queue_has_nonstale(struct prio_queue *queue)
+static int queue_has_nonstale(struct prio_queue *queue,
+			      struct commit **nonstale_cache)
 {
+	if (*nonstale_cache) {
+		struct commit *commit = *nonstale_cache;
+		if (!(commit->object.flags & STALE))
+			return 1;
+	}
+
+	/*
+	 * This might also benefit from looking back-to-front, since
+	 * earlier commits are more likely to get popped sooner.
+	 */
 	for (size_t i = 0; i < queue->nr; i++) {
 		struct commit *commit = queue->array[i].data;
-		if (!(commit->object.flags & STALE))
+		if (!(commit->object.flags & STALE)) {
+			*nonstale_cache = commit;
 			return 1;
+		}
 	}
 	return 0;
 }
@@ -61,6 +74,7 @@ static int paint_down_to_common(struct repository *r,
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
+	struct commit *nonstale_cache = NULL;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r))
 		queue.compare = compare_commits_by_commit_date;
@@ -77,12 +91,15 @@ static int paint_down_to_common(struct repository *r,
 		prio_queue_put(&queue, twos[i]);
 	}
 
-	while (queue_has_nonstale(&queue)) {
+	while (queue_has_nonstale(&queue, &nonstale_cache)) {
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
 
+		if (nonstale_cache == commit)
+			nonstale_cache = NULL;
+
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
 			    generation, last_gen,
@@ -1053,6 +1070,7 @@ void ahead_behind(struct repository *r,
 {
 	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
 	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
+	struct commit *nonstale_cache = NULL;
 
 	if (!commits_nr || !counts_nr)
 		return;
@@ -1074,11 +1092,14 @@ void ahead_behind(struct repository *r,
 		insert_no_dup(&queue, c);
 	}
 
-	while (queue_has_nonstale(&queue)) {
+	while (queue_has_nonstale(&queue, &nonstale_cache)) {
 		struct commit *c = prio_queue_get(&queue);
 		struct commit_list *p;
 		struct bitmap *bitmap_c = get_bit_array(c, width);
 
+		if (c == nonstale_cache)
+			nonstale_cache = NULL;
+
 		for (size_t i = 0; i < counts_nr; i++) {
 			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
 			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);


I don't have a repo handy which reproduces the problem, so I can't see
if it improves things. But if it's easy to do, can you report on the
timing change with your monorepo?

I do think what I've shown here is a bit hacky (just like the
limit_list() one), as we are relying on heuristics about the order in
which items are taken from the queue. So even if it performs well, we
may still prefer the counter version for being truly O(1). But having
timing numbers would be useful for comparing the two approaches.

-Peff
