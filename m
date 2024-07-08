Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01494433DF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429533; cv=none; b=Shluz1H0Jm7oHAZCeZcBcyTU+gFh2nlHh9Lyrqp4vFqDtE5LTa4FFvGXcJwXHhzZj385vrP4Y6DIOA8Hgx/Le6a6i7Nnb7U+vWZXvZKVi3EfaDGyRUBZB7yhmTWDztVTLgqw4GkVOWJqHnT1vG7DXLvY5fLJnyuWSBt/XbXNidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429533; c=relaxed/simple;
	bh=I5XggIAG8i9Z8OX5+2bMHhSMpTTOL1y2BdSeKvo1ms4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ueiu9rYh80Vk5wIlljNeHAKy4P/FPoprBRZWQ70ZDvw/IaEqIc1eSpweY9Nko4Ezz3yWtTf80ASFQLXXmMQDlNj8FntHPVxXFby/I05XVO+BpgI7Oen2tXYlMBWfBkY7QYd9vugOyNM69gjN9dzER9zhddfKpLW32v3e6kmDS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14133 invoked by uid 109); 8 Jul 2024 09:05:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jul 2024 09:05:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20620 invoked by uid 111); 8 Jul 2024 09:05:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jul 2024 05:05:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jul 2024 05:05:30 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240708090530.GC819809@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <CAPig+cRUOSHuNezZfVUT43JGT5BWA3LTbQvKCkD37DxXn=L6Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRUOSHuNezZfVUT43JGT5BWA3LTbQvKCkD37DxXn=L6Jg@mail.gmail.com>

On Sun, Jul 07, 2024 at 11:40:19PM -0400, Eric Sunshine wrote:

> > On the flip side, what about cleaning up? The "heretags" array is
> > emptied as we parse the heredocs in swallow_heredocs(). But I think once
> > a ShellParser's $self->{heredocs}->{FOO} is written, it will hang around
> > forever (even though it's valid only for that one command). Probably not
> > a big deal, but there's probably some correct spot to reset it.
> 
> There are a few reasons I wasn't overly concerned about cleaning up in
> this case:
> 
> (1) The parsers are all short-lived, so the collected heredoc bodies
> won't stick around long anyhow. For each test checked, a TestParser is
> created and destroyed. For each script mentioned on the command-line,
> a ScriptParser is created and destroyed. None of these parsers stick
> around for long, though, a ScriptParser outlives a TestParser.
> 
> (2) The heredoc bodies in question tend to be pretty small, so it's
> not consuming an inordinate amount of memory even if a single parser
> latches bodies of multiple heredocs.
> 
> (3) We tend to be quite consistent about naming our heredoc tag (i.e.
> "EOF", "EOT"), so a latched body in the parser's %heredocs hash is
> very likely to get overwritten, thus the hash is probably not going to
> eat up a lot of memory. Given the entire test suite, I'd be quite
> surprised if any one parser ever latches more than three heredoc
> bodies at a time, and the vast majority of parsers are likely latching
> zero or one heredoc body.
> 
> (4) I couldn't really think of a correct spot to reset %heredocs.

All of that makes sense to me, especially (4). :)

> That said, after reading your message, I did try implementing an
> approach in which the heredoc body gets attached to the `<<` or `<<-`
> token. That way, a heredoc body would be cleaned along with its
> associated lexer token. However, the implementation got too ugly and
> increased cognitive load too much for my liking, so I abandoned it.

OK, thanks for trying. I do think sticking it into the token stream
would make sense, but if the implementation got tricky, it is probably
not worth the effort. We can always revisit it later if we find some
reason that it would be useful to do it that way.

> > OK, mostly as expected. I think the check for "-" here is redundant with
> > what's in check_test(). We could just feed the heredoc body either way,
> > and in the nonsense case of:
> >
> >   test_expect_success 'title' 'test body' <<EOT
> >   nobody reads this!
> >   EOT
> >
> > the heredoc data would just be ignored.
> 
> Right. I went back and forth with this, never sure if this code was
> overkill. On the other hand, we could make this more paranoid and
> complain if we see either of these cases:
> 
> (1) "-" but no heredoc
> (2) heredoc present but something other than "-"

Those seem like good things to check for, and not too hard to add. I'll
see if I can work up some tests.

> > Requiring "<<" at the end is somewhat limiting. E.g. this is valid:
> >
> >   test_expect_success <<EOT 'title' -
> >   the test body
> >   EOT
> 
> True, I didn't even think about that.
> 
> > I don't expect anybody to do that, but it would be nice to be more
> > robust if we can. I think the tokens are still wrapped at this point, so
> > we could read through all of them looking for "<<" anywhere, without
> > getting confused by "$(cat <<INNER_HEREDOC)". I think, anyway (I didn't
> > test).
> 
> Correct. The stuff inside "$(...)" does get parsed and linted, but by
> the time ScriptParser::parse_cmd() sees it, `$(cat <<INNER_HEREDOC)`
> is just a single (string) token.

OK, I'll see if I can generalize it a bit (and add a test).

-Peff
