Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3D2EAE5
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970176; cv=none; b=ticuuApdq8FciqAZnCUUyFCDX2hM3u1sfI4ZsLzJesNlx7JT77tNt7GKR3uTD+xe0HiTLLaGpvuQxG/edMx6Lwy1Mz8eJq6CUyW0yyttHeJ1+Uat3q+a1o4+3zsMv7Ls+bIJwkHnZnEBET0k+Q9OvJY+/X8wBx5FsrsmSJObwvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970176; c=relaxed/simple;
	bh=kxVifDFcVNFqwmkBidsyi0UOHPmeqjc2yceJ7ofNUbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTtxkLVMgL//Sr8kKJ/ZXvzvsjUl11onnE8esCBZ37Vq6ZYWp9+DTt2ObyZ6/p6EUDzL8aBnYjcgT+7Mg5D9CjiikL3Y0OdPDtiASjlj0TXR33XJ0PSDXjWIfLt3astn4Nboyg2zpQkc6HHetE01ohuq1/KeuNOrks3OB2vIJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16138 invoked by uid 109); 26 Jul 2024 05:02:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jul 2024 05:02:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30827 invoked by uid 111); 26 Jul 2024 05:02:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2024 01:02:57 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jul 2024 01:02:53 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
Message-ID: <20240726050253.GC642208@coredump.intra.peff.net>
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
 <20240723021900.388020-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240723021900.388020-3-gitster@pobox.com>

On Mon, Jul 22, 2024 at 07:18:59PM -0700, Junio C Hamano wrote:

> The pathname of a repository comes from getcwd() and it could be a
> path aliased via symbolic links, e.g., the real directory may be
> /home/u/repository but a symbolic link /home/u/repo may point at it,
> and the clone request may come as "git clone file:///home/u/repo/"
> 
> A request to check if /home/u/repository is safe would be rejected
> if the safe.directory configuration allows /home/u/repo/ but not its
> alias /home/u/repository/.  Normalize the paths configured for the
> safe.directory configuration variable before comparing them with the
> path being checked.

This may be a dumb question, but... will this always work, if the config
option is not necessarily an exact path, and might have globbing
characters in it?

We don't currently treat it like a wildmatch glob, but:

  1. We do allow "/*" on the end. Should we strip that off so it doesn't
     confuse the realpath lookup?

  2. This is shutting the door on using wildmatch or similar in the
     future. Is that OK?

> @@ -1236,6 +1236,16 @@ static int safe_directory_cb(const char *key, const char *value,
>  
>  		if (!git_config_pathname(&allowed, key, value)) {
>  			const char *check = allowed ? allowed : value;
> +			char *to_free = real_pathdup(check, 0);
> +
> +			if (!to_free) {
> +				warning(_("safe.directory '%s' cannot be normalized"),
> +					check);
> +				goto next;
> +			} else {
> +				check = to_free;
> +			}

I'm not sure about this warning. I don't know how people use this config
in the real world, but it seems plausible to me they might have:

  [safe]
  directory = /home/me/this/always/exists
  directory = /home/me/this/might/not/exist

perhaps because they're using a generic config file across multiple
machines. And then they'd get:

  warning: safe.directory '/home/me/this/might/not/exist' cannot be normalized

on every invocation (at least ones that need to consult safe.directory).
Should we be quiet there, and maybe fall back to using the
non-normalized path (though I guess if we could not normalize it, that
probably means it could never match anyway)?

-Peff
