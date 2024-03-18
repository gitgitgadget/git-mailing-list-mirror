Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8525634
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752931; cv=none; b=aHWtZ76TOYeTshb2ba9gk6YMMBm+8/5FyU2OE5OU8sX3t/41YXnilEdLn2OeL5PBn4LkgZ8RX7ICg5n4czTncUcxumgv5wxlP1YLAPWGL3IE1Wo8Wzp4pQalAATdFhzNtlnwalclLUtKrCoxBPU0KkwE7PbGiZTKjrJdp2nfVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752931; c=relaxed/simple;
	bh=efsthJfqEM1ZOuHM9V9loZVtxUeMwEKPZ8vL27y5H88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWZrp+XERPNQoJ65vrCpfofEO4kYeXrCBsKt06ymfQHwjFrwCBh5sSj8mUeS3LPkUdiilrhmLkyCjnSLkQMSrt00HP0yVWvezVULGz+7/UvjSToZbMcs7SIulDuFk+ew/C5YVqbfylK6mPUrrL/cFPkkyxSQFWSp6wgLmVXuYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9073 invoked by uid 109); 18 Mar 2024 09:08:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Mar 2024 09:08:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26890 invoked by uid 111); 18 Mar 2024 09:08:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Mar 2024 05:08:53 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Mar 2024 05:08:48 -0400
From: Jeff King <peff@peff.net>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: Failures in GitHub Actions linux-leaks and linux-asan-ubsan
Message-ID: <20240318090848.GC602575@coredump.intra.peff.net>
References: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com>

On Sat, Mar 16, 2024 at 03:20:44PM -0400, Philippe Blain wrote:

> The failures are due to the new ubuntu-22.04 GitHub Actions image
> (release 20240310.1.0, [1]) which uses a kernel where ASLR is configured
> in a way that is incompatible with ASan and LSan as used in 
> the GCC and Clang versions in that image. More info can be found
> in [2] and [3] and pages linked there.
> 
> A workaround was already implemented in the image generation process 
> [4], so the next version of the image should work. I think the images
> are released weekly. We could maybe add the same sysctl command to reduce
> the entropy to our YAML file, or we could live with it for the next week
> or so while waiting for the next image to roll out.

Thanks for digging into this! I had done a little but didn't get nearly
as far. I am happy I can just ignore it and the problem will resolve
itself. ;)

While I have the attention of folks who might be interested in CI
failures, let me hijack the thread for a moment: has anybody figured out
why macOS jobs sometimes time out after 6 hours? I assume that is an
Actions limit, and something is just hanging. It sometimes hits
osx-reftable[0], but sometimes osx-clang[1] and osx-gcc[2]. I've seen it
on my builds and some on git/git (the last one is from git/git).

It's hard to tell which test is hanging, because the output only shows
the finished tests. I tried running them without "prove" and doing it
one-by-one, but then the hang doesn't seem to occur (so presumably it's
a race under load). I tried comparing the list of tests reported as
finishing versus the total list, but there was nothing enlightening.
It's all stuff in t9xxx, which you'd expect to be running near the end
anyway (and it feels like if there was _one_ test hanging, we should
finish everything else, since we run with some parallelism). So it's
almost like a bug in "prove" or something. But AFAIK it just started
happening in the past month or two.

-Peff

[0]: example run: https://github.com/peff/git/actions/runs/8107092556/job/22158038562
[1]: example run: https://github.com/peff/git/actions/runs/8091601551/job/22110929146
[2]: example run: https://github.com/git/git/actions/runs/8273234891/job/22636626511
