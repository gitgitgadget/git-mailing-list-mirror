Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E939099C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424331; cv=none; b=rjYIMwlpczheRzoVDgKYIdcCvYGQc78wMNHjWxOML3i+k9JfAgfhgwo5u9DtdqRNWNSa2nkiUKVBe0UKyt02sFeYTLaPRV78Bb7tkNsDdNxdCE7e20OgPayVSNFPBzxWWMy7JTxzRDY+NA7D9L3JKPD9DRiR3efp2lbKDSy+7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424331; c=relaxed/simple;
	bh=lwBi9uQ9wUgp2rmlhJ++RG9WIelJm4DrGvk2pa02NXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy6LhBXk3D4elE7xXAo/pwXTteZXGYf7B4CrE+jiFY/CAgyqt46H91iMP4a391t2rq8RI55MeB0MkFJkuLYda88t2zNDfgkITp0DfHOMeTiMK40j9HDdJEL2z9eScsBenam2pa3p2A/5xFtOwTGr4o36ib4VypBqnMFsrOzc3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4gVHyR2gyWz7Yd7t
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 19:34:39 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4gVHyD3HNszRnm3;
	Tue,  2 Jun 2026 19:34:28 +0200 (CEST)
Message-ID: <8515a482-9a08-4b0a-bd7c-385e1bda1a20@kdbg.org>
Date: Tue, 2 Jun 2026 19:34:28 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] Improve git gui operation without a worktree
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.06.26 um 01:02 schrieb Mark Levedahl:
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
> v3 of this series addresses j6t's review of v2, with some reordering of
> patches (1 from j6t added, patch #8 moved to #1), adds another rewrite
> of the browser / blame parser that eliminates the notion of path before
> rev on the command line, blame works correctly with a user modified file
> in the worktree. Clarification is added on the need for GTI_WORK_TREE,
> and the logic in finding a worktree from the gitdir is simplified.
> 
> Johannes Sixt (1):
>   git-gui: remove unnecessary 'cd $_gitworktree' from do_gitk
> 
> Mark Levedahl (11):
>   git-gui: use HEAD as current branch when detached
>   git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
>   git-gui: do not change global vars in choose_repository::pick
>   git-gui: use --absolute-git-dir
>   git-gui: use rev-parse exclusively to find a repository
>   git-gui: use git rev-parse for worktree discovery
>   git-gui: simplify [is_bare] to report if a worktree is known
>   git-gui: try harder to find worktree from gitdir
>   git-gui: allow specifying path '.' to the browser
>   git-gui: check browser/blame arguments carefully
>   git-gui: add gui and pick as explicit subcommands
> 
>  git-gui.sh                | 377 ++++++++++++++++++++++----------------
>  lib/choose_repository.tcl |  21 +--
>  2 files changed, 223 insertions(+), 175 deletions(-)

This round looks excellent! Thank you very much!

While queuing, I applied the small fixup below to 03/12.

-- Hannes

diff --git a/git-gui.sh b/git-gui.sh
index 933e72c9b255..15dd2b3a84cc 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2064,7 +2064,6 @@ proc incr_font_size {font {amt 1}} {
 
 proc do_gitk {revs {is_submodule false}} {
 	global current_diff_path file_states current_diff_side ui_index
-	global _gitworktree
 
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.

