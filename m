Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ACC1A0728
	for <git@vger.kernel.org>; Sun,  3 May 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798405; cv=none; b=hXENT4HTrYQQ95miF+Bj9KUONjNFfbb4uwYvTjFLEt0Hs4k0fWZzUm/VMf9WcTN0MCfcOH8zKuAWsyIDoe9Wo55Qp/kNUxCUofpLnswugDrk5Pe8qr7gz9KxGoMopVwKVory5Qkx8QO0+0RgzRZSoIli7pRXufHexUTCl6twW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798405; c=relaxed/simple;
	bh=5aSO1a/p1I830lDmX3uloOMTJA15SzgEHT98OMHmW1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4Eq/jqsAKhKRJXSz8kTDOzxQveCXu5Gshh5Trui8AsLytP+Qcn47S5sIrxZ0xhU9JbF3imuWUGiL7Zs7QXJzBLoRi7oefFKeM2eVobDYTOKkS3yTIpZ4A27+WtvdTZlDzK62bb/aHI8jtOmf509VOqPJwa24GF8x5PYbvycErk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4g7dpg6XZcz7QVX9
	for <git@vger.kernel.org>; Sun,  3 May 2026 10:53:15 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4g7dpS463yzRnlT;
	Sun,  3 May 2026 10:53:04 +0200 (CEST)
Message-ID: <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
Date: Sun, 3 May 2026 10:53:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 02.05.26 um 23:51 schrieb Mark Levedahl:
> Two basic problems I see here are beyond the question of if (and when) git-gui should try
> to locate a worktree:
> 
> - git gui blame in a gitdir was apparently broken by the git repo commit 2d92ab32fd
> ("rev-parse: make --show-toplevel without a worktree an error", 2019-11-19). Prior to that
> commit, git gui would stay in the startup directory enabling only features that cannot
> modify the repository, and gitk could bring this view up in a gitdir. This doesn't work
> right now.

True, `blame` used to work in bare repositories, but is broken now.

> - git-gui's logic includes a conceptual error embodied in proc is_bare: is_bare uses $(git
> rev-parse --is-bare-repository) but what we need is $(git rev-parse --is-inside-git-dir),
> and these are not synonyms.
> It does not matter whether a worktree exists that points at the gitdir, and as discussed
> before, main worktrees can easily exist that we cannot locate from the gitdir. At best,
> is_bare is a guess.
> So, is_bare should be replaced by is_inside_gitdir, and we should also have
> is_inside_worktree. These are mutually exclusive, though both can be false.

I would not call the use of --is-bar-repository instead of
--is-inside-git-dir an error, just a choice that has been made. In
particular, when the startup directory is named '.git' and is not marked
as bare, then its parent directory can very reasonably be taken as its
worktree. (That's how things worked before --show-toplevel was used.) If
the check is for --is-inside-git-dir, this treatment would be ruled out
early.


> My current idea of an improved startup flow enables features only at the end:
> 
> 1) If not in a gitdir or worktree, 
>     1a)   if git gui's subcommand is not 'gui', abort with an error (citool, browser, or
> blame invocations carry information specific to a gitdir/worktree). 
>     1b)   otherwise, invoke repository_chooser, which either aborts, or changes directory
> to a worktree.
> 
> -- we are now in a gitdir or a worktree, and this may or may not be the startup directory.
> 
> 2) Look at the combination of git gui subcommand and directory type (worktree / gitdir) to
> decide to continue.
>     2a) blame / browser are ok in either directory type.
>     2b) citool requires a specific worktree, which should have been the initial startup
> directory. Abort if not.
>     2b) gui requires a worktree. Abort if not (my recommendation), or offer to find (or
> automatically find) a worktree.
> 
> 3) Change directory to the top level of of the directory_type (git rev-parse knows
> toplevel of a worktree, different code is needed for a gitdir).
> 
> 4) Enable features based upon subcommand and directory type.
> 
> There are 12 combinations of initial directory type (gitdir, worktree, neither) and
> subcommand (gui, blame, browser, citool) to consider, with a lot of duplicated code
> amongst the 12 cases. So, obviously, steps 1 and 2 can be convolved in many ways that are
> different than what I wrote above.
So true.

But perhaps there is a simpler solution: Let's present an error if
--show-toplevel fails except in the case where the startup directory is
named '.git' (and is a valid Git repository) and is not bare (then the
worktree is the parent). I insist in this exception, because this
use-case was considered important in the past (87cd09f43e56 "git-gui:
work from the .git dir", 2010-01-23).

-- Hannes

