Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439903B635C
	for <git@vger.kernel.org>; Wed,  6 May 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052728; cv=none; b=ZYrmN6m/+IZtmDOCAMgawjcVWAoF1KMO7ObkD06A1DC7sEnHA3Cp/hrRuBbjW9gqePdnn94PvSf04wqxTIwFqYUbR2Da0+KRG5s26/MgFZ+fQ2fo0qNF9ubYIz1TJS/DqUpWu46vl+qwSgtg0ddK6wgudXAAhdMzwdgJTQG/y6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052728; c=relaxed/simple;
	bh=tgMggROHTmnsc7aVVfPjzFZGY5FvarFKoWZsKZFAqtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWm3mBzh5W17i5H3KTlQB8xs3KqtfpAQ1Qxcx1NQZKQemlrvTcqWQkkjNWNWuZq8hhdN/E5JqYJ2KzgFkBUZ8hGQPsZm1cGpS9yyOTIymZ4StgYX+i9kp2YZSvBiIyORTbwHAQl1IvrIBeq3T0VkrwcNHK3Eb7CSJjY5sTHA/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4g9Rsb0vvJzRnlc;
	Wed,  6 May 2026 09:32:03 +0200 (CEST)
Message-ID: <ac115a8f-5dbc-4988-b8a5-c1647af1bb74@kdbg.org>
Date: Wed, 6 May 2026 09:32:02 +0200
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
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.05.26 um 17:13 schrieb Mark Levedahl:
> On 5/3/26 4:53 AM, Johannes Sixt wrote:
>> I would not call the use of --is-bar-repository instead of
>> --is-inside-git-dir an error, just a choice that has been made. In
>> particular, when the startup directory is named '.git' and is not marked
>> as bare, then its parent directory can very reasonably be taken as its
>> worktree. (That's how things worked before --show-toplevel was used.) If
>> the check is for --is-inside-git-dir, this treatment would be ruled out
>> early.
>>
> Whether being in a gitdir is ok, or a worktree required, is of fundamental importance and
> is not explicitly checked now. This is my issue. (Whether the repo is bare, or embedded in
> a worktree, is relevant only when automatically fixing a user error.)

I don't quite follow what you a trying to say here.

>> But perhaps there is a simpler solution: Let's present an error if
>> --show-toplevel fails except in the case where the startup directory is
>> named '.git' (and is a valid Git repository) and is not bare (then the
>> worktree is the parent). I insist in this exception, because this
>> use-case was considered important in the past (87cd09f43e56 "git-gui:
>> work from the .git dir", 2010-01-23).
>>
>> -- Hannes
>>
> 
> This would not fix gitk's blame / browse from a gitdir, and I don't really see a one or
> two line fix as being adequate.
> 
> git-gui sets GIT_WORK_TREE and GIT_DIR at startup. GIT_DIR passes my simple tests, but
> mishandles GIT_WORK_TREE.
> 
> I expect these two invocations to be equivalent, both starting git-gui in the worktree
> '/some/path':
> 
>     GIT_WORK_TREE=/some/path git gui
>     git -C /some/path gui
> 
> But, the GIT_WORK_TREE approach:
>     works as I expect ONLY when the current directory is a valid worktree
>     when started from a gitdir, uses that gitdir in conjunction with the requested worktree
>     when started from an uncontrolled directory, shows the repository picker.

The important aspect here isn't about the worktree, but whether a gitdir
can be determined for the current directory. All three observations make
total sense.

That said, setting GIT_WORK_TREE without also setting GIT_DIR is
undefined and need not be considered further.

> The git -C approach is indifferent to the current directory, of course.
> 
> GIT_WORK_TREE enters much too late in the process, and rather should handled first:
>     if GIT_WORK_TREE is in the environment, cd to that first. Throw an error if that
> directory is not a valid worktree.

As I said, GIT_WORK_TREE without GIT_DIR is an invalid use-case. For
this reason, the first thing to do is find the database, and from there
work out the worktree. In the most common use-case it is the current
directory.

> I don't actually understand the use case of defining GIT_DIR or GIT_WORK_TREE to git gui,
> and I wonder what other bugs are lurking... maybe the better approach is to just abort if
> GIT_DIR or GIT_WORK_TREE are defined?
I lean towards setting GIT_DIR always. This is necessary, because Git
GUI can be run from a subdirectory of the worktree, and then changes
directory to the top-level. It must be ensured that the same GIT_DIR is
used that was detected from the subdirectory.

Now that the current directory is at the top-level of the worktree, we
could just not set GIT_WORK_TREE at all, provided that setting GIT_DIR
without GIT_WORK_TREE is a valid use-case for Git. I am not yet sure
about that.

-- Hannes

