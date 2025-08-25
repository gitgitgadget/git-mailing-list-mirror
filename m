Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590522A4E5
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107256; cv=none; b=fKGjSkvQlsqb1Ql1UPkOkqTdkQsPZ+DLFfQiyKXEfnINxzxA0BcWES6lP8YaPZatNxX44ihZ+56mcKygHbgpcT8dwrEsxD5n5v0f5OH9HT/BKIFUazK53xaSfCaZb4cfj5sHwy6ce51or6TkV6aaPdDs+fqQrjf5LEnoWn7H028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107256; c=relaxed/simple;
	bh=vvzepqtYL4/FI1Iwm6D0N8yKuUoRKUEuCOCZW1liZjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsb/3vFatDIW2yOFpN1yFI4Y+ijyg6EjLWndNVjp2TIEFFShYAR2du7tZ8TiM64ybavzhhTVGEFpL1u9DIAhAK7vqdesrs5mmjIyn7ovOhlsbR+vqke+oMmIgb3Lfxvsewzsfdc6seLC/16lEjBBtNKIctybYbQkOs4HZE6TQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A+UKzUW5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A+UKzUW5"
Received: (qmail 73252 invoked by uid 109); 25 Aug 2025 07:34:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=vvzepqtYL4/FI1Iwm6D0N8yKuUoRKUEuCOCZW1liZjQ=; b=A+UKzUW5I7/tK18Zv4PZJxW8UPq7miMjJLQaVQLXasqVdtYaQmN8Bb4lyNW6j6OrhuHI/9g+pfiWlwZ5aX753VSBJXOgJbfaiP2Txxjx9fU0Qvwqxt5XxPquH/BG9iF0OLdCTSwUOvWpmc5WN9UNm0dKQU9dVBMgUtby+884NnRfmQ+UVPuQo1Xef29JYlmtg6VrwSV+DrpGPsli7/okNx1JzNq7md4C3QBRw5AC/78t+z0i3LAar3JDlluEakfAp7J/xPWrMyUQQ7vrNNgfrXCzHpXl2iMWW2x1bz3xLC5Ut39QiH/G6iUrXqwwi3rswlTcJsS2FQjhyaAkMlDLZQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Aug 2025 07:34:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 149962 invoked by uid 111); 25 Aug 2025 07:34:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Aug 2025 03:34:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Aug 2025 03:34:03 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250825073403.GA332447@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>

On Sun, Aug 24, 2025 at 06:32:47PM +0200, René Scharfe wrote:

> >> Use the commit index value as a hash because it is unique, has the
> >> right size and needs no computation.  We could also derive the hash
> >> directly from the pointer value, but that requires slightly more effort.
> > 
> > Interesting. This is exactly what commit-slabs were created for (and are
> > why the convenient index value is there in the first place!).
> 
> Kinda -- they have a payload value, while a khash set only stores keys.
> A commit slab with an int payload would still be smaller than a khash
> set with 64-bit pointers as keys -- IF we were to add all commits.  Here
> we typically add just a few, but a pathological history could add a lot;
> not sure if there's a boundary.  Hmm.  So you might be able to find
> examples where commit-slabs win.

A khash set doesn't have a "vals" array, but I think it does always keep
the flags array, which is a uint32_t per bucket. That's how it knows
which buckets have a value in them (since it does not otherwise assume
there is a sentinel value like NULL). So even though its API is that of
a set, you can think of it as a mapping of keys to flags. So a mapping
to an int (or even a char) should cost the same.

> > The idea of commit-slab was to have a zero-cost lookup, which is done by
> > indexing into an array (well, really an array-of-arrays). The biggest
> > downside of commit-slabs is that they allocate one element per commit.
> > So for a sparse set you end up over-allocating and possibly suffering
> > cache woes due to requests being far apart.
> 
> Right, and it doesn't support removal.

True. And I think that is the big downfall for what I was suggesting
earlier (backing a slab with a hash table). If you have a slab that
holds only a few items at one time, but which cycles through a larger
set of items, it will grow to match that larger set. That is a waste of
memory with a traditional slab, but if you back the slab with a hash
table you also waste computation doing lookups on a hash table with lots
of elements, when most of them are not interesting (but the slab code
has no way to say "this is not interesting any more"; you can only
take the address and assign to it).

So probably the slab API is not so great for many cases. But what I was
mostly getting at is: should we be using hashes in more places if their
access time is cost-competitive with the slab arrays?

More on that in a moment...

> > +define_commit_slab(commit_counter, int);
> 
> We only need one bit, so a uint8_t or char would suffice.

True, though that doesn't seem to change timings much for me (I used
"int" because that's what your khash used, but I think the type is a
dummy value in "set" mode).

> I didn't even consider them a contender due to the memory overhead.  The
> difference is surprisingly small.  I also got 3%:
> 
> Benchmark 1: ./git_khash describe $(git rev-list v2.41.0..v2.47.0)
>   Time (mean ± σ):     608.4 ms ±   0.6 ms    [User: 544.6 ms, System: 49.2 ms]
>   Range (min … max):   607.5 ms … 609.3 ms    10 runs
> 
> Benchmark 2: ./git_slab describe $(git rev-list v2.41.0..v2.47.0)
>   Time (mean ± σ):     624.4 ms ±   1.0 ms    [User: 560.6 ms, System: 49.3 ms]
>   Range (min … max):   623.3 ms … 626.5 ms    10 runs
> 
> Summary
>   ./git_khash describe $(git rev-list v2.41.0..v2.47.0) ran
>     1.03 ± 0.00 times faster than ./git_slab describe $(git rev-list v2.41.0..v2.47.0)
> 
> I guess hash tables are just fast, even the slower ones.  Provided they
> fit into memory.

Yeah. Thinking on it more, how much benefit are we getting from the use
of commit->index in your patch? In other contexts where we store oids or
objects in hash tables, we use the low bits of the oid directly. So it's
similarly cheap. If I do this tweak on top of your patch:

diff --git a/builtin/describe.c b/builtin/describe.c
index edb4dec79d..e024feb080 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -289,7 +289,7 @@ static void lazy_queue_clear(struct lazy_queue *queue)
 
 static inline unsigned int commit_index(const struct commit *commit)
 {
-	return commit->index;
+	return oidhash(&commit->object.oid);
 }
 
 static inline int ptr_eq(const void *a, const void *b)

I get similar results (actually faster, but I think within the noise).

Which made me think more (always a danger). We already have an oidset
data structure, which is backed by a khash. It's not _quite_ the same
thing, because it's going to store an actual 36-byte oid struct as the
hash key, rather than an 8-byte pointer to a "struct object" (which
contains that same oid). And likewise when we do a lookup, the bucket
search requires a larger memcmp() than the pointer equality. But how
much difference does that make?

If I instead do this on top of your patch:

diff --git a/builtin/describe.c b/builtin/describe.c
index edb4dec79d..38ce0c1978 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -287,41 +287,16 @@ static void lazy_queue_clear(struct lazy_queue *queue)
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
-
-KHASH_INIT(commit_set, struct commit *, int, 0, commit_index, ptr_eq)
-
-static void commit_set_insert(kh_commit_set_t *set, struct commit *commit)
-{
-	int added;
-	kh_put_commit_set(set, commit, &added);
-}
-
-static void commit_set_remove(kh_commit_set_t *set, struct commit *commit)
-{
-	khiter_t pos = kh_get_commit_set(set, commit);
-	if (pos != kh_end(set))
-		kh_del_commit_set(set, pos);
-}
-
 static unsigned long finish_depth_computation(struct lazy_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits = 0;
-	kh_commit_set_t unflagged = { 0 };
+	struct oidset unflagged = OIDSET_INIT;
 
 	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
 		struct commit *commit = queue->queue.array[i].data;
 		if (!(commit->object.flags & best->flag_within))
-			commit_set_insert(&unflagged, commit);
+			oidset_insert(&unflagged, &commit->object.oid);
 	}
 
 	while (!lazy_queue_empty(queue)) {
@@ -330,10 +305,10 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
-			if (!kh_size(&unflagged))
+			if (!oidset_size(&unflagged))
 				break;
 		} else {
-			commit_set_remove(&unflagged, c);
+			oidset_remove(&unflagged, &c->object.oid);
 			best->depth++;
 		}
 		while (parents) {
@@ -348,13 +323,13 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 			p->object.flags |= c->object.flags;
 			flag_after = p->object.flags & best->flag_within;
 			if (!seen && !flag_after)
-				commit_set_insert(&unflagged, p);
+				oidset_insert(&unflagged, &p->object.oid);
 			if (seen && !flag_before && flag_after)
-				commit_set_remove(&unflagged, p);
+				oidset_remove(&unflagged, &p->object.oid);
 			parents = parents->next;
 		}
 	}
-	kh_release_commit_set(&unflagged);
+	oidset_clear(&unflagged);
 	return seen_commits;
 }
 

then I likewise get very similar timings. Your version seems to be
consistently a little bit faster, but within the run-to-run noise of
~1%. But the bonus here is that we didn't need to define a new hash
type, nor do any tricks with the commit->index field.

Now if we really are worried about those extra bytes in storing a fresh
oid, is there room for new data types? I.e., A "struct objset" that
stores object pointers, hashes based on the oid, and uses pointer
equality to find a match?  And likewise a "struct objmap" that could
perhaps compete with commit-slab (but be more pleasant to use).

> >   1. Does the hash always perform better? For a dense set, might the
> >      commit-slab do better (probably something like topo-sort would be a
> >      good test there).
> 
> With dense you mean that most commits get some data value assigned that
> is kept for longer?  That's when commit-slabs should shine.

Yes, that's what I meant. And yeah, I'd expect commit slabs to be more
competitive with hashes in those cases. But I wonder if a good hash
table could come close enough to obsolete slabs.

> >   2. Can the hash version handle strides of different sizes? One of the
> >      points of commit-slab is that the fixed size of the value type can
> >      be set at runtime (so you could have a slab of 32 bits per commit,
> >      or 132, depending on your traversal needs).
> 
> Dynamic value sizes require an indirection via a pointer, or at least I
> don't see any other way.  What would be a possible use case?  (Don't see
> any in-tree.)

The value isn't totally dynamic; it's static for a single instantiation
of a slab. I don't think khash supports that (it has a value type and
lets the compiler take care of indexing into an array of that value).
But you could imagine a world where khash (or some custom hash code)
only knows that it's storing N bytes per item, and does the indexing
multiplication itself.

But yes, I don't think we are even using that feature of commit-slab
currently. I used it in a series for fast --contains long ago:

  https://lore.kernel.org/git/20140625233429.GA20457@sigill.intra.peff.net/

but can't remember why I never got back to it. It would also be useful
for show-branch, which wants to paint down for each starting tip. But
given that we haven't used it, it may just not be that useful a feature.

> >   3. How does it perform if we swap the commit->index field for using
> >      the pointer? If it's similar or faster, we could get rid of the
> >      commit->index field entirely. Besides saving a few bytes and being
> >      simpler, that would also mean that we could start to use the same
> >      slab techniques for non-commit objects. There are several cases
> >      where we use a few custom bits in object.flags because we need to
> >      cover both commits and other objects. But those are error prone if
> >      two sub-systems of Git use the same bits and happen to run at the
> >      same time without clearing in between. It would be great if each
> >      algorithm could declare its own unique flag space (and discard them
> >      in one action without iterating yet again to clear the bits).
> With "commit" being the pointer, returning "(uintptr_t)commit / 8" in the
> hash function for the khash set gets me the same performance.  This
> assumes an eight-byte alignment and that pointer values are flat indexes
> into memory, which might be too much.  A portable solution would probably
> have to mix and spread out all bits evenly?

I'd think there would be more entropy in the low bits in general, so
just "(uintptr_t)commit & 0xffffffff". But probably just using oidhash()
is better still.

> The nice thing about commit-slabs is the lack of required maintenance.
> They just allocate as needed and never give anything back, never need to
> rehash.  And they don't need to store the keys anywhere.  They should be
> good alternatives to object flags used during full history traversal
> without flagging non-commits.
> 
> Off-the-shelf hash tables like khash might be slower in these cases,
> though not far off, I expect.

Yeah, maybe. I've never really loved the drawbacks of commit-slab, and
your numbers made me wonder if we could be getting away with hashes in
more places. Though one of the drawbacks I find with commit-slab is the
grossness of instantiating a giant mess of macros. That is not much
better with khash. ;) And certainly oidmap, though it does not use
macros, is no picnic to use either.

-Peff
