Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD213E8BF
	for <git@vger.kernel.org>; Thu, 23 May 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458549; cv=none; b=U+qCii9tZqLjx5I5JryBFXHqVS4n7RjEMvt4oKbkJbteKb141GpJfX9976ua33hyiKthxpGu9zDf4hIDBWnr8OnzJkVc1+jabr1NNrF3rurl/4m44dFC1+nGN5cbNAnEaoz36zVBV6d5lbB3OFDvmw/XVb0gZa5n1j1Pq9kiWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458549; c=relaxed/simple;
	bh=mjPQer1aejdGWTLMNWbTQuQDeQ2yZhRPzukfa7hNhKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHPleM8B3+pFREq2Y6VBtz77QzkM4mtJ5D+5XMuyj1YQDb0hPqZRo1I/vn4z2EeEySc+ewDYIIX+HuTPthjRsKKjCzthbOUhrgNXnLVp7gE4Hod+dHQ99DC3jIhEIw9W807OgUXY1epzAlRli7mN1W+ohRp1FU6stRJmtgw94aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31232 invoked by uid 109); 23 May 2024 10:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 10:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28773 invoked by uid 111); 23 May 2024 10:02:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 06:02:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 06:02:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/30] config: introduce git_config_float()
Message-ID: <20240523100225.GA1308330@coredump.intra.peff.net>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <3070135eb4b9bd16117e82f1817c112c56a24b55.1716318089.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3070135eb4b9bd16117e82f1817c112c56a24b55.1716318089.git.me@ttaylorr.com>

On Tue, May 21, 2024 at 03:02:29PM -0400, Taylor Blau wrote:

> Future commits will want to parse a floating point value from
> configuration, but we have no way to parse such a value prior to this
> patch.
> 
> The core of the routine is implemented in git_parse_float(). Unlike
> git_parse_unsigned() and git_parse_signed(), however, the function
> implemented here only works on type "float", and not related types like
> "double", or "long double".
> 
> This is because "double" and "long double" use different functions to
> convert from ASCII strings to floating point values (strtod() and
> strtold(), respectively). Likewise, there is no pointer type that can
> assign to any of these values (except for "void *"), so the only way to
> define this trio of functions would be with a macro expansion that is
> parameterized over the floating point type and conversion function.

I agree it doesn't make sense to support both. But if we have to choose
between the two, should we just use "double"?

I doubt you need the extra precision for your case, but I also doubt
that the speed/storage benefits of "float" would matter. And support for
"float" in C is kind of weird. There is no "float" specifier for printf.
And according to my copy of strtof(3), until C99 we only had strtod()!


Regarding using non-integers at all, I do wonder how much we need them.
We've usually stuck to integers in other spots, even if it means a sort
of pseudo-fixed-point (e.g., rename scores). Looking ahead, you're using
these for the power-series knobs. I guess it would be pretty confusing
to try to force integers there. I dunno. Not really an objection, but I
just wonder if it was something you considered.

-Peff
