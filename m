Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AF1DE8BE
	for <git@vger.kernel.org>; Fri, 15 May 2026 04:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820063; cv=none; b=XiTLm84dFK4+0MQmOdixveSNKDxXJlE6oFrYd8R+d5TaHIti7yXSJRhvzOIbgjwdWWTfn4O9pQQqIUoMbe0IpmSPtQCgvP9EAIDMBSYI10OCZPGsnE3VMxhAaa7Qv7ET7MQgsbizm/7+5e9OGiPAaRxkpasXmwB0ZNZZKIeJhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820063; c=relaxed/simple;
	bh=6W5Z30ysx4hbVinMErf48ZR1wFEqgNOA+S9GoLy2zAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ/CHZ5djaHtmwKLGDGbZ8/HifC7bT8DDR9NJnorPjqfsslNberG/ija2BLKr3u0IGSxEdkUI8lBgZQiuAoXEniVr8nZlH9Gmy+7c3Nf26e+oa7rkHOm4Mn6Cc+MIMtRErQkgwOUW5pK8Jfj30B1SsoxeFYB1w9p9xq9n4/tSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=flIomoq0; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="flIomoq0"
Received: (qmail 52837 invoked by uid 106); 15 May 2026 04:41:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=6W5Z30ysx4hbVinMErf48ZR1wFEqgNOA+S9GoLy2zAA=; b=flIomoq0mFfKEs3L+PmnYTiplMdz4kAmijUIqA5CCBH4VqfjCHO2U8HYVD3kdPu3aAERllP49D3VRD2Rvkbhou24sLbGT+tGh8PWi0pdJncK8ZWZDz9brRMP71R43rE3PPGwlzAOOaUivQ2NsIDYw11CMtMMP53zo4YIhjHXCV0QvYU+wM6yw3lc37G4g2aH6XS8uUP8CLwWYqsStwCSpULtmZ35NCLl7YJaNmYO9IpcHWL1qLsGvczJ29GZzV4S4U4yidaoU3aO2QP0np5eIavgdOtVuhDIFJEGSVeP/36/oMxTNeOarUF2cN7yxTu5hkayVHstshvz+uJ1dzRGMQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 04:41:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96825 invoked by uid 111); 15 May 2026 04:41:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 00:41:00 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 00:40:59 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] use __builtin_add_overflow() in st_add() with Clang
Message-ID: <20260515044059.GB83595@coredump.intra.peff.net>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <0ded6062-f66a-4713-af24-d1b5aa654823@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ded6062-f66a-4713-af24-d1b5aa654823@web.de>

On Thu, May 14, 2026 at 05:13:46PM +0200, René Scharfe wrote:

> Clang and GCC optimize away comparisons of overflow checks by checking
> the carry flag on x64.  GCC does the same on ARM64, but Clang currently
> (version 22.1) doesn't.
> 
> Provide a variant of st_add() that wraps __builtin_add_overflow() to
> help Clang optimize it.  Use it on all platforms for simplicity.

OK. I probably would have just used the intrinsic everywhere with
__GNUC__, but if gcc is already figuring it out, it doesn't matter in
practice.

> +/* Help Clang; GCC generates the same code for both variants. */
> +#if defined(__clang__)
> +static inline size_t st_add(size_t a, size_t b)
> +{
> +	size_t sum;
> +	if (__builtin_add_overflow(a, b, &sum))
> +		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
> +		    (uintmax_t)a, (uintmax_t)b);
> +	return sum;
> +}
> +#else
>  static inline size_t st_add(size_t a, size_t b)
>  {
>  	if (unsigned_add_overflows(a, b))

It's a shame we can't share more code here, especially the die message.

I guess the ideal primitive is probably a wrapper with the same
interface as __builtin_add_overflow(), which could then be used
everywhere that unsigned_add_overflows() with some minor conversion.

But it gets awkward to do as a macro, and using an inline function runs
into type questions.

-Peff
