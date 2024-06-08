Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214F1E890
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717843115; cv=none; b=UNedEuq2M1YEmB+XPEHV08N7uzKP6ldZ9tqjO04GdBFRjUdOwgxFx5b2WHnidSURYE1khA8JZwWwa3CxbDoTXrWbmvRiajdTzL/U6pg93aNa4eDsZbsxOouv99mug/3w20iu58DyhuT7zTzR/pJ5pe0wfIo7nZqIIB5kzN7ZdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717843115; c=relaxed/simple;
	bh=mkvZWNBL678hmjT9tEMFKSBVIAxU9Gw7Q+Iq0kdFDdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjwBf0oopUYY/6IdKyBKtHd4pDd5OcX2EghUfnuP+HUzXY3tqtQKDKxUAh55OdwhfElvX8u5rnWhTFOeGUNUTwGbZhcpWdoUOnj9j43yeVo9ghpsxwK7to9qUnYLW3E/WbFGGOzrqAuXIUYVTp/6aW58vn3n8tAjHSPuqbM2R1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8200 invoked by uid 109); 8 Jun 2024 10:38:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 10:38:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29328 invoked by uid 111); 8 Jun 2024 10:38:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 06:38:30 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 06:38:32 -0400
From: Jeff King <peff@peff.net>
To: ellie <el@horse64.org>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240608103832.GE2659849@coredump.intra.peff.net>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <bc030171-70fa-41cf-945a-2d20bf237372@horse64.org>
 <7de78f3d-f174-4bf6-837f-9c90bf935d21@horse64.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7de78f3d-f174-4bf6-837f-9c90bf935d21@horse64.org>

On Sat, Jun 08, 2024 at 11:44:09AM +0200, ellie wrote:

> Another idea that probably is silly in some way too: couldn't after the
> first error, git automatically start over and do this whole --depth=1
> followed by --deepen... automatically? I feel like anything that wouldn't
> require knowing and manually doing that process would be an improvement for
> people affected often by this.

I'm skeptical that shallow-cloning and deepening is a good strategy in
general. Serving shallow clones like this is expensive for the server,
and there's more network overhead in the back-and-forth requests.

It also only slices up the repository in one dimension. There could be
a single tree that's really big, or even a single blob that you can
never get past.

So yes, it may work sometimes, but I don't think it's something we
should codify.

-Peff
