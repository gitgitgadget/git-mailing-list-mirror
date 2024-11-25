Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C7376E0
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732535570; cv=none; b=ivr694ZrUw1+vuqh4OPCHhcrwBR0+aHsD3zYrt+mxSb9fTIucFLuB5g4whwyMTAl44m92xtgl3L4tR4MRiN33p9nWcOgYWH128XrnhCl1jUFGg9R/84LiS541SecRlHAjXNh97Qg2u4dBEgoOiDwu9L6KRWRh/TMcSM4f/97Y78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732535570; c=relaxed/simple;
	bh=zkr7jt+F5zjztN150PgUNmZFc9Q6TvxC+EIuzgwqbyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6ishIUmYHIdXpuA5wl8idgGYOC/5ctytGK79K40CNsUmXx6G/lsNTJ7DRp4gfiqDxFIUgUhH8C3w0TMflG20bBhWuu065XObSzmp/ZJnGLOAZ0c3Yv0FTJttjJ/QVcxA+SrF8mIl19Ozp0I+NwO6EDmcTLC5Zum5sALUhSaCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NWAmNi3H; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NWAmNi3H"
Received: (qmail 11139 invoked by uid 109); 25 Nov 2024 11:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zkr7jt+F5zjztN150PgUNmZFc9Q6TvxC+EIuzgwqbyg=; b=NWAmNi3HIb9AdCfiwEDk04xzUxB2AxW5OIukQPEozyqRjxNPV/HDHfy69L9zVs7GvuRpcwBnhQ0SXqtm5J1kTyAzSnl734R47+5FiX00AHmw4m4uUA7U/qmfedyucYV4nY36YwMCwynQjSPxlPtuAFHvIoUYd9ZvSEhlh0TsDg2Ke/w0AqKcsGaoLavewPJsYIxOorehS3Wc8rxVFvG0oLwBba9GPHLS4bk4rWWJwYoMtImzRm00VLtd94i9MbO/yv4/uC9I/tb5tHMTC2zmsMep++8di1Qpziuc4QbyEU0zaNaxNvtl4tfUptbFiRGfmDoxOEkaCmgEWfRscqrVng==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Nov 2024 11:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9477 invoked by uid 111); 25 Nov 2024 11:52:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2024 06:52:47 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Nov 2024 06:52:47 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Miguel Rincon Barahona <mrincon@gitlab.com>,
	Kev Kloss <kkloss@gitlab.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7900: fix host-dependent behaviour when testing
 git-maintenance(1)
Message-ID: <20241125115247.GA1070119@coredump.intra.peff.net>
References: <20241122153033.GA1737136@coredump.intra.peff.net>
 <eb504a75147d8609be66e131d239a69d192d693d.1732511129.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb504a75147d8609be66e131d239a69d192d693d.1732511129.git.ps@pks.im>

On Mon, Nov 25, 2024 at 06:33:41AM +0100, Patrick Steinhardt wrote:

> We have recently added a new test to t7900 that exercises whether
> git-maintenance(1) fails as expected when the "schedule.lock" file
> exists. The test depends on whether or not the host has the required
> executables present to schedule maintenance tasks in the first place,
> like systemd or launchctl -- if not, the test fails with an unrelated
> error before even checking for the lock file. This fails for example in
> our CI systems, where macOS images do not have launchctl available.
> 
> Fix this issue by creating a stub systemctl(1) binary and using the
> systemd scheduler.

Thanks, this explanation makes sense and clears up the CI issues I saw.

>  test_expect_success 'maintenance aborts with existing lock file' '
> -	test_when_finished "rm -rf repo" &&
> +	test_when_finished "rm -rf repo script" &&
> +	mkdir script &&
> +	write_script script/systemctl <<-\EOF &&
> +	true
> +	EOF
> +
>  	git init repo &&
>  	: >repo/.git/objects/schedule.lock &&
> -	test_must_fail git -C repo maintenance start 2>err &&
> +	test_must_fail env PATH="$PWD/script:$PATH" git -C repo maintenance start --scheduler=systemd 2>err &&
>  	test_grep "Another scheduled git-maintenance(1) process seems to be running" err
>  '

As always, I am never sure whether to use $PWD or $(pwd) for the benefit
of Windows. But digging up this message:

  https://lore.kernel.org/git/2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org/

I think $PWD is right here.

-Peff
