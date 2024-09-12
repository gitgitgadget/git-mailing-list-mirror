Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6718C921
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128015; cv=none; b=ViAqmd2BaowGdYTgWQ3I8wTri3MdC0shr5At4UTz78dWm6I7gZIMJgarWcebTLs1xuPrU0VdFmG7iwDp/E5YHLnKIu+PRmttwELkipIUcSCmHbeYWEbY/1Zn+IqkuKl+eX7CNWqy4/0oh5QO4JwAWAZfq2NUJH1MGbbpTX5Popg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128015; c=relaxed/simple;
	bh=KCnDlNYq+RF3nA21ceDYhblyQo7beeHT8TBV1+TNmlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVFXiXSH3+GIccMjOUbBl7moksjmAfeAVEZVZR4U7a5LIr9J0dmuoVBxw40iJ5FTkxgNuJAJRwvJRKtcbry8OAEXM5DOahBoRXebxs2jWy7s7FEAS+dOlVknzvRBY7slhAXfrwZmiCx5YjvnTYfD4+DssxmU4JezND7f7eEIfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16192 invoked by uid 109); 12 Sep 2024 08:00:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 08:00:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22310 invoked by uid 111); 12 Sep 2024 08:00:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 04:00:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 04:00:11 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: remove 'Upload failed tests' directories' step from
 linux32 jobs
Message-ID: <20240912080011.GA556677@coredump.intra.peff.net>
References: <xmqqy140o2kb.fsf@gitster.g>
 <xmqqv7z14y9d.fsf@gitster.g>
 <20240912075631.GA11676@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912075631.GA11676@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 03:56:32AM -0400, Jeff King wrote:

> > If somebody finds a better solution (i.e., a way to extract trash
> > directories of failed tests', with actions/upload-artifact@v1), that
> > can be added later on top.
> 
> I looked at this a bit last night, but as I didn't come up with any
> useful solution, I refrained from replying. I was going to do a brief
> write-up of all of my dead ends, but after banging my head against the
> wall a bit more, I think I might actually have something. ;)
> 
> I think a better path forward is to figure out how to keep up to date
> with the upload-artifact action for all jobs. The root of the issue is
> that all of the runner images are 64-bit, and the actions aren't
> prepared to run inside a 32-bit container. They're written in javascript
> and ship with their own node.js, but it doesn't work inside the
> container due to dynamic linking issues.

So obviously that other email ended up long and full of details. What I
was originally going to say was: "OK, losing artifact uploads for
linux32 is not the end of the world, and it is important to unblock CI
now."

But I _think_ all of those details I sent add up to a possible patch
series. But it probably still makes sense to take your patch here, as it
unblocks CI in the short term. And then I can build the bigger fix on
top of that (it touches the same spot, but in the end both end up
removing that special case).

-Peff
