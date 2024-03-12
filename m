Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE119B651
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231574; cv=none; b=avvNPA9jz+g1LggbYQACo9oGCDLJS9/jNQOz0NtR3bi4xYKnmLZ0S+7csLygHQ0Cb+7u/ok4TldCuDA/UjXqZ4rXLAQpRQ7gB4Os8avCNDWhe618f5GJXSK4M793nLPhUszNVz0C4qe3ILbGYEDcbUT/8SzbqknB+IOAixjFvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231574; c=relaxed/simple;
	bh=68m84BucWv9Z7/mVcBlMAayZeVHUwx6Zlp50vYV6Xa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoAe6HOKD73ALPukn3mp2pgFjdrXitwDhwotFiFCAUuQxvn5gIpBnRAHU0pj7KoucF6NqRqIGaqLkPt9Js+jNL2zw2nYic1WzDxsXDSmUlwciJRLUlyoFKfl23/nTwTN7q8JtUI8IeK/6NrIhpNP2Xu149fCVaSRfenM/nkZKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16121 invoked by uid 109); 12 Mar 2024 08:19:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 08:19:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27597 invoked by uid 111); 12 Mar 2024 08:19:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 04:19:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 04:19:31 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 11/15] find multi-byte comment chars in unterminated
 buffers
Message-ID: <20240312081931.GC47852@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092638.GK2080210@coredump.intra.peff.net>
 <3f823e48-572c-4e19-ab76-e6d7cab9461f@web.de>
 <d82e11f2-15c1-4ecb-8c7c-19667d2c5fb4@gmail.com>
 <xmqqfrx0hg01.fsf@gitster.g>
 <66a70346-98e8-44dd-a680-36a21df5f32a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66a70346-98e8-44dd-a680-36a21df5f32a@gmail.com>

On Fri, Mar 08, 2024 at 04:20:12PM +0000, Phillip Wood wrote:

> On 08/03/2024 15:58, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> > 
> > > I agree with your analysis. I do wonder though if we should reject
> > > whitespace and control characters when parsing core.commentChar, it
> > > feels like accepting them is a bug waiting to happen. If
> > > comment_line_char starts with ' ' or '\t' that part will be eaten by
> > > the strspn() above and so starts_with_mem() wont match. Also we will
> > > never match a comment if comment_line_str contains '\n'.
> > 
> > Another thing I was wondering is what we want to do a random
> > byte-sequence that may match from the middle of a multi-byte UTF-8
> > character.
> > 
> > The reason I haven't mentioned these "nonsense input" is because
> > they will at worst only lead to self-denial-of-service to those who
> > are too curious, and will fall into "don't do it then" category.
> 
> We could certainly leave it as-is and tell users they are only hurting
> themselves if they complain when it does not work.

That was mostly my plan. To some degree I think this is orthogonal to my
series. You can already set core.commentChar to space or newline, and
I'm sure the results are not very good. Actually, I guess it is easy to
try:

  git -c core.commentChar=$'\n' commit --allow-empty

treats everything as not-a-comment.

Maybe it's worth forbidding this at the start of the series, and then
carrying it through. I really do think newline is the most special
character here, just because it's obviously going to be meaningful to
all of our line-oriented parsing. So you'll get weird results, as
opposed to broken multibyte characters, where things would still work if
you choose to consistently use them (and arguably we cannot even define
"broken" as the user can use a different encoding).

Likewise, I guess people might complain that their core.commentChar is
NFD and their editor writes out NFC characters or something, and we
don't match. I was hoping we could just punt on that and nobody would
ever notice (certainly I think it is OK to punt for now and somebody who
truly cares can make a utf8_starts_with() or similar).

> > Also, what exactly is the definition of "nonsense" will become can
> > of worms.  I can sympathise if somebody wants to use "#\t" to give
> > themselves a bit more room than usual on the left for visibility,
> > for example, so there might be a case to want whitespace characters.
> 
> That's fair, maybe we could just ban leading whitespace if we do decide to
> restrict core.commentChar

Leading whitespace actually does work, though I think you'd be slightly
insane to use it.

I'm currently using "! COMMENT !" (after using a unicode char for a few
days). It's horribly ugly, but I wanted to see if any bugs cropped up
(and vim's built-in git syntax highlighting colors it correctly ;) ).

-Peff
