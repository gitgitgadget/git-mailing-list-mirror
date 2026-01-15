Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D129E10C
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768509564; cv=none; b=KZ1aCp/bbo2KGX1x3sakJMMPAE40PZgh4O0HVOhBglHvBwWRI85XFdQEBr1RBDvkvBUU68JgP516AbaUuyGbnk8vvojTDHyAwFIzivNiehYG5SOwAggG93j74VmR+9qwAC+zdBCIha1MOSEZx8B0GvId+jEE2rtdOyrIPb/2pc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768509564; c=relaxed/simple;
	bh=oW8MNemGnbQcdGgWvdOwvQpqKg5xhDIziKzi3einXjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F62HhJvtXeCVtfvMpw1SYpHAvEGDEDTH2dxBP0KIpZNsmveXKDFLPgwQwC5I67Fd3g2mcJpl9qWQgJVvM+VRybhYkCvnpMuLJv0EMHQERyu/H7rmh5cZkzw6p31iRuxSfQnP0Xll0EQYz7jJ8ruLk564z5DRkh+QUEFiZiozzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L5Zus38o; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L5Zus38o"
Received: (qmail 50507 invoked by uid 109); 15 Jan 2026 20:39:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oW8MNemGnbQcdGgWvdOwvQpqKg5xhDIziKzi3einXjI=; b=L5Zus38ouLNVrMMZ4h3thanFOc1NvgHZmsB5zab6I1dRjV+2H3OBfurL+GbSTfD+75EDnNgNc2GAqbbFdKxF9iKH8P1hzuMuJfXYZ5s433UwlUixHtP7kFB4WK6HaBBC1dL8M/31I/nn6RRHcRvKLw1nFS/I4KyoR27OjeLLnB401IEncCGTfRn1O6HeKg/MXyUBjd5albR8fOuTsMJpVt9wBqQ3rHnhf6wWZwvUFgkTooANDieA7wbpZDh3LpFddArEnxAFmPro61nlupuT/jBX3T8N6oWr2T2X8mgvC+4wf/HmwsFQzgeGXvPQ0Rz62a1MKS0JAodwsb2vcBI4Lg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jan 2026 20:39:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 82794 invoked by uid 111); 15 Jan 2026 20:39:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jan 2026 15:39:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Jan 2026 15:39:21 -0500
From: Jeff King <peff@peff.net>
To: Martin Fick <mfick@nvidia.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Delta Islands without bitmaps?
Message-ID: <20260115203921.GD1053259@coredump.intra.peff.net>
References: <CH3PR12MB90262C525E918BDE952987FFC285A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH3PR12MB90262C525E918BDE952987FFC285A@CH3PR12MB9026.namprd12.prod.outlook.com>

On Thu, Jan 08, 2026 at 12:56:03AM +0000, Martin Fick wrote:

> I am having a hard time trying to get delta islands to work as I expect.
> I would like to treat each head as an island of its own, but I do not
> seem able to do this. From reading the code, I believe that I am not
> able to make this work because the feature ignores objects which 
> are not covered by bitmaps and refuses to put them in their own 
> island? I don't see anything in the docs hinting at this, so I wanted to 
> confirm whether my reading of the code was accurate, and to maybe 
> get some clarification as to why this was done? 
> 
> Perhaps this would work if I could force every head to have an 
> associated bitmap, but there doesn't seem to be a way to do this?
> Is there some other way I can force all heads to be in their own 
> individual island?

I don't think you need to use reachability bitmaps with delta islands.
The islands are just about delta selection.

If you read the code you might be thrown off by the use of bitmaps in
the delta island code itself, but these are actual "which islands is
this object in" bitmaps, and not related to on-disk reachability
bitmaps.

It has been a long time since I've fiddled with delta islands, but I
think that just:

  [pack]
  island = refs/heads/(.*)

would work. Then if you had branches "foo", "bar", etc, you'd get
islands "foo" and "bar".

I do suspect that per-head islands may yield a much bigger on-disk
packfile (and bigger clones). It would disallow using an object as a
base if it is not in your oldest branch, even if it is in most of the
other ones. So the deltas of your shared history are subject to the
oldest / least-inclusive branch.

But then, that's kind of the tradeoff of delta islands. It might still
be helpful if you expect people to fetch branches one at a time.

-Peff
