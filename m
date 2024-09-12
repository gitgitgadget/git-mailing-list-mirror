Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C66F2E8
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134162; cv=none; b=jXX4h99VotaHZNhDUZXwxe3sA4fzOU9N+v/BjIc3k8PZzdJRs8MPPW0BZmnfe2mbVigvzhCzsP42MUol8Mvt29hWwq0yvXRsNTpjl1ts8kTyYaaLz7hfwYYjpc1+/uzJ9JbEj7ts/QSAYeR8899zpndX0tYggVSr9NkZ/Msm/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134162; c=relaxed/simple;
	bh=VWSpNx8MN8c1RvghtJ4XUxrIYVnJJOIkOPttWefyiHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqa8DEXp6aTZsXaVORyBdAYXzyFybLadoGAhC0sjxUC5jQ8h4l0ZnuFYrrjq9mJSYje4MhgVuVdnwjKtY4NYfqRLOWFQvY/2HJzB3rFjesPruEopohKgQadEXDO31t1VnD1wlUx0rHtA1miyLFv5CarnJ+Rjho6zUZ2HDpFviQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17292 invoked by uid 109); 12 Sep 2024 09:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 09:42:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23123 invoked by uid 111); 12 Sep 2024 09:42:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 05:42:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 05:42:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH 0/4] make linux32 ci job work with recent actions
Message-ID: <20240912094238.GA589050@coredump.intra.peff.net>
References: <xmqqy140o2kb.fsf@gitster.g>
 <xmqqv7z14y9d.fsf@gitster.g>
 <20240912075631.GA11676@coredump.intra.peff.net>
 <20240912080011.GA556677@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912080011.GA556677@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 04:00:11AM -0400, Jeff King wrote:

> But I _think_ all of those details I sent add up to a possible patch
> series. But it probably still makes sense to take your patch here, as it
> unblocks CI in the short term. And then I can build the bigger fix on
> top of that (it touches the same spot, but in the end both end up
> removing that special case).

OK, here's what I came up with. I built it on top of what you have
queued in jc/ci-upload-artifact-and-linux32, but it could be applied
separately (and it should merge OK).

The state after each patch should still pass, but of course each of them
depends on the ones before.

The big downside is discussed in patch 3: we are losing what is probably
the oldest platform we test against. I don't think it's fixable in this
approach, though; the Actions node just won't run on such an old
platform. So the options are:

  - hope that they eventually move to a true static node binary

  - switch the design entirely; handle docker ourselves, run the actions
    in the regular runner-image environment, and then just do the "make
    test" bits inside the container

IMHO what's in this series is an OK tradeoff (we are going from an
8-year-old image to a 4-year-old one, but it gets older with each
passing year). If somebody wants to pursue the alternate design above,
be my guest. I'm just trying not to fall into that rabbit hole myself. ;)

  [1/4]: ci: drop run-docker scripts
  [2/4]: ci: unify ubuntu and ubuntu32 dependencies
  [3/4]: ci: use more recent linux32 image
  [4/4]: ci: use regular action versions for linux32 job

 .github/workflows/main.yml | 12 +++----
 ci/install-dependencies.sh | 45 +++++++++++++++-----------
 ci/run-docker-build.sh     | 66 --------------------------------------
 ci/run-docker.sh           | 47 ---------------------------
 4 files changed, 32 insertions(+), 138 deletions(-)
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh

-Peff
