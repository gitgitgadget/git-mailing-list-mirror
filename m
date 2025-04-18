Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297B204C26
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744971449; cv=none; b=qF1LyMyCjl41nIMFyZu2CxOXHAlkYHozL3L+kRa6zq1g7ROxxVpxiYGz1izQWVaePd/6DIq/aQZOX54EnSu4XzhpLeGJm30o/AcXqWYp1xw1yxwuMkz0q0stWF0gHFyE57nENFZolt2+5pkrMLEIzaxzHSLl1lejN3exywXru3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744971449; c=relaxed/simple;
	bh=a1dEBAR9eqHrEZDy0wKW3y6t+lG0X/+w+gpiBjTpc6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZL6edHRtB+yaqQcVs9FJmhwae9HwVO4nJs/6KvvmSNWHON4xPZ0tDWKnSS5Xsod8xd+VIUrqSnsWFBYCN/pENvMHw81cAg+RYg1OvpJzehoeiP/DGJFW6/XVfc7mgueHqgzVeTursq7WzA79mAvyrb83m2/6K7d1N+z7PBFRq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gois9Ec2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gois9Ec2"
Received: (qmail 16621 invoked by uid 109); 18 Apr 2025 10:17:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=a1dEBAR9eqHrEZDy0wKW3y6t+lG0X/+w+gpiBjTpc6U=; b=Gois9Ec2CdrBsnaOQ9Oafels05VW4nz8gHfuZ7+eVepOQUhFZD6FjFnNNbjWmE5/dmDNgz/vJDWp5QVFdMvhpDTN87TKLAXchsOJbR8E6g+/Mj3OMhuJNJ1Gba3CV47kux67tudepH/m1T5fl596H38vSR+Fu+azYYzAora+x0W3A5i8T5GYbi9Xr/ZfMv/5ESsGAANprpg4yLh46R24dCc9WCFsMf6mVzOeGauJ/OnSD8bKc6ArIS5Em+NFNiMCVro8HnTkL330r8sNO7+MqTCAS2BWCXZdXU5OTlJPtVumnlDwZGVYI0LKiUN15qJeCdumJqh4/Q6xjswQZ5/w4g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Apr 2025 10:17:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31822 invoked by uid 111); 18 Apr 2025 10:17:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 06:17:30 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 06:17:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t/perf/lib-bitmap.sh: avoid test_perf during setup
Message-ID: <20250418101725.GD10441@coredump.intra.peff.net>
References: <cover.1744924321.git.me@ttaylorr.com>
 <0906e14c0e55b52573c7e0b632c7c639850700ec.1744924321.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0906e14c0e55b52573c7e0b632c7c639850700ec.1744924321.git.me@ttaylorr.com>

On Thu, Apr 17, 2025 at 05:12:23PM -0400, Taylor Blau wrote:

> In the test_pack_bitmap() helper function, we first repack the
> repository under test for consistency and to eliminate any effects from
> different distributions of objects among packs.
>
> This step is performed with test_perf, so it is repeated
> $GIT_PERF_REPEAT_COUNT number of times. But we do not care about timing
> this portion of the setup phase, and repeating the process does not
> change the outcome.

Isn't this also where we actually generate the bitmaps? I.e., it is
where we would see a performance regression in the bitmap writing
process (whereas the rest of the script is about the reading side).

That said, I don't think it's even doing that very well. It is mutating
the on-disk state, so the first run will potentially be much slower than
subsequent runs (since everything is now in one big pack with bitmaps,
and we try to reuse deltas and bitmap data as much as possible). And
since we take best-of-N, we're basically just measuring those subsequent
noop repacks (unless you set the repeat count to 1!).

I think we've run into this before, e.g. in 775c71e16d (p5302: create
the repo in each index-pack test, 2019-04-22). And there the solution
was to reset the repo state before each timing, assuming it is quick
enough not to affect the test too much. Our perf suite doesn't provide
much support there (we'd want something like hyperfine's --prepare
option).

So I dunno. It is possible for timing this operation to provide some
value, but I don't think the current implementation is doing that. And
it's quite expensive to run.

> diff --git a/t/perf/lib-bitmap.sh b/t/perf/lib-bitmap.sh
> index 55a8feb1dc..fdf5f35f1b 100644
> --- a/t/perf/lib-bitmap.sh
> +++ b/t/perf/lib-bitmap.sh
> @@ -69,7 +69,7 @@ test_partial_bitmap () {
>  }
>  
>  test_pack_bitmap () {
> -	test_perf "repack to disk" '
> +	test_expect_success "repack to disk" '
>  		git repack -ad
>  	'

The same issue exists in t5326, which calls "multi-pack-index write"
with the "--bitmap" flag, I think. So if we are going to do this, we'd
probably want the same there.

-Peff
