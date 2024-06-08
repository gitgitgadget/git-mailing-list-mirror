Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628AA482D3
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846164; cv=none; b=AwSc1l0JDCdE0nBGNLIz6ShUy+E8H2XiDxH7ALWfTbjPuHIjwJ6pqcw4Vl8eGS3/8r1uYIs40l2jRKaGhqmlV+NloUDm5dGmRrugKG/S+CdaozaVXDLnYg5BmilHpAZ5sMShSQFXtlCcIYYr7rxWyRU2Q7wT+hASmTYTfsCgJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846164; c=relaxed/simple;
	bh=DYW7lVN09qEYVwwkyv39p4VR8TFCsG5ZKr3AccaZ5A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3f+S0CDCvJ9m5nk1+977U5j8MQkji2eAtQ83LiUieE3JY7Jpst7/wUsuqNs4V4e1PU94pB8ei95wZnCLBuyo8LoO0W2RSoveG2IV3jZ279H7luBoxDaRqviNdv0p3xvKuaT+CjVErQhXTWtSd3Kf6ztH9EfnDFwKmGAcfqbJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9004 invoked by uid 109); 8 Jun 2024 11:29:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 11:29:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29828 invoked by uid 111); 8 Jun 2024 11:29:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 07:29:20 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 07:29:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH 1/2] am: add explicit "--retry" option
Message-ID: <20240608112920.GC2966571@coredump.intra.peff.net>
References: <20240606081724.GA1166769@coredump.intra.peff.net>
 <20240606082114.GA1167215@coredump.intra.peff.net>
 <xmqqzfrym3fu.fsf@gitster.g>
 <xmqqtti6m2yz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtti6m2yz.fsf@gitster.g>

On Thu, Jun 06, 2024 at 09:48:52AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> I think even without the test-terminal cleanup, this is a good thing.
> >> Any time there is a heuristic like isatty(), we should have a way for
> >> the user to be more explicit about what they want().
> >
> > I very often do "git am --no-3" to countermand a failed "git am -3"
> > (or vice versa), so I'll be hit very hard with a need to retrain my
> > fingers.  But I'll live ;-)
> 
> Ah, no, this is not about not paying attention to isatty(0), but
> give us an additional way.  I can see how it would help our tests;
> it would be nicer if the feature also has real world use.

Exactly, you can still do "git am -3" as before, and that's what I'd
expect everyone to do. It is just about letting you be explicit if you
want.

I don't know if it could have real world use or not. In theory if you
had a more complex program driving "git am", you'd need this. But in
practice, I think the overlap between "people who write GUIs for Git"
and "people who think mailing patches is a good idea" is pretty small.
Let alone one with advanced features like "try this patch again with
--3way". ;)

But I do think as a general rule we should never provide any action
_only_ through heuristics like "is stdin a tty". We should let the user
be explicit, and use heuristics to guess the right thing when they don't
feel like being so.

> > "--retry" is a horrible word, in that it makes it sound like it will
> > keep trying to apply the same patch over and over until it applies
> > cleanly or something.  Can't we use "--continue" like everybody else
> > (like "git rebase --continue", etc.), or would that be even more
> > confusing?

There is already "am --continue", but it is not quite the same thing. It
will try to commit the resolved tree state and keep going. Whereas with
--retry we really are trying the same patch again. So it really is "over
and over again", but only once per invocation. ;)

I'm open to a better name if you can come up with one.

-Peff
