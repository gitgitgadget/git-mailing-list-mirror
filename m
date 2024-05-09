Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96D539A
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273209; cv=none; b=RAYPIYoCgzQjyi3OB+sTjCxs/7Ig4nYkdiP9HTu5Mks70CoWNVecAlHvAoA4EAOwMlpbnS9cf81q9Z6lB8ETruJO687ZVCkinTZjRhQFZO/tsLYOZ7Qzo4ca7jJzVGM+/kyn2uCjqG78mkTaU7kzHYCwbeixs2hdLgY2wiHnQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273209; c=relaxed/simple;
	bh=tmrtNiTipwRDqOrzedL/nP0CWagT1XA5bkvZG5faJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd3ZtI6RJdShGreDwRilyAkov/Q86mcpR91alO7mBkFo00cgL3weTxOMnXWkxL5M87oy2ZzGrk1rpEUkljPbGghLxNLE6LHrd+nfve4atJp0zQ5QEUnYL/8HjIqoz5rUlFxVX3npLsbqon8XxtzoJS01dHS9h0zMk3Kgv+nUtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7016 invoked by uid 109); 9 May 2024 16:46:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:46:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31366 invoked by uid 111); 9 May 2024 16:46:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:46:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:46:46 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] bundle-uri: enable git-remote-https progress
Message-ID: <20240509164646.GB1708095@coredump.intra.peff.net>
References: <20240508124453.600871-1-toon@iotcl.com>
 <20240508124453.600871-5-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508124453.600871-5-toon@iotcl.com>

On Wed, May 08, 2024 at 02:44:53PM +0200, Toon Claes wrote:

> diff --git a/bundle-uri.c b/bundle-uri.c
> index ca32050a78..462f00f668 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -293,7 +293,6 @@ static int download_https_uri_to_file(const char *file, const char *uri)
>  	int found_get = 0;
>  
>  	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
> -	cp.err = -1;
>  	cp.in = -1;
>  	cp.out = -1;

This is the cause of at least one test failure in t5558, I think. We
spawn a remote-https to try to download the bundle, but it may not be
present, and we continue without it. In that case, the child
remote-https says something like:

  fatal: failed to download file at URL 'http://127.0.0.1:5558/bundle-5.bundle'

and then the caller says:

  warning: failed to download bundle from URI 'http://127.0.0.1:5558/bundle-5.bundle'

Prior to this patch, the "fatal" part coming from the child process was
suppressed (and the test checks that this is so, which is why it fails,
even though the clone itself works fine).

Obviously you need to enable stderr to see the progress, so I'm not sure
how to resolve it. In an ideal world, you'd ask for the two over
separate descriptors, but I think run_command() only supports 0/1/2
stdio due to portability limitations for Windows.

One option is that remote-https could ferry machine-readable output back
to the parent over stdout, which could then format it for the user.

Another is that we could somehow ask remote-https to squelch
non-progress errors, though that feels a bit weird (and awkward to
implement, since the message comes from a die() call).

> @@ -328,6 +327,9 @@ static int download_https_uri_to_file(const char *file, const char *uri)
>  		goto cleanup;
>  	}
>  
> +	fprintf(child_in, "option progress true\n");
> +	fflush(child_in);
> +
>  	fprintf(child_in, "get %s %s\n\n", uri, file);

I was curious why you'd flush here. It makes sense if you are going to
then read back the response from stdout, but we never do (it should be a
single "ok" line). I think it's OK to ignore it, given that we'd just
continue without progress in that case.

But I did wonder why this wasn't messing up reading the response from
the "get" command just below. The answer is that we don't read that
response either! We just assume that the process will exit successfully
or not based on the result. We are relying on the pipe buffer to avoid
deadlock, but I think that's OK since the output is always going to be
small.

-Peff
