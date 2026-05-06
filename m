Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649993EDAD4
	for <git@vger.kernel.org>; Wed,  6 May 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072246; cv=none; b=jhr/xeuxaAwxLx+1GTOi8qKjOEfe2eVWC58Lv2SCcJuhfqXKJgkEpQHQ0lET2zL0g/FD8HBP6PFYFNuWDEI/V3qtfnYw1gFP5B5lSwvmv6l5HsNgXnr9/XBO4tsorLFw5fVXx1u71HcEp1oyyNnd7uhpdMEbUMadpJCTIjT1F3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072246; c=relaxed/simple;
	bh=tjWQ1EBW2u40PpOlHUYUAdlRtV03gMG3OVdw1r8Man0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEDrhvsdgTU/oZKxpX5GMqEp/9inHyko2LQJ6dAWga+i8LllWQYBoS0N6k5FbsOmV7UKAVa4vJX18NvTeDHSpuDSzQ+IAxC8L19ckQ3wUId3RJsd+ccqKSsPmScESOEVN8Aov1lBzhSAz9AqkUlOLh/L/2DmI+a+HJ/f1aEVBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4g9b4q6bc6zRnlL;
	Wed,  6 May 2026 14:57:15 +0200 (CEST)
Message-ID: <9fecbb11-3cc5-4084-bc29-bd948962dca0@kdbg.org>
Date: Wed, 6 May 2026 14:57:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
 <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
 <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
 <ac115a8f-5dbc-4988-b8a5-c1647af1bb74@kdbg.org>
 <f6c7c3d5-1d68-45b5-87a7-ae19b59270f4@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <f6c7c3d5-1d68-45b5-87a7-ae19b59270f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 06.05.26 um 13:27 schrieb Mark Levedahl:
> A git repository (gitdir) can have config.bare true | false | not set
> git rev-parse --is-bare-repository tells you that whatever gitdir is discovered from the
> current directory has core.bare==true. This happens whether the call is from inside the
> gitdir, or in the parent dir of a gitdir named '.git', or in a directory containing a
> symlink or a gitfile link to the gitdir. This call never tells you what directory you are
> actually in.

OK. But how does "find out which directory we are in" come into play
here? If we find a bare repository, we do not need a worktree. If we are
in a non-bare repository, we can find the worktree with `rev-parse
--show-toplevel`.

> 
> git rev-parse --is-inside-work-tree gives:
>     true - the call is made from a directory that is suported/supportable as a worktree of
> a gitdir.
>     false - the call is made from inside a gitdir, or from a directory linked to a to a
> gitdir with core.bare == true.
>     and error is thrown if no gitdir is discovered.
> 
> I find --is-inside-work-tree a much better call to make early in setup. 
>     true - full git-gui is ok, 
>     false - blame/browser is ok (gitdir might have core.bare true)
>     error - no gitdir found, the repository picker should be called.

But we would still make an exception for the case that $PWD is a
non-bare repository named ".git", because then, by Git GUI's definition,
its parent is the corresponding worktree.

> So, the only need to test if the repo is marked bare is when looking for a possible
> worktree when git-gui was started inside the gitdir, or started in a directory linked to
> said gitdir, or GIT_DIR in the environment points to said gitdir: I consider all of this a
> user (or configuration) error, and there are many possible causes to explore to give
> useful feedback to the user.

How does this scheme work when the user starts `git gui blame` in a bare
repository that does not have a worktree? Would this not produce an
error because no worktree was found?

> As you mentioned elsewhere, the problem on browser/blame is that _gitworktree is empty
> when no worktree is found, so GIT_WORK_TREE is exported to the environment as an empty
> variable. This cause is in a commit from 12 years ago:
> 
>     3decb8e0ac ("git-gui: tolerate major version changes when comparing the git version",
> 2014-05-17)

I don't think that this commit very relevant. The problem is in `git
branch --show-current` (and probably other git command variants) that
want to turn an empty $GIT_WORK_TREE into an absolute path even in cases
where no worktree is needed. I haven't tried to figure out which commit
(in the Git repository) started to do this.

> The fix is to set _gitworktree to _gitdir before exporting GIT_WORK_TREE, or to just not
> export an empty GIT_WORK_TREE. Obviously, having GIT_WORK_TREE = GIT_DIR is asking for
> trouble, but perhaps is ok as git-gui is running in a read-only mode for browse/blame. My
> limited testing shows this works.
Good to know. My preference is to not set GIT_WORK_TREE at all provided
that setting GIT_DIR without GIT_WORK_TREE is a use-case supported by Git.

-- Hannes

