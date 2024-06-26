Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23F8F47
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435240; cv=none; b=RyNvXl0HE65D6NMfGUisZRUQR/wVRtJ4XYZgTqPkW3gko+RijhM8e9n29VVk18GwIC+B9BVb/vvf6EqWVjQKKDMISMHKmzU/+7n4gMvvGg7RzQum8UZwK2A3aJLSWpOVYYyyV9aOFRQafmc1vQYZNQHHi04UbGWnnByq4XUOlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435240; c=relaxed/simple;
	bh=8XSubAHNB7l1+JcDH/Mk8QpVTubUVLx3hbJFYE7c5Lw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uNfvWmfbPJOHVM3p9k38KbJtBZsPonE4KYnBdbF2WvVwtyREY5ArH5cShJpMTi5FNHtuNjphIKYwV5rZ9HD0GUSiwO5zlZTS//0/EzxPMFVqwDecwOReRBCPaYtkSOcArUYQGGYiGdQ0G69aWGRG1mKhhPfipvX58GjFgFjOk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25985 invoked by uid 109); 26 Jun 2024 20:53:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:53:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25172 invoked by uid 111); 26 Jun 2024 20:53:56 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:53:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:53:55 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 0/3] reduce test suite dependency on network
Message-ID: <20240626205355.GA1009060@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I'm in a remote cabin with spotty internet this week, and I noticed
several delays while running "make test". The culprit was DNS request
packets being dropped due to a passing rainstorm, but not enough that
the OS decided the network was down (the DNS resolver was on the other
end of a VPN). So I was waiting for DNS timeouts.

This is kind of an exotic situation, but it seems to me that the test
suite should avoid making network requests in general, just for the sake
of reproducibility. And avoiding timeouts is a nice bonus.

So here are a few small fixes, after which running "make test" requires
zero DNS lookups (and presumably zero external network at all, though of
course we hit localhost/127.0.0.1 for various http, etc, tests).

  [1/3]: t5553: use local url for invalid fetch
  [2/3]: t5551: do not confirm that bogus url cannot be used
  [3/3]: t/lib-bundle-uri: use local fake bundle URLs

 t/lib-bundle-uri-protocol.sh | 4 ++--
 t/t5551-http-fetch-smart.sh  | 1 -
 t/t5553-set-upstream.sh      | 8 ++++----
 3 files changed, 6 insertions(+), 7 deletions(-)

-Peff
