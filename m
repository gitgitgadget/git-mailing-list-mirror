Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F141922FB
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682650; cv=none; b=gcUKhGCslVi+pXvc+puUV8BaGc0L3JX2IlzuBYrh21n65e5I7LZ5y6TU3nm+0IiqSuup5lZ/5bknFB3BWJGmq67apd8yFZ0U6qUBc7po2mwjEsViElYTJgxpvS/nqDjbQpyEVYh5GUrqVq12y6a3gLoEEJ/oHLbeyDmdMPJv+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682650; c=relaxed/simple;
	bh=7OExRwFKiJkxOFLhdCj7GHVslLmPQwQbbgFrz4S5p5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkpgtVhWS/jAowmg3/BYHPqL2SaX26+bCOKzf/MEtcKFtCYAyDLpFSjIbx4JCExWCtASxZkVB9bBXImro3RVsLkSBvS5YaZCSjht+DxBhOg93gwHaHa6BGXmqVbEt25u4fKOa46J8THTeB5JxobT9zAdGm2Ris4VVBC9VV+GfZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FJuo0qdF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FJuo0qdF"
Received: (qmail 251399 invoked by uid 109); 17 Oct 2025 06:30:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7OExRwFKiJkxOFLhdCj7GHVslLmPQwQbbgFrz4S5p5Q=; b=FJuo0qdFJ3W6dRWenCb1ENXL5fAPbk5sHnv44MDph3pbJQFIFF/soDwFIlxFS/0IGg6QEePdQ2e1mCYxXHVKufDPCVJ5o6YQWlmG5J3l0YRGZGpXQ9AfSUQNlg672BcuLFDBvBCqMk02XJVcROYs7U7kXymqnlNemVO2E8Ay82XRdPn8/P5JHGaRtSxQneyi31oViMfZ/k97bzLF99OmqYa9W+XnSvsI3PM77HCOUD1oU2bywzgSzNzsASQgsshSr5JzMDwpQD2yJuKNTEJlz31l0QnN46ERUa0tLNrPdEnTk54VFc3XrRnsprDILCmelDeg9Osiilbd79aAobC5pg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 06:30:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 392238 invoked by uid 111); 17 Oct 2025 06:30:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 02:30:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 02:30:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <20251017063039.GA3074253@coredump.intra.peff.net>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPGB/FJtjDmyNLvG@nand.local>

On Thu, Oct 16, 2025 at 07:38:36PM -0400, Taylor Blau wrote:

> Looking through the backtrace, it looks like someone is calling
> mark_path() with a NULL oid, like so:
> 
>     (gdb) bt
>     #0  __memcmp_evex_movbe ()
>         at ../sysdeps/x86_64/multiarch/memcmp-evex-movbe.S:132
>     #1  0x00005555555f2c32 in oideq (oid1=0x0, oid2=0x555555a5eeb0)
>         at ./hash.h:408
>     #2  0x00005555555f3523 in mark_path (path=0x555555a5eee8 "a", oid=0x0,
>         data=0x7fffffffd650) at builtin/last-modified.c:179
> 
> , which makes sense, since at the end of the main loop we call
> mark_path() on all remaining active paths to indicate that they were
> modified by whatever commit we just popped off the queue.

Hmm, sounds like the mark_path() discussion from:

  https://lore.kernel.org/git/aHmPHcNQYlhGo8JB@nand.local/

coming home to roost. I'm sure you already knew that, but there's maybe
an interesting process observation here: in pulling a battle-tested
implementation apart into patches to be applied in chunks, we ended up
missing a critical part of that original implementation and getting a
bug.

It's not like we didn't know that was a risk, of course, and the payoff
was getting a fresh look at the patches (to improve them and maybe even
fix latent bugs). So it's probably something to just live with. But I
wonder if/how we could mitigate that risk. When I reorganize patches in
a tricky way locally, I often eyeball the diff of the end states
(whatever mess I had originally, versus the result of the "clean"
version), and that might have shown the omission here.

I'm not sure if that would have helped here or not. The "end state" of
the battle-tested version is really GitHub's internal fork. But maybe
your original patches extracted from that (tb/blame-tree in your fork, I
think) applied on top of the same base point (e.g., the current tip of
master) might be an interesting comparison? Or maybe not. The earlier
rounds have may have had other adjustments which introduce a bunch of
noise.

Anyway, that is mostly philosophical rambling. I did have one concrete
thing to say below.

> > +/*
> > + * Hold a bitmap for each commit we're working with. Each bit represents a path
> > + * in `lm->all_paths`. Active bit means the path still needs to be dealt with.
> > + */
> > +define_commit_slab(commit_bitmaps, struct bitmap *);
> > +
> 
> Nice, I am glad to see that we are using a bitmap here rather than the
> hacky 'char *' that we had originally written. I seem to remember that
> there was a tiny slow-down when using bitmaps, but can't find the
> discussion anymore. (It wasn't in the internal PR that I originally
> opened, and I no longer can read messages that far back in history.)
> 
> It might be worth benchmarking here to see if using a 'char *' is
> faster. Of course, that's 8x worse in terms of memory usage, but not a
> huge deal given both the magnitude and typical number of directory
> elements (you'd need 1024^2 entries in a single tree to occupy even a
> single MiB of heap).

I doubt the memory usage matters too much. We throw away each bitmap
after we finish processing its associated commit, so our max memory is
really the size of the bitmap/char array times the size of the queue (so
effectively the width of the history graph). So yeah, I too would be
curious if the performance is actually better with chars.

I also wonder how often we pass an unchanged bitmap to our parents
(e.g., for the common case that a commit has a single parent, and does
not touch any of the active paths, the active set will be the same for
both). There's probably an easy-ish optimization to avoid allocating a
new bitmap, and to just transfer ownership via pointer.

  You can even get fancier and always just speculatively pass your
  bitmap to _all_ parents, keeping a refcount, and then copy-on-write
  when you need to clear a bit. We do something similar in
  delta-island's set_island_marks(). But the complexity may not be worth
  it, as I'd guess that the single-parent, nothing-cleared case would
  dominate.

That's definitely something that could come on top of this, though (or
never).

> Likewise, I wonder if we should have elemtype here be just 'struct
> bitmap'. Unfortunately I don't think the EWAH code has a function like:
> 
>     void bitmap_init(struct bitmap *);
> 
> and only has ones that allocate for us. So we may consider adding one,
> or creating a dummy bitmap and copying its contents, or otherwise.

I thought that, too, though it does change the max memory use a bit.
Right now we are storing one pointer per commit (the "struct bitmap *")
and that is true whether we have processed the commit or not (it is
populated while the commit is in the queue, and then NULL after). If we
stored the struct directly, that's twice as many bytes (the eword_t
pointer, plus a size_t), and it's per commit.

So for the 1.3M commits in linux.git, for example, that's 10MB used
during the whole program. We save a few bytes by not having the extra
pointers, but only for items that are in the queue (which are relatively
small).

Probably doesn't matter much, as 10MB isn't that much (and we are surely
storing much more for the commit structs themselves). I'd be curious if
avoiding the extra malloc/free and pointer chasing shows a run-time
improvement, though.

Ironically, we do not really need the bitmap's size field at all! All of
these bitmaps are going to start as "all_paths_nr" worth of 1's and get
whittled down from there. So they could all just be the same size
allocation and skip their "nr" field entirely. Of course we couldn't use
the bitmap struct then.

I notice that the original implementation does keep a "nr" field
per-commit, but it's not the size of the allocation. It's the number of
bits set. It feels like we shouldn't need to keep that forever. It's
mostly used to see if the parent got anything passed to it, but we can
throw it away after that. So you could be saving 8 bytes per commit
there (and I don't see that information kept at all in Toon's version).

Anyway, these are all probably micro-optimizations that don't matter
that much. I am a little curious if chars outperform bitmaps, though.

-Peff

PS I tried building tb/blame-tree from your repo because I was poking at
   how some of it worked (having forgotten everything I ever knew about
   it by this point). It does work, but needs this:

diff --git a/blame-tree.c b/blame-tree.c
index 6addac7b0b..2448f2caf4 100644
--- a/blame-tree.c
+++ b/blame-tree.c
@@ -800,7 +800,6 @@ static int process_parent(struct blame_tree *bt,
 		int k = diff2idx(bt, fp->two->path);
 		if (0 <= k && active_c->active[k])
 			scratch[k] = 1;
-		diff_free_filepair(fp);
 	}
 	for (i = 0; i < bt->all_paths_nr; i++) {
 		if (active_c->active[i] && !scratch[i])

  on top, since otherwise we try to double-free the filepairs. I'd guess
  it is a victim of rebasing across a5aecb2cdc (diff: improve lifecycle
  management of diff queues, 2024-09-30), which swapped out
  DIFF_QUEUE_CLEAR(), which left freeing the responsibility of the
  caller, for diff_queue_clear() which handles that itself.
