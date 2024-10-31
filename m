Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C921A2567
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388707; cv=none; b=FybIfhN0jNQt1Aw2qFF3f0JyC35NHUNrMCrgFi+YgYALnPluah3ksGy3gyA7DY9dCr59PRWBhD097HLq2bsp0I+DZ9770L2g0sSFzWYyfyrwiB7ZOd3G5oHCB3BborWYrbubrJRVyuL8/Jh+hDQ35ImusivaODmSvY9TS2ibZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388707; c=relaxed/simple;
	bh=NupFGQuBgLXn3ApPA+kBvTOPdNxUBjfzt/Ft/RQrtrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYFyUMw63QQuzxsOo5eiWnE6ZrbRIY8yh7FbjI4yboGsen6noMCTf7jLLoMwJ7U2if+CmDXN7qkrprIO4Z0yvmpBhqwUf2U4UUkuN0KGRheBnpg+Ek2vFgnTLv3Xtxo7qyLvdvD9aRNREyrCCCQBkTfVVZ6xU9yX/58PmfAs3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RB8VeYBX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RB8VeYBX"
Received: (qmail 19970 invoked by uid 109); 31 Oct 2024 15:31:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NupFGQuBgLXn3ApPA+kBvTOPdNxUBjfzt/Ft/RQrtrs=; b=RB8VeYBXlaWpVnpsNpTmLLkZvncwGp9XqSLBuLKuEftfO7Gd85+eRn3ke8M4qnp7aThDEXcPIsiGGkmSOCC0aiq9OlInCF1hLdWHspt9aT6qABa9uD+tdpOSVTP5DLGoMmHf+Y1Qr30lxw+kds70IePXpInmMD1kVUvkHZIZ9ECLeZ/1Qzi3RQGnTnSQREAv1CJd0e12Y+qOIeWRlZhOXuSSje4Ro+OEJM7jSNtbig2T7qhi2Kqh7A4BV+lXMPIE1Wwowq6GHCWxCTkwuv2goSal6ka9yQgFST+m+uWGhCQZI/2OmMdEDmzG7RZy7Ko93CZqa8VS+z7H4Tik/5b1sg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 15:31:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2867 invoked by uid 111); 31 Oct 2024 15:31:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 11:31:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 11:31:43 -0400
From: Jeff King <peff@peff.net>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <20241031153143.GA2275115@coredump.intra.peff.net>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
 <20241031151000.svsa7d2ogcdz7hf6@jpoimboe>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031151000.svsa7d2ogcdz7hf6@jpoimboe>

On Thu, Oct 31, 2024 at 08:10:00AM -0700, Josh Poimboeuf wrote:

> > I think we'll build the commit graph file by default these days when you
> > run "git gc". But we don't build it immediately after cloning. Perhaps
> > we should change that.
> 
> Hm... I actually ran "git gc" and it didn't seem to help at all.

What version of Git are you running? I think gc enabled it by default in
31b1de6a09 (commit-graph: turn on commit-graph by default, 2019-08-13),
which is v2.24.0.

You could also try "git commit-graph write --reachable" and see if that
improves things. If it doesn't, then maybe you have the reading side
turned off explicitly for some reason? Try "git config core.commitgraph"
to see if you have that set to "false".

-Peff
