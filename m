Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89788F6D
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722117927; cv=none; b=kikfZyPIoz8zI6Xc0UhyZNls0LN5cl3/PbmRFHuh6mR9Vmfb18KsibpvRrIcq7lbwatQ69cx/dgT8mDbolLA7uz1mQ6jzAWEQ03mlpapx5NF60gU+KVD7ptKNVaOYmUT7vKOb1j//kC7yVqJ40iHy7lbzceOpPvp2y2wowfKUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722117927; c=relaxed/simple;
	bh=YrTPNCAXofV+i01jyrImjmudraagzJhOzLTsIHkLqWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsIBwd354CSXHI+6kT6bLs8bG25GvnH/svJd17bqX4Hw+0eG+VeduP3KEGxQY9+RZ7B6A4k5BAF1mf2OjMmFZrJ7OUsxBfGkjYriEpwDdPUAweGD2Lsyj6Ar3GuSxAG+f1wiJKzwWyrbzkRqKr4OUnMrONFCurgdcdzSAneCOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3955 invoked by uid 109); 27 Jul 2024 22:05:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Jul 2024 22:05:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18063 invoked by uid 111); 27 Jul 2024 22:05:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Jul 2024 18:05:26 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 27 Jul 2024 18:05:24 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
Message-ID: <20240727220524.GA1263829@coredump.intra.peff.net>
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
 <20240723021900.388020-3-gitster@pobox.com>
 <20240726050253.GC642208@coredump.intra.peff.net>
 <xmqqikwsyz6d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikwsyz6d.fsf@gitster.g>

On Fri, Jul 26, 2024 at 08:02:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This may be a dumb question, but... will this always work, if the config
> > option is not necessarily an exact path, and might have globbing
> > characters in it?
> >
> > We don't currently treat it like a wildmatch glob, but:
> >
> >   1. We do allow "/*" on the end. Should we strip that off so it doesn't
> >      confuse the realpath lookup?
> 
> This one I wondered, too, but the test seems to show that it is OK ;-)

Hmm. Would it depend on what's in the filesystem, though? That is, if I
had a file named "*", would it get confused?

That is unlikely in normal use, of course, but can we do something
tricky with it? I think probably no? Accessing "/path/to/*" implies that
the user meant to allow all of "/path/to", which would include that. So
the most an attacker could do is _disable_ safe.directory for something
that should have it on.

> >   2. This is shutting the door on using wildmatch or similar in the
> >      future. Is that OK?
> 
> I am inclined to keep this part and any other logic that are meant
> to address "security" things simple and stupid.  So in that sense,
> I am not so worried that it would be hard to retrofit wildmatch to
> this codepath.

That's my general instinct, too. But I wanted to make sure we were
explicit about the choice.

> > Should we be quiet there, and maybe fall back to using the
> > non-normalized path (though I guess if we could not normalize it, that
> > probably means it could never match anyway)?
> 
> The only reason I did the warning was because it makes me feel a bit
> uneasy to have a configuration item that either gets ignored or
> triggers a fallback behaviour and not to tell users about it.  Other
> than that, I have no strong preference.

Yes, that was my first thought, too, but I noticed the bogus messages
while playing with it. I _think_ if it triggers it means that it points
to something that doesn't exist (or you don't have permission to read),
in which case it would by definition not have matched. So silently
ignoring might not be so bad.

-Peff
