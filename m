Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737318C332
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664670; cv=none; b=JpiwNpJjbtDu8sYQl++BS+JbihI2lykzxpx+CY3ieo0EYiB+ktdeNkglvGhQJrfR5HDvYo6TGWdcpFhlXthVXqLFsBEzbqI5+3nJ/eJFY5lLoG9exT/bp92aqkXG5PkMkacsT65ar+B56/CkzsQ203CstiZcu44Fkl1dsr6As+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664670; c=relaxed/simple;
	bh=06nAIa2Mbk6oQFhSs8PE86lEuYJjtXSAAnVTEH/J03s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gibNKFN2Zw8cpJQDuA3B6PRuJvXKCXlMsC3QZ7MMAuvlJpb6OkTqYPTYV1QaIgt0ItcwqRC8/tjIMWfXQqbTiCHKt6ZaAfmJsd+2LljjfN+XFRjmUhhCor8Og6spqUwzbQ/IP8QgzS7a8Xz0AAkqhz50tFqmayWwnlHMqBPvEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TzvlRmUY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TzvlRmUY"
Received: (qmail 14804 invoked by uid 109); 15 Nov 2024 09:57:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=06nAIa2Mbk6oQFhSs8PE86lEuYJjtXSAAnVTEH/J03s=; b=TzvlRmUYBQXm5cXt18cy3DECqZB6eXBA0nba3yBSQhQBcpDzh5U2dh0/OUJkYD6mu1+KKXK+gbE6ruEefM53UoC6865ibXl2kRwyVBact0yX5qneWQQ3FuRkZySncO0l6sWygvWQtxGAUrYDzjM0dNnQn3Yyv6yJRbje/tMq1srRJFkMJyaJ5U2sAdX7EBnKBXoSlJ0Ag8cm7d3PDIp66SGezXr0wLmyTzjOmdl1i7FwKCJZkJq+CDBxf8bxy6Gyxvk12cUVmdBUUifDld3+S4QQ2u2JUOuxAPH/6cBCgIIA8qRZKHmGW34Nsy40VphNgx7hL4IXZQkUQUi4ABZ/0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Nov 2024 09:57:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7020 invoked by uid 111); 15 Nov 2024 09:57:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2024 04:57:52 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Nov 2024 04:57:46 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
Message-ID: <20241115095746.GD1749331@coredump.intra.peff.net>
References: <cover.1731518931.git.me@ttaylorr.com>
 <2520abf24a8a194b3f7040e218f878dc88a740a0.1731518931.git.me@ttaylorr.com>
 <20241114002504.GB1140565@coredump.intra.peff.net>
 <ZzX9vT4GVqCyfFUE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzX9vT4GVqCyfFUE@nand.local>

On Thu, Nov 14, 2024 at 08:40:13AM -0500, Taylor Blau wrote:

> > I do think the explanation in the message of the first commit would be a
> > lot simpler if it were simply combined into this patch. With them split
> > you effectively have to explain the problem twice. I don't feel that
> > strongly about changing it, though.
> 
> I always seem to go back and forth on that. I feel somewhat strongly
> that for complicated regression fixes that we should demonstrate the
> existing failure mode in a separate commit with a test_expect_failure.
> That forces the author to ensure they really understand the bug and can
> produce a minimal (or close to it) reproduction.
> 
> It also makes it easier to demonstrate that the fix actually does what
> it says, instead of assuming that the test fails without the fix applied
> (and passes with it applied).
> 
> That does force the author to potentially explain the bug twice. In my
> experience, I tend to keep the explanation in the first patch relatively
> brief, hinting at details that will appear in the subsequent patch
> instead of explaining them in full detail.
> 
> So I dunno. It's a tradeoff for sure, but I think having an explicit
> point in the log that demonstrates the existing bug is valuable.

I do think it's important to make sure your tests fail in the way you
expect. I can't count the number of times I have _thought_ I had a
solution and then after seeing that the test didn't fail without my
patch, had to go back and study it more. :)

But I generally do it with:

  # build the old version
  git checkout HEAD^
  make

  # now go back to the new and test _without_ building
  git checkout -
  cd t && ./t1234-whatever.sh

(or more likely with a "break" in "git rebase -i" for a longer series).

That is, I'm running a mis-matched test/build combo. I guess in one
sense that is horrible and I'm a bad person. It is easy to make a
mistake and test the wrong thing. But it does make the resulting patches
easier to read/review, IMHO.

  As an aside, I think this kind of mismatch gets awkward with the
  proposed meson out-of-tree build stuff. Running the tests through
  meson would presumably trigger a build. And running without means
  pointing to the built git binaries manually.

-Peff
