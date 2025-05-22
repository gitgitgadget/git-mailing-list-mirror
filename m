Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F56417A2FC
	for <git@vger.kernel.org>; Thu, 22 May 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933168; cv=none; b=XMntxbbGklXcajPe/P3hEVlZ4SUStILw2ztSsoeQqzohSYs3P3ljf8CrBiaEktg6uUQd7TPlbTF/h7vznzSYJECU5myXrR6VDczer+dyPT1kGvrchcPoFDRb3SpMsSmjX2K76Q8Mgk7GhNajgKlBz0fd9gvFNvF6qSeXTEF2SDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933168; c=relaxed/simple;
	bh=aKj8gMuYMkwUSS0p6qdb4Ji74ApP5YvXouhACnAdZaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNoO4S5unQUhqgk2xnQNX8InzZhTIvksPwHziyICgN9lNY3ngieLGh854PZDExT0Xd1HcdruJb7JeH4dEKhwnYptdUKGmbNTxw/gFrt9tkoa6ZFrN4VyPS6DbzweRTq+p8FSncuOFdub4GJ/mXqciivZsOqYBE4TVZy6fbs/afE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bSpBAx3I; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bSpBAx3I"
Received: (qmail 720 invoked by uid 109); 22 May 2025 16:59:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aKj8gMuYMkwUSS0p6qdb4Ji74ApP5YvXouhACnAdZaQ=; b=bSpBAx3IrGcCj3wMkeYSIXjOc+AFX5y3XTBorZaBoRah2VhvklrYlIOUDG7Mkn+cWa6tI6s77v4t9051zYAz5POpS14GEi7hARZtAJM3EfiE3qzBzzTfBawHy90KmKvymhy4eSdgY5q/RFkskZR/DSPgCnXgLz16PzCW5vnbc05Mv7fvcJXoBEV5NYLf/6DlBkgXwaT7WAalcy33Qwo9eow3fI+jNXRaI64V8NmbK138v2TaoOBTgeokFL9UkKH2JFbdu8nUHF+Q4TSxznwHx5Tyv55pcDZJbukFLPdNtm4Ko4reWX0f1qWt+wkl9g9Hk1vBdijHW1+ogWoOZE+J6A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 16:59:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20552 invoked by uid 111); 22 May 2025 16:59:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 12:59:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 12:59:24 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <20250522165924.GA1613@coredump.intra.peff.net>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
 <20250522053235.GB1134267@coredump.intra.peff.net>
 <xmqqbjrk7ikx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjrk7ikx.fsf@gitster.g>

On Thu, May 22, 2025 at 08:47:58AM -0700, Junio C Hamano wrote:

> So the idea is to leave m->packs[] for unused pack NULL instead of
> magic value, so that users of that array do not need to check?
> 
> I think that is a lot safer than the magic "we know this fails"
> value that existing callers that have long trusted that a non-NULL
> .packs[] element is a valid pack.

Right. It would protect any further users of that assumption that we
missed.

> By the way, I suspect I am not reading the code correctly, but I am
> not sure what fill_midx_entry() does with a failed case.
> 
> 	midx_for_object(&m, pos);
> 	pack_int_id = nth_midxed_pack_int_id(m, pos);
> 
> 	if (prepare_midx_pack(r, m, pack_int_id))
> 		return 0;
> 
> With or without cached failure, this should return 0 when and only
> when m->packs[pack_int_id] is a usable pack.  But what about the
> access on the next line?

I think there's a subtlety here with incremental midx's, in that a pack
id can be "global" within the whole midx chain, or a local index into a
specific chain element's list of packs.

In fill_midx_entry(), I think we get such a global id back from
nth_midxed_pack_int_id(). And then when we hand that to
prepare_midx_pack(), it is converted into a local midx/id pair with:

  pack_int_id = midx_for_pack(&m, pack_int_id);

where the end of that function is the same:

  return pack_int_id - m->num_packs_in_base;

you saw elsewhere. So at that point we have a local midx and index,
which is what prepare_midx_pack() fills via the m->packs[pack_int_id]
field.

So when you say "only when m->packs[pack_int_id] is a usable pack", you
are talking about the local m/pack_int_id within that function.

But back in the caller...

> 	p = m->packs[pack_int_id - m->num_packs_in_base];
> 
> Do we have any guarantee that we called prepare_midx_pack() for 
> the pack at (pack_int_id - m->num_packs_in_base)th slot?  Can p
> be NULL here?  And with the magic "we know this fails" value, can p
> be that magic value?

Our pack_int_id is the global one, so it needs to be adjusted. But this
pack pointer we access is the same one that was filled (or not) by
prepare_midx_pack(). So it cannot be NULL or the magic "fails" value,
because prepare_midx_pack() returned 0.

So I think this code is fine.


One thing that did puzzle me: in prepare_midx_pack() we not only adjust
the pack_int_id, but we may walk back through the midx chain to find the
correct multi_pack_index struct. Wouldn't the caller need to do the
same?

The answer is that it does. The midx_for_object() call in
fill_midx_entry() does that same walk, storing the result in its local
"m" variable. So the walk backwards in prepare_midx_pack() is
superfluous for this particular caller, who we know is already handing
us the desired multi_pack_index struct, and it could just do:

  pack_int_id -= m->num_packs_in_base;

rather than calling midx_for_pack(). But the same is not necessarily
true for other callers, so we should continue calling that function.

I suspect this would all be a bit more obvious if prepare_midx_pack()
simply returned the pack pointer, avoiding the need for callers to look
at m->packs at all (and making it a true cache, internally only to
prepare_midx_pack()).

Looking at other callers of prepare_midx_pack():

  - in fill_packs_from_midx(), we do not adjust our "m" to match the
    index. But that is OK, because we adjust our local index (which we
    get by iterating from 0 to m->num_packs) to a global index when
    calling the function:

      if (prepare_midx_pack(ctx->repo, m, m->num_packs_in_base + i))
	...
      open_pack_index(m->packs[i]);

    which is fine.

  - I'm less sure of the call in expire_midx_packs(). It iterates over
    num_packs in the same way, but does:

      if (prepare_midx_pack(r, m, i))
              continue;

    and then looks at m->packs[i]. That would be wrong if "m" is not the
    first item in the chain. Ah, I see. Earlier we do:

      if (m->base_midx)
              die(_("cannot expire packs from an incremental multi-pack-index"));

    so we know that the global and local ids are equivalent in this
    instance (since the "base" midx . Still seems a bit fragile.

  - There's a similar case in midx-write.c:want_included_pack(). That
    one seems to have the same local/global confusion, but I do not
    obviously see anything preventing it from being fed a non-base midx.
    So it might possibly be buggy?

    Likewise fill_included_packs_batch() in the same file.

    In both cases I think if prepare_midx_pack() returned a pointer, we
    could just use it directly.

  - In nth_bitmapped_pack(), we call midx_for_pack() ourselves to get
    the right midx. That's good, but getting a pack pointer from
    prepare_midx_pack() wouldn't help us, because we still look at the
    midx struct for other reasons.

So I dunno. It might be a useful refactor, but it doesn't make the
problem go away entirely. I'm suspicious of those calls in midx-write.c,
but Taylor can probably say more about whether they're wrong or if
there's some less-obvious reason we'd only see a base midx there.

-Peff
