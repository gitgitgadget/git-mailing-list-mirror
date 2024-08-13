Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E81E517
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554978; cv=none; b=df40j3PzQF6x1wpmy3esblplyIceVuZsOX6zYG712QYVXvncETReGNJ43EOCXJyvZKFQ2rCBoSPb709+SCv2UpPRpKHKSFU7QG1XB5UTwRG1kSCqXcWsQ4FRMi79p/pRKynSnxbzluMiYE7PUYPnmTcmaLreqbcGv1hQ1G0KURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554978; c=relaxed/simple;
	bh=gOBLoifSgebD2vM7MhAuISoCjfZPAksomb/JzZt+cEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4IC9fLRc9dkMN2pLWY23rX+BRZs5yQ8h+Gj0awzrWivU5vuht936qwmcNI5WNzh8TvSIYQwhT0y7YKNLyK6hl1BgttZrQq67xg6TLsLFrRtV5BcoJz1PsM7PPnFm/FsfDq1DdsuRGWx3kYt0AM9Jv1N5Cga50zVo8vbu0kufVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4742 invoked by uid 109); 13 Aug 2024 13:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 13:16:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6802 invoked by uid 111); 13 Aug 2024 13:16:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 09:16:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 09:16:14 -0400
From: Jeff King <peff@peff.net>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git clone --reference=<repository> (without --dissociate),
 forgets to copy/get_pack_of objects from <repository> when
 "--no-local"/"file://" is present
Message-ID: <20240813131614.GF968816@coredump.intra.peff.net>
References: <CANrWfmR2sB8abN3tjuavu-sDwuENMh3DPdFKS9fXan_1kYURPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANrWfmR2sB8abN3tjuavu-sDwuENMh3DPdFKS9fXan_1kYURPA@mail.gmail.com>

On Tue, Aug 06, 2024 at 09:37:33AM +1200, Han Jiang wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> (repo7 and repo8 should behave similar to repo5 and repo6, i.e. setup
> ".git/objects/info/alternates" && copy/get_pack_of objects;)
> (repo7 and repo8 shouldn't: forget to copy/get_pack_of objects.)
> (The problem only surfaces after "./client/mirror.git/" is removed:
> repo7 and repo8 should have the original objects (so git log shouldn't
> give error) but they don't have.)

I don't think this expectation is correct. Using "--reference" without
"-dissociate" creates a dependency on the mirror repository. It's not
safe to delete it. This is discussed in the "--shared" description of
git-clone(1), and the "--reference" description refers to it.

So in your example:

> git -C './client' clone --reference='./mirror.git' --no-local '../server/repo.git' './repo7'

I would not expect repo7 to have any objects. Its needs were satisfied
by the mirror, and when it told the upload-pack process running in
server/repo.git what it had, that process knew that it did not need to
send any objects.

It's actually your repo5 and repo6 that are the oddballs:

> git -C './client' clone --reference='./mirror.git' '../server/repo.git' './repo5'

Here since we are cloning a local-file repo, we take a shortcut and do
not do any object negotiation at all! Instead, we just take all of the
objects from server/repo.git as hardlinks, since doing so is less work
than figuring out what we might need.

It makes us robust to mirror.git being removed (since we ended up with
duplicates of all of its objects anyway). But it's still not safe in the
long run. If the mirror gets new objects, we'd rely on them for
subsequent fetches (rather than getting new copies), and the same
dependency is created.

-Peff
