Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3001A9B58
	for <git@vger.kernel.org>; Sun, 24 May 2026 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607000; cv=none; b=U8nipwCer0DGMheSw/EiQFhOqI10+7BE1NUtAyg/ZF2T3pSuDjgEFvt/QkHIiZHBWklcp010zylDvSgiB2tz3fAu//GHnDBvtFM18cvqjp7vMAtbqdjP9VjB5KrvG7a/pek4h7D1x2OXCu694EWzLB/7Wb1o/fLxrW+G6EVPG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607000; c=relaxed/simple;
	bh=dXZ6tQcmLdwadFoOatsmwkedsrwVEwUYtKqfLJw40SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxnYpqmbmwyh/1c+kovssDSIwrEO6aO3FaBaaCyGkK/ZxhSnhL5YSrLznFeu1vraF4kLDhCCpxFLIyxQKnYipb2ot/y/4wodQpMhagrSVEM/CO2uoB+W4rHaSGAaM3FwBYhQB81emcGHtDt4p2ONsOGUdmffGNO9+PcV2FKZF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gNVgP1V5XzRnCp;
	Sun, 24 May 2026 09:16:33 +0200 (CEST)
Message-ID: <43f070e4-e624-4a33-8c24-294520fb503a@kdbg.org>
Date: Sun, 24 May 2026 09:16:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Improve git gui operation without a worktree
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:23 schrieb Mark Levedahl:
> git gui has a number of inter-related problems that result in problems
> during startup from anything but a checked out worktree pointing at a
> valid git repository. Some of the symptoms are:
> - blame / browser subcommands, and launching gitk, are intended to be
>   useful without a worktree, but fail to work.
> - unlike git, git-gui is supposed to use the parent directory as a
>   worktree if started from the .git subdirectory in the very common
>   single worktree + embedded git repository format. This does not
>   work.
> - git-gui includes a repository picker allowing a user to select a
>   worktree from a list and/or start a new repo+worktree: this dialog can
>   appear at unexpected times, masking useful error feedback on
>   configuration problems.
> 
> This patch series addresses the above issues, substantially rewriting
> the initial repository/worktree process to rely upon git rev-parse so
> that git's knowledge of access rules, repository configuration, and use
> of GIT_DIR / GIT_WORK_TREE (or git --gitdir / --work-tree) is used
> throughout, replacing code largely based upon what git did in 2008. This
> also means that git gui will naturally gain any new rules implmented in
> git-core.
> 
> With this, git-gui only exports GIT_WORK_TREE when non-empty.
> GIT_WORK_TREE is needed, and must be exported, if the user is overriding
> core.worktree in the git repository. But, GIT_WORK_TREE cannot be used
> to specify the lack of a worktree, so exporting an empty GIT_WORK_TREE
> is one of the problems fixed by this series.
> 
> v2 of this series is a very substantial rewrite driven by j6t's review,
> with patches reoranized and squashed, interfaces to the repository
> chooser changed, a different code structure to allow user control of the
> repository picker, a different approach to fixing the command line
> parser for blame / browser, and other more minor changes. Patches
> for fixing blame / browser are now after all discovery refactoring as
> they cannot be tested without some of those fixes.
> 
> Many subtle things are fixed beyond the list at the top, including
> better compatibility with git blame and repeatable browser / blame
> operation for specific revs not in the worktree, regardless of the
> worktree state. j6t indicated that in the git-gui project, the following
> fails in the current release:
> 
> cd lib
> GIT_DIR=$PWD/../.git GIT_WORK_TREE=$PWD/.. ../git-gui.sh browser origin/master .
> 
> This is due to a _prefix issue, and is fixed as of the patch
>      git-gui: use git rev-parse for worktree discovery
> 

I've completed my review of this iteration.

Repository and working tree discovery is already converging fast.
However, I have issues with the proposed argument parsing of the browser
and blame modes, in particular, I don't think that we need to
accommodate the uncanny file-before-rev argument order and that it
disregards the worktree completely. Maybe we should postpone any changes
in this area, if possible?

Throughout, we use a strange indentation style of 'if {[catch ...' that
is violated in new code, but I left uncommented. It should indent the
catch body one additional level like so:

	if {catch {
			commands that can fail
		} err]} {
		error handling here
	}

Thank you very much for working on this topic.

-- Hannes

