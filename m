Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07061FA24D
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930604; cv=none; b=JPibEpPzVHLWWKFi2TKOVGtX90kEWy7o+IEv2Yoc1PvQUEpC3l+XInUDdNnDS634fYuti+CnJBX2xd+MtyEs0s2poLjt4gez9/JSDWytSxZofOhRUXyY7GlJCjhSH0GuwDEBDm/fQ8cZ6pa0xhlQ4VqaGQX408LTmZhsdCaPqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930604; c=relaxed/simple;
	bh=Ae+S5f4kstx5QDD8ktY6wisGCVpcfNfifT8CzpmJhn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWPQl4x7UcOqz50kbhn56kDv3ay83CfvKqr6pSlHMUfdzmyg/1UbtuEaZp66KNsu4y0ZBkoRI8WkMAPlIOdL6mPGP5e7Q5PWFHS+InvdYKUQJXgir9ZPunJTJDtzNCjngSgVqNGF3JtpBnbV4EWy/PwTcBHV1PNL+c370Ay1u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aJd2z8wz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aJd2z8wz"
Received: (qmail 18363 invoked by uid 109); 3 Jan 2025 18:56:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ae+S5f4kstx5QDD8ktY6wisGCVpcfNfifT8CzpmJhn4=; b=aJd2z8wzQI5D9CUGe+64HQ/n5cTMXsk27kfgplEAkDy6maxtVvTrd+OonCVlC5LTm3E9tF09ujKhuLGDFXWAXXx2U/qC4dZpM8twBdMBs6aac/qWlSLHRDqUz2UkUvzLax6VFJS7sJDAobwgxw5x1h7SUms2yfeWysb7j6aBrJy5AFJkmvA+8jYwtYF+S1kWdy8uAN5GJ1cwdaTcNxUHQuwR83u4E7YTQwh3gbkDp5AQO7gF9LqiAZW4SyWS8Y/Q0mqj6hmuGR1espQJe4CO00P2k4wtoff6rh0Jqg54mk2sAUNPw8UEBougZubvR/UTJ4QK0FrzNGo9lV2I4Zmq6w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 18:56:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3975 invoked by uid 111); 3 Jan 2025 18:56:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 13:56:41 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 13:56:40 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] github: convert all Linux jobs to be containerized
Message-ID: <20250103185640.GA3208749@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-4-a9bb95dff833@pks.im>

On Fri, Jan 03, 2025 at 03:46:41PM +0100, Patrick Steinhardt wrote:

> We have split the CI jobs in GitHub Workflows into two categories:
> 
>   - Those running on a machine pool directly.
> 
>   - Those running in a container on the machine pool.
> 
> The latter is more flexible because it allows us to freely pick whatever
> container image we want to use for a specific job, while the former only
> allows us to pick from a handful of different distros. The containerized
> jobs shouldn't cause a significant slowdown, either, so they do not have
> any significant upside to the best of my knowlegde. The only upside that
> they did have before the preceding commit is that they run as a non-root
> user, but that has been addressed now.

I remember running into a few issues recently with containerized jobs,
so I dug in the archive a bit. The issue there was that the container
was not equipped to support the dynamically-linked version of node that
was being mounted into place (whereas the runner image from the CI
provider would work fine).

I guess that's probably not a big deal for us here. These are roughly
the same environments, just pulling from docker instead of relying on
the runner images. It's possible that Actions scripts might depend on
something special in the runner image, but in practice I think they try
to keep the dependencies pretty light.

So we're probably OK to proceed here, and deal with any problems in the
unlikely event that they come up.

I do wonder if it will affect run times. Presumably GitHub has made it
pretty fast to get things started on the bare runner image. Now we're
pulling docker images. That is hopefully pretty optimized and cached,
but it is extra work. Might be worth measuring.

-Peff
