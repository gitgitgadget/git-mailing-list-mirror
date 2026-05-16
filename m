Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA09363C7A
	for <git@vger.kernel.org>; Sat, 16 May 2026 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920146; cv=none; b=bIvcNiZ/JF1+cz+B5T7HgfYMUDg/f+lG5zaqrjh+0G160ZWUydpdsApDz76Cn2KBUnWJgRX9DKkHik6f91LeAKkhGZGoETajlucg4XYAduNy9ubjUCcXwzGMPzMSrAtOZWy2qT7Uzt9w17phYIGOOubykQBeGkOWH4IjMVMo9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920146; c=relaxed/simple;
	bh=VCApAdwh/zatopiJQDc+MOVf60B868DZNj7WQYp4byI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxw58BoCDHa9ez1zacCdc3vZe/uzlYOeapjDNUdXYKXObQL4aUAp67LS+XiyMCUy0UMoLiLScNwdhjHTAwzDmI3FMy5LDSRu5GeOUWO89u5iBbP9Vtovg6Nxm5i0275DxNlZl1w3B37tfE5xXjg2x1B8Z5qPiGtNBv9/3Lcp9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gHcff3L1JzRnlY;
	Sat, 16 May 2026 10:28:58 +0200 (CEST)
Message-ID: <c5147296-06e1-4f7d-8f4f-f424e26e5b13@kdbg.org>
Date: Sat, 16 May 2026 10:28:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] Improve git gui operation without a worktree
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git gui has a number of inter-related problems that result in problems
> during startup from anything but a checked out worktree pointing at a
> valid git repository. Some of the symptoms are:
> - blame / browser subcommands, and launching gitk, are intended to be
>   useful without a worktree, but fail to work.
> - unlike git, git-gui is supposed to use the parent directory as a
>   worktree if started from the .git subdirectory in the very common
>   single worktree + embedded git repository format. This does not
>   work.
> - git-gui includes a repository picker allowing a user select a worktree
>   from a list and/or start a new repo+worktree: this dialog appears at
>   unexpected times, masking useful error feedback on configuration
>   problems.
> 
> This patch series addresses the above issues, substantially rewriting
> the blame / browser command line process, the initial repository and
> worktree discovery processes, and using git rev-parse when possible to
> handle repository / worktree discovery including any specification of
> GIT_DIR or GIT_WORK_TREE to reduce the future likelihood of conflict
> with command line git. This also allows explicit user control to avoid
> the repository picker masking a configuration error.

OK. Overall, this goes in the right direction. There are still open
questions and potential problems with this implementation. We also
disagree in a few details; see my comments on the patches.

> 
> Note: I question why git-gui ever exports GIT_WORK_TREE. If it is not
> empty, that is the current directory when startup is complete and any
> git command will use the current directory as the worktree.

I fully agree with this.

> If empty,
> there is no worktree and the current directory should be (and after this
> series, is) at the toplevel of the gitdir: again, there is nothing to
> communicate to another process.

Here I disagree. We should not need to change directory if no working
tree was found.

> If a process being launched needs a
> different worktree, that should be the startup directory given to the
> process without changing git-gui's current directory.

I haven't thought this through, but this sounds very reasonable.

> 
> Mark Levedahl (11):
>   git-gui: allow specifying path '.' to the browser
>   git-gui: refactor browser / blame argument parsing
>   git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
>   git-gui: put choose_repository::pick in a proc
>   git-gui: use --absolute-git-dir
>   git gui: GIT_DIR / GIT_WORK_TREE make any discovery error fatal
>   git-gui: use rev-parse exclusively to find a repository
>   git-gui: simplify [is_bare] to report if a worktree is known
>   git-gui: support using repository parent dir as a worktree
>   git-gui: improve worktree discovery
>   git-gui: add gui and pick as explicit subcommands
> 
>  git-gui.sh | 276 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 135 insertions(+), 141 deletions(-)
> 

-- Hannes

