Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A9B644
	for <git@vger.kernel.org>; Sat, 25 May 2024 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716614989; cv=none; b=sIQ2yD1kDLropD5uXsxMB1VclWSkYMexIGTtQI11Cjgrc3zskEqrQwl1VC1hRC4/bXfeB7xrtc5mhMHqWK/IyP82vXXNg58VyI39CPo4nPR30t1asGgE5QB5m5gFbTUVFwyf6FDVypBIssVSvAScU0c/VIns00QmNF91Ch142Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716614989; c=relaxed/simple;
	bh=YysMKLSnsG+3q4Vq7Zqi3OAGQWYLE9Od/kw87fXmhSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJnOem7VMnI1P/ZfYgMWDiogXC3NBnei37kR/obaebKaKURNbXPgCe5iD6Hd8962rr3if8b/VPSE9ae8rkA7bd2G4RLtc6j5oFX+cihaacVW7l6/W9LHMk10/70C6JERMiCjXbOualSpgofRAY8z9H/gsz9hL5GIibXXcaqoLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4075 invoked by uid 109); 25 May 2024 05:29:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 05:29:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16183 invoked by uid 111); 25 May 2024 05:29:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 May 2024 01:29:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 May 2024 01:29:46 -0400
From: Jeff King <peff@peff.net>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, jonathantanmy@google.com
Subject: Re: [PATCH] promisor-remote: add promisor.quiet configuration option
Message-ID: <20240525052946.GD1895047@coredump.intra.peff.net>
References: <20240523131926.1959245-1-tom@compton.nu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523131926.1959245-1-tom@compton.nu>

On Thu, May 23, 2024 at 02:19:26PM +0100, Tom Hughes wrote:

> Add a configuration optione to allow output from the promisor
> fetching objects to be suppressed/
> 
> This allows us to stop commands like git blame being swamped
> with progress messages and gc notifications from the promisor
> when used in a partial clone.

I'm not at all opposed to providing a way to suppress this, but I feel
like in the long run, the more fundamental issue is that git-blame kicks
off a zillion fetches as it traverses. That's not only ugly but it's
also horribly inefficient.

In an ideal world we'd queue all of the blobs we need, do a single
fetch, and then compute the blame on the result. That's probably easier
said than done, though we have done it in other spots (e.g., for
checkout).

In terms of user experience, you can simulate it with something like:

  # fault in all of the necessary blobs in one batch
  git rev-list HEAD -- $file |
  git diff-tree --stdin --format= -r --diff-filter=d -m --raw -- $file |
  awk '{print $4}' |
  git -c fetch.negotiationAlgorithm=noop \
      fetch --no-tags --no-write-fetch-head --recurse-submodules=no \
      --filter=blob:none --stdin

  git blame $file

Obviously that command is horrid and not something users should have to
care about. But if we had some way for blame to say "hey, I am
traversing from X..Y, looking at these pathspecs", then our first
lazy-fetch could try to grab all of them. And I think the same would be
the case for "git log -p", and so on.

Doing a separate traversal isn't maximally efficient, but it might not
be too bad in practice (and we could even do partial traversals to
balance chunking versus responsiveness, though in the case of
non-incremental blame we need everything before we generate an
answer anyway).

But anyway, I bring it up here because I think once we reach that end
state, it won't be as interesting to turn off the fetch progress.

-Peff
