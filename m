Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FD4B1E72
	for <git@vger.kernel.org>; Mon, 19 May 2025 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637545; cv=none; b=OURwsDOZSXhblDmwMtQIlnGyi1YfrRqAlzMihNwIF24zv3gXhRviog7r3sBT+RzpoizJKnzIXjVXQ51fak9YvHk0SdJveriFPRxQ7yxxbnmyOds9Z1uZG775k6Jvz5HCARmfUvEhKBwFU1QPsdmXOMNUJJPETwhTG545W1mz8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637545; c=relaxed/simple;
	bh=jgUtzuL+UDIbphCI9cgNt0Ds4HSRmmv7rxiPKZlgU7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6axEuPrs7NAiu6w5BewkrPQr3MRQ7SkoYS2y/nzkkn0sMkoEtH8hirmy/vCTbbyG3S34SXFKE0FngKcfFxbehtwGSPpP3ekqOp4PAAH7obE19De/BuO7Q+xMHWxfA7kc6gs9C4Y2Gh0te4khb7BtWkZG0gzoS73/+M1ksYUsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ip4ByEJ1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ip4ByEJ1"
Received: (qmail 14464 invoked by uid 109); 19 May 2025 06:52:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jgUtzuL+UDIbphCI9cgNt0Ds4HSRmmv7rxiPKZlgU7A=; b=Ip4ByEJ1t4Teq7BsvZoHAO+Ovu5VNz4azMmOpVzf+5xJaalO8PfPwuH/3osGihN/P4R7kofb8pxaODJoVsRwlnmiSBHi2DIPvpStgCeaOVhWeoZdu27lFHxWBcZnsBvLA/DPfCwG2vam7XuEdJnm2n+FyY3Yth4t83S2IDdrbsaXE5V2v9RB7WUSjz3cQVWIjmKVRRkv2rJvMq9Gp/nBfpkZ8osV9cPUPmNCMVIEp8t/q5IT8JNc5Rwsp3w4OPMHDTYXl7uEf2LnICNuQ1GMqezT0ZzYeRBsb/+arB8ZVscvm/BAQBStY3xgJcXxAvJzyxhA87l+B1zIo7fshv6VZw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 06:52:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24709 invoked by uid 111); 19 May 2025 06:52:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 02:52:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 02:52:21 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
Message-ID: <20250519065221.GC102701@coredump.intra.peff.net>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
 <xmqq7c2gv1zx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c2gv1zx.fsf@gitster.g>

On Fri, May 16, 2025 at 11:34:10AM -0700, Junio C Hamano wrote:

> > The reason why we do this is likely because we reuse `p->pack_name` to
> > derive the other files' names, as well, so that we only have to allocate
> > this buffer once. As such, we have to compute the packfile name last so
> > that it doesn't get overwritten by the other names.
> 
> I vaguely recall that the order of checks between .idx and .pack
> were deliberately chosen, as we do not want to add and attempt to
> use .pack file before its associated .idx file is ready since
> without the latter the former is unusable at runtime.  

It is definitely intentional and important that we discover packs by
their .idx file first. The writing side uses the creation of the .idx
file (via atomic rename) as the final step in making a pack accessible.
Before that, a reader could see a .pack without its various accessory
files (and so not realize it has a .keep file, for example).

>     Side note: It may have been more important back when the name of
>     the packfile was a hash of names of the objects in the pack,
>     which meant that when you repack a quiescent and fully repacked
>     repository twice with different parameters, you could have ended
>     up with a packfile whose name is the same but the contents as a
>     bytestream (hence the object offset) are different, making a
>     stale .idx not pointing into the correct position in the new
>     .pack file.  These days the name of the packfile is based on the
>     contents of the pack as a bytestream, so we no longer suffer
>     in such a scenario.

I don't think reading the .idx file first was sufficient to protect us
there, since the .pack could be replaced racily after the reader opened
the .idx. I don't recall if we were subject to that race back then (and
it just didn't come up enough to worry about), or if repack would throw
away an identically-named file. Anyway, as you note, it's no longer an
issue.

But I think that is mostly orthogonal to how the auxiliary files are
handled. I think Patrick's guess is correct that the order we have is
simply because it was most convenient to end up with ".pack" in the
name.

> > All of this likely doesn't matter in the general case: Git shouldn't end
> > up looking too many nonexistent packfiles anyway.
> 
> In any case, we shouldn't attempt to use .pack when its associated
> files are missing.  It is not about nonexistent but about incomplete
> (including "in the process of being written").

This shouldn't be a race for files being written. The .idx is written
last, so the .pack should always be there. And the midx is written after
that, so again, the pack should always be there. At least for newly
written packs.

We might see the opposite: packs going away because they were repacked
(and perhaps even a new midx generated). In that case you might see
a race like:

  - process R opens the existing midx, which mentions pack P (but does
    not yet open P)

  - process W repacks, deleting P and generating a new midx with P'

  - process R wants object X; the midx claims it is in pack P, so it
    tries to open that but fails

What should happen here is that R will fail to find the object at all,
should hit reprepare_packed_git(), and will then pick up the new pack.

I don't recall offhand whether reprepare_packed_git() will open the new
midx. If it doesn't, we'd still find the object via the actual pack
.idx, but we may end up consulting the now-stale midx over and over (so
we'll get the right answer, but there may be some room for
optimization).

> > while the issue was entirely self-made because the multi-pack index
> > should have been regenerated, we can still reduce the number of syscalls
> > by 75% in the case of nonexistent packfiles by reordering these calls.
> 
> That sounds more like a band-aid, if we still do the remaining 25%
> that we somehow know would be unnecessary.

Yeah, that was my gut reaction, too. add_packed_git() is not
optimized[1] at all. But it shouldn't have to be, because it's meant to
be called once per process. Even with the re-ordering, we'd still make a
bunch of pointless stat() calls for the .pack file we know is not there.

The code in prepare_midx_pack() converts a numeric pack id (referenced
inside the midx) into a "struct packed_git" pointer, caching the results
in multi_pack_index->packs. That field holds NULL for "we have not
looked it up yet" or a valid pointer to a packed_git. It probably needs
to hold a third state: "we tried and failed".

Something like this (large untested) patch:

diff --git a/midx.c b/midx.c
index 3d0015f782..354b1f886c 100644
--- a/midx.c
+++ b/midx.c
@@ -405,7 +405,7 @@ void close_midx(struct multi_pack_index *m)
 	munmap((unsigned char *)m->data, m->data_len);
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (m->packs[i])
+		if (m->packs[i] && m->packs[i] != (void *)(intptr_t)-1)
 			m->packs[i]->multi_pack_index = 0;
 	}
 	FREE_AND_NULL(m->packs);
@@ -458,6 +458,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 
 	pack_int_id = midx_for_pack(&m, pack_int_id);
 
+	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
+		return 1;
 	if (m->packs[pack_int_id])
 		return 0;
 
@@ -482,8 +484,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_release(&pack_name);
 	strbuf_release(&key);
 
-	if (!p)
+	if (!p) {
+		m->packs[pack_int_id] = (void *)(intptr_t)-1;
 		return 1;
+	}
 
 	p->multi_pack_index = 1;
 	m->packs[pack_int_id] = p;

-Peff

[1] There probably are optimization opportunities in add_packed_git(). I
    don't think re-ordering will help much in the common case that we
    actually do have the pack. But really, most callers do not care
    about these auxiliary files at all! We could simply skip them during
    the initial setup and lazy-load them via accessor functions.

    I _think_ that should be OK with respect to races. For a newly added
    pack, we know they will always be in place before the matching .idx
    file (per the logic I outlined above). For a pack that goes away, we
    might racily fail to see its auxiliary file. But that is mostly true
    now (we might see its .idx, and then the .promisor file is deleted
    before we call access()). It does increase the size of that window,
    though (and in particular lets it happen even if the pack has
    actually been opened).

    I'm not sure how much that would matter in practice. OTOH, I'm not
    sure that saving a few access() calls would be all that meaningful,
    unless you have a zillion packs. And if you have a zillion packs,
    you're likely to get much bigger speedups in other areas by
    repacking them anyway. So it hasn't really been an area I've
    pursued before.
