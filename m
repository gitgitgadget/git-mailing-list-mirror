Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401E13AD3F
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908162; cv=none; b=mf/2r1rljXKxXwp5gU1IGYJXs4SDZXDxuciSOrupRoWBcEpWrhS3vs8NNwoBYBUDrTor560ksXy7HxCR3YQ7ScN/Xw2tSTm1fP72z9dtbWaz0BHnTXDoM/mYFz9N+/B1xzPHOnLFIPZnk9rLoHz+1id8LccAw3FvQlKMVx4bKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908162; c=relaxed/simple;
	bh=OkoSiAz98kZDR0/XoPwbbiq58hm196OZ+/Ci9uOV3mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfbYcoelfReVxfIONedW2NyBtancdBqnydhH0shmQtXoMA0y7ED5VbbN/XI8YCcr/OR83YSMKlsX0nIxiHUo6yZVGcuOs9U/ojtNUx31Zt3R5TPrKL4cjDj8ufURK1iuESMnj3GInD6CzMJUYOLc6l9UG/qvBnhAv8tpp0Q3eRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fm9jYWwX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fm9jYWwX"
Received: (qmail 27184 invoked by uid 109); 19 Jul 2025 06:55:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=OkoSiAz98kZDR0/XoPwbbiq58hm196OZ+/Ci9uOV3mw=; b=fm9jYWwX/wXVKVc2uyKoEAwEHg2E6iW/wgK+pJVBdjIv1xsb9cP6ZZ635YtoxBvfklMqeafo1YBIqu7A19u2ZMZSGZW1odEcfAX7hPP/tV/oJfMPouFXSWTXNoEk27//DP0AvisTKA4hq3kiW3F+TEb14eXlYmRgdfQgCYZdsUoonU5ts51NlIxySCo39q+x2lAI2j9rE7lAgkslEyT4EFpBo888u6GecZmQ7MCd0FAjMgRdwM4pKhhQoVHPK0SBZvB79qCwggpk/9aInsAcBh9amk5ZDP8MWLAvb0CZBvUFW7KLtEGXhKdemCrwwVL/D7yfYppfNH4oJhtVX9b0yg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 06:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4555 invoked by uid 111); 19 Jul 2025 06:56:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 02:56:03 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 02:55:58 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to
 prio_queue
Message-ID: <20250719065558.GD705356@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
 <20250716050540.GB1396022@coredump.intra.peff.net>
 <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0950e32-b4fa-4aff-8b5c-58c734b880b2@web.de>

On Wed, Jul 16, 2025 at 11:39:49AM +0200, René Scharfe wrote:

> On 7/16/25 7:05 AM, Jeff King wrote:
> > On Tue, Jul 15, 2025 at 04:51:07PM +0200, René Scharfe wrote:
> > 
> >> pop_most_recent_commit() calls commit_list_insert_by_date(), which and
> >> is itself called in a loop, which can lead to quadratic complexity.
> >> Replace the commit_list with a prio_queue to ensure logarithmic worst
> >> case complexity and convert all three users.
> > 
> > I guess I'm cc'd because of my frequent complains about the quadratic
> > nature of our commit lists? :)
> 
> And because you introduced prio_queue.

I think that was Junio, but I think I can be counted as a cheerleader
for the topic. :)

> > Mostly I asked because I had to look at pop_most_recent_commit() to see
> > what operation would be made faster here. Looks like it's mostly ":/",
> > but maybe also fetch's mark_recent_complete_commits()? I guess we might
> > hit that if you have a huge number of refs?
> 
> The :/ handling was the easiest to test for me.  fetch_pack() and
> walker_fetch() require some server side to set up, which seems not worth
> it just to demonstrate quadratic behavior.  Having thousands of refs
> would make the list long enough to notice, as would having lots of
> merges.

OK, that makes sense. Just making sure I understand the benefits.

> My general idea is to get rid of commit_list_insert_by_date() eventually
> to avoid quadratic complexity.

Yeah, it's certainly at the root of many such problems we've seen over
the years.

> > I actually have a series turning rev_info.commits into a prio_queue
> > which I need to polish up (mostly just writing commit messages; I've
> > been running with it for almost 2 years without trouble). Ironically it
> > does not touch this spot, as these commit lists are formed on their own.
> 
> That is not a coincidence.  I had a look at that series and tried to
> reach its goals while keeping rev_info.commits a commit_list.  Why?
> Mostly being vaguely uncomfortable with prio_queue' memory overhead,
> lack of type safety and dual use as a stack.  I still used it, but only
> as local variable, not in the central struct rev_info.

Hmm, I would have thought prio_queue had less memory overhead. You're
spending one pointer per entry in a packed array, versus list nodes. But
it's true that it doesn't shrink as items are removed (though that is
something we _could_ implement).

The dual use as a stack actually came in handy for my series, IIRC.
There are spots which use a commit_list but care about a specific order,
and my list/prio_queue conversion helpers use that to create a non-heap
prio_queue that just returns the items in the original order (it's
actually FIFO, but we can get that by reversing).

I dunno. That's kind of horrible when I say it out loud, but it did make
things work. I'm surprised that your attempt ended up with a performance
hit when mine did not. Mine tried not to be clever, and even leaves in
place a few spots where we convert between the two representations to
satisfy various interfaces (with the goal that we'd probably eventually
switch to prio_queue everywhere).

-Peff
