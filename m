Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79685656
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387404; cv=none; b=Q0+aoHl1BiSwat1pqqIvX57b/IHbnqNAoZxUwFW3EuguhXnL6AZMxDhjr1Wv14xnCHQvRptr0AGiy0ywb/2Jk9vl1dY8YxOSEMLUVapTsuLl8HYMzCw+M7MBWzoLVBel+m4BoSHYAtKSuA+HyPV+8aIoePcjyTvlGBJroztyZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387404; c=relaxed/simple;
	bh=XA68Zp7buK/ax9xYQ1OsRSrGiNdQfiK/d3+s14iYbYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odYpX55hWAVlhV3xtKzZRGq2He/px1xMUpAORPXOz4hIVNXv4/UGyy9inGRPnfDrUvyQ/P46TLHLypEmMqEyuqq/M14WN+d3yd/2/ynPZAsPOmuCdDwkkAxxsFLspon+cYDBWSgVnoP3yU3ZZZ8lbtFIiExnOu2sc2nNhmKk0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7YWwgIJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7YWwgIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C386DC4AF0E;
	Thu, 31 Oct 2024 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730387402;
	bh=XA68Zp7buK/ax9xYQ1OsRSrGiNdQfiK/d3+s14iYbYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7YWwgIJqh2WWJB9+CuvB6ogo3qzjG5UDkv1bqLsw+8Y1XTHQkglmiXCJntcFECA2
	 k1NMCKyyCxulVsoLnu65BQdJjVOasi8KOMgsk0CGW20kh6mGwr1OtSZhGPQz2LonUb
	 rWl9cAtf0LletSsqimAZg5vEV15q8W4CWEfduP+Mn2gSSsoE/vaTszbcOAN2sWMJsw
	 ZOjMbpKFOJeFEeZapytQ+pOV8WHxw6R+li68c9xpfb/DNDZsXGFcSWmWC0B3AlziNX
	 q8mZbc6IBk5sOKOIMI/hTH3TsbAAI6Im1yVC32i/KJNctGulSNyY4F243Z1iNefmDY
	 vZXO5/zyLtqnQ==
Date: Thu, 31 Oct 2024 08:10:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [BUG] "git describe --match" performance
Message-ID: <20241031151000.svsa7d2ogcdz7hf6@jpoimboe>
References: <20241030044322.b5n3ji2n6gaeo5u6@treble.attlocal.net>
 <20241031114731.GA608553@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031114731.GA608553@coredump.intra.peff.net>

On Thu, Oct 31, 2024 at 07:47:31AM -0400, Jeff King wrote:
> On Tue, Oct 29, 2024 at 09:43:22PM -0700, Josh Poimboeuf wrote:
> 
> > $ time git describe --match=v6.10-rc7 --debug
> > describe HEAD
> > No exact match on refs or tags, searching to describe
> > finished search at d8470b7c13e11c18cf14a7e3180f0b00e715e4f0
> >  annotated       1844 v6.10-rc7
> > traversed 1282750 commits
> > v6.10-rc7-1844-gc61e41121036
> > 
> > real	0m9.243s
> > user	0m8.940s
> > sys	0m0.268s
> > 
> > $ time git describe
> > v6.10-rc7-1844-gc61e41121036
> > 
> > real	0m0.149s
> > user	0m0.111s
> > sys	0m0.036s
> 
> There's more discussion of the actual solution in the nearby thread from
> Rasmus. But I did want to note one thing here: when I initially tried to
> reproduce your problem, my "slow" case was a lot less bad.
> 
> The reason is that I had a commit graph file to speed up traversal. So
> independent of the git-describe fix, you might want to try:
> 
>   git commit-graph write --reachable
> 
> That reduces the slow case for me by a factor of 10. And likewise other
> traversal operations should get faster.
> 
> I think we'll build the commit graph file by default these days when you
> run "git gc". But we don't build it immediately after cloning. Perhaps
> we should change that.

Hm... I actually ran "git gc" and it didn't seem to help at all.

-- 
Josh
