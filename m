Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D4A2FD1B6
	for <git@vger.kernel.org>; Sat,  9 May 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778349179; cv=none; b=F0L5eG977QAsyxPMcTOBAl+ETgx8grLZw3Ctqa10qrwHS83CbaCM8HeXQM4TdB8W+crA9cnOi/fZhlBEDHIlLIkmLfAmUQtdcqyioGZHO2jU4iKvk8WA5scLNfDb6CJ4xXQKyUsdHXS5/WVQR3PyKYH7a65JGA7sgPQTcCvBu1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778349179; c=relaxed/simple;
	bh=ZK878qU4Lf6diHo9gliNmFimXyx6JSb7J8v3P/aXzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQSwRlwmXkb6+eQ/lXQxhFb+XMfwsVS6q0J70eXSVRQbSZcHjoDF7VNJvujb4lyQ0zRgBrDa8M4MbapZd0jmLJAiRW1pa4KAZzjQuQ6cd8TZKHgrJoSrJs7/+yWLqS977oyVZKP4H6KO2oubybAqPLvAinVE0T9bIUrosP+xUEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VBxhWnYA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VBxhWnYA"
Received: (qmail 1870 invoked by uid 106); 9 May 2026 17:52:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZK878qU4Lf6diHo9gliNmFimXyx6JSb7J8v3P/aXzFI=; b=VBxhWnYArnfx11OlAVwOGkOQjPdf1B45KiVUz/K7UgVFC7MlFB1CfDq12OOPZKC5xnB5/uStOMwZ1PElxAX+gGt+MUiLoRLi+C1E2DL/mQeIW97DuT+DYdjQR2GpXIb8k1w2Nm31jAehoO5ABI4HBjV72DD+p0fwiQsKnMYvkQdshcSOscbfd8zdAbZ99A3/epp0wqzrKglLDrgU4z0zZEx8RWMrLQFPosAUW1Jwaf5g7yQOaDtrwZMu6nQ2RetHX7XicMrSmKrecI9yWgtrUfVj+1OH+fHRulRsMz4aEZu4yy6hrR7fCexa+9WIEqNC+1zMODCMwFBrIE4LeWkakg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 09 May 2026 17:52:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3544 invoked by uid 111); 9 May 2026 17:52:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 09 May 2026 13:52:49 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 9 May 2026 13:52:49 -0400
From: Jeff King <peff@peff.net>
To: jean-christophe manciot <actionmystique@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: unexpected auto-maintenance, was Re: git hogs the CPU, RAM and
 storage despite its config
Message-ID: <20260509175249.GA2336928@coredump.intra.peff.net>
References: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>
 <20260508180341.GB737125@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508180341.GB737125@coredump.intra.peff.net>

On Fri, May 08, 2026 at 02:03:41PM -0400, Jeff King wrote:

> Also, should background maintenance be locking to avoid multiple runs?
> It does not seem to do so, and if I run:
> 
>   git init
>   for i in $(seq 10000); do
>     echo $i >>file
>     git add file
>     git commit -m "commit $i"
>   done
> 
> I get several concurrent pack-objects processes. After a few thousand
> commits I got bored and hit ^C, and the resulting repo was corrupt!
> Which is not too surprising, as multiple simultaneous repacks are known
> to be unsafe, but means we should probably avoid them.

There is a pretty awful bug here, and it got much worse in v2.54.

First, the locking for "git maintenance run --detach" is totally broken.
We take the lock as the first step of maintenance_run_tasks(), then run
foreground tasks, then daemonize(), and then run background tasks. But
daemonize() forks and exits the parent process, leaving the child
process to do the real work. But the lock subsystem registers the
lockfile as a tempfile to be cleaned up at exit. So the moment we
daemonize, we release the lock, even though we're still going to run
sub-commands that should happen under lock.

I don't think this affected the old "git gc --detach" because it takes
the lock after daemonizing[1]. We can't do the same here, though, since we
need to hold the lock for the foreground tasks. So either we need to
release and re-take the lock between foreground and background tasks, or
we need to teach the daemonize() function to update the "owner" field on
all of the tempfiles to the new child[2].

AFAICT this has been broken since a6affd3343 (builtin/maintenance: add a
`--detach` flag, 2024-08-16). But it was mostly harmless because under
the hood we were running the "gc" task, which ran git-gc itself in
no-detach mode. So git-gc took its own lock, and we never ended up with
more than one repack running at a time.

But that changed in 452b12c2e0 (builtin/maintenance: use "geometric"
strategy by default, 2026-02-24), which is new in v2.54. Now we are
running repack directly, with no additional locking. So because of the
lock bug from a6affd3343, that means lots of repacks running at the same
time.

Ultimately fixing the lock bug will solve that. Though if doing so is
too complicated for a quick maint release, I'm tempted to say we should
consider reverting 452b12c2e0 for a potential v2.54.1 (as there were a
few other regression fixes so far, I assume we'll have one soon-ish).

-Peff

[1] git-gc does have a mode where it will take the lock and run some
    foreground tasks. That mode probably has the same bug, but I'm not
    sure if it existed before we switched to "maintenance run --auto".
    At this point it's moot.

[2] You can't just disable the atexit handler in the parent process
    here, because then the child wouldn't actually clean them up either
    (because its pid will not match the owner field). So we really need
    to transfer ownership during the daemonize() process, which probably
    needs a new tempfile.[ch] function to walk the list and update all
    of the owner fields.
