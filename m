Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65448F4E
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707975060; cv=none; b=JuddQNBHKSJKSpwtsgVSiBbvtfCq5Ta+/haj8Lhex3tCRE6fY6IrGKNreRmkt1hn0PuNLlxjWEALdJMFxR9atVpMWM2MzUwDZm/bELdDJBzt7/TvPGy30lQvKiiToeej1bwDYNbZrCKfcZ4B8IjOah7Pp/7h9NUvDRV50y4ec/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707975060; c=relaxed/simple;
	bh=aQiXddxRj3je+92AAhlLfynUExP5h1hy+pclQ38UBCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNIv5LVvDXcPDplcyjYGmhfflV5ucgpljjm8EgLzCaMF65j7kC7E8qmE/0YLesFihe+4VjXA3hlswchLNMtaNPkpk3jtYPKop0PAjfmqynZxfxljk3N6U7mXV/oKSJtERWaDxUs1SE71A4aj9mWRN/S4azdmjFlTFRXYyOO2Yn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18215 invoked by uid 109); 15 Feb 2024 05:30:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 05:30:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11904 invoked by uid 111); 15 Feb 2024 05:30:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Feb 2024 00:30:58 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Feb 2024 00:30:56 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: --no-lazy-fetch option
Message-ID: <20240215053056.GD2821179@coredump.intra.peff.net>
References: <xmqq1q9mmtpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q9mmtpw.fsf@gitster.g>

On Thu, Feb 08, 2024 at 03:17:31PM -0800, Junio C Hamano wrote:

> Sometimes, especially during tests of low level machinery, it is
> handy to have a way to disable lazy fetching of objects.  This
> allows us to say, for example, "git cat-file -e <object-name>", to
> see if the object is locally available.

That seems like a good feature, but...

> @@ -186,6 +187,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  			use_pager = 0;
>  			if (envchanged)
>  				*envchanged = 1;
> +		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
> +			fetch_if_missing = 0;
>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
>  			disable_replace_refs();
>  			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);

This will only help builtin commands, and even then only the top-level
one. If I run "git --no-lazy-fetch foo" and "foo" is a script or an
alias, I'd expect it to still take effect. Ditto for sub-commands kicked
off by a builtin (say, a "rev-list" connectivity check caused by a
fetch).

So this probably needs to be modeled after --no-replace-objects, etc,
where we set an environment variable that makes it to child processes.

-Peff
