Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A61E898
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912156; cv=none; b=OkbscsuNBZz165BYddGKzkGZvYSEuaY39BLv5reJtbvKihXH4C+maVIKkWs1X9ALgO6oV/Fq+rGoLhK13+Daz5xfv8YuJnVXgKxsPJCQJ4afY6Ti2KSXdoh6eb66tYIj8QGiko0kcGBAL/ui4gb+V5cVtEyLsUMdRtBxos2xDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912156; c=relaxed/simple;
	bh=etCfzzmUy/4wexNp5sv8NymtMIVmAMprlWq2xum1k3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPOzcktyVSsJ4YjDr/RY1CZc9VxeIVCZaLpFNBN0tK7tRaqxz71HxqMavMUZr3isqRX/kOyFPsfAUjEFpQ0my+Ih5DhAEMSQYF04QRy2jugwjg3ttmtfT6NZ0n2+WPQJ+TaSRw3W9JiTaFXGsTYG2sVqb1mSA5/4y4ZOnPFTvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8118 invoked by uid 109); 23 Apr 2024 22:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Apr 2024 22:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5498 invoked by uid 111); 23 Apr 2024 22:42:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Apr 2024 18:42:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Apr 2024 18:42:32 -0400
From: Jeff King <peff@peff.net>
To: intelfx@intelfx.name
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
Subject: Re: Building with PGO: concurrency and test data
Message-ID: <20240423224232.GE1172807@coredump.intra.peff.net>
References: <65f32df3f49341bf192b606914d44cc937f7971a.camel@intelfx.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65f32df3f49341bf192b606914d44cc937f7971a.camel@intelfx.name>

On Sun, Apr 21, 2024 at 02:52:48AM +0200, intelfx@intelfx.name wrote:

> 1. The INSTALL doc says that the profiling pass has to run the test
> suite using a single CPU, and the Makefile `profile` target also
> encodes this rule:
> 
> > As a caveat: a profile-optimized build takes a *lot* longer since the
> > git tree must be built twice, and in order for the profiling
> > measurements to work properly, ccache must be disabled and the test
> > suite has to be run using only a single CPU. <...>
> ( https://github.com/git/git/blob/master/INSTALL#L54-L59 )
> [...]
> However, some cursory searching tells me that gcc is equipped to handle
> concurrent runs of an instrumented program:

That text was added quite a while ago, in f2d713fc3e (Fix build problems
related to profile-directed optimization, 2012-02-06). It may be that it
was a problem back then, but isn't anymore.

+cc the author of that commit; I don't know offhand how many people
use "make profile" (now or back then).

> 2. The performance test suite (t/perf/) uses up to two git repositories
> ("normal" and "large") as test data to run git commands against. Does
> the internal organization of these repositories matter? I.e., does it
> matter if those are "real-world-used" repositories with overlapping
> packs, cruft, loose objects, many refs etc., or can I simply use fresh
> clones of git.git and linux.git without loss of profile quality?

I'd be surprised if the choice of repository didn't have some impact.
After all, if there are no loose objects, then the routines that
interact with them are not going to get a lot of exercise. But how much
does it actually matter in practice? I think you'd have to do a bunch of
trial and error measurements to find out.

My gut is that "larger is better" to emphasize the hot loops, but even
that might not be true. The main reason we want "large" repos in some
perf scripts is that it makes it easier to measure the thing we are
speeding up versus the overhead of starting processes, etc. But PGO
might not be as sensitive to that, if it can get what it needs from a
smaller number of runs of the sensitive spots.

All of which is to say "no idea". I know that's not very satisfying, but
I don't recall anybody really discussing PGO much here in the last
decade, so I think you're largely on your own.

-Peff
