Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94A171E5C
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344828; cv=none; b=e4Q0W55buEM+M9t2pyLHGRqzhQhQid5UJB0l5Cu+jWz8ccJmT4wMojaT7NrUdBcfwN3b1AYa5pvo+tKmKjuavDHG5fAeMsbWHSka9GZuJFsrDF4MqyKNaCMWqQkGGq1Tb/L4Eel3S1d/9lV+F+DW1NIfbGIwMDXkONLfSELFWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344828; c=relaxed/simple;
	bh=zRGYBtobDQ5buugLC15Nb0vtwaPriyMTtaP0OMzupuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4+hWRAEe82ZyWPybMFva4xQKrO+gNZ745/5hbTItaCkOFBzBBYO0G81pbo+5O4Nu1O1tCEkEAaNEebtT6rHBfp+OWsW8zInFOlOLkKywYfj/l8F8V2WhDZXRfhmf2fJZwJm8eZVkGcmrJKOr2iTj5tjjFsHGJzffAPA4gi9Zz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19332 invoked by uid 109); 5 Apr 2024 19:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 19:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31620 invoked by uid 111); 5 Apr 2024 19:20:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 15:20:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 15:20:24 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] usage: report vsnprintf(3) failure
Message-ID: <20240405192024.GB2561807@coredump.intra.peff.net>
References: <3da13298-b6a6-4391-b8e8-5dae9a28b860@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3da13298-b6a6-4391-b8e8-5dae9a28b860@web.de>

On Fri, Apr 05, 2024 at 08:59:52PM +0200, René Scharfe wrote:

> vreportf(), which is used e.g. by die() and warning() by default, calls
> vsnprintf(3) to format the message to report.  If that call fails, it
> only prints the prefix, e.g. "fatal: " or "warning: ".  This at least
> informs users that they were supposed to get a message and reveals its
> severity, but leaves them wondering what it may have been about.
> 
> Here's an example where vreportf() tries to print a message with a 2GB
> string, which is too much for vsnprintf(3):
> 
>   $ perl -le 'print "create refs/heads/", "a"x2**31' | git update-ref --stdin
>   fatal:
> 
> At least report the formatting error along with the offending message
> (unformatted) to indicate why that message is empty.  Use fprintf(3)
> instead of error() to get the message out directly and avoid recursing
> back into vreportf().
> 
> With this patch we get:
> 
>   $ perl -le 'print "create refs/heads/", "a"x2**31' | git update-ref --stdin
>   error: unable to format message: invalid ref format: %s
>   fatal:
> 
> ... which allows users to at least get an idea of what went wrong.

Thanks, I think this is a good change and you've nicely summarized the
situation above. And the patch itself:

> diff --git a/usage.c b/usage.c
> index 09f0ed509b..7a2f7805f5 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -19,8 +19,11 @@ static void vreportf(const char *prefix, const char *err, va_list params)
>  	}
>  	memcpy(msg, prefix, prefix_len);
>  	p = msg + prefix_len;
> -	if (vsnprintf(p, pend - p, err, params) < 0)
> +	if (vsnprintf(p, pend - p, err, params) < 0) {
> +		fprintf(stderr, _("error: unable to format message: %s\n"),
> +			err);
>  		*p = '\0'; /* vsnprintf() failed, clip at prefix */
> +	}

is nice and simply, and shouldn't have any unexpected side effects.

-Peff
