Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D791863E
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090996; cv=none; b=VP5WH0QwvUcTfCxI0kjX5/LAnVZiBwfK4+lPNw4jwDzQ9eRw37vTSMSRxW21RS++tSqO5WBPkzSZmZbpTIg2sB5Mgw6hL/bFWlD8xlysYL6ZrnxwCP1ZNQKlIastFsg2Sjgia0/wUtkiyqZ6TYzeKVTX5w6IH+zVOitNkQs0X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090996; c=relaxed/simple;
	bh=Vpq9MFVX2lzZZS8QQx1LNycB3Y9nUKZmg7WWYrH5Yag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkuYv4X/QDahKkybzA1sYlPSTy9da8XKlGpCdhIjtf56LlW9twC02yeV8gXqHjQkHab7pOuhSFS6hETKuDlpDsZtAUvhL7ye35b2CL/M2gqU4pQl+Cffm5MSoIl5sO/u2VJIRe0lFP+PY80gCLm5sB8nzteD3J161sGDez5tyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VSkNOEAQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VSkNOEAQ"
Received: (qmail 3939 invoked by uid 109); 1 Dec 2024 22:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vpq9MFVX2lzZZS8QQx1LNycB3Y9nUKZmg7WWYrH5Yag=; b=VSkNOEAQkEIMpvcJDJNciT8h3nQ4RJVbXLQWwdDzsdhoGCo6nFth8VHgcTA3v25IC4GIZi3V/ftOJOTX6wpe9c28yzJpUPZCY1jF9YyNKXfC5LZ+f1Uw0MskIUJAMCa4zB0TKoJgH4MBUDblRhl90h0GDZWW7DQtGPpZvI4cq/4qeD526uJQ0XuopqHaBdvYElZSwnBsVp5YFRLiA7BRhKpTm1m5qYHWXW6h9K/k+4OCFkKuCiOIvbfpKHmbrZw/E8mcAlMm/K66oe5lcsnC6NhZ9WO1OYfegrC5RxTu+065aWUgTDQEYZUqfG0U8y359ORpkX/WsmvK+pjCv+hIRA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 22:09:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14463 invoked by uid 111); 1 Dec 2024 22:09:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 17:09:52 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 17:09:52 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] daemon: fix type of `max_connections`
Message-ID: <20241201220952.GG145938@coredump.intra.peff.net>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-10-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129-pks-sign-compare-v1-10-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:31PM +0100, Patrick Steinhardt wrote:

> The `max_connections` type tracks how many children git-daemon(1) would
> spawn at the same time. This value can be controlled via a command line
> switch: if given a positive value we'll set that up as the limit. But
> when given either zero or a negative value we don't enforce any limit at
> all.
> 
> But even when being passed a negative value we won't actually store it,
> but normalize it to 0. Still, the variable used to store the config is
> using a signed integer, which causes warnings when comparing the number
> of accepted connections (`max_connections`) with the number of current
> connections being handled (`live_children`).
> 
> Adapt the type of `max_connections` such that the types of both
> variables match.

Makes sense.

> @@ -1315,10 +1313,11 @@ int cmd_main(int argc, const char **argv)
>  			continue;
>  		}
>  		if (skip_prefix(arg, "--max-connections=", &v)) {
> -			if (strtol_i(v, 10, &max_connections))
> +			int parsed_value;
> +			if (strtol_i(v, 10, &parsed_value))
>  				die(_("invalid max-connections '%s', expecting an integer"), v);
> -			if (max_connections < 0)
> -				max_connections = 0;  /* unlimited */
> +			/* A negative value indicates unlimited children. */
> +			max_connections = parsed_value < 0 ? 0 : parsed_value;
>  			continue;
>  		}

If this were a common pattern, we might want some kind of helper that
parses and clamps the negative values. But I suspect it's not common
enough to merit that, and it's not too many extra lines of code to parse
and assign separately. So this looks good.

-Peff
