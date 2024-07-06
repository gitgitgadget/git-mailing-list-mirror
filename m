Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED6200B7
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307492; cv=none; b=tCBUdZn3hYowbD3QFJaTBzimLb6nANtQRBVqQI4/vqyTFIkESQTcaGO9aIBRd6d7YqiilxC6c3zQc06hmNVDG46EZJGoMEtaG3225dmv28Co7qpYO3Rmckx4Lms/dsYcL70mvK13WZmCh3jFMHj3NnM5zZqHcQPuSjzVfzvUxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307492; c=relaxed/simple;
	bh=9YxLAhDKWKv3hrvGrHaVatDMgWQkwDUwlPwBU8uwv5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDMLV/tB2DDNyQA8+6IwfiHtiIZCxqgAqZhS9Z9rpyI56fIEXAn7QXPZHMu9txuCLcIXRTuz8hblBDXlaXowIqErgfP0CJKtTHI5QK7NRnG1DpSUWkalsko8E539e98cL9wb/nWaFHhuThPwGxYefeOx53rtM4K7/9ug5EhIsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31831 invoked by uid 109); 6 Jul 2024 23:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 23:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7050 invoked by uid 111); 6 Jul 2024 23:11:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 19:11:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 19:11:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
Message-ID: <20240706231128.GA746087@coredump.intra.peff.net>
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net>
 <20240706060143.GD698153@coredump.intra.peff.net>
 <xmqqr0c6makb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0c6makb.fsf@gitster.g>

On Sat, Jul 06, 2024 at 03:15:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'll post some patches in a moment:
> >
> >   [1/3]: chainlint.pl: fix line number reporting
> >   [2/3]: t/chainlint: add test_expect_success call to test snippets
> >   [3/3]: t/chainlint: add tests for test body in heredoc
> >
> > with the idea that we'd apply your patch here on top of what Junio has
> > queued in jk/test-body-in-here-doc, and then these three on top.
> 
> Would the final form be to have Eric's preparatory enhancement to
> chainlint and then these three first, and finally the "here-docs"
> conversion I queued from you earlier?

I had planned on top (leaving a brief moment where chainlint would
ignore the new format), but either way is fine.

My biggest question is around my patch 1 above:

  - is it worth squashing in to Eric's patch? I didn't want to do that
    without getting his OK on the approach.

  - instead of bumping the line number in the caller, should the lexer
    record the line number of the here-doc to be used later?

  - the test harness in the Makefile strips the line numbers from the
    chainlint output, so it's hard to verify those fixes. I saw them
    only because the combination of the two bugs meant that the here-doc
    had a "line 0" in it, which was enough to confuse the "sed"
    invocation in the Makefile.

    I did manually verify that it is OK after my fix, but do we want
    that to be part of the chainlint tests? Just leaving the line
    numbers in is a maintenance nightmare, since it depends on the order
    of concatenating all of the tests together (so our "expect" files
    would depend on all of the previous tests). But if we wanted to get
    fancy, we could perhaps store relative offsets in the expect file. I
    think it gets pretty complicated, though, since we print only
    problematic lines.

I was going to give it a few days for Eric to chime in on those points,
and then assemble a final version for you to apply (but I certainly
don't mind if you want to pick up what's here in the meantime).

-Peff
