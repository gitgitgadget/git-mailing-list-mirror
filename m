Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD233DEC8
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544540; cv=none; b=VZhanM3pvNMDi7ICZaN8tSHhWles+OeRA2wdsqF+/T91hIQ1f06QLuh/dHWD/5v7ngrtATAIUni7rpgrDc/HbasFYJsLpDMG9sbdU4jQICG2D6cZjw6HKbG3iQy8bD77FaTTaJHGhUhRgzqbKWnfLTnVzqyFF1HcD9DkLXVZ4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544540; c=relaxed/simple;
	bh=F+FQt/FbQfB0vdgSll0NQh9jDbWhUAQtTnUsqjpNhog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzFaFHNahz3J+Zpf9DnvTDfgOHjFFEEvZ7tXYb0YEulyFk+JsVSUR61k3S6eXhDM1qfbEt+oODGzZWDH+pEFnmHtxM/qCgwyvHRpuokUtkDEQzaApiPg1oT9KX13VjcDbttXXzQGHdM0ZVdqnX5FXjoEZ4FO/fmFDCuFOrfUQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iPZ5NLNJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iPZ5NLNJ"
Received: (qmail 47599 invoked by uid 106); 3 Mar 2026 13:28:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F+FQt/FbQfB0vdgSll0NQh9jDbWhUAQtTnUsqjpNhog=; b=iPZ5NLNJEGL+jGzOKZSLdO+qOqRWp5mOKHJ5nk6CEU2i7YjmZzBsAxfSbUQUGZprKlfY/R+2JwKixUgrXzmgQIWnMbfm01ISkyI8FYj+saFDFP2/6KVguxYjmKc34sQLzTDdHrdlJpf3xr83imfJrcWo2IvMpm5M4qc/VSQvlZa1UJRRwY8C6iCMIQCXF/U3+676w7uknqP2u+Sv5F/s25EVYq4un/pCAn07sve8xPDii3EQE4cFBmShjA8BOzlGWk8DTV7UPhnFnF9GJOUDpJaSdRv3vYirTyk4A6hEdqs+MePFEE+oivNinnzndlMln6rCiwXwjGgN1zj95DMWoQ==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Mar 2026 13:28:56 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 347883 invoked by uid 111); 3 Mar 2026 13:28:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Mar 2026 08:28:56 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Mar 2026 08:28:55 -0500
From: Jeff King <peff@peff.net>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/1] builtin/receive-pack: avoid spinning no-op sideband
 async threads
Message-ID: <20260303132855.GA748945@coredump.intra.peff.net>
References: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
 <20260302191704.1814567-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302191704.1814567-2-adrian.ratiu@collabora.com>

On Mon, Mar 02, 2026 at 09:17:04PM +0200, Adrian Ratiu wrote:

> It is important to call the hook_exists() API provided by hook.[ch]
> because it covers both config-defined hooks and the "traditional"
> hooks from the hookdir. find_hook() only covers the hookdir hooks.

Ah, OK. Traditionally hook_exists() was just a thin wrapper over
find_hook(), but it looks like that changed in your series. But either
way, it much more clearly expresses the intent to use hook_exists().

So this obviously looks good, but just some random thoughts below.

> @@ -934,6 +934,9 @@ static int run_receive_hook(struct command *commands,
>  	int saved_stderr = -1;
>  	int ret;
>  
> +	if (!hook_exists(the_repository, hook_name))
> +		return 0;

It is a little inelegant that we have to look up the hook data
separately ourselves here, and then it will be done again in
run_hooks_opt(). But I don't think there is an easy way to reorganize
it, short of something like:

  struct hook myhook = HOOK_INIT;

  load_hooks(&myhook, hook_name);
  if (myhook.nr)
	return 0; /* no hooks of this type */

  ...other prep work...

  run_hooks_opt(repo, &myhook, &opt);

I doubt that is worth it, as the lookup process should not be too
expensive. It looks like we cache the config parts of the lookup
already. We call access() to find the traditional hooks on each lookup,
but that is also true of the code before your series.

It would not matter at all for pre-receive, for example, but for
something like update, I guess we are doing a bunch of pointless
access() calls that could be cached. But again, not new in your series,
and nobody has really noticed. So we can either treat it as an
optimization for later, or just leave it be forever.

-Peff
