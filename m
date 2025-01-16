Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB31DE2A5
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024258; cv=none; b=U6bK49J6MWeDgt9aca72qH8k4RKF4y3mLyPLTRZbXW+VJkOvP6YLWGKbb0N+9ldSIUSan5o0h1KUHGL6pA0AoA9UFoSCBK1XSgMnnafYPqQux0ITeJ+lcDQEDxMq6KENWWH7IgAc+UqYUCVku7S1N8q92v+AqZqHJXTEVBLsyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024258; c=relaxed/simple;
	bh=39FaRBb7gcJ9oNGtti9f0FcNLL+MUKdDZ0c7dkihvNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOkUIsmd1lrpoXoIUCjPasDWA4sSzzYxs5lrSLpxNyD4/iNWBTA4uDWbpag/4hRKeSrbA24gFlXlTwfuvmRpaqW+g3mXZ606MCzEi8hSUV2wpuTNCWHHOvDN6EwsCqX/dA31V0UNsxOniDi5WVF2kUtDjrlmWYUkMYxEdOWvJKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HnIJr4+n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HnIJr4+n"
Received: (qmail 12347 invoked by uid 109); 16 Jan 2025 10:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=39FaRBb7gcJ9oNGtti9f0FcNLL+MUKdDZ0c7dkihvNM=; b=HnIJr4+nuRWfyxdrSSkB/AC5GoFzmkoJuJp8aF3wqVDp0wj5FAxiZTZxCYfqLNI9QzfihxXI3dQprCF9hEB8BGas3VDay0VGF1rz745ngPLOEabWwNsH+6ewYoZsV2/tKJrUUrk9kajakUY2XHiFBExq4+LpBDtDu8OkWGOvt0LzVdOwJHc3NOeDkYm8z9C6ZuT/ckMGbWG4pLI6ybS+MQWx/jLwFp+mXOLgypQEAIf4YzXZ0f+wvUOMtZ1QnjnbRDUuKsi5SWpEDIbhdsc30A97vKnrOA5VUa8KB2FM8MYqzwAWgrvMPUjE/9kEI+x+zHO9vMvUfQ1PRWVJTAMG/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:44:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24185 invoked by uid 111); 16 Jan 2025 10:44:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:44:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:44:14 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] usage: add show_usage_and_exit_if_asked()
Message-ID: <20250116104414.GD773990@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116012524.1557441-5-gitster@pobox.com>
 <20250116103620.GB773990@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116103620.GB773990@coredump.intra.peff.net>

On Thu, Jan 16, 2025 at 05:36:20AM -0500, Jeff King wrote:

> > -static void vreportf(const char *prefix, const char *err, va_list params)
> > +static void vfdreportf(int fd, const char *prefix, const char *err, va_list params)
> >  {
> >  	char msg[4096];
> >  	char *p, *pend = msg + sizeof(msg);
> > @@ -32,8 +32,14 @@ static void vreportf(const char *prefix, const char *err, va_list params)
> >  	}
> >  
> >  	*(p++) = '\n'; /* we no longer need a NUL */
> > -	fflush(stderr);
> > -	write_in_full(2, msg, p - msg);
> > +	if (fd == 2)
> > +		fflush(stderr);
> > +	write_in_full(fd, msg, p - msg);
> > +}

Oh, I meant to mention also: I wondered about the other references to
stderr in this function. But we hit those only when we fail to format
the error message that was asked for, so continuing to send them to
stderr is the right thing (i.e., your patch is right but I wanted to
help out other reviewers).

-Peff
