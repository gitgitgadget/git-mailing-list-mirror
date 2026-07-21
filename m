Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6B2DA76A
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606257; cv=none; b=jrPElB0NM/90HxupVysBu2eLD6IR1TnzO+NaTMc1T25IvfSYXU4kK8b5VyEykLsmMZPr7P8P+tHWCvGwshPDSh6ZgEFD6qm/n8zJbuJ6M7Ywx2llPcfa3MELsWeKdW59ub3pjMPoCizRnK1zR7De1/deKd+KdcuKTDNQN38+wF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606257; c=relaxed/simple;
	bh=Lnm+c12IVn3nqpOEHhlYDYh5jvWWR6KEP76XsMbjgJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2ksmdfbsVNdhotP4EH6XNGl9S6fYQXbc9V2pHwGkQxOTOPxSd6/QSgkh+We3p0ZEb39+N0/oljvUhF9TAgv84WzA2VUKWVzdhDjOBi29uMAX+9zFwU8q9sGny/YSQs/VvJ0jmLRfgySBX/5XmPG+3RCtLY5+eTWItHhxiO7uUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MtrJGz/Y; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MtrJGz/Y"
Received: (qmail 90840 invoked by uid 106); 21 Jul 2026 03:57:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Lnm+c12IVn3nqpOEHhlYDYh5jvWWR6KEP76XsMbjgJY=; b=MtrJGz/YZU7NSyN2W8LLdRIouir79tLMkRg9+U+e85F9aCrTLvqOBrsV43h/8xp+zaJAa6ZFjNyLtAYVx6gxa77oz03hNv2HcUupqFBCn/V/S66HUO8TBI4N5nXbRv4N49y3SH6o+50s42WzkpGweeICfScjKK/t1VcTvy+iUJKCgKuIzhAHhA/Pxs5Aehk9xxfF5wqZtx1l9gKCMdgCBLibu982963Pm/yaqTp4RupdRIpuAXJWnfJTRGCxyQueuXM9jFe8AnnD8+cZbC0bfj+QIFz5AY4rqXBNB+pYyHX1R+hwljYT2izusubrlVsHyjqhEWb1qRUQRkpVr6+M2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jul 2026 03:57:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29094 invoked by uid 111); 21 Jul 2026 03:57:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2026 23:57:33 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 20 Jul 2026 23:57:33 -0400
From: Jeff King <peff@peff.net>
To: Wolfgang Kritzinger <wkritzinger@atlassian.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <20260721035733.GA581473@coredump.intra.peff.net>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>

On Tue, Jul 21, 2026 at 03:17:23PM +1200, Wolfgang Kritzinger wrote:

> `strace` shows that after a push, 2.54 does a failing open() of
> of numerous loose objects -- once in the quarantine (incoming)
> directory and once in the main object store -- before finding it
> in a pack:
> 
> openat(".../objects/tmp_objdir-incoming-XXXX/ed/58..", O_RDONLY) = ENOENT
> openat(".../objects/ed/58..", O_RDONLY) = ENOENT

Interesting. Here's a smaller reproduction recipe that shows the issue:

  # clone of git.git, or any other non-trivial repo; it should be mostly
  # packed
  src=/path/to/git

  git init empty
  export GIT_ALTERNATE_OBJECT_DIRECTORIES=$src/.git/objects
  strace -fe openat \
    git -C empty rev-list --objects $(git -C $src rev-parse HEAD) >/dev/null

In v2.50, we see almost no loose object open calls, because we check the
pack first. But in v2.54, we see tons of them.

> 2.50 does not do this. In most customer deployments of Bitbucket,
> the Git data lives on an NFS share. The extra latency on NFS makes
> this process of checking for non-existent loose objects take too
> long, the push essentially hangs at the "Checking connectivity" step.

Yeah, I can imagine. But even on a fast filesystem, we definitely want
to avoid all of those syscalls. Replacing "strace" above with a timing
harness, even on a system with fast syscalls and a warm cache, the v2.54
version is ~12% slower.

> I believe this new behavior was introduced in the recent object
> database rework. After using bisect, I belive the problem can be
> traced back to commit 8384cbcb4c.

Hmm, my bisect ended up at a593373b09 (packfile: refactor
`find_pack_entry()` to work on the packfile store, 2026-01-09), which is
nearby. I'm not sure if it might depend on other factors (e.g., presence
of commit graphs, midx, etc) or my reproduction is not exactly like
yours, or if one of us messed up bisection.

+cc Patrick as the author of both commits.

> I don't know the codebase well, but from what I can see is that
> the order in which objects are looked up in object databases
> changed.
> 
> Assuming there are two object databases configured (Main repo,
> and the quarantine directory, for example), the lookup order used
> to be:
> 
> 1. _quarantine dir_ packs
> 2. _main dir_ packs
> 3. _quarantine dir_ loose objects
> 4. _main dir_ loose objects
> 
> With Git 2.54, the order appears to have changed to:
> 
> 1. _quarantine dir_ packs
> 2. _quarantine dir_ loose objects
> 3. _main dir_ packs
> 4. _main dir_ loose objects
> 
> In my testing, within a well-packed repo, Git 2.50 actually never
> performed a loose object lookup.

Yeah, and that type of regression makes sense for what a593373b09 was
trying to do. But I think the v2.54 behavior is wrong. We should check
all packs before any loose objects.

I'm not sure of the correct fix. This is working against the whole "odb
sources are independent and abstract" refactoring that a593373b09 was
going for. But I think it's an important optimization. I guess the
abstract version would be that each source has "fast" and "slow" lookups
or something like that, and we check all fast ones before slow ones. But
that is pretty gross.

I'll leave it to Patrick to ponder further. I haven't really been paying
a lot of attention to the odb refactoring.

-Peff
