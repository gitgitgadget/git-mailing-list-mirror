Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F2847A
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 05:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720243408; cv=none; b=HX4oEhOulCVK8bCvpudZHM9TJDXMah7fCmjyOJtFLjY+CZNOLd9xqOZUttqjnL4/IS2WnZCM3IXafIyMGGB+4/FfyHzhIrGYSZ17sI5Pv6JzuGNNDkTFtJaKLR+VtByRFVNAPIhLBXci7+vGZoUVPsY7HaIr2onHdLVkdzRdWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720243408; c=relaxed/simple;
	bh=KnBi78QNUfEXXLNMoY32M2j5HZA67j/7pZXSfDucibk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muPkHozQ3d+8t5jnufOK06fNinHwbWuQ+nq+WvhiQkRQyJEIn6TDPFp/DiEhHgEb4lrni7zh0SJqqL/4P2Xek3JjoQtNbHtjlvbYthbd813Xdaj6ImrwPT0N62iMRuez251dDpRvROzCM6YHP/M8dQziTPrXeIb6E/bSZchQMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22694 invoked by uid 109); 6 Jul 2024 05:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 05:23:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30809 invoked by uid 111); 6 Jul 2024 05:23:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 01:23:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 01:23:17 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
Message-ID: <20240706052317.GA698153@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240701220840.GA20631@coredump.intra.peff.net>
 <CAPig+cQdioTBinkacLFb7yktm168oB+qyP9MpZtTRE=1aBz5yg@mail.gmail.com>
 <20240702005144.GA27170@coredump.intra.peff.net>
 <20240702211913.GB120950@coredump.intra.peff.net>
 <CAPig+cQna9nDzr9it2=VN-4_hUctG+t4=97s5h9KqmNHS=cuuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQna9nDzr9it2=VN-4_hUctG+t4=97s5h9KqmNHS=cuuw@mail.gmail.com>

On Tue, Jul 02, 2024 at 05:59:46PM -0400, Eric Sunshine wrote:

> > diff --git a/t/Makefile b/t/Makefile
> > @@ -106,18 +106,28 @@ clean: clean-except-prove-cache
> > +       for i in $$(grep -L "'" $(CHAINLINTTESTS_SRC)); do \
> > +               echo "test_expect_success '$$i' - <<\\\\EOT" && \
> > +               sed -e '/^# LINT: /d' $$i && \
> > +               echo "EOT"; \
> > +       done >>'$(CHAINLINTTMP_SQ)'/tests && \
> 
> Unfortunately, `grep -L` is not POSIX.

Yeah, this was just for illustration. Even if it were portable, I don't
think it's a good direction. :)

> >   1. Move the test_expect_success wrapping lines into each
> >      chainlint/*.test file. It's a little bit of extra boilerplate, but
> >      it makes them a bit easier to reason about on their own.
> 
> Yes. This is exactly what I had in mind for moving forward. It's just
> a one-time noise-patch cost but gives us much more flexibility in
> terms of testing.
> 
> It also makes spot-testing the chainlint self-test files much simpler.
> We would be able to do this:
> 
>     ./chainlint.pl chainlint/block.test
> 
> rather than much more painful:
> 
>     { echo "test_expect_success foo '" && cat chainlint/block.test &&
> echo "'"; } >dummy && ./chainlint.pl dummy; rm dummy

Oh, nice. Having just written new chainlint tests, this made checking
them _way_ easier.

> >   2. Add a few new tests that use here-docs with a few variations
> >      ("<<EOT", "<<\EOT", probably a here-doc inside the test here-doc).
> >
> > Does that sound OK to you?
> 
> Absolutely. I'm very much in favor of these changes.

Great! I have patches which I'll send out in a moment.

-Peff
