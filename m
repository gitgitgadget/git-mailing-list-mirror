Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2940D58A
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798628; cv=none; b=Si3HDOYTTRXN8X4rsVNoMIVC3fWZq+wItKR741gT8ndYAA3SQ6TcIexsGvAtlJZoEw37jNnuOYx6/2trZNQRfELXB1629Y5zLjZYJWEbmjKfJgehgKZqDjTmLvOWKXQeaxHRaV/Wh0jwbjKS9z3KwqwbM8LbMCr31mu2KrWZKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798628; c=relaxed/simple;
	bh=B3O6b7fMzco9IMRyoWhiFHptBDgEljteWyr/aJ0UaC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJCCUTyvd5kbPaXqJC4dvpHtL5n0mqm2mXquB8v2n63HtvtZS98ST+pvlnPNaZhgQ01pnAGcD7Okycr239YltEY7dsmnEv5i7eF2LFxGR0EAQnMEL1af9b2DdjXltc4K4dn0qOubYwpizsLIvsW28Pj1fCDq+rX3IyVLkqvc0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RU8CCAPR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RU8CCAPR"
Received: (qmail 69756 invoked by uid 106); 30 Jun 2026 05:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B3O6b7fMzco9IMRyoWhiFHptBDgEljteWyr/aJ0UaC0=; b=RU8CCAPRjmJDkPE1+A2zC/Fvltw84UsyRQjhjRia+vr2kTW2KVqSQjRMmuu81IxKQ+5SbK6HtBYgHGxvjBCYExKLikT1OzFMHDJ21H6YTiU5vp5Sn2KQr1SfL6/uldyrLsXNwuc3Sd6zUxZLHtDN6tkY3iQWQHJDkCqkx8Cf0gyH3u5MkCTjVGV4WR8ppq2E4bXejAgRdikbuujpcPLaff5HAlUw6y7LR6phQvk/9BDx7i7OrJiD8aYegXUKNX4Fu7RAwcvikwGF9BdmGDW5nru24B1Y+qgx30GWY34yoMWFwLkBKDRIADeu6KNXQOPIlEf2/QmyXtb/U49PVsBzQw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 05:50:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 141034 invoked by uid 111); 30 Jun 2026 05:50:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 01:50:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 01:50:26 -0400
From: Jeff King <peff@peff.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <20260630055026.GE2495216@coredump.intra.peff.net>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
 <94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com>
 <20260630053825.GC2495216@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630053825.GC2495216@coredump.intra.peff.net>

On Tue, Jun 30, 2026 at 01:38:25AM -0400, Jeff King wrote:

> Try:
> 
>   make SANITIZE=leak
>   cd t
>   GIT_TEST_COMMIT_GRAPH=1 ./t3451-history-reword.sh -v -i

Of course that made me curious how a full run of the test suite would
react to that flag. We get a few failures of t345x tests, but they all
look like the same leak discussed here.

t4014 also fails, but with a unique leak. I don't think it's the same
thing; it looks like we may leak the slab from init_topo_walk().

-Peff
