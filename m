Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F632E143
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989462; cv=none; b=C7Mah2QAtEhpIFLxfcBrmfxNvoq/QeS1oo7Rnx8xmTvV5Kjcz6dB636i3YIsZsVXCBRoXBuFZdQptQ+QNps670XoT/fTJ3wN8me4Ahl3NW+tjB8DeHdBARfhs5LCXEKnYUGuYFTGjTSe5+nr9nLJQ1k5u+4r+7TRFsf2zCEY7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989462; c=relaxed/simple;
	bh=AomykgFot2jiiU1l/FzFFQzfD6pTsqJTGrtS68M+gQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/Vp0VTwFA6aEllpblHON845q9HPHT0jGUxABgKnIxj+X+oSGMFZ1C8ph0IMzfVeLnY5ra+pI0qs8usjI7NOEQ/LEGErLforCxZ8FcbIHtZgf4xxnM6hEYH4fTpJvF2QWprdWyvky+qZ6s2P9gMnKw86x/3OtGFFosozcEthOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B60TyS6J; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B60TyS6J"
Received: (qmail 56529 invoked by uid 106); 6 Aug 2026 04:10:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AomykgFot2jiiU1l/FzFFQzfD6pTsqJTGrtS68M+gQI=; b=B60TyS6JuASq1G2ylxQ6jgR5875vzzkHGeRa4Qer7SccYJoYjL1EjK1Adi9Shuum/eX1QpybL/4MejVBGDmN2QCwLKSWGnaL7h/xBtfQW2TILbLw4L+rueF/nQ/Pg7E6d5Ul0trpd/7PkMPYggyRPPKIAPlCW4mKDqnYo6bbKFmXZDdC/k69HrCFASv51qdixScfYhpPOgomIz3fe7I1tRLkdNOQvfvV4MEERnwApNbuxT2oYbRZIlj43tBIz19haeqq16G2WyZTYH/9k21wY4DsEnkiw4kviwnflRmhA33zwx/aITpG+MtYrIwj1izwZABuslbxxa+XFeDHjjSG0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Aug 2026 04:10:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 86378 invoked by uid 111); 6 Aug 2026 04:10:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Aug 2026 00:10:53 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Aug 2026 00:10:52 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: Question on textconv
Message-ID: <20260806041052.GA1610686@coredump.intra.peff.net>
References: <017e01dd2441$476839f0$d638add0$@nexbridge.com>
 <20260805045026.GA972736@coredump.intra.peff.net>
 <020201dd24e3$89ad1220$9d073660$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <020201dd24e3$89ad1220$9d073660$@nexbridge.com>

On Wed, Aug 05, 2026 at 10:05:52AM -0400, rsbecker@nexbridge.com wrote:

> Could we extend textconv to support %f (the original path) if specified in the
> textconv configuration? That would solve the ambiguity of what is being supplied.

In theory, yes. But there is one gotcha: there's a system for caching
textconv output in git-notes, and it uses only the original blob id as
the cache key.

So I'm not opposed to adding something like %f, as long as the patch to
do so handles the caching problem (even if it just refuses to cache,
that would be much better than returning possibly-wrong results).

That said, it sounds like you just want %f to work around a bug where
the content is not provided. Probably fixing the bug is a better path
forward. Looking at the working tree file to get the contents will not
always be correct (e.g., if you're diffing an old tree).

-Peff
