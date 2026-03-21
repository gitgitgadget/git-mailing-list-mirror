Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB62741B6
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774111191; cv=none; b=FUORhQ+TvvFYyjXJK6KgZzJpofL8XqFBlxmhm7jld4S8xq31QzF32Sht9IJZIwElkiSeDirtZTYMMs2eRVFIn647h1mxYJSEEx3NFqJTj39hMC9k6GrVZdJ2Afmmwk/XPIuSDG6jW0GkZ7fFAeAe0xp+ahTIn11lF/ez82+P3Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774111191; c=relaxed/simple;
	bh=bwrhekTucpNSiaRRWF/X3+Md6acZNYlHwLqJ1fnathA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roHOkRADjEOzIjLl10y68nOQmMAtH51/3d1G3u1tZagDlxfyge7SvtxFG3/RaRaTnw/PKpqKxLH66pChofTNTZam9dynVLf13kyHhojXf9DkpLsvJNFs5f9R+k6fyhd1g/odXnVPs9rb+CZ07xV9DCPt60hSCodGttAU2y9yYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z8JVYJTm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z8JVYJTm"
Received: (qmail 85560 invoked by uid 106); 21 Mar 2026 16:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bwrhekTucpNSiaRRWF/X3+Md6acZNYlHwLqJ1fnathA=; b=Z8JVYJTmYDKNjat2XpdjK97rqzWRKyYWSjoXJiJc+AwkhNEeOYy3PUTzOHoNCuHfLL2ST5Z0923c0faUmG0v/SibnX1P7m9Yn/Jp+KGNLuqj1egas/JwRLHVd1G1mQ/LRYVENLo70te/6ukvbC0IqTorrYrlOIXEixYOz9asg2O//vzxBxtDgggs7fQqfygPxv1Nb4MbbrSGLudg+SNUaNOSih+G3vOQ9aQJkQPZLm05oR1CtgcdLuJ1w5wSysQWznR/hK2iKB2Qgj93pdlPBRYoyVRxaZJOsukNhp4JfHRcSf2qiCqVz0HmFovhBVGnVzc2uV7fzg+oS3ChTE+VdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Mar 2026 16:39:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 120395 invoked by uid 111); 21 Mar 2026 16:39:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 12:39:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 12:39:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260321163941.GA717067@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <xmqqqzpdb172.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzpdb172.fsf@gitster.g>

On Sat, Mar 21, 2026 at 09:24:17AM -0700, Junio C Hamano wrote:

> Here is my second try.  strbuf_getwholeline() does not have to break
> strbuf invariants even tentatively.  We just grab the guts of sb,
> let getdelim() possibly reallocate, and then return it in the normal
> case.
> 
> In the EOF code path, the only special thing we need is when we
> started with slopbuf[] and getdelim() allocated some bytes yet
> returned EOF.  We are expected to free it before returning.

This is similar to what I initially wrote (but revised before sending),
but I don't think it works because...

> +	/* 
> +	 * We haven't touched sb at all; as with the initial "were we
> +	 * already at EOF?" case, return EOF without touching sb.
>  	 */

...this part isn't necessarily true. We handed sb->buf (copied via the
local "buf") to getdelim(). It might have reallocated it behind our
backs and returned the new pointer, and now sb->buf is dangling.

And in that sense, assigning sb->buf to a local buf becomes _more_
confusing, because now we have two copies of a pointer that is being
mutated.

> By the way, the big comment about xrealloc() in the middle, most of
> which is outside the post-context of the first hunk, should be
> updated, as our xrealloc() do not aggressively try to recover these
> days, if I understand correctly.  I left it outside the scope of
> this patch, whose sole focus is to reduce the number of places in
> the codebase that check if sb->buf is NULL.

Yes, I think you're right.

-Peff
