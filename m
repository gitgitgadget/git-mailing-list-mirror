Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FED194C7E
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434232; cv=none; b=PogtBkN8XvXltoLE2q9uFfiOP3hZvgbkguXpR2oG0mLfWTx8oqReDdWo2+fI7r88pnN90eI2Oc5ISNd3KMjIa+ax4D3yohWKCSoN/85ZgtZNCxbpf+a5TdP7/w89MXsGTKrs1qlX8GsQXZfSnBwogELM+NhpM08J2FlFGWOi5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434232; c=relaxed/simple;
	bh=4H2Iv+/S/JK7CFVG4X3+9dCSyPSXpgP3bpT1+ncmx/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv7Shy9QtFz+8lM82b/LosEd3k5UO5DvNpErNCbDANK/clstuqRD0lDm+ZSbgAMirrau3cgfPc7Bue7Dr80pl0YN+JOk/okcg/qu6ThzFZHBA7VIVb0rH2HJZO1lxeW/hlNNBOQdJsxM/kIGY1IHC0A7O1NDq8o769QI95GuQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25525 invoked by uid 109); 26 Jun 2024 20:37:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:37:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25034 invoked by uid 111); 26 Jun 2024 20:37:05 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:37:05 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:37:05 -0400
From: Jeff King <peff@peff.net>
To: Florian Schmaus <flo@geekplace.eu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
Message-ID: <20240626203705.GB441931@coredump.intra.peff.net>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
 <xmqqa5j71snb.fsf@gitster.g>
 <a87a7131-3207-42f2-93c0-e6e9e02a2062@geekplace.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a87a7131-3207-42f2-93c0-e6e9e02a2062@geekplace.eu>

On Wed, Jun 26, 2024 at 09:06:10PM +0200, Florian Schmaus wrote:

> > True.  As long as it is deemed safe to honor the one-off "git -c
> > safe.directory=..." from the command line, for the purpose of this
> > "I who am running this 'git' process hereby declare that I trust
> > this and that repository", I think it would be the best solution
> > for the "git daemon" use case.
> 
> How does one pass "-c safe.directory=…" to git-http-backend?
> 
> I currently have an Apache config snippet like
> 
> SetEnv GIT_PROJECT_ROOT /var/www/example.org/htdocs/git
> SetEnv GIT_HTTP_EXPORT_ALL
> ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
> 
> <Files "git-http-backend">
>   Require all granted
>   AcceptPathInfo On
> </Files>
> 
> to serve git repositories.
> 
> Granted, the apache user has a home directory, so I am probably able to set
> save.directory via ~/.gitconfig.
> 
> However, the point here is that git is often invoked indirectly, with no
> control over the command line arguments that are passed to it. On the other
> hand, one has usually control over the environment variables.
> 
> I agree that "-c safe.directory=…" is preferable to
> GIT_IGNORE_INSECURE_OWNER. However, sometimes using "-c safe.directory=…" is
> cumbersome and maybe even impossible.
> 
> One alternative to GIT_IGNORE_INSECURE_OWNER would be a generic
> GIT_EXTRA_ARGS environment variable. So one could set
> 
> GIT_EXTRA_ARGS="-c safe.directory=…"
> 
> Not saying that I like the idea, just pointing out this option.

You can do:

  GIT_CONFIG_COUNT=1
  GIT_CONFIG_KEY_0=safe.directory
  GIT_CONFIG_VALUE_0="*"

It is a bit verbose, but it's a documented interface in git-config(1).

Under the hood "git -c" uses a different, older mechanism, but we've not
documented it nor promised that it will remain stable.

-Peff
