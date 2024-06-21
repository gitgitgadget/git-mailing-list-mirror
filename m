Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1471155329
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000005; cv=none; b=rSqqk/qhleE1uOrndQ56HkzHziooFIYS4cQyJQ5YsQHHUGzrOhNibfbZTjzxbjd61KkHc08fvjzXIC+SWyGlmO8e4QT35sqGAy6hTS9vwMGuwoL1LgAQzvkNAy0nl/nq127I9ZTGPTh5Mp0YLOYbbgoLVD90/L90EoSgFnMmF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000005; c=relaxed/simple;
	bh=bsR2zU3lYlDRQquxuBoiw0sFKiPCzPfepnMyksJF0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJnB0LpSHpQv3Kj1AWuNJ+wvQk0zLjEABZifxOjwPP2dPuI46QL3mghE//iOiPr0YL8J/a75GH5td1ivVajmu2ECBJYQyo1rGBUuA7rnfCOj8ZslokAMMLTi2jf6N0Z5fyalgcldmwTjJHdR+YKnPI64dhA8XGyJHGQmOnw8luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=QXmSt3wz; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="QXmSt3wz"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A961F7BE;
	Fri, 21 Jun 2024 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1719000003;
	bh=bsR2zU3lYlDRQquxuBoiw0sFKiPCzPfepnMyksJF0Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXmSt3wzKj4d5Rie1f+/bLFu0Y6Xiq7+zwM4FpXj+6TzZQcoL9GVyvW4cebgWWETR
	 WoFY/XoT1OZfvQuTcGLs8KwOjU9RFREZ4g2jz/BaVM+s/Fz1+qK6DgsMg7cjahtvd5
	 +PLokX8pzUqA/83zDcLxReENERf/oZUli6uJ/VDg=
Date: Fri, 21 Jun 2024 20:00:02 +0000
From: Eric Wong <e@80x24.org>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by
 default
Message-ID: <20240621200002.M726804@dcvr>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <xmqq1q4v5m5a.fsf@gitster.g>
 <20240618213041.M462972@dcvr>
 <20240621071640.GD2105230@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621071640.GD2105230@coredump.intra.peff.net>

Jeff King <peff@peff.net> wrote:
> On Tue, Jun 18, 2024 at 09:30:41PM +0000, Eric Wong wrote:
> 
> > +script='

<snip>

> > +expect="$hello_oid blob $hello_size"
> > +
> > +test_expect_success PERL '--batch-check is unbuffered by default' '
> > +	perl -e "$script" -- --batch-check $hello_oid "$expect"
> > +'
> 
> We often use "perl -e" for one-liners, etc, but this is pretty big.
> Maybe:
> 
>   cat >foo.pl <<-\EOF
>   ...
>   EOF
>   perl foo.pl -- ...
> 
> would be more readable? To be clear I don't think there's anything
> incorrect about your usage, but it would match the style of our suite a
> bit better.

*shrug*  It doesn't save the nested quoting/expansion confusion;
but it's Junio's call.  I don't think a v3 is worth the effort.

> Likewise, it would be usual in our suite for the helper to do the
> minimum that needs to be in perl, and use our normal functions for
> things like comparing output (rather than taking its own "expect"
> argument).

<snip>

> +test_expect_success PERL '--batch-check is unbuffered by default' '
> +	echo "$hello_oid" |
> +	perl run-and-wait.pl git cat-file --batch-check >out &&
> +	echo "$hello_oid blob $hello_size" >expect &&
> +	test_cmp expect out

I prefer to avoid process spawning overhead from test_cmp;
but that's a small drop in a big bucket.

> I went for brevity above. Notably missing are:
> 
>   - the use of strict/warnings. I think we've shied away from these in
>     the test suite because we want to run on any version of perl. In my
>     experience most strict/warnings output is actually telling you about
>     obvious garbage, but not always. IIRC perl got more strict about
>     "()" around lists in some contexts a few years back, and code which
>     used to be OK started generating warnings. OTOH, those warnings were
>     probably a sign of problems-to-come, anyway. Without "FATAL",
>     though, I think "use warnings" is not doing much good (nobody is
>     ever going to see its output if the test isn't failing).

It may make problems easier to find if there are failures,
so I think the potential benefits outweight any downsides.

>   - I dropped the close/waitpid. I guess maybe it is valuable to confirm
>     that cat-file did not barf, but IMHO the important thing here is
>     testing that it produced the single line of output we expected.

I've found some unexpected bugs through excessive error checking
in the past, so much preferred to keep them.
