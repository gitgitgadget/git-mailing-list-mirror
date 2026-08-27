Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26E3644D4
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806525; cv=none; b=Kncbg3QFshQSBmJvR9f4KUH+VEq/Fz/ILS9ZDZWBslkAjcMWr6b1tJyq0qx8Jco7hOVV6NYgno3yXzVK7YBzn73JuN87gbeLtU5rILkIO1+SVWsr78HHOEQmWC7XhnDRmnPfZ8Cu2BvDAnfg55vIEXgy4MmAyiJ5qCf3yat6SLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806525; c=relaxed/simple;
	bh=HwjWxs5OhcbLbqrYSXYXAc9DuEGhECx37IIpaobGA5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jf4MQXh3+ZqONi6pZgRET0cYHcoVlkuoz3C4mr2PVBsbbUA1NfFGE6WxxOUfyqK0zr534ocfhI+tfm3XE1yddi10XV3i0Si8bbA1gE6cLS3z/QhbGXaagO62GCd1dCCRVWVYlhYvxljeBQLZfHqFVMTJi8moylmfSzKFZxgV9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ciO7/4gj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ciO7/4gj"
Received: (qmail 6791 invoked by uid 106); 27 Aug 2026 04:55:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HwjWxs5OhcbLbqrYSXYXAc9DuEGhECx37IIpaobGA5Y=; b=ciO7/4gjK4xyMdijnwrrx+N1ZWJXOurjqYHxXuBHukLum/ReQ7YykuZFiMLEuL3J3Qrceh4ZFfhRKe3/bbx21K/OK5YMoeIfRqsFeMPBz7gJfhQ9nG+TxJEC3TdZ+mJ6DBxysQ3L6aOK72fAYY3qsEdUhv1X+BrPF5d2F1hh2d+cOx8++21V9vwPfIVO9sQhnoBEa3eCYQG1NMXGQoiQ1FodRCJdO7yXiDh1RdRZXBHebjescGvh7bdC5qq3TAA86qVJaYcGA+iSHSsUWlq20Xj1GC9QsX9VCSBPMxcGVXMgriFl27oK+8rhv9e49IyCz4FyYzG9ZJM+LAojegEzOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2026 04:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33976 invoked by uid 111); 27 Aug 2026 04:55:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2026 00:55:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Aug 2026 00:55:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four
 options
Message-ID: <20260827045515.GA176544@coredump.intra.peff.net>
References: <20260826233152.1703497-1-gitster@pobox.com>
 <20260826233152.1703497-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826233152.1703497-3-gitster@pobox.com>

On Wed, Aug 26, 2026 at 04:31:52PM -0700, Junio C Hamano wrote:

> To avoid allocation costs, the implementation reports only the first
> four mutually incompatible options used.
> 
> This behavior is deliberate.  If a set of ten options were mutually
> exclusive and a user specified seven of them at once, they would be
> told that the first four cannot be used together.  If the user then
> tries the remaining three, the same error for the remaining three
> would be reported.  It is dubious that there is any practical
> downside to not reporting all seven incompatible options at once,
> especially given that there are other three mutually incompatible
> options that the user will not be told about with this message
> anyway.

It took me a minute to understand why we would even want to have an
arbitrary-sized input if we are capping at 4 anyway. The answer is that
we are capping at 4 options _that the user actually specified_. But the
input can be the total set of conflicting options, which is greater. OK.

Really we could cap at 2 if we wanted to be technically correct, but it
might annoy the user to find each pair iteratively.

So that makes sense. Of course the follow-on question is whether any
callers actually want to pass more than 4 options. I don't see any
patches adding new calls.

> -void die_for_incompatible_opt4(const char *opt1_name, int opt1,
> -			       const char *opt2_name, int opt2,
> -			       const char *opt3_name, int opt3,
> -			       const char *opt4_name, int opt4)

One nice thing about foo4() without varargs is that the compiler will
tell you if you messed it up. The obvious downside being that you have
to count in order to avoid messing it up. ;)

But now we can forget the NULL terminator and cause a runtime problem.
So we probably want LAST_ARG_MUST_BE_NULL in the header file here:

> +void die_for_incompatible_opts(const char *opt1_name, int opt1, ...);

The rest of the patch looks OK, but just a few observations.

> +void die_for_incompatible_opts(const char *opt1_name, int opt1, ...)
>  {
> -	int count = 0;
> +	unsigned count = 0;
>  	const char *options[4];
> +	va_list ap;
> +
> +	va_start(ap, opt1);
>  
>  	if (opt1)
>  		options[count++] = opt1_name;
> -	if (opt2)
> -		options[count++] = opt2_name;
> -	if (opt3)
> -		options[count++] = opt3_name;
> -	if (opt4)
> -		options[count++] = opt4_name;
> +	while (count < ARRAY_SIZE(options)) {

Using ARRAY_SIZE() is nice, because we could in theory bump this 4
later. Though sadly here:

>  	switch (count) {
>  	case 4:
>  		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
> -		    opt1_name, opt2_name, opt3_name, opt4_name);
> +		    options[0], options[1], options[2], options[3]);

we still hard-code various count values. It probably would be fine to
allocate a buffer for the message, though I guess that pushes
translators into lego-land.

> +static inline void die_for_incompatible_opt4(const char *opt1_name, int opt1,
> +					     const char *opt2_name, int opt2,
> +					     const char *opt3_name, int opt3,
> +					     const char *opt4_name, int opt4)
> +{
> +	die_for_incompatible_opts(opt1_name, opt1,
> +				  opt2_name, opt2,
> +				  opt3_name, opt3,
> +				  opt4_name, opt4, NULL);
> +}

OK, now we wrap the arbitrary-sized version. The "3" and "2" variants
could probably be cleaned up slightly by calling it, too, rather than
passing dummy 0/"" values.

-Peff
