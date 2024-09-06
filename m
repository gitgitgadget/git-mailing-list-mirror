Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF59159571
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659464; cv=none; b=lfGUzmQC3KD4sEA42aT6uOZs7sDN39gitFr30O/u/GcY2oJXdHC8j78LdtCk1bQ8vzV/L/YcgzzcGksxKQQnXqGXCOR3C0L8pb1lVoP24eSruPMLoGyHGC4cnYKIS/y9WotoqQgWv9Ltf41jjJ2d1YiXh4l4gh3TC1ZkC8acw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659464; c=relaxed/simple;
	bh=P7UuKwEEfsCWr9loC90BoOgRqgdWOo8M+IdBI3L+B5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxDruq3uz0rmRPym2Nqg0pHtAMDjHoW/sOV5hRWPtT8c0s9MI8yv+wWGuiMykyfumaReOHU1xY0By4ZcjHihwPD8oy8EpaLUrarkED66/o8XSlVx9EZ+16ZKgqZhmsmoHcXQPpneo4ngf0j2xHhPtQntvJonJ5hPhFWHAYqquCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24708 invoked by uid 109); 6 Sep 2024 21:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 21:50:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23872 invoked by uid 111); 6 Sep 2024 21:50:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2024 17:50:55 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Sep 2024 17:50:54 -0400
From: Jeff King <peff@peff.net>
To: Brooke Kuhlmann <brooke@alchemists.io>
Cc: git@vger.kernel.org
Subject: Re: Should Git Tag trailer formatting work?
Message-ID: <20240906215054.GA1149961@coredump.intra.peff.net>
References: <E46F3EFF-66D1-4B29-BCF3-6FFAB2504411@alchemists.io>
 <20240906040434.GB4168449@coredump.intra.peff.net>
 <249C7637-0032-4D53-A8A0-83935764334E@alchemists.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <249C7637-0032-4D53-A8A0-83935764334E@alchemists.io>

On Fri, Sep 06, 2024 at 09:22:33AM -0600, Brooke Kuhlmann wrote:

> Yeah, I can render trailer information when using your examples but
> *only* if I disable signing my tags. Here's what my global Git
> configuration looks like:

Ah, OK, that makes sense. We have to parse the trailers from the end,
and the parser is not prepared to handle tags' inline signatures (in
commits, the signatures are embedded in headers, so the trailer parser
doesn't have to worry about them).

I have a rough patch, but it requires making an extra copy of the tag
buffer, since the trailer API needs a NUL-terminated string. I'll see if
I can clean that up to let us parse it in place, and should send
something out in a day or so.

-Peff
