Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22573C09F8
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554444; cv=none; b=YPZjD9sY1Y1Tf2Mx8MUPdEX3ZTjEUH34TTaiAx81xfg1PlrEgyY3vI00UrEZCuci9VZtGRa4QI5+3dKl3JGkmJ4xI9AYVAAuzq55IH7310CKQHXGXDgy8+eoMFsHz2QMaQChi2uj45ZBvXwsU4CDERhv5stTgSMj3tomygcDV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554444; c=relaxed/simple;
	bh=AnwdlOXsW+EfV98ygyMWL6Dfd68taz1Ljt9LAt3LXRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvnAT2+QBQIlADMajIOsgDPdh6eMhlXTzmRRah4A0KheY9wEx9XDw51tuJ+XpNiAxLS+WpxIGW3zIO5MEUwGVU3Mr0vJbeku5/nLtv4PpPCUtGErpFLtoUOSKMn4EcQ58FpSeB9cmhztOm8I3QfhIkgCG19w9U5auR5LloWSCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YzVHWNpO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YzVHWNpO"
Received: (qmail 43310 invoked by uid 106); 4 Jun 2026 06:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AnwdlOXsW+EfV98ygyMWL6Dfd68taz1Ljt9LAt3LXRs=; b=YzVHWNpO8wBKZnus2w3Ga35s3zEQWa6/mASnaDKBVtDLyLDwuDa03Ov0E4pucAZupkufGOAzXljJ8/pBrdeaIHXcfmOjiKlqA+TCWAQHoDJBzSy85GBlS/F22a6Yd7kvfHcp4ziNDPHMSfvM7Pr2IP3WMMvcV+Rn2v+MDcx3sNik9prTlwF6+yaRD7cptDPY1DSx8k0I2bbv4UCPVjVK+IKmBe42kl7C/2XDBQIuNGw2ucYjEh34Ey9OkCrQF0Ni1XcDDOD2LNdAO1iJjzzC8mdtES4EGWyepOzG38WAgbFJznEaJRQnFas/Bxp81nvL/Rq45uuEtAmLi61CSJqJVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Jun 2026 06:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 110525 invoked by uid 111); 4 Jun 2026 06:27:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Jun 2026 02:27:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 4 Jun 2026 02:27:20 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH] read_gitfile_gently(): return non-repo path on error
Message-ID: <20260604062720.GA3195904@coredump.intra.peff.net>
References: <20260602061159.GA693928@coredump.intra.peff.net>
 <ah6WEtk2pXyViEQA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ah6WEtk2pXyViEQA@pks.im>

On Tue, Jun 02, 2026 at 10:36:34AM +0200, Patrick Steinhardt wrote:

> > The correct output (which this patch produces) is:
> > 
> >   fatal: not a git repository: /home/peff/compile/git/.git/worktrees/worktree3
> > 
> > And indeed, that path is missing. But why? I feel like I've run into
> > this same problem occasionally over the last year or so, but never
> > before. Did we get more aggressive about removing worktrees at some
> > point? I haven't been able to reproduce whatever is killing off the
> > worktree directory, and by the time I see the error it is long gone.
> 
> Both git-gc(1) and git-maintenance(1) prune orphaned worktrees that are
> older than three months by default, which can be configured via
> "gc.worktreePruneExpire". That logic has changed in 4dda60c9df (Merge
> branch 'ps/maintenance-missing-tasks', 2025-05-15), which would kind of
> match your timeline.
> 
> But rereading that patch series I cannot really see how it could result
> in more aggressive pruning of worktrees. We used `git worktree prune
> --expire <expiry>` before that series, and we still use that logic now.

Yeah, but this .git/worktrees/ directory shouldn't be pruned _at all_.
The worktree itself is still there (which is why I'm getting the error).
So perhaps there's a bug in checking that things are still there, or
perhaps something is corrupting .git/worktrees/*/gitdir.

Another option is "I moved my git checkout and the worktree prune
couldn't find the directory as an absolute path", but I'm sure I didn't
do that.

An even more exotic option is that I run Git's test suite a lot, and
very occasionally bugs in the test suite cause the script to escape the
trash directory. And some scripts do run "rm -r .git/worktrees". I find
it pretty unlikely for that to be the culprit though.

Oh well. I don't have any good leads, so I guess I'll see if it happens
again. But maybe now if somebody else sees it we can commiserate. :)

-Peff
