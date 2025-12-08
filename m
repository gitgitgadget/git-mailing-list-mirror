Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF7C2FD68E
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224911; cv=none; b=GL/0Jgd5b21IlSng4cqoOMJmR8+oonUyqH60xrMsDrIT2vd37BTZq2VE201b59DI254pJ04DsBZN3+D+M8C9vhcaMH9HbRRsoHD/tT4bApU2NzXoCGUQUtpL1Dawi7+Uk5/2gvwsQo6vF4tRWyz0Kxfl9Np6tDupT12cBGRqOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224911; c=relaxed/simple;
	bh=RkGNP6ZQGpmD+06YtpeFg6I5pHYtHkBU5XvkTL5lzqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKzLnlOAWTCHk4yy6OYLV6cm0x6Z3Dt4klj4fx7sH2ohDUj6wU1gZNmoXE/98y5hRubNePJuhHSDUOuvugzPR411b2uZ3JHNamMa1UALjlxlSgur+8LZZdrTYP9cl93RGbZlJyG47LRLun5Bz6u8PXrOnnpipg9Ps+s+iAs9DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WN0LFkwo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WN0LFkwo"
Received: (qmail 305539 invoked by uid 109); 8 Dec 2025 20:15:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RkGNP6ZQGpmD+06YtpeFg6I5pHYtHkBU5XvkTL5lzqs=; b=WN0LFkwo8Xuix5Ll0WiaXOCgjeBKaGebF12mxM+XM+IB/mnlBemWwuirmxt2RATG1qXLdP9WKz1PmkH5SZaOYzUa8RoTJaRj6gqBqxM7V8SYicuNPBw7gMpg4Qr8qMDO3uuof2tXhv5bodEfkobJPuoTMBnGd2UL5+uFxMDsa1+TU245/8CuFozDzMXeSvqYH22IwoFOMORs1RGH6kt/a/kF6SIYUtxJlgCIRo5qUSoZJefGbn3V7ZIojl53oalsq3LnQScv23hS084tUhla85EBtpxFAubsvylgy7NqaW2Sm8zqD1RTWOLbwZGibJvSHlfHsMECnwqSnH9JiPCs9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Dec 2025 20:15:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 389861 invoked by uid 111); 8 Dec 2025 20:15:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Dec 2025 15:15:03 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Dec 2025 15:15:01 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
Message-ID: <20251208201501.GA216526@coredump.intra.peff.net>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
 <20251128205514.GA605489@coredump.intra.peff.net>
 <87bjk9w5yv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bjk9w5yv.fsf@iotcl.com>

On Mon, Dec 08, 2025 at 12:47:20PM +0100, Toon Claes wrote:

> >     So it would probably have to be limited to something like:
> >
> >       CLEAR_ARRAY(lm->scratch->words, lm->scratch->word_alloc);
> >
> >     which I'd guess would cover most memset cases. But this is getting
> >     specific enough that maybe the macro is making things more confusing
> >     rather than less.
> 
> I've submitted a v2 that introduces MEMZERO_ARRAY(). I'm curious what
> the responses on this proposal are?

I think it looks fine, though as Junio noted, the original is already in
next so it would have to be a patch on top.

Is such a macro worth it? I guess we'd be able to see if there are other
possible sites with something like:

  git grep 'memset(.*0,.*\* \?sizeof'

that's looking for memsets of "0" that also multiply by sizeof. Looks
like there are a few:

  add-patch.c:    memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
  builtin/last-modified.c:        memset(lm->scratch->words, 0x0, lm->scratch->word_alloc * sizeof(eword_t));
  compat/simple-ipc/ipc-win32.c:  memset(ea, 0, NR_EA * sizeof(EXPLICIT_ACCESS));
  diff-delta.c:   memset(hash, 0, hsize * sizeof(*hash));
  hashmap.c:      memset(map->table, 0, map->tablesize * sizeof(struct hashmap_entry *));
  pack-revindex.c:                memset(pos, 0, BUCKETS * sizeof(*pos));

The first one is an oddball, but the other five could use it. So if we
were to do a patch adding MEMZERO_ARRAY(), it would probably make sense
to convert those spots. I'd be OK either way.

-Peff
