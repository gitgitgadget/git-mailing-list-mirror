Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA5275864
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455131; cv=none; b=AxNSTMioig4vY7rQSsYo7wKwqgDyMnYH0UozLUqFjT0zEFbQqgpifcf8k9cOBuojOq4nzMM7o8+4K3k8Dt6X0ZgZsKdgJAhk3PsR0QuSm+NEzTWUAccMJCTZeNmz7UJF6YK4tVvxnUwQ14HiLC8oWL1oI+bo+kUHzvTwaFb7qyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455131; c=relaxed/simple;
	bh=qGG6GyQluGi5IqV2lFACfszd+jQHaKOwcPKcnkUr4R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k76EhdsP/p069lPFiCeMakRfKGzC07EGGh1Fk72Zqu5xcKbAW2ciZoav0l5RzWY7aBcizOR8UxComerXcmt16qLa/iYPuWQMObOqSvwrfWeUYNgf2GUWzEtfdF/vou4M7uftETkaI1e/j8yiCj5m0cPA8sZ07eqMQqkg7GX8Hcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=By0qv/sw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="By0qv/sw"
Received: (qmail 19279 invoked by uid 109); 18 Nov 2025 08:38:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qGG6GyQluGi5IqV2lFACfszd+jQHaKOwcPKcnkUr4R4=; b=By0qv/swqxgmkEXh4D2GEFZ1/yotzmhMpsTeXAAtwXeM1fd9tRrgzQIUeAdjH1yFzrGa0HFvmdSVhuj80VLf27uGe5OcQOT6Rndo6PVmWXY9Vd4JVht/kBqhO7Fy5MjmbrCeuzin+wa2oviLCal2xDWGvdQInrtGjInoADQ8S+zbrFcF9AmDg87/vdLgSiWiTkZIiyKM63tMe2robm1tYf4LBKSxYBaIQ7k/DKVnd/BxD7LR6QbEasw//4hETfB2e0vLweQ4HEM54QN5K/voWhmWkBYl90CasO/7JntT97GJl1827RZDXqkm9XJlvRbFZA9KTaXh8OKAyYXvx1L8Yw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 08:38:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27041 invoked by uid 111); 18 Nov 2025 08:38:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 03:38:43 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 03:38:38 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <20251118083838.GA4164207@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080537.GD979063@coredump.intra.peff.net>
 <aRRuzrmbJBW8q4Dd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRRuzrmbJBW8q4Dd@pks.im>

On Wed, Nov 12, 2025 at 12:26:06PM +0100, Patrick Steinhardt wrote:

> > +static long parse_long(const char **ptr, unsigned long *len_p)
> > +{
> > +	const char *s = *ptr;
> > +	unsigned long len = *len_p;
> > +	long ret = 0;
> > +	int sign = 1;
> > +
> > +	while (len && *s == '-') {
> > +		sign *= -1;
> > +		s++;
> > +		len--;
> > +	}
> > +
> > +	while (len) {
> > +		if (!isdigit(*s))
> > +			break;
> > +		ret *= 10;
> > +		ret += *s - '0';
> > +		s++;
> > +		len--;
> > +	}
> > +	*ptr = s;
> > +	*len_p = len;
> > +	return sign * ret;
> > +}
> 
> Hm. I'm not a huge fan of not having any error handling at all. It just
> feels way too fragile for my taste:
> 
>   - As you mention we don't detect overflows, as we would detect them at
>     a later point in time when trying to access index entries at invalid
>     offsets. But if the input is crafted in a way that the overflow ends
>     up with a reasonable index entry we might just as well _not_ detect
>     that an overflow has happened and end up using the wrong index
>     entry.

Yes, but this is true of the original code as well. It does not bother
to check if strtol() saw overflow (and in fact, it is using "int" and
not "long", so it would need to do its own overflow check on top).

But see below.

>   - We don't verify that we even have a number in the first place. We'd
>     simply return "0" in that case and not advance the pointer. This is
>     fine though as we verify that the returned size is non-zero, so we'd
>     detect this case.

I think "0" is accepted at least for it->entry_count. The original did
check that strtol() advanced "ep", and I dropped that. As with the
overflow, it's not a memory safety issue, but it changes how we'd react
to garbage input.

For v2 I've tweaked the interface to return an error code from the
helper, and it will complain if there's no input at all. I didn't add in
overflow checks, as they weren't there originally and are a little
tricky to get right (and I wanted to focus on the memory safety issue).
But they could be easily added to the helper on top of my patches.

-Peff
