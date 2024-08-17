Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FB13C9A2
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723878879; cv=none; b=KyTDyfC/8iy/SHdstbmZTCrxITYxU+gSPTWQti/UQC8Y7iCT38pK4Cz2SQWeBzERvSzN6U8SjhIY8JAMkyd124kkkr2v6K8QvlP7K68sY3HEV5us4H2OuFnqvDb+If1jRYyQ9qSycdyqOOrj6nYcKVxt6mTtR68hGIY2Pxx6WM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723878879; c=relaxed/simple;
	bh=XgRzMBBb2HAQvrpa36jQtb2e/b9lGXCXxAIju935J1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfmDAPn/TUH53Szwm4GKvOSY/4ZasoiadXh0i23DFPYhLxXrFkYZ7Q7WKmVP7sGA5YNVDgd0UkcO3oWcly8M2RtTkFpsyM3rGZ9tMfC3bRVSglzFbfxI5BBXZFgMAD0TAz/FkfeU9aW1XMMa/x0YJ0N1R4TSsF4bp4vZpPwH/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23363 invoked by uid 109); 17 Aug 2024 07:14:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:14:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27463 invoked by uid 111); 17 Aug 2024 07:14:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:14:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:14:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] builtin/maintenance: add a `--detach` flag
Message-ID: <20240817071435.GA1531456@coredump.intra.peff.net>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <347d0a200201ce215f5b2c46d23de0cdd0181956.1723804990.git.ps@pks.im>
 <20240817070924.GA1438563@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817070924.GA1438563@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 03:09:25AM -0400, Jeff King wrote:

> While investigating that, I ran it with --stress locally (on Linux) and
> got some odd (and definitely racy) results. The test itself passes, but
> the "rm -rf repo" in the test_when_finished sometimes fails with:
> 
>   rm: cannot remove 'repo/.git/objects': Directory not empty
> 
> or similar (sometimes it's another directory like 'repo/.git'). My guess
> is that the background process is still running and creating files in
> the repository, racing with rm's call to rmdir().
> 
> Even if we remove the test_when_finished, it would mean that the final
> cleanup after test_done might similarly fail, leaving a crufty trash
> directory. I think to make this robust, we'd need some way of detecting
> when the background process has finished. I don't think we report the
> pid anywhere, and the daemonize() call means it won't even be in the
> same process group. Maybe we could spin looking for the incremental pack
> it will create (and timeout after N seconds)? That feels pretty hacky,
> but I can't think of anything better.

Ah, I just noticed that a similar problem happened in t6500, discussed
during v2 of the series (I only looked at the latest version). I think
t7900 needs a similar run_and_wait_for_auto_gc() solution.

I suspect the Windows "out is not empty" issue is separate, though.

-Peff
