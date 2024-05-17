Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9123754
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933504; cv=none; b=tC2rF4F4X6ORrcoQG5toxOQYCDVsd5YhqkTfSH31GmFNR9Gt3cWsk/9aRiIgFR+qBL5puConeJU1nUlDYr2ENEMezbBtKuB7wvsrYP62EpL4ToXhFBqTPpSJL8p/+W88sJsvRWdmpAvvSer7cW2pfgB62dtD5KbqG7JD4AWFLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933504; c=relaxed/simple;
	bh=kQPwPC+TOIxFGrMzHVfSTgi5MbZU3edPrCkMJrPmR6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4gyNS0WqZnWBx6pGL7pQe8/cjSs1Lo7oyKg+2QGEhiL+WEiSC02Jx4xvIZtipvFFAgZr1IKsoWBTxSTTe1vt3wQASSw1+7B48t7h/yBdeVlcKvrAoaizaH4xjHE8WWvv5aJjrobh3KRCrGZM11RUF7TbOGM9J/wAc+biu3KJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7280 invoked by uid 109); 17 May 2024 08:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 May 2024 08:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22940 invoked by uid 111); 17 May 2024 08:11:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 May 2024 04:11:37 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 May 2024 04:11:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <20240517081132.GA1517321@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
 <Zj8blb0QqC2zdOAC@framework>
 <ZkX9w6etjDVAh-ln@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkX9w6etjDVAh-ln@tanuki>

On Thu, May 16, 2024 at 02:36:19PM +0200, Patrick Steinhardt wrote:

> I was spending (or rather wasting?) some more time on this. With the
> below diff I was able to get a list of processes running after ~50
> minutes:

I was going to say "good, now I don't have to waste time on it". But
your findings only nerd-sniped me into digging more. ;)

> So it seems like the issue is t9211, and the hang happens in "scalar
> clone warns when background maintenance fails" specifically. What
> exactly the root cause is I have no clue though. Maybe an fsmonitor
> race, maybe something else entirely. Hard to say as I have never seen
> this happen on any other platform than macOS, and I do not have access
> to a Mac myself.
> 
> The issue also doesn't seem to occur when running t9211 on its own, but
> only when running the full test suite. This may further indicate that
> there is a race condition, where the additional load improves the
> likelihood of it. Or there is bad interaction with another test.

I can reproduce it at will and relatively quickly using "--stress" with
t9211. I pushed up a hacky commit that removes all CI jobs except for
os-clang, and it stops short of running the build/tests and opens a
shell using tmate. For reference (though you'd need to work out
something similar for GitLab).

  https://github.com/peff/git/commit/f825fa36ed95bed414b0d6d9e8b21799e2e167e4

And then just:

  make -j8
  cd t
  ./t9211-scalar-clone.sh --stress

Give it a minute or two, and you'll see most of the jobs have hung, with
one or two "winners" continuing (once most of them are hanging, the load
is low enough that the race doesn't happen). So you'll see 3.17, 3.18,
3.19, and so on, indicating that job 3 is still going and completing its
19th run. But everything else is stuck and stops producing output.

You can likewise see processes in "ps" that are a few minutes old, which
is another way to find the stuck ones. And I get the same three
processes as you: scalar clone, fetch, and fsmonitor--daemon.

And here's where I ran into tooling issues.

Normally I'd "strace -p" to see what the hung processes are doing. We
don't have that on macOS. Doing "sudo dtruss -p" runs without complaint,
but it looks like it doesn't report on the current syscall (where we're
presumably blocking).

I installed gdb, which does seem to work, but attaching to the running
processes doesn't show a useful backtrace (even after making sure to
build with "-g -O0", and confirming that regular "gdb ./git" works OK).

One can guess that scalar is in waitpid() waiting for git-fetch. But
what's fetch waiting on? The other side of upload-pack is dead.
According to lsof, it does have a unix socket open to fsmonitor. So
maybe it's trying to read there?

Curiously killing fsmonitor doesn't un-stick fetch, and nor does killing
fetch unstick scalar. So either my guesses above are wrong, or there's
something else weird causing them to hang.

I imagine there may be better tools to poke at things, but I'm at the
limits of my macOS knowledge. But maybe the recipe above is enough for
somebody more clueful to recreate and investigate the situation (it
probably would also be easy to just run the --stress script locally if
somebody actually has a mac).

-Peff
