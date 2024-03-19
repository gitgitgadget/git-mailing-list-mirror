Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761515FB90
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882271; cv=none; b=TmP4D0/4fbem0lEU2yXeT9hThJ4dSejIeF2vUIxx5gU4e4u27JyYlsEXtoAgeWi6Ukhv7dcFYD8KOC88AeI/SPRfk/fSUoferrwDl82H7Hc+yKTddxewt6amEk69kxOwKH/q7SUl6o6T/w5YoGLYYhfi9rgRGdPStnfvq5gc87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882271; c=relaxed/simple;
	bh=7a4SEzUN+quEU2XFsP3Y1/OieAXQpzeqBWO3JTtJ+ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCGNonDDoQS0aNyUdJr/tebCrNoi1qhW5zofyUh6qPgkL6B+0d0kPw+4sofiZuRH+hA6jCtHTSP+3c+rkKzlfwfOhJMzP++ndv7/cTSNtrSJ3O0V+h19znrA+7FUp0aq8qC50BXvGsAa/vn/G4aMPwSlPU/DTOf+wznjh1JXyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3405 invoked by uid 109); 19 Mar 2024 21:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Mar 2024 21:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11486 invoked by uid 111); 19 Mar 2024 21:04:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 17:04:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 17:04:28 -0400
From: Jeff King <peff@peff.net>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] config: learn the "hostname:" includeIf condition
Message-ID: <20240319210428.GC1159535@coredump.intra.peff.net>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <20240319183722.211300-3-ignacio@iencinas.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319183722.211300-3-ignacio@iencinas.com>

On Tue, Mar 19, 2024 at 07:37:22PM +0100, Ignacio Encinas wrote:

> +`hostname`::
> +	The data that follows the keyword `hostname:` is taken to be a
> +	pattern with standard globbing wildcards. If the current
> +	hostname (output of gethostname(2)) matches the
> +	pattern, the include condition is met.

I was going to comment further here, but I see Eric already replied with
everything I was going to say. ;)

One small comment on the patch...

> +static int include_by_hostname(const char *cond, size_t cond_len)
> +{
> +	int ret;
> +	char my_host[HOST_NAME_MAX + 1];
> +	struct strbuf pattern = STRBUF_INIT;
> +
> +	if (xgethostname(my_host, sizeof(my_host)))
> +		return 0;
> +
> +	strbuf_add(&pattern, cond, cond_len);
> +	ret = !wildmatch(pattern.buf, my_host, 0);
> +	strbuf_release(&pattern);
> +	return ret;
> +}

This is absolutely a nit, but I think using xmemdupz() like:

  char *pattern;
  ...

  pattern = xmemdupz(cond, cond_len);
  ...
  free(pattern);

expresses the intent more directly (it's also a little more efficient,
but that's probably not measurable).

-Peff
