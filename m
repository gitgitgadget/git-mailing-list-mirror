Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6C3B1A2
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179216; cv=none; b=ub+mgGuax+XYdVqLW+XUwtS9vGTOyW/r4di3a+9up4gomg6w7PfLjdIXF8judGbbN9hOvwTZ+y1CBF76oMFFDAUdT4lM1qWTFrD3j1QmSdJeKYFlHhQQ3JlCbBEmvKBFxsaBKNgcxM4sQNmMsC0M241zEMyDw0UTDH4PmaCHF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179216; c=relaxed/simple;
	bh=Iz/iocrKlNMxVFQyxX8O97TpvAChfviCTMndJqDGS5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvIevo4YIupz29yx2lSu5fF4vsDzxkFjYdxQ4odnVwe8wSoRwuVNOXYJVHkP4AXBfHzYSvIVX24QHY3zDt1P2XrjP9EYXJNzqlQIWGOUJ453p10Y8cdqe7OV429VLnck4/QjU4V3FQY8Y7KNZsAurNJTDm+/UVZvX782abgLxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26855 invoked by uid 109); 3 Apr 2024 21:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 21:20:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11905 invoked by uid 111); 3 Apr 2024 21:20:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Apr 2024 17:20:15 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Apr 2024 17:20:13 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
Message-ID: <20240403212013.GA1957295@coredump.intra.peff.net>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
 <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
 <20240403011818.GB892394@coredump.intra.peff.net>
 <b48fd3ee-2975-481f-aa0e-8ec4d07ea705@web.de>
 <20240403204836.GC1949464@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403204836.GC1949464@coredump.intra.peff.net>

On Wed, Apr 03, 2024 at 04:48:36PM -0400, Jeff King wrote:

> Yeah, I'd prefer not to go to mkpath(), even though that's the simplest
> thing, just because we should be reducing the subtle non-reentrant parts
> of the code over time. I don't think the cleanup handling for
> mkpathdup() is too bad:
> 
> diff --git a/apply.c b/apply.c
> index 432837a674..15dfe607ff 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4502,20 +4502,25 @@ static int create_one_file(struct apply_state *state,
>  		unsigned int nr = getpid();
>  
>  		for (;;) {
> -			char newpath[PATH_MAX];
> -			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
> +			char *newpath = mkpathdup("%s~%u", path, nr);
>  			res = try_create_file(state, newpath, mode, buf, size);
> -			if (res < 0)
> +			if (res < 0) {
> +				free(newpath);
>  				return -1;
> +			}
>  			if (!res) {
> -				if (!rename(newpath, path))
> +				if (!rename(newpath, path)) {
> +					free(newpath);
>  					return 0;
> +				}
>  				unlink_or_warn(newpath);
> +				free(newpath);
>  				break;
>  			}
>  			if (errno != EEXIST)
>  				break;
>  			++nr;
> +			free(newpath);
>  		}
>  	}
>  	return error_errno(_("unable to write file '%s' mode %o"),

OK, this misses one of the breaks, and potentially clobbers errno in
that path by calling free(). So it is harder than I said. I still think
it's worth doing, though.

-Peff
