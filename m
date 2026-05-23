Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00B3168FB
	for <git@vger.kernel.org>; Sat, 23 May 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779545166; cv=none; b=F/hEUxLgHF/tWTs7gffekkgTeYL9st5s89hYhwhRvekyeq4U0Z8XwCmXBJiCv0cFzjV26MIQJ2wFopupcpfh5wHzcVHE/54lNeZvY2UmME2qN3uwW2DnDkpc43esgK3eSdwy83up11Od9D+VmCB23gyzJ/AEpqZIffc3ER1Z7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779545166; c=relaxed/simple;
	bh=Q9oGW9tHJKR2IwuFZSidjLwd4Yn+I/2RO2Jfmk49wLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5jPWHcmYStEcQcHYmXG0iWZoy56nGlmPG74MmLLGgFUAxvcE7znYEcVRUAN4WMDHHGgq9lLmBsVdtQd5EWntfnYjagWqJjMl/41r1SMIgTVYgYmPKsr6M+qc17k0XOv0dbDHplQSgy0FpZ7EjB/cnMOWwZefK/rDLIURE4DWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gN3pJ51vTzRnlS;
	Sat, 23 May 2026 16:06:00 +0200 (CEST)
Message-ID: <a1e9da65-f8dd-4544-bbc9-d3b01328cebe@kdbg.org>
Date: Sat, 23 May 2026 16:06:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-8-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-8-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git-gui, since 87cd09f43e ("git-gui: work from the .git dir",
> 2010-01-23), has had the intent to allow starting from inside a
> repository, then switching to the parent directory if that is a valid
> worktree.

I can imagine that this kind of use occurs in "Git GUI here" menu item
of the file explorer on Windows. So, we should resurrect the feature.

> 
> This certainly hasn't worked since 2d92ab32fd ("rev-parse: make
> --show-toplevel without a worktree an error", 2019-11-19) in git, but
> breaking this git-gui feature was unintentional.
> 
> There are (at least) 3 cases where the gitdir can tell us where the
> worktree is, and we would like all to work:
> 
> - core.worktree is set, and points to a valid worktree. This is already
>   handled  by git rev-parse --show-toplevel, even when not in the worktree.
>   There is nothing more to do in this case.
> 
> - the gitdir is embedded in a worktree as subdirectory .git. The parent
>   is (or at least should be) a valid worktree. This worked long ago.
> 
> - the gitdir is a worktree specific directory (under
>   <mainrepo>/worktrees/worktree_name), within which there is a file
>   "gitdir" pointing to .git in the worktree. git gui never learned to
>   handle this case.
> 
> Let's handle the latter two cases. Always check that the discovered
> worktree is valid and points to the already discovered gitdir according
> to git rev-parse. This avoids issues that may arise because we are
> discovering from the gitdir up, rather than the worktree down, and file
> system non-posix behavior or misconfiguration of git might cause
> confusion.  For instance, a manually moved worktree might not be where
> the gitdir points.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 8fe25fe188..aeb7ed3548 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1100,6 +1100,41 @@ unset argv0dir
>  ##
>  ## repository setup
>  
> +proc find_worktree_from_gitdir {} {
> +	# Directory 'parent' of a repository named 'parent/.git' might be the worktree.
> +	# Assure parent is a worktree and using the git repository already discovered.
> +	# Also, handle case of being in a worktree's gitdir, where file "gitdir" points to
> +	# gitlink file .git in the real worktree.
> +	set worktree {}
> +	if {[file tail $::_gitdir] eq {.git}} {
> +		if {[catch {
> +			set gitdir_parent [file dirname $::_gitdir]
> +			set worktree [git -C $gitdir_parent rev-parse --show-toplevel]
> +			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
> +			if {$::_gitdir ne $parent_gitdir} {
> +				set worktree {}

I tried to come up with a situation where we end up here, but couldn't.
When would this happen? If it actually can't happen, I would prefer to
spawn fewer git processes and just take the result of 'file dirname'.

If the code must remain, can we please rename one of gitdir_parent or
parent_gitdir?

> +			}
> +		}]} {
> +			set worktree {}
> +		}
> +	} elseif [file exists {gitdir}] {
> +		if {[catch {
> +			set fd_gitdir [open {gitdir} {r}]
> +			set gitlink_parent [file dirname [read $fd_gitdir]]
> +			catch {close $fd_gitdir}
> +			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
> +			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]

Since worktrees can be messed up quite easily, it looks reasonable to
check whether the worktree points back to the gitdir. (But I haven't
tried to construct a case that passes the check in the next line.)

> +			if {$::_gitdir ne $parent_gitdir} {
> +				set worktree {}
> +			}
> +		}]} {
> +			catch {close $fd_gitdir}
> +			set worktree {}
> +		}
> +	}
> +	return $worktree
> +}
> +
>  proc is_gitvars_error {err} {
>  	set havevars 0
>  	set GIT_DIR {}
> @@ -1176,6 +1211,13 @@ if {[catch {
>  	set _prefix {}
>  }
>  
> +if {[is_bare]} {
> +	# Maybe we are in an embedded or worktree specific gitdir
> +	if {[set _gitworktree [find_worktree_from_gitdir]] ne {}} {
> +		set _prefix {}
> +	}
> +}
> +
>  if {![is_bare]} {
>  	if {[catch {
>  		cd $_gitworktree

-- Hannes

