Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E171BD020
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394330; cv=none; b=enic3qfsPTSvNRoYRJ6auF1DO8uUc7DfrKoH+64A0zRQBh/14YQdEL461V+1SHjpQK3nwMn5dlGMb0vpOt259YY/gvMxo7kT/x55Xj03xBka4fZmG9OdsFa3YxWh5cpheMTZJF5dZqf+sDOz9JNkFi7I2rUBapQyB/lY+ZnFnuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394330; c=relaxed/simple;
	bh=ZA0DyZVL9/HpchpQxGxnbBZSL6SgfXFz+GHU0CNT7IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlVrcfwmp+7Mh8KmmfN0vD06RUzOsnVMcZmnmfhAekFED5YKPFCAK7SViZiXF5nN714Etw9QdjbouAFOtx27rP9FuHr+VAvH3Bv0r6icDBf3HVOtd7EIrsgS2pAzKrdSt3o7IkD9xBjGUKuRlgUAwmkHG8CmrhBG18j9w5U/ogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iJmTrGH1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iJmTrGH1"
Received: (qmail 20181 invoked by uid 109); 31 Oct 2024 17:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZA0DyZVL9/HpchpQxGxnbBZSL6SgfXFz+GHU0CNT7IU=; b=iJmTrGH1vcRI9JlvE95VOqB1b6pH34CTActhl6ctr4V59UQC0MA/iCngQnbmwUaH1DdLSUdTEVPT1wMSuF/5S3nHg5/+M7XLVaQ7GwZmUwxo1JO1zJpUJMXl3NgSVvxC36yXWpDUlwoay1ZRQ/MJUHiAkqoRkT2t7Gg9Zv1miyNHAzTySRAYoWFsjT9UdE3m49e3Y2gRuZcsDnJuZH32R56HxRVK1TuWgTxsTdjTcrKYRDeY3gEfgQeu3I3E5GBD2RmA6L72DdHae0Ff5MTfG7CMpLgT3TnBwzvygw3BosfUvyi+EKqE2+eABGZXpbrUf8d8hJasfbi6mnPKk1BznQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 17:05:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3711 invoked by uid 111); 31 Oct 2024 17:05:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 13:05:26 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 13:05:26 -0400
From: Jeff King <peff@peff.net>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <20241031170526.GA2277590@coredump.intra.peff.net>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
 <20241031151000.svsa7d2ogcdz7hf6@jpoimboe>
 <20241031153143.GA2275115@coredump.intra.peff.net>
 <20241031162522.3qcolxhgxe4g2zmu@jpoimboe>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031162522.3qcolxhgxe4g2zmu@jpoimboe>

On Thu, Oct 31, 2024 at 09:25:22AM -0700, Josh Poimboeuf wrote:

> But my real development repo, which has many branches and remotes plus
> the historical git repo grafted, still takes 10+ seconds.

If grafts are present, the use of the commit-graph is disabled, because
the point of the commit-graph is precomputing and caching various
properties of commits. Which, absent grafting, are immutable.

I think we talked long ago about computing commit-graphs over the
grafted state, and then using those graphs as long as the graft state
remained the same. But I don't think we ever implemented anything.

Another possibility (that I don't recall we've ever discussed) is
partially using commit graphs. Some commit properties, like generation
numbers, depend on other commits. So a graft at the bottom of history is
going to rewrite the generations for all of the descendants. But we
could still use the graph information to load the parents and trees of
all of the non-grafted commits. Those are still valid even in a grafted
situation, and that's what's providing most of the speed up in this case
(without it, we're literally zlib inflating each commit we traverse in
order to find its parents, versus an integer lookup via the
commit-graph).

That might not be _too_ hard to implement. In theory, anyway. :)

> Note the commit it finishes at is from almost 20 years ago (I have
> historical Linux git history grafted in which goes back to 1991):
> 
> commit d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
> Author: Karsten Keil <kkeil@suse.de>
> Date:   Thu Apr 21 08:30:30 2005 -0700
> 
>     [PATCH] fix for ISDN ippp filtering
> 
>     We do not longer use DLT_LINUX_SLL for activ/pass filters but
>     DLT_PPP_WITHDIRECTION witch need 1 as outbound flag.
> 
>     Signed-off-by: Karsten Keil <kkeil@suse.de>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> Presumably only one candidate matches the "v6.12-rc5" glob (which is an
> exact string, not a wildcard) so it tries to find 9 more but never finds
> any?
> 
> Since it's not a wildcard pattern, I would expect it to stop immediately
> when it reaches the exact match.

Yeah, I think this is just the same issue we've been discussing.

-Peff
