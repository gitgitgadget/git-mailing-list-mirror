Received: from shells.gnugeneration.com (shells.gnugeneration.com [66.240.222.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8814B061
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 04:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.240.222.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992032; cv=none; b=MSuBviLurwnkRhbp2E8LkGr+/A4jNnmP2BBEKLCBa21dv6lGi/sCMTCZOXxsWX5Of5hVX65LdpfWDFZjP7Qdam6GsV2NqzUxtKIcGYZsAGuCz1Xcv4lhUdgpFqTlCOWqXPipRQRbfpgwJY4I8KI7oZpcZlQqVTe/dbXaPaI3cJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992032; c=relaxed/simple;
	bh=IPbiX1gEEQvNlOOjyXuqBjKvJwvO10Rtjc2SKJQdkes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eynJi7PFlxC1apqpmQ7VdDrEru36LmN0hDNk6mbpKf14FBt+Op1R1ryPr5lGvmTnHM+UH6UtsgmzuSn5DOXtYQv9eQ+V23byXNoDpGlWUL5bMnl0hOg5YFuPHmLsERj/msNeiEXI5OHR5/Cd9ZpDqxFHEWlotZWlt6jFZGC426k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com; spf=pass smtp.mailfrom=shells.gnugeneration.com; arc=none smtp.client-ip=66.240.222.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shells.gnugeneration.com
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
	id 0DC7EC00B6B; Thu, 29 Aug 2024 21:18:31 -0700 (PDT)
Date: Thu, 29 Aug 2024 21:18:30 -0700
From: Vito Caputo <vcaputo@pengaru.com>
To: Roman Sandu <r.sandu@gaijin.team>
Cc: git@vger.kernel.org
Subject: Re: Committing crimes with NTFS-3G
Message-ID: <20240830041830.m675suaade5jrj3p@shells.gnugeneration.com>
References: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1dad03-703c-47ae-a039-c15aa765fd0b@gaijin.team>

On Thu, Aug 29, 2024 at 11:43:40PM +0300, Roman Sandu wrote:
> Good day!
> 
> I have a decently sized (80K files) monorepo on an NTFS drive that I have
> been working with for a while under Windows via git-for-windows. Recently, I
> had to (temporarily) switch to Ubuntu (24.04) via dual-boot for irrelevant
> reasons, and I decided that simply mounting my NTFS drive and using the
> monorepo from Ubuntu is a great idea, actually, as NTFS-3G allow for
> seamless interop with NTFS via UserMapping. And so that is exactly what I
> did and It Just Works!
> 
> Except it kind of does not. Every time I run `git status` it takes 8
> seconds, which is very painful when doing tricky history rewriting.
> 
> To diagnose the problem, I ran git status with GIT_TRACE_PERFORMANCE
> enabled, and what I see is that the "refresh index" region is taking up 99%
> of the time. Digging further, `strace -fc git status` tells me that 99% of
> the time is spent on newfstatat'ing files. Okay, makes sense, stat'ing files
> through FUSE is not all that quick. But how many files are we talking about?
> My repository has `feature.manyFiles` enabled in git, so I would expect
> `core.untrackedCache` make it so that `git status` skips basically
> everything except for the root folder which contains, what, 20 subfolders?
> But it actually does >96K stat calls! Which is more than the amount of files
> in the repository in total. Briefly looking at the output of `strace -f git
> status`, I see that git indeed goes through basically all of the repository,
> even things that have not changed for years, as if `core.untrackedCache` is
> not actually enabled. Manually enabling it on top of `feature.manyFiles`
> does not help. Note that `git update-index --test-untracked-cache` tells me
> that mtime does indeed work, and I've also manually stat'ed some folders
> which `git status` re-stats on every run and I see that the modify time is
> indeed a couple of hours ago, yet even when running `git status` several
> times in a row it re-scans the entire folder every time.
> 
> So, what do I do about this? It honestly looks like a git bug to me, maybe
> it silently fails to update the index with new timestamps because it was
> initially created on Windows? But I have no clue how to narrow this issue
> down further, so any ideas or suggestions would be appreciated!
> 

It was pretty big news that Paragon's read-write NTFS driver was merged
into the kernel.  You might want to give that a try if your main problem
is performance.

https://lore.kernel.org/lkml/CAHk-=wjn4W-7ZbHrw08cWy=12DgheFUKLO5YLgG6in5TA5HxqQ@mail.gmail.com/

Regards,
Vito Caputo
