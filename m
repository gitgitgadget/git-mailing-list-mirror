Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA1A2D
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720243869; cv=none; b=npyx2DThuYI8T3qrdUvJwDVAgRgmXHBMAM3FC3fU9wGoKLMcpy2PCSXBRjBf4Jc1zUva9dUpKnEWHpYwXmxj1F4B6YNtjdDl1z2LY6MZNoE1qVC2P2wiUmAedDI5bL76nJlsr2xG6AOV1A78TL9+JIDcoLuU0ztW0/t4PivSmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720243869; c=relaxed/simple;
	bh=ep5jPVrtjHUP80HEhJJQneRi5oDjuBJ7IJZWkke8YwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljttvUh2qnmVgz4YTlTMUCURaTPnrCrRh5J8y/kDbiLABMQlNO+0TzJnZQ0U1DqrBan7RsxxsJX4Vj3ILLZNQ0VTVUHy6gkjdDEwryarkfkj5qlc4xjbqUtCNExDMe3NJekMJdmPCugGiMya6bB8u6cN/xGurepMy9P0sePyh9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22726 invoked by uid 109); 6 Jul 2024 05:31:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 05:31:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30861 invoked by uid 111); 6 Jul 2024 05:31:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 01:31:03 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 01:31:05 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240706053105.GB698153@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
 <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ6PLZA=s6D1XsdcFeeg-=ffib9QZGFLycsHWLZZ1ibCg@mail.gmail.com>

On Tue, Jul 02, 2024 at 05:25:48PM -0400, Eric Sunshine wrote:

> I created a white-room fix for this issue, as well, before taking a
> look at your patch. The two implementations bear a strong similarity
> which suggests that we agree upon the basic approach.
> 
> My implementation, however, takes a more formal and paranoid stance.
> Rather than squirreling away only the most-recently-seen heredoc body,
> it stores each heredoc body along with the tag which introduced it.
> This makes it robust against cases when multiple heredocs are
> initiated on the same line (even within different parse contexts):
> 
>     cat <<EOFA && x=$(cat <<EOFB &&
>     A body
>     EOFA
>     B body
>     EOFB
> 
> Of course, that's not likely to come up in the context of
> test_expect_* calls, but I prefer the added robustness over the more
> lax approach.

Yes, that's so much better than what I wrote. I didn't engage my brain
very much when I read the in-code comments about multiple tags on the
same line, and I thought you meant:

  cat <<FOO <<BAR
  this is foo
  FOO
  this is bar
  BAR

which is...weird. It does "work" in the sense that "FOO" is a here-doc
that should be skipped past. But it is not doing anything useful; cat
sees only "this is bar" on stdin. So even for this case, the appending
behavior that my patch does would not make sense.

And of course for the actual useful thing, which you wrote above,
appending is just nonsense. Recording and accessing by tag is the right
thing.

> > And then ScriptParser::parse_cmd() just has to recognize that any "<<"
> > token isn't interesting, and that "-" means "read the here-doc".
> 
> In my implementation, the `<<` token is "interesting" because the
> heredoc tag is attached to it, and the tag is needed to pluck the
> heredoc body from the set of saved bodies (since my implementation
> doesn't assume most-recently-seen body is the correct one).

Ah, OK. So it would probably not be that big of a deal to record a
single bit for "this heredoc is interpolated". But until we have
anything useful to do with that information, let's not worry about it
for now.

> > diff --git a/t/chainlint.pl b/t/chainlint.pl
> > @@ -168,12 +168,15 @@ sub swallow_heredocs {
> >                 if (pos($$b) > $start) {
> >                         my $body = substr($$b, $start, pos($$b) - $start);
> > +                       $self->{parser}->{heredoc} .=
> > +                               substr($body, 0, length($body) - length($&));
> >                         $self->{lineno} += () = $body =~ /\n/sg;
> 
> In my implementation, I use regex to strip off the ending tag before
> storing the heredoc body. When I later looked at your implementation,
> I noticed that you used substr() -- which seems preferable -- but
> discovered that it strips too much in some cases. For instance, in
> t0600, I saw that:

Yeah, I was afraid of trying another regex, just because there are
optional bits (like indentation) that we'd have to account for. Since $&
contains the match already, that's all taken care of by the existing
regex. From your follow-up, it sounds like the substr() approach does
work (*phew*).

-Peff
