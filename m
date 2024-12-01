Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF5134A8
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733092156; cv=none; b=E7kTQeJuCjrhkvRcxzhoWroAUGjYq+o/tyA4ql21lKHxX8SzpnXQx1NSABO0BalUwdo2xRFa++3tIhq/OaoTU1RYcINXCEZKv/w0lFck21XgBPGYkwY4G3/Vt4yn6FCuA1hv2Q4TbAZGO1bsxjEe46y+cBRckbd3Mp7/Wkujqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733092156; c=relaxed/simple;
	bh=B88FVap8GD4V14IryCTDjTVdvUhsbaU1V7RmcFGO66g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEwRF5kQaQVZqdtIfHNQ+wEiDJ6XB9itoHh7RHKPVnJYfFswVh6NGOGkMtJKQlX4XXbGJl1to2aDZ//cRw/8o3PNuQz7UZ4v2ryw/R9Ws+0MjSefkddEt2GdkcBQnaAzFDS3RwO58l4EjmC9t0lJlY3h7HkmqUbWs1cuvPvZLLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CpnXDNEO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CpnXDNEO"
Received: (qmail 4291 invoked by uid 109); 1 Dec 2024 22:29:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B88FVap8GD4V14IryCTDjTVdvUhsbaU1V7RmcFGO66g=; b=CpnXDNEOpo6hCURKpg9TPavuP8wuINHCgAqoDmWJc2++slTJjAZyrHgKxb09hvD9CdOr35TW9unwoOkCR/sE4bLxNCNzeAHyVEUFZkoWFRGQIaFLtuQJwW2c/fnTiiUYWGZzXvDQwgvzFcUZ5GQnqTK8y68VZcpw6FfCDQmIdB+Z6ZmmDxRP+GxMQf/engcdOJCRbhMGA9hjscn/13FAnqhS5EBUVqxHT2bQ0xUvvh/ooBZsv9cygnLsbEKyXcH0C3SmdDZ1uK0Mcs8e5pUZwvwLeOhKqeuIB3NBCHV8sh7GS70JWTy1yHPBBO58reVWzMYlRC45mAUPr/yeIwNiFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 22:29:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14618 invoked by uid 111); 1 Dec 2024 22:29:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 17:29:13 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 17:29:13 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] Start compiling with `-Wsign-compare`
Message-ID: <20241201222913.GH145938@coredump.intra.peff.net>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:21PM +0100, Patrick Steinhardt wrote:

> when compiling with DEVELOPER=YesPlease, we explicitly disable the
> "-Wsign-compare" warning. This is mostly because our code base is full
> of cases where we don't bother at all whether something should be signed
> or unsigned, and enabling the warning would thus cause tons of warnings
> to pop up.
> 
> Unfortunately, disabling this warning also masks real issues. There have
> been multiple CVEs in the Git project that would have been flagged by
> this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
> the vicinity of these CVEs). Furthermore, the final audit report by
> X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
> that it might be a good idea to become more strict in this context.

Yeah, this is something I've wanted to do for a long time. Your subject
line got me all excited that it was done, so I was a little disappointed
to see that it's the start of a long transition. :)

Still, I think it is good to start, and the way you've laid it out seems
pretty reasonable to me.

Regarding those CVEs, I suspect that -Wconversion is at least as
interesting there, as it catches direct assignments that may truncate
(I think those two were a little more complex, but a common issue is
then using the truncated computation to allocate a too-small buffer).

But we have to start somewhere, and this may be a more tractable place.
The patches themselves looked mostly good to me, though the one with the
casts raised my eyebrows a bit (I left further comments there).

Thanks for getting the ball rolling on this.

-Peff
