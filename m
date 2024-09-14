Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9F18037
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726298978; cv=none; b=hmpMBAr32vSiDW1kGkk1TjaYP6j3t3edmDgjIduV6PWUvaV2YyiffSysq3xd4aj43wzSs4wq9tjTIRE205ev+ss4M1J3aN3u7NvRgrXs0XNKkC39T6RYonsUX2z7D8Nq4ANC5pZl0WqdH5KSNJY9EmooJXxSvvaLi73QWsagkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726298978; c=relaxed/simple;
	bh=VJsYvtLPCoqfG7rD6cfE0DKKicm9ayR8eGr+cHAElcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdygePoXAvwspRYaXgSHCOff4rL6pfJqoV+Y0M8IQW2OjUW/vcJVfawWA58HGKiUq0jeMANCVDb8t7xHGwemTWvSeDhYFFhtC9WFVYKTvxJ/65wAMILopDtANN1J9JttvYMxMFZ/uTUlBDNP+3C2342AbBB06ohJP+/l872j4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32429 invoked by uid 109); 14 Sep 2024 07:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Sep 2024 07:29:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11874 invoked by uid 111); 14 Sep 2024 07:29:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Sep 2024 03:29:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Sep 2024 03:29:32 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
Message-ID: <20240914072932.GB1284567@coredump.intra.peff.net>
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>

On Sat, Sep 14, 2024 at 12:42:39AM +0000, Johannes Schindelin via GitGitGadget wrote:

> To get the CI builds to work again, a work-around was implemented in
> https://lore.kernel.org/git/20240912094841.GD589828@coredump.intra.peff.net
> to let the 32-bit container make use of the 64-bit node 20 provided by
> the Actions runner.
> 
> This, however, runs the risk of using 64-bit executables when we
> purposefully chose a Docker image that only contains 32-bit bits and
> pieces so that accidental use of 64-bit libraries or executables would
> not happen.

How big a risk is this? In my experience with multiarch systems, the
difficulty is the opposite: convincing the non-base toolchain to work at
all, rather than using it accidentally. Especially as the solution in my
patch is not configuring apt for multiarch support, where you could
accidentally install gcc:amd64 versus gcc:i386. Even if we were to
accidentally bring in the cross-platform compiler via the
gcc-10-x86-64-linux-gnu package, you'd have to point $(CC) at it
explicitly.

But maybe others have had a different experience?

> Let's go about this the other way round instead, by overriding the amd64
> version of node 20 the Actions runner provides with an x86 one (which is
> "officially unofficial" by virtue of being hosted on
> unofficial-builds.nodejs.org).

I'm not totally opposed to this direction, but I'm a little concerned
about the stability/maintenance of the solution. In particular:

> +        NODE_URL=https://unofficial-builds.nodejs.org/download/release/v20.17.0/node-v20.17.0-linux-x86.tar.gz &&

Will this URL work forever? Looking at the release/ directory, it looks
like it should hang around. They have entries going back to 2019 (which
is not all that old, but I suspect that's when they started the build
repository).

The flip side is: will node20 be sufficient for Actions forever? Node16
was already deprecated in Actions in 2023, and it was released in 2021
(looks like Node releases have a 2-year lifespan in general). So node20
takes us to April 2026 or so.

Of course my solution has similar problems. Probably node24 or whatever
comes next will need another glibc bump.

I was mildly surprised that the build you reference didn't run into that
problem, actually. But I double-checked and it appears to run OK in
Xenial; it needs 2.17, according to some "objdump -T" sleuthing. I'm not
sure why that's so different from the official 64-bit builds.

> +        curl -Lo /tmp/node.tar.gz $NODE_URL &&
> +        tar -C /__e/node20 -x --strip-components=1 -f /tmp/node.tar.gz

This is pretty intimate with how Actions work (both the node20 version
and the "/__e/" magic). It's hard to say if/when that would bite us.

>     For good measure, I also reported this problem with that deprecation at
>     https://github.com/actions/upload-artifact/issues/616 even though I know
>     that the GitHub Actions team saw a headcount-losing reorg recently and
>     therefore I do not really expect that they have any bandwidth to help
>     with this. So this work-around is the best we can do for now, I believe.

I think it's reasonably well known there already. Here are some relevant
issues I came across:

  - https://github.com/actions/checkout/issues/334
  - https://github.com/actions/checkout/issues/1590
  - https://github.com/actions/setup-node/issues/922
  - https://github.com/actions/runner/issues/2906

Most folks are hitting the glibc issue rather than the i386 one, but the
core of the problem is the same.

IMHO the ultimate solution is a statically-linked node binary (you'd
still be relying on the kernel, but that has a very good track record of
userspace compatibility).

-Peff
