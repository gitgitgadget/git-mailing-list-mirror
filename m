Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A71C687
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720244659; cv=none; b=YEILZVlcNJwVp2k990o3Pg+MPn1KR7UzpgC8st5wN9n9eao+35KUsWALBCSMwNvw3bwbBhnSGe1dt36o/WRdsDnzA53kPNOoLnptGtiZqeNOuymPHzC+U4yoPncMQaRm4gfR3pSJpcRMVmymOcIAr9FDgLQVq0nqimgQMqHSAAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720244659; c=relaxed/simple;
	bh=pGyEJh59Ri5JJVxJVENA9APjz2mQn6bpso3RPEKzj50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaRac+e4/CH2+Lc1Tv8EcmfkKphTl26GYNTd82WCQ7M4AWwMaHfXkGTCKqJuigCIBE81SzZEGMxCNkju5KkffPmGpUb8OoHEjcODDuUDH9WeCRzpSjjd2MKAw+FWy17l4qFFKTfR4sPjaZcDesu0ikMf0szNFgFxI+nBNMDI5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22856 invoked by uid 109); 6 Jul 2024 05:44:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 05:44:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30928 invoked by uid 111); 6 Jul 2024 05:44:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 01:44:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 01:44:15 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240706054415.GC698153@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
 <20240702011350.GA31739@coredump.intra.peff.net>
 <CAPig+cRJZeNTfOB_ygqo7yoYzko6-2wH11cxu2kHeNNBuxVn7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRJZeNTfOB_ygqo7yoYzko6-2wH11cxu2kHeNNBuxVn7g@mail.gmail.com>

On Tue, Jul 02, 2024 at 05:37:39PM -0400, Eric Sunshine wrote:

> > BTW, there's one non-obvious thing here about why this works. You'd
> > think that:
> >
> >   test_expect_success 'foo' <<\EOT
> >         cat <<-\EOF
> >         this is a here-doc
> >         EOF
> >         echo ok
> >   EOT
> >
> > wouldn't work, because the lexer only has a single here-doc store, and
> > the inner one is going to overwrite the outer. But we don't lex the
> > inner contents of the test snippet until we've processed the
> > test_expect_success line, at which point we've copied it out.
> >
> > So I dunno. It feels a bit hacky, but I think it's how you have to do it
> > anyway.
> 
> It wasn't non-obvious to me, but I suppose it's because I know the
> author, or I am the author, or something.

:) I had a brief moment of panic where I thought "wait, what I sent out
is going to break in this case!" and then was surprised when it worked.

> > > -     $n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\|)$/;
> > > +     $n-- while $n >= 0 && $tokens[$n]->[0] =~ /^(?:[;&\n|]|&&|\|\||<<[A-Za-z]+)$/;
> >
> > One curiosity I noted is that the backslash of my "<<\EOT" seems to be
> > eaten by the lexer (I guess because it doesn't know the special meaning
> > of backslash here, and just does the usual "take the next char
> > literally").
> 
> That's not the reason. It actively strips the backslash because it
> knows that it doesn't care about it after this point and, more
> importantly, because it needs to extract the raw heredoc tag name
> (without the slash or other surrounding quotes) so that it can match
> upon that name (say, "EOF") to find the end of the heredoc body.
> 
> It's mostly an accident of implementation (and probably a throwback to
> chainlint.sed) that it strips the backslash early in
> Lexer::scan_heredoc_tag() even though it doesn't actually have to be
> stripped until Lexer::swallow_heredocs() needs to match the tag name
> to find the end of the heredoc body. Thus, in retrospect, the
> implementation could have retained the backslash (`\EOF`) or quotes
> (`'EOF'` or `"EOF"`) and left it for swallow_heredocs() to strip them
> only when needed.

OK. I think it does make things easier to normalize this a bit, so that
ScriptParser::parse_cmd() doesn't have to worry about all of the various
spellings. If we recorded a single bit for "this was quoted" alongside
the heredoc contents, that would be plenty. But as I (erroneously) said
elsewhere, we can worry about that later if we find something useful to
do with it.

> There's another weird throwback to chainlint.sed in
> Lexer::scan_heredoc_tag() where it transforms `<<-` into `<<\t`, which
> is potentially more than a little confusing, especially since it is (I
> believe) totally unnecessary in the context of chainlint.pl.

Ah, I hadn't noticed that. Looks like we use it in swallow_heredocs() to
read the tag data itself. But importantly the token stream still has
the correct original in it, which we need to correctly match in
ScriptParser::parse_cmd().

> > I think that is OK for our purposes here, though we might
> > in the long run want to raise a linting error if you accidentally used
> > an interpolating here-doc (it's not strictly wrong to do so, but I think
> > we generally frown on it as a style thing).
> 
> Such a linting warning would probably have to be context-sensitive so
> it only triggers for test_expect_* calls.

Yes, definitely.

-Peff
