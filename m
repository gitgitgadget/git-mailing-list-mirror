Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965972ECD2E
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290699; cv=none; b=kqSEITsFkDCeKZydNE0xgcknPFImk7bsqnJiwpH0IhUXK6u0fZi+DEyTJ/ZAmSG/Ga1myW1GBeS3iHE4jP4kyht4qftE7BC9pAro28t4mUBxUPOFa291iXnwZQSHoVMdJ26eO25PbIqzxFx+1eUDKKlyZu5xRVz958u3FYKuwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290699; c=relaxed/simple;
	bh=mQ4L89vTWNr5V1+L2YEGiqwrNHtadQY4G29Rxe121zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOW1XK8fHhhRkn/8yY5fIy+L8nZ4XKsFlT9xKIfHREBid32FA2eecKNM4p6+wv2mIAuqNxEetEARZrmoJAjsVdAJszgpA7huKa7Smx60agTtub+CXKH5blU00BWUR5tihobF6jTOw858vKm9Ft/X9TVZzfgI+5GrnnisXtJucnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iP+yN5Eq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iP+yN5Eq"
Received: (qmail 430865 invoked by uid 109); 4 Nov 2025 21:11:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mQ4L89vTWNr5V1+L2YEGiqwrNHtadQY4G29Rxe121zM=; b=iP+yN5EqKooQjakvxyzAFxKLeLWJteZyBCDYinZi5DQ4ado8s+mNLWWxJCKAfDcu3MVNCvRfknleoEBgQgaEfH1pJ2rIwIz09+WY0lnavqc2W9uKGU1w8rfX3kCYOBHvkkWYd5j7rQFgd8Poq71cpdvYtA3P0e3KwUa96itk5+xtf77gq5957vlFn89DpU1HIKJxNpMFGqVGao53O6qF8V6xM0HuHGnGKq1EfZ4P8vqmUPUAaC9MPJODS8XBFhPjDjMswnWGomTcBj9WaeO7iNaZgRWthIyq8M9MqlVUvqttftintvWvcQUlD74jEL89SUVQ5qjuTeZ0GIy2m8cP2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Nov 2025 21:11:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 677362 invoked by uid 111); 4 Nov 2025 21:11:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Nov 2025 16:11:30 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Nov 2025 16:11:30 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: fix stale parsed objects
Message-ID: <20251104211130.GA2618884@coredump.intra.peff.net>
References: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
 <xmqqpl9xps3x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl9xps3x.fsf@gitster.g>

On Tue, Nov 04, 2025 at 10:31:14AM -0800, Junio C Hamano wrote:

> > As reported by Junio in <xmqqo6pjt2wn.fsf@gitster.g>. This applies
> > directly on top of ps/ref-peeled-tags at 054f5f457e (ref-filter: parse
> > objects on demand, 2025-10-23)
> >
> > Thanks!
> 
> Thanks.  As we stop reusing a stale maybe_object and instead start
> parsing the right object when we need to, I wondered if the "on
> demand" commit needs a new benchmark, but the example cited in the
> message used %(raw) so it would not be affected, I guess.

Yeah. The point was to speed up stuff like %(raw) that needs the object
contents but doesn't want to do the parse. So it never looked at
maybe_object in the first place, which is why it got faster.

I actually wonder if there is any other placeholder that benefits at
all. The ref-filter code already tries to avoid doing unneeded work. The
most obvious there is not loading the object at all, which is why stuff
like "%(refname) %(objectname)" is faster than adding in %(raw), which
needs the object contents (but no parsing). And likewise stuff like
%(tag) needs parsing, and thus also triggers loading the object.

So 054f5f457e helps formats which require the object contents but _not_
parsing. I can't think of another placeholder besides %(raw) which would
benefit from that.

What _would_ help more formats is doing the parsing more progressively,
skipping parts that aren't needed. If you just want %(tree), for
example, then:

  1. You don't need to look at non-commit objects.

  2. You can stop parsing the commit objects after the "tree" line.

But doing that is more involved. So not an argument against the patch,
but just noting its limitations. ;)

I think the parser in pretty.c tries to be a bit more careful here. It
would be nice if we could unify these.

-Peff
