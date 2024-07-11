Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02219EEB7
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733531; cv=none; b=U+ANVu3O2g3xcjYpWn9giEp0x6tJckPrCb7Jovqjas9Zk6oGcjv3aumQbtp7mgSt9LgP82u1/1KmzMjf1mfEpM3ozpoZjXO+XcRxnVG/spzCq6L27qFV66EP69YDmFqNVxqVXnYvtLzxCQ+pjRSHiFb4eZt/Lp/t/i876pTsHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733531; c=relaxed/simple;
	bh=7GwaVZoZC6Ri8p9Sr8M7o1mQDtUBhTPTW12p8LegqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLbfnyXv18PMWylnao1XFJDAO2jyF4oVkg1OR2t/yVUwb7O7BVuU3kAxGO7Z8GGj+NxT/X69IjNI03FawBWfInqxEKGEsVenGGtMyzVu5393w34NFCO4r+cWLqg55P+AFLmTTWMEC240595r7l4Ww8iJ+5t87SIu4R2RqikqgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19472 invoked by uid 109); 11 Jul 2024 21:32:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jul 2024 21:32:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25195 invoked by uid 111); 11 Jul 2024 21:32:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jul 2024 17:32:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jul 2024 17:32:08 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Ilya Tumaykin <itumaykin@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
Message-ID: <20240711213208.GB3648684@coredump.intra.peff.net>
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
 <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com>
 <xmqq4j937pyf.fsf@gitster.g>
 <20240710093610.GA2076910@coredump.intra.peff.net>
 <xmqqed81xjl7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqed81xjl7.fsf@gitster.g>

On Wed, Jul 10, 2024 at 10:06:28AM -0700, Junio C Hamano wrote:

> > I don't think we'd ever generate this ourselves, but could somebody
> > manually edit a hunk into this shape? When I tried it in practice, it
> > looks like we fail to apply the result even before my patch, though. I'm
> > not sure why that is. If I put "some garbage" without the blank line, we
> > correctly realize it should be discarded. It's possible I'm just holding
> > it wrong.
> 
> I've given up on the "hunk edit" doing wrong things to a patch
> already.  
> 
> The "edit" codepath used to be a lot less careless before Phillip
> whipped it into a much better shape with the series that ended at
> 436d18f2 (Merge branch 'pw/add-p-recount', 2018-03-14), that
> introduced recount_edited_hunk() that special cases "+/-/ ".  It
> already knows that a completely empty line in a patch is an empty
> and unmodified line (which was ported from f4d35a6b (add -p: fix
> counting empty context lines in edited patches, 2018-06-11)), so
> this patch does not have to do anything new there.

Yeah, I was being paranoid without actually thinking through the
implications. As Phillip noted, we do not even run the code I changed on
the edited hunk (which already does handle the empty line). So not only
could I not break it, but it is already doing the right thing thanks to
that earlier work.

> But "recounting" will be fooled by garbage left in the edited
> result, so I think we have done all we can do to resolve possible
> ambiguities.  The patch under discussion is not adding anything new
> and making it any worse, I would say.

Yep, agreed. So modulo a slight inaccuracy in the commit message, I
think my patch is OK. That said, I like what Phillip showed in his
reply. If he wants to wrap that up into a patch, I think it could
replace mine.

-Peff
