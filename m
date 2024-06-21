Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C726AD5
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952024; cv=none; b=CA+MhXYseS0cFI/C107YJCRR1q/CBMCO/z5GT1apzYi9j8vxnVl+iXizQ2cJOC5BAcoVT5IEfHtA7xTfOF2nsE35LmEILnS6WRsdEdRYfXkYJAKeFxYJH50111NDQqz+gApBBDFzHp+qifYBXK5if3N+ncVoFT4opi4061+/le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952024; c=relaxed/simple;
	bh=FoO0oYRG2Bjj+UeoVvvzvKkk1envdgoa409Oyc1/3mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHiREB6Ag0K3IdQL3HxQnRm0fgoitVYQrRtjObZmmZjKvgepWR9dRLvMiQCn/luIJfvdxmRp0UqUQ/oROhGxAQFtqwhW4W2+9nzPgBz6tmB98QXSsF1JnrFhqu552KrNh56MWHVaTRaLD5jz+CutUQr2kbYaNBs2hlkb8sV3nQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26251 invoked by uid 109); 21 Jun 2024 06:40:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Jun 2024 06:40:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6494 invoked by uid 111); 21 Jun 2024 06:40:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Jun 2024 02:40:18 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Jun 2024 02:40:20 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pager: die when paging to non-existing command
Message-ID: <20240621064020.GB2105230@coredump.intra.peff.net>
References: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7106878-5ec5-4fe7-940b-2fb1d9707f7d@gmail.com>

On Thu, Jun 20, 2024 at 07:25:43PM +0200, Rubén Justo wrote:

> When trying to execute a non-existent program from GIT_PAGER, we display
> an error.  However, we also send the complete text to the terminal
> and return a successful exit code.  This can be confusing for the user
> and the displayed error could easily become obscured by a lengthy
> text.
> 
> For example, here the error message would be very far above after
> sending 50 MB of text:
> 
>     $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
>     error: cannot run non-existent: No such file or directory
>     50314363
> 
> Let's make the error clear by aborting the process and return an error
> so that the user can easily correct their mistake.
> 
> This will be the result of the change:
> 
>     $ GIT_PAGER=non-existent t/test-terminal.perl git log | wc -c
>     error: cannot run non-existent: No such file or directory
>     fatal: unable to start the pager: 'non-existent'
>     0

OK. My initial reaction was "eh, who care? execve() failing is only one
error mode, and we might see all kinds of failure modes from a missing
or broken pager".

But this:

> Finally, it's worth noting that we are not changing the behavior if the
> command specified in GIT_PAGER is a shell command.  In such cases, it
> is:
> 
>     $ GIT_PAGER=:\;non-existent t/test-terminal.perl git log
>     :;non-existent: 1: non-existent: not found
>     died of signal 13 at t/test-terminal.perl line 33.

...shows what happens in those other cases, and you are making things
more consistent. So that seems reasonable to me.

> The behavior change we're introducing in this commit affects two tests
> in t7006, which is a good sign regarding test coverage and requires us
> to address it.
> 
> The first test is 'git skips paging non-existing command'.  This test
> comes from f7991f01f2 (t7006: clean up SIGPIPE handling in trace2 tests,
> 2021-11-21,) where a modification was made to a test that was originally
> introduced in c24b7f6736 (pager: test for exit code with and without
> SIGPIPE, 2021-02-02).  That original test was, IMHO, in the same
> direction we're going in this commit.

Yeah, the point of f7991f01f2 was just to clean up the tests. The
modification was only documenting what Git happened to do for that case
now, and not meant as an endorsement of the behavior. ;) So I have no
problem changing it.

> The second test being affected is: 'non-existent pager doesnt cause
> crash', introduced in f917f57f40 (pager: fix crash when pager program
> doesn't exist, 2021-11-24).  As its name states, it has the intention of
> checking that we don't introduce a regression that produces a crash when
> GIT_PAGER points to a nonexistent program.
> 
> This test could be considered redundant nowadays, due to us already
> having several tests checking implicitly what a non-existent command in
> GIT_PAGER produces.  However, let's maintain a good belt-and-suspenders
> strategy; adapt it to the new world.

OK. I would also be happy to see it go. The crash was about reusing the
pager child_process struct, and no we know that cannot happen. Either we
run the pager or we immediately bail. I think that the code change in
that commit could also be reverted (to always re-init the child
process), but it's probably more defensive to keep it.

-Peff
