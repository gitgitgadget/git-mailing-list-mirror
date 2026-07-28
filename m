Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DA30568E
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252002; cv=none; b=axIr74PxHef2Gtil7RE2e5OsxVVJkOmx0Xw4hKGwn9BW6dY7FC/vbVpCwTex+q+KHGrP8QHkMlL6PH+ElQV9yUHhAS+4SFO36ofP6YDAPCejvtCp4Bf2zjXe+IOkrBTQwQo8ZVbBaH08OSC4SItVvmUma9He6Phj9mRjnr4xtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252002; c=relaxed/simple;
	bh=EyvhT+vYvq97FFtYfzTF6HH7kfjtiMtzjohg7vT/lmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+hvYrcKG1Urcdi0oG48Hya82diwIGoxcP8OEPnKSHxXeD9XQ/AS1805whkWK6v9N5xI7xHHOvAOyiM4fTbgDvLPPVQD1yXi6dMgk1VwOR19a5ehHIurkfhhS1ElWLTmadLFJz/f/at6z2UX+xbWgv/mQ6pjmMDpr37brEIM/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VC8ZLG1H; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VC8ZLG1H"
Received: (qmail 81049 invoked by uid 106); 28 Jul 2026 15:19:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EyvhT+vYvq97FFtYfzTF6HH7kfjtiMtzjohg7vT/lmI=; b=VC8ZLG1Hwrq5Aa20qNHZMf+L2bxQzePw8X1vL6devGBXxC5Vzbv2Lcs4+Vi89tzQocNaU6BEmhz8AychP1Z47+oC6L9mr5B4o0nFqlQNaLwP4kQ0COj8NVUOhMuQSGKY+rTYaCYS5U20NjkLVgCDN33Miy/3vy/W65I6hZPIDTzu915B6UH+oZr9TGNUJGJc1C6i4Ft1NNFkamCg2QirwvIANQmHXbNsHSxOuFOtZ61zaR5xGrCo+DPz15/8XdW9paF5bJYDjh5onKySvpkmeuq8Z8kIxjip8oJURsPlaGjhGEu01J8ic+oMasyC40sTKUk2AjkfS4MCGCKl17LWQA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 15:19:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 100282 invoked by uid 111); 28 Jul 2026 15:20:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 11:20:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 11:19:59 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] merge: fix leak with merge.defaultToUpstream
Message-ID: <20260728151959.GC41931@coredump.intra.peff.net>
References: <20260728-toon-fix-merge-leak-v1-1-d6bd161a3acf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728-toon-fix-merge-leak-v1-1-d6bd161a3acf@iotcl.com>

On Tue, Jul 28, 2026 at 03:00:04PM +0200, Toon Claes wrote:

> The leak has been present since 93e535a5b7 (merge: merge with the
> default upstream branch without argument, 2011-03-24). Although the leak
> sanitizer was enabled for tests in fc1ddf42af (t: remove
> TEST_PASSES_SANITIZE_LEAK annotations, 2024-11-21), it went unnoticed
> because no test calls `git merge` without arguments, exercising the
> default-to-upstream path. Add such a test in t7600, which fails under
> the leak sanitizer without this fix.

Wow, I'm surprised we didn't cover this case in the test suite.
Increasing coverage is good.

> @@ -1517,8 +1517,10 @@ int cmd_merge(int argc,
>  		option_commit = 1;
>  
>  	if (!argc) {
> -		if (default_to_upstream)
> +		if (default_to_upstream) {
>  			argc = setup_with_upstream(&argv);
> +			argv_to_free = argv;
> +		}

The fix looks correct to me. This whole argv-juggling is pretty gross
(especially the part below which overwrites argv[0]!). I suspect using a
separate strvec to hold the heads would be cleaner, but it is probably
not worth anybody's time to micro-polish this.

-Peff
