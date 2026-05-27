Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78F357CFE
	for <git@vger.kernel.org>; Wed, 27 May 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879402; cv=none; b=nJPWck0Rs87MiddbHzqjGTseHIKk16KNVdd5syt57GDq9L5zC9qUlEPTXGg0dTPzijeN8gVajoVlPOWDq2+d3As0q7pY68ayscxmOoPPdadeSlBA9EDfv3BIrQEXl2rlyPja0ubOavCnSvB//bnXxO1dsZtpcUSo/+y4BwZl+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879402; c=relaxed/simple;
	bh=TRwugpVjndTyGhlUmjC3EQRpFImE5EAC0pRw4qFF4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJxBMCpCLB8p2l4euXTgNQRfR3eYbCmNaGv0Eo1Eg0j0XueCClHYWQTZwTiDB8rCjiEftdL+V0C2cB9hgtr60IzEKHFSxml5tV5f72mZGvgU2hIziIfrtmmOeKd2tcaxbCp50Od17VymqIx4UPgIamsLLH5jnw1y36boSwePxSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Uqe4+um4; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Uqe4+um4"
Received: (qmail 29395 invoked by uid 106); 27 May 2026 10:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TRwugpVjndTyGhlUmjC3EQRpFImE5EAC0pRw4qFF4Yc=; b=Uqe4+um4/QTd+RIODoULmdlU33ne0+Wbu0cuuEKARzRyTj2tsO/SJoeYSMND5R7elJqU0Hwhpo7m+85RcN+QeBsreJyYgSMMeSRJwVkJoRBJiLe59najjr3mKj0T7BzpSf3ulYhl9YVsYtg0CGWjY+GqBeOhpYTxBKqxCQFbkWP9tRMaizADxjSHhD6fZZZRsVPYw1HbrqBQZxHO9x8+CI9ghYn+BunOhXMCXIlsMwxUKz4ZUGdpMJehGhStnYZNGeBf3hlueqI17PoMjDaXHsPJMHRPKcQMHsGeXAeW0z5UM/FwRm7Tj03q/ckNOvjKolf67xEqjO+CdhxZlGbUcA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 10:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 73674 invoked by uid 111); 27 May 2026 10:56:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 06:56:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 06:56:39 -0400
From: Jeff King <peff@peff.net>
To: SURA <surak8806@gmail.com>
Cc: git@vger.kernel.org
Subject: git-maintenance detach timing, was Re: I discovered a minor issue
 with `git fetch`.
Message-ID: <20260527105639.GK981444@coredump.intra.peff.net>
References: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>

On Fri, May 22, 2026 at 03:45:25PM +0800, SURA wrote:

> A zombie process has appeared. It appears to originate from a `fetch`
> subprocess that terminates very quickly; despite several attempts, I
> have been unable to successfully capture it.
> 
> This issue was discovered within a legacy service. A few days after
> upgrading to Git 2.53.0, the system's PID resources were exhausted by
> zombie processes. This is likely the result of recent changes, as this
> problem did not exist in earlier versions (2.4x).
> 
> To be honest, this is not an urgent matter; I have already deployed
> `tini` as the init process (PID 1) to prevent the service from
> becoming unavailable.

Yeah, I agree that you need some kind of zombie-reaping init process.
But I did wonder if we might have started generating more zombies here.

I did a little poking around with "strace -p 1". I didn't see extra
fetch processes, but I did see a lot of zombie git-maintenance processes
getting reaped. Which makes sense; by default we run background
maintenance with --detach. We can't ever reap that ourselves, since the
whole point is that it might outlive the parent fetch.

Once upon a time, we used to run "git gc --auto", and it would check
whether gc was needed (using a simple count of objects and packs) before
detaching. So in most cases it would realize there was nothing to be
done and exit immediately without daemonizing, and would get reaped by
git-fetch.

We switched to running "git maintenance" in v2.29. But it didn't yet
have a detached mode; it just run "git gc --detach" under the hood, so
the behavior was roughly the same (gc was reaped by maintenance which
was reaped by fetch).

Later, git-maintenance learned its own --detach flag, as of v2.47. But
unlike gc, it detaches immediately, and then each sub-task decides if it
needs to be run or not. So every "git fetch" will generate a detached
maintenance process that then gets reaped by init.

And if you moved from a pre-v2.47 version, then you'd see an increase in
such processes.

I think this is probably OK in practice. It is an extra fork that git-gc
never incurred, but as long as you have a functioning init process, they
won't accumulate.

I do wonder if git-maintenance could be more like git-gc here. Its
notion of tasks is more abstract, but it could in theory ask each task
"do you need to run?" and if they all say "no", then it can quit without
detaching. That would save an extra fork() for every noop
auto-maintenance call. I don't know how measurable that is in practice.
Or even how easy it is for each task to do such a check. Something like
"prefetch" is kind of all-or-nothing; you find out whether it needs
doing by doing it.

-Peff
