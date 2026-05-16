Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AA384CD0
	for <git@vger.kernel.org>; Sat, 16 May 2026 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778919303; cv=none; b=L3W5upp3eTuMjoSFcIyZBPrSnq3tapc+G6QfrjGUyniWW5noF0I09fo71MDCX/rsCM++1l7k604pbobuCGRk+n9d9Bf+ZFRa+dIaT2R7TAFf40xxqPM1judAcixQ9hetAxjBYuCK+74LnIc1er0VBCR0uH1mUHDnHpTdFOpnppQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778919303; c=relaxed/simple;
	bh=WJ3GICn1e7ZMB7Zy51opqsyqSwkczgPJ4ynulPMhlC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2PvlNvqykOyj8tyG9R18X7YLcMi2biZt4g4bIUEsLY0h3b5JqsQlcrzFfa90sIqMTf4lxtSSPVohmV9JN9pdWKRUbAvEy5uzldZ/JXuPw+p2Yj9XCWKRpjSasnXoZV9Miy1+9FHOziXPXXEiJ7GPqYphFZtkI6iDA0axbk0y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gHcLT6s6jzRnmG;
	Sat, 16 May 2026 10:14:57 +0200 (CEST)
Message-ID: <4d25544d-1a7e-4407-9191-1fb05ff55244@kdbg.org>
Date: Sat, 16 May 2026 10:14:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] git-gui: support using repository parent dir as
 a worktree
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-10-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-10-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui, since 87cd09f43e ("git-gui: work from the .git dir",
> 2010-01-23), has had the intent to allow starting from inside a
> repository, then switching to the parent directory if that is a valid
> worktree.
> 
> This certainly hasn't worked since 2d92ab32fd ("rev-parse: make
> --show-toplevel without a worktree an error", 2019-11-19) in git, but
> breaking this git-gui feature was unintentional.
> 
> Add a proc to test if the parent of the git repository is a valid
> worktree, and set that directory as the worktree if so. Use invocations
> of git rev-parse to assure all validity and safety checks included in
> git-core are executed.

BTW, missing sign-off.

> ---
>  git-gui.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index a03eaa7..e326401 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1100,6 +1100,23 @@ unset argv0dir
>  ##
>  ## repository setup
>  
> +proc is_parent_worktree {} {
> +	# Directory 'parent' of a repository named 'parent/.git' might be the worktree
> +	set ok 0
> +	if {[file tail $::_gitdir] eq {.git}} {
> +		set gitdir_parent [file join $::_gitdir {..}]
> +		set expected_worktree [file normalize $gitdir_parent]

We have [file dirname ...]. Is there a reason to avoid it?

> +		catch {set git_worktree [git -C $gitdir_parent rev-parse --show-toplevel]}
> +		if {[string compare $expected_worktree $git_worktree] == 0} {

The purpose of this check should be explained in a comment. I think it is:

For a repository with the database in a directory named .git we assume
that the working tree is the directory containing .git. But
configuration may point to a different worktree. Then we do not want to
hold on to our assumption.

However, whether [git -C elsewhere ...] uses the same gitdir that we
have discovered so far cannot be told from this piece of code alone.
Therefore, I think it is wrong to extract this check into a function.

Also, I don't think we can use string comparison here. On Windows, the
command returns the Windows style path, but Tcl my operate with a POSIX
style path.

> +			set ::_prefix {}
> +			set ::_gitworktree $git_worktree
> +			cd $git_worktree

So many side-effects in a function whose name suggests that it only does
some checks. Please, don't do that.

> +			set ok 1
> +		}
> +	}
> +	return $ok
> +}
> +
>  proc is_gitvars_error {err} {
>  	set havevars 0
>  	set GIT_DIR {}

In general, I am not a fan of commits that add new functions, but no
call sites. Please squash this into 10/11. Ditto for is_gitvars_error in
06/11.

-- Hannes

