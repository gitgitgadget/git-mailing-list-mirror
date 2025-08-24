Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70A393DCB
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756031484; cv=none; b=Cz0dkd9GFvQFVmIEi8IEK5iieKGaADBHtzkg0FHIttE2D0JepLBvwp1wgvSopvarUlA2ijRXanMCcNV0p2zFlGsGQ4tILWi4OCgUHxcavgrgCLiLECa6eDVRXFBIZkbGcPe+2A7m9Yptb2dgwrvfE7avURvviLaVESLog/5MNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756031484; c=relaxed/simple;
	bh=izzY4MetIh7FOzJBXJc0IR5GW2Z4GDvBj2BOxePvEOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEFZlPW820aE3YtQRDOHWO1dTcZeLzUdCqfPqaP27uXza0RZl7FUOmoQkf/dt9ShKA6dCl5EIuDcAZfWFlt85XxIfOfein0pRMZmLb6oFl6u8Q7KqvRaBO5rntj4P8ZMt7rHcIfamNoYIvz4NAcTQrVuYtLjq2MfToqYDzPHAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FLztG5Gt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FLztG5Gt"
Received: (qmail 66357 invoked by uid 109); 24 Aug 2025 10:31:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=izzY4MetIh7FOzJBXJc0IR5GW2Z4GDvBj2BOxePvEOE=; b=FLztG5GtlmxM1wd6FsuG7loW3ifJiUuCKVIARePJ2a9GOsl0RNcD6RZXIND0yImXbN4xpMEqJHKPTiO0eyHw/c52l1y2gnN/AzI7zshfyjNtLIwutQAZ9jd+A9awmp1nflSeS8FBzq8PRlc8mfBH9rFYyIXzdj+fL6EW+e3LDPMyXaLI9qjte1kG78LSIIVgq2/zQRIYLvyessPTBJv4mAaCHBJPWgdVucG5pw6AcslEdbc9BC8xLaOqk4Eoj2yOTWUdMO+thrbIHgFIYtGqZG7nwHTAtTFm/9/sgINaEYk2mgdpl4b+hYQ79mOtPuYMxFHeC4+aC4jWd5ijAagkEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 24 Aug 2025 10:31:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 133193 invoked by uid 111); 24 Aug 2025 10:31:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 24 Aug 2025 06:31:17 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 24 Aug 2025 06:31:17 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250824103117.GA250458@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>

On Sun, Aug 24, 2025 at 10:37:28AM +0200, René Scharfe wrote:

> We could dedicate an object flag to track queue membership, but that
> would leave less for candidate tags, affecting the results.  So use a
> hash table, specifically a khash set of commit pointers, to track that.
> This avoids quadratic behaviour in all cases and provides a nice
> performance boost over the previous commit, 08bb69d70f (describe: use
> prio_queue_replace(), 2025-08-03):
> 
> Benchmark 1: ./git_08bb69d70f describe $(git rev-list v2.41.0..v2.47.0)
>   Time (mean ± σ):     851.7 ms ±   1.1 ms    [User: 788.7 ms, System: 49.2 ms]
>   Range (min … max):   849.4 ms … 852.8 ms    10 runs
> 
> Benchmark 2: ./git describe $(git rev-list v2.41.0..v2.47.0)
>   Time (mean ± σ):     607.1 ms ±   0.9 ms    [User: 544.6 ms, System: 48.6 ms]
>   Range (min … max):   606.1 ms … 608.3 ms    10 runs
> 
> Summary
>   ./git describe $(git rev-list v2.41.0..v2.47.0) ran
>     1.40 ± 0.00 times faster than ./git_08bb69d70f describe $(git rev-list v2.41.0..v2.47.0)
> 
> Use the commit index value as a hash because it is unique, has the
> right size and needs no computation.  We could also derive the hash
> directly from the pointer value, but that requires slightly more effort.

Interesting. This is exactly what commit-slabs were created for (and are
why the convenient index value is there in the first place!).

The idea of commit-slab was to have a zero-cost lookup, which is done by
indexing into an array (well, really an array-of-arrays). The biggest
downside of commit-slabs is that they allocate one element per commit.
So for a sparse set you end up over-allocating and possibly suffering
cache woes due to requests being far apart.

Whereas in your technique we are trading a little bit of computation
(indexing a bucket and then probing for the match) to get a table that
scales with the number of elements actually added to it.

It should be easy to convert between the two and time it. On top of your
patch, I think this works:

diff --git a/builtin/describe.c b/builtin/describe.c
index edb4dec79d..f1d1ce8c8e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -287,36 +287,38 @@ static void lazy_queue_clear(struct lazy_queue *queue)
 	queue->get_pending = false;
 }
 
-static inline unsigned int commit_index(const struct commit *commit)
-{
-	return commit->index;
-}
-
-static inline int ptr_eq(const void *a, const void *b)
-{
-	return a == b;
-}
+define_commit_slab(commit_counter, int);
 
-KHASH_INIT(commit_set, struct commit *, int, 0, commit_index, ptr_eq)
+struct commit_set {
+	int nr;
+	struct commit_counter present;
+};
 
-static void commit_set_insert(kh_commit_set_t *set, struct commit *commit)
+static void commit_set_insert(struct commit_set *set, struct commit *commit)
 {
-	int added;
-	kh_put_commit_set(set, commit, &added);
+	int *v = commit_counter_at(&set->present, commit);
+	if (!*v) {
+		set->nr++;
+		*v = 1;
+	}
 }
 
-static void commit_set_remove(kh_commit_set_t *set, struct commit *commit)
+static void commit_set_remove(struct commit_set *set, struct commit *commit)
 {
-	khiter_t pos = kh_get_commit_set(set, commit);
-	if (pos != kh_end(set))
-		kh_del_commit_set(set, pos);
+	int *v = commit_counter_peek(&set->present, commit);
+	if (*v) {
+		set->nr--;
+		*v = 0;
+	}
 }
 
 static unsigned long finish_depth_computation(struct lazy_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits = 0;
-	kh_commit_set_t unflagged = { 0 };
+	struct commit_set unflagged = { 0 };
+
+	init_commit_counter(&unflagged.present);
 
 	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
 		struct commit *commit = queue->queue.array[i].data;
@@ -330,7 +332,7 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
-			if (!kh_size(&unflagged))
+			if (!unflagged.nr)
 				break;
 		} else {
 			commit_set_remove(&unflagged, c);
@@ -354,7 +356,7 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 			parents = parents->next;
 		}
 	}
-	kh_release_commit_set(&unflagged);
+	clear_commit_counter(&unflagged.present);
 	return seen_commits;
 }
 

Here's what I get for timing:

  Benchmark 1: ./git.orig describe $(git rev-list v2.41.0..v2.47.0)
    Time (mean ± σ):      1.195 s ±  0.012 s    [User: 1.152 s, System: 0.045 s]
    Range (min … max):    1.175 s …  1.220 s    10 runs
  
  Benchmark 2: ./git.khash describe $(git rev-list v2.41.0..v2.47.0)
    Time (mean ± σ):     912.4 ms ±   5.7 ms    [User: 867.7 ms, System: 46.3 ms]
    Range (min … max):   901.1 ms … 921.2 ms    10 runs
  
  Benchmark 3: ./git.slab describe $(git rev-list v2.41.0..v2.47.0)
    Time (mean ± σ):     937.9 ms ±   7.6 ms    [User: 896.1 ms, System: 43.5 ms]
    Range (min … max):   924.8 ms … 947.9 ms    10 runs
  
  Summary
    ./git.khash describe $(git rev-list v2.41.0..v2.47.0) ran
      1.03 ± 0.01 times faster than ./git.slab describe $(git rev-list v2.41.0..v2.47.0)
      1.31 ± 0.02 times faster than ./git.orig describe $(git rev-list v2.41.0..v2.47.0)

So I see similar speedups vs stock Git using your patch, but the
commit-slab version is just slightly slower. That of course makes me
wonder if we could or should replace the guts of commit-slab with a hash
more like this. Some obvious questions:

  1. Does the hash always perform better? For a dense set, might the
     commit-slab do better (probably something like topo-sort would be a
     good test there).

  2. Can the hash version handle strides of different sizes? One of the
     points of commit-slab is that the fixed size of the value type can
     be set at runtime (so you could have a slab of 32 bits per commit,
     or 132, depending on your traversal needs).

  3. How does it perform if we swap the commit->index field for using
     the pointer? If it's similar or faster, we could get rid of the
     commit->index field entirely. Besides saving a few bytes and being
     simpler, that would also mean that we could start to use the same
     slab techniques for non-commit objects. There are several cases
     where we use a few custom bits in object.flags because we need to
     cover both commits and other objects. But those are error prone if
     two sub-systems of Git use the same bits and happen to run at the
     same time without clearing in between. It would be great if each
     algorithm could declare its own unique flag space (and discard them
     in one action without iterating yet again to clear the bits).

-Peff
