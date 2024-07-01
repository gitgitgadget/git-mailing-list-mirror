Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31D2A1D1
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857963; cv=none; b=mVZSh61Wdl/NRrY/D5KJsRueQCZSRR4PLSxHSecBT0NM1rOEqZTKUOR+VezRDFrycB4cl93PTSXtd91yrRCaju/+qlf97RNPGY5Ra7qQ9hqWhMe2uanDSMF6tTqCdtlVjck40asn0emJykrpsnzUUIuLkWpltTlPFF42e5oMH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857963; c=relaxed/simple;
	bh=N+/owwyQHI2YkM4rv/Uukio1hN7ZSopCD5GU0qOvfcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcNtvCwhZxsOjuCj8FN9Q9qmd9B1UpTxFh8OXrQeQFEotf0QSQHn3G6/p3gxxcvAYQWcu7MHeJOzfbky5jhIjHHgMnX0cTOzvPGjFjM0o3wqW/3aXxQBFVO6FzH3hvONJwNiIuGhQ/EKae8p5TGGVz2itLe1+Plc43hktFwBxpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25490 invoked by uid 109); 1 Jul 2024 18:19:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 18:19:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14827 invoked by uid 111); 1 Jul 2024 18:19:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 14:19:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 14:19:16 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: phillip.wood@dunelm.org.uk, Florian Schmaus <flo@geekplace.eu>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: support GIT_IGNORE_INSECURE_OWNER environment
 variable
Message-ID: <20240701181916.GD3199@coredump.intra.peff.net>
References: <20240626123358.420292-1-flo@geekplace.eu>
 <20240626123358.420292-2-flo@geekplace.eu>
 <9e5b0cc6-e28c-4c51-ab48-663c61c00ee3@gmail.com>
 <72e42e9f-5b85-4863-8506-c99d658d7596@gmail.com>
 <ae658244-877f-c5cf-8947-83b87b66d01f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae658244-877f-c5cf-8947-83b87b66d01f@gmx.de>

On Mon, Jul 01, 2024 at 06:34:10PM +0200, Johannes Schindelin wrote:

> The `local_repo_env` array _specifically_ lists `GIT_CONFIG_PARAMETERS` in
> https://github.com/git/git/blob/v2.45.2/environment.c#L129 to be removed
> from the environment when spawning the `git upload-pack` process.
> 
> It was not originally listed, but added via
> https://lore.kernel.org/git/20100824064114.GA20724@burratino/, where the
> commit message does not really shed light into the question why this was
> desirable, and there is no discussion in that mail thread about this
> aspect of the patch, but at least the added test case reveals the
> intention in some sort of way: The `-c` option allows to specify
> `receive.denyDeletes`, and in the described scenario the idea was that it
> would only apply to the client side of a local `receive-pack` but not the
> "remote" one. As the example above illustrates, that patch might have
> been overly focused on one specific, particular scenario.

One reason we haven't loosened local_repo_env for the local transport is
that it would make it inconsistent with all of the other transports.
I.e., "git -c foo.bar=baz fetch" would still be ignored over ssh, https,
and so on, because those transports don't pass environment variables.

There's some more discussion from a similar case that came up a month
ago:

  https://lore.kernel.org/git/20240529102307.GF1098944@coredump.intra.peff.net/

-Peff
