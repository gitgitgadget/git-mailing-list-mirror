Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7232DCC12
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747966712; cv=none; b=pJ4b6zDntP9q9oq44/n6n1IetJGt5kRdNl63h8YVeXGLKD7Wg5HS72G9rYZDn7YZu36jxCsk/ml2FqK/fW5y40XLHBSEu0BoUQrPAFD94mS5qDkRu5fDxlANuT/1TuOz0hYh0N89LvY0MVJcgjq1+jgxFaNukUTyIEvyZytce3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747966712; c=relaxed/simple;
	bh=Qbd64pPGFtKLwr/vq26QTPiQjPtGGsf0+Aw6SrleqUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOAP3GXSQTgbrt0BgYlO1jR7pr+/xSteKTmBTszcDliMiL1NU6JmEDO0U32yyS9am3dJ+HF5Tg8hWt8ts6pgUdPYKYSBiIJhjuqfrEe6XrNJvs9DRRUHI/Q+tfleF3nITWcWqpneWhtU5OAy8Vl5K/OWdOLrfE7jSV/fqK6X7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=X8zK9Las; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="X8zK9Las"
Received: (qmail 2625 invoked by uid 109); 23 May 2025 02:18:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Qbd64pPGFtKLwr/vq26QTPiQjPtGGsf0+Aw6SrleqUE=; b=X8zK9LasZQhF6wJ6YaYpXs0/f0rPtUpzgWguic1jVTA5hP+EjE0L4DYVQ+IJl1/jhv3k18tGIiVktMCmN9VE/zO220JByL45eaFtDm9nCDLu/PpNDIJb/SZchKW1C4oQILWk89CBEvSfqXVU6sFZXwlJsdvTMy5C2amvhp8XZDn6iJSvwn7lPoE86uc1xIwd4PaayDct5hc7KVksuZWj5rnDrvV+V5eIFM1vRt87jJu424liuYii4ryov4sSqEjK/uYh/XTRmX5lZOHFgInZZlIYLkMKsrISaHe42JUyvHn/tmh6f37k3CQgwYnPujEFOND6qKbnpuMiA9a/BttEbg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 May 2025 02:18:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28176 invoked by uid 111); 23 May 2025 02:18:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 22:18:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 22:18:28 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <20250523021828.GC559000@coredump.intra.peff.net>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
 <20250522053235.GB1134267@coredump.intra.peff.net>
 <aC/QBHBbmYaVUzHV@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aC/QBHBbmYaVUzHV@nand.local>

On Thu, May 22, 2025 at 09:31:48PM -0400, Taylor Blau wrote:

> > Yuck, yet another spot that needs to be aware of the new tri-state
> > value. One alternative is using an auxiliary array to cache the errors,
> > and then only the lookup function needs to care. Like:
> 
> I like this direction, though I dislike having a separate array that we
> need to keep in sync with m->packs. It might be nice to have an array
> like:
> 
>   struct {
>       struct packed_git *p;
>       unsigned err:1;
>   } *packs;
> 
> , which would allow you to keep the error state next to the packed_git
> itself.

In general, yes, I think array-of-struct is better than struct-of-array.
In this particular case the latter is not too bad because the management
is all handled centrally in the midx constructor.

The downside of doing array-of-struct as you propose is that every site
that uses it will need to be modified. But that is at least a one-time
pain and not an ongoing maintenance burden (unlike the "magic" value
approach).

> I wonder if changing the signature to:
> 
>     int prepare_midx_pack(struct repository *r,
>                           struct multi_pack_index *m,
>                           uint32_t pack_int_id,
>                           struct packed_git **p_out);
> 
> would be a good idea. It allows you to pass garbage input (like a
> non-existent pack_int_id) and get a useful error back. It also allows
> you to pass a pack_int_id that is valid, but cannot be loaded and get a
> useful error back via the return value.

Would the return value be a richer set of values than the current
success/fail? If not, then I think just returning the pack pointer does
that fine.

I was also tempted to suggest that it should take a "struct
multi_pack_index **", to return the matching midx as an out-parameter.
That would "just work" for callers that want to look at the surrounding
midx, too.

But maybe it gets weird for ones that are (correctly) expecting to find
the pack within the same midx. I.e., code like this:

  for (i = 0; i < m->num_packs; i++) {
	if (prepare_midx_pack(r, m, i + m->num_packs_in_base))
		die(...);
	/* do something with m->pack[i] */
  }

is correct now, and we _shouldn't_ ever need to switch to a different
"m" inside prepare_midx_pack(). But if we ever did, propagating that up
to the caller would be mighty confusing.

So perhaps better to leave it as-is, and let the caller explicitly do
midx_for_pack() or whatever to find the right "m" as necessary.

> But I think without actually trying it and seeing what the fallout looks
> like, it's hard to say whether or not the above is a step in the right
> direction.

Yup. All of this can wait, too. Patrick's series is fixing its own
localized issue (however he wants to structure the extra bit of
storage). Most of what we're talking about here is future-proofing so it
can happen at our leisure. I think the only other actual bug is the
want_included_pack() one discussed in the other part of the thread.

-Peff
