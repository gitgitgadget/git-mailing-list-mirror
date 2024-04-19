Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4A13B28A
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549391; cv=none; b=HSI3Y5lOFA1F/z8fAEeqmXuU+HRovWmPXWkdqhDRmd6dkmzkZyfC85o5coPYfl5KkClX6KgpzkrlEFs5G3iM6B/69q1brodF0c8m/M53g+4MgrHGanDw32Go+z2YjmHki/6ZDNSKqyzyUznEwP67WPG4z8RgT+13IUS3jahS9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549391; c=relaxed/simple;
	bh=9OdNTEDw53ElzQLsx/tkEOStJr0mGxzLcyvpenJn+4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWiDvjqG0xiLE8j3qNHW0ST5T8nxmMAwHOlStjBuvmmQih9J8+xglMPWRa561Rx4abqwHA1zXoTsrfkAEzSgwqCMpExnDpMLVO8zW7YaqZ3GhaO9byGzRb/t+DcHSp5ENDeOk5Ol2MPdpAlqcLPwHf7UA2X4etohLKGbPYIOqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16497 invoked by uid 109); 19 Apr 2024 17:56:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Apr 2024 17:56:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26512 invoked by uid 111); 19 Apr 2024 17:56:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Apr 2024 13:56:23 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Apr 2024 13:56:21 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] for-each-repo: optionally keep going on an error
Message-ID: <20240419175621.GB14309@coredump.intra.peff.net>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
 <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
 <abd796894c857fc9ad96b9942089474df01f0506.1713444783.git.gitgitgadget@gmail.com>
 <ZiHyGFRPm_pwdGgC@tanuki>
 <xmqqy199l4qf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy199l4qf.fsf@gitster.g>

On Fri, Apr 19, 2024 at 09:03:20AM -0700, Junio C Hamano wrote:

> You mean that it could be a regression that we lose the raw return
> value from run_command_on_repo() when !keep_going?
> 
>  - git.c:handle_builtin() does exit(run_builtin(builtin, argc, argv));
>    In this case, builtin is set to cmd_for_each_repo.
> 
>  - cmd_for_each_repo does "return result" at its end.
> 
>  - result comes from run_command_on_repo(), which returns the value
>    returned by run_command().
> 
>  - run_command() returns -1 for "not found".
> 
> So if run_command() failed due to missing command, we would have
> exited with 255 (= (unsigned)(-1) & 0xFF), but with this change we
> would now exit with 1.
> 
> Passing anything outside 0..255 to exit(3) is a bad manners, and but
> this does change behaviour.  Hmmm.

run_command() may also return the exit code of the program run. So
imagine a setup like:

  git init
  git config alias.foo '!exit 123'
  git config repo.paths "$PWD"
  git for-each-repo --config=repo.paths foo
  echo $?

Before the patch we see "123" and after we see "1".

I do agree that passing -1 to exit is bad; we maybe should normalize to
127 for not found, though I think we could also see -1 for system errors
like fork() failing.

-Peff
