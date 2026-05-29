Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901A33F5B0
	for <git@vger.kernel.org>; Fri, 29 May 2026 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043186; cv=none; b=jOdrYXINNI+SMq/NsKg/ttYtY7QJQe6FWVWJur/CQQJb8o2fF6LA6KDaqUaHsultyEXT8qSRGO5k9vPCck2xky8CTUcx2EEd+jz3taZBi6NNkE6glMDw4iUItJMKP4VaYbiPvUXui9Mn6hmDQ1OZm5iKufaeps3wZ7OLn+H9a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043186; c=relaxed/simple;
	bh=0cGKXrSDmF2FlacS5MEX6V4ZJFWtvK5r4lxA1Ldel14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeFZsLsZOwR1aMJ5v45X2UTGV+59T0eBW9L5HxCiz67uPBsXKs3Q+3kVrFcNuCYuLN99L1ZIEP5Ap3zvujf9vdrrPoHyapHNI+22OFXUAq31szTd7InkWa02rb3LOvV8MeWMDyC8u7jUfvYvoanPDtwWPPC9+vBRwGW9f5pAQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EGnthnb9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EGnthnb9"
Received: (qmail 5735 invoked by uid 106); 29 May 2026 08:26:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0cGKXrSDmF2FlacS5MEX6V4ZJFWtvK5r4lxA1Ldel14=; b=EGnthnb9j/FC2V+e5KzN3v1Y8otIbnK/7wz98RCoADP+kvvJEzH3adFIAo0WU42b5AECzkS+OARt/Ou6ITsnii+uJ3eGzCspx6XVrrapQHsZvKDxW5JxRuVdKsrEtXY34uhvTzLCM883IlA8VS0vCrQER+zw/YF2VnFXjjXB29Mq4Ua+EQVKPdgNguOVF8OgUbnn6Cfw+/aZKugs1bcxmzpEjPzkG8KRTFDHwsqtATtA5NjOVF6+BAIgfifwRH4FQjc/q322rKXFgUe4jjI4r4yZwNeUM9tHnXqnZVQGoZ+CSFhg3fJla4CldjB4AIPnwiF1vbOkqrfXagvk1zD1vg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 08:26:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9062 invoked by uid 111); 29 May 2026 08:26:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 04:26:27 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 04:26:22 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/8] pack-bitmap: sort bitmaps before XORing
Message-ID: <20260529082622.GB1106035@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <b0a4f31353a7053ab37b6d8c8f22c69bcfadfe50.1779207127.git.me@ttaylorr.com>
 <20260527100406.GG981444@coredump.intra.peff.net>
 <ahciIDuESxNa9Fzn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ahciIDuESxNa9Fzn@nand.local>

On Wed, May 27, 2026 at 12:56:00PM -0400, Taylor Blau wrote:

> > If you have some spare CPU cycles to burn, I would be interested in a
> > comparison of the bitmap size of your test repo using v2.30.0, v2.31.1,
> > and this patch.
> 
> I started running this experiment, but I don't think I actually have
> enough CPU cycles to let it finish ;-). Pre-v2.31 bitmap generation is
> *really* slow[^1], and after multiple hours (forcing the same selection
> of bitmaps by back-porting and adjusting 'test-tool bitmap') I couldn't
> seem to make any meaningful progress.

Oof. I forgot just how slow it could be. Thanks for trying.

> I'm sure that you could get some plausible numbers out of benchmarking
> this on a smaller repository. In case you're interested, here's the
> patch I wrote on top of v2.30.0:

I tried it myself on linux.git, which is the biggest repo I usually have
on hand. But it seemed to generate the same size back then, and now, and
after your xor-sorting patch. I'm not sure what's different between that
and your super-big test case. Maybe just the number of bitmaps? Maybe
graph structure causing weird order of selection?

I grabbed chromium.git (63GB!) and tried that, too. Its bitmap size
shrinks a tiny bit with this patch (143MB to 140MB). So some
improvement, but not enough of an effect for me to slog through a v2.30
bitmap build just to see if things changed back then.

Regardless of whether the issue was introduced there, or was always
lurking, I think the sort order introduced by this patch is the right
thing to do.

> > Certainly good numbers. The obvious follow-up question is: how does the
> > reading side fare? I'd expect it to be a little better, if only because
> > there are fewer bytes to consider when XOR-ing. But if there's some
> > hidden assumption we're missing, then it could get wildly worse. It
> > would be good to confirm that that didn't happen. ;)
> 
> It doesn't make a huge difference. Prior to this patch, the timings on
> my test repository for 'git rev-list --count --all --objects
> --use-bitmap-index' go from:

OK, good. I wasn't expecting great things, but just wanted to double
check that bad things did not appear.

-Peff
