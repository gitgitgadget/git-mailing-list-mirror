Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BD19004A
	for <git@vger.kernel.org>; Sat, 23 May 2026 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779542832; cv=none; b=emkYaEwCb8XIqWTtMl/HnTQSoBjTGOY3R03imm2mMDRQghBCCyK6kALTS0cQDTVPyzDm6uAZfz/FqC0aTgAK/+X6yaTxFuUOjGyuI9QyYDFMZLWEj5vtuQgfrfr92/CeJD8G3S8Rua1XG+lspENdgDC5CM5FzfBQmCi9Fu4qerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779542832; c=relaxed/simple;
	bh=1qBkZRG7irjBrFCfV89MMtmWvnB3Ae6Sp0FyTn9uB3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TtPiMgz7Jk6LmK3KOi4g2Eu48FvMUujdXCxJb/BJw5D7CgKX39esKJkPArIhTF2wjyf1869RZrp47IhBYSRJ/1upwvNX7ofGl5Q2FeVfFPt+Y0fD6zbAsFiElJdRPT0zbZ7z1ExAX807q0G7Rbo4deBvOhEkZ124DbNntpOQ8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gN2xF1d4NzRnCy;
	Sat, 23 May 2026 15:26:57 +0200 (CEST)
Message-ID: <40533d91-660d-4dad-b8fd-a11dac9a8b0a@kdbg.org>
Date: Sat, 23 May 2026 15:26:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] git-gui: use git rev-parse for worktree
 discovery
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-7-mlevedahl@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-7-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git gui uses a combination of tcl code and git invocations to determine
> the worktree and the location with respect to the worktree root
> (_prefix). But, git rev-parse provides all of this information directly,
> and assures full error and configuration checking are done by git
> itself. The entirety of discovery in normal configurations involves
> 
> 	git rev-parse --show-toplevel (gets worktree root)
> 	git rev-parse --show-prefix (shows location wrt the root)
> 
> An error thrown on either of these lines means the worktree discovered
> by git is unusable, or git did not discover a worktree because the
> current directory is inside the repository. If the user has defined
> GIT_DIR or GIT_WORK_TREE, this is a user configuration error and git-gui
> should stop.
> 
> Otherwise, the blame or browser subcommands can be used without a
> worktree.
> 
> A separate error might occur when changing to the root of the discovered
> worktree. The cause would be file system related and completely outside
> of git's control. So, the final "cd $worktree_root" is separately
> trapped.
> 
> Discovery of the repository and the worktree must be guarded to trap
> errors: the intent is that any configuration problems are caught during
> discovery, and later processing need not include error trapping and
> recovery. So, move all worktree discovery code to be immediately after
> repository discovery.
> 
> This does move configuration loading to occur after worktree discovery
> rather than before. None of the code executed in worktree discovery has
> any option controlled by a git-gui configuration variable, so no impact
> is expected. git itself will always read the repository configuration,
> including worktree specific configuration data if that exists, so this
> is unaffected by when git-gui loads its own config data, and we cannot
> be sure the full worktree dependent configuration can be loaded before
> full discovery is complete.

Very good!

When you move code around, please do not apply style changes so that

git show --color-moved --color-moved-ws=allow-indentation-change

can prove that no change was intended.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 64 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 30 insertions(+), 34 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 936c309e59..8fe25fe188 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1164,6 +1164,36 @@ if {$_gitdir eq {}} {
>  	set picked 1
>  }
>  
> +# find worktree, continue without if not required
> +if {[catch {
> +	set _gitworktree [git rev-parse --show-toplevel]
> +	set _prefix [git rev-parse --show-prefix]
> +} err]} {
> +	if {[is_gitvars_error $err]} {
> +		exit 1
> +	}
> +	set _gitworktree {}
> +	set _prefix {}
> +}
> +
> +if {![is_bare]} {
> +	if {[catch {
> +		cd $_gitworktree
> +	} err]} {
> +		catch {wm withdraw .}
> +		error_popup [strcat [mc "Cannot change to discovered worktree: "] \
> +			"$_gitworktree" "\n\n$err"]
> +		exit 1;
> +	}
> +} elseif {![is_enabled bare]} {
> +	catch {wm withdraw .}
> +	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
> +	exit 1
> +}
> +
> +# repository and worktree config are complete, export them
> +set_gitdir_vars
> +
>  # Use object format as hash algorithm (either "sha1" or "sha256")
>  set hashalgorithm [git rev-parse --show-object-format]
>  if {$hashalgorithm eq "sha1"} {
> @@ -1179,37 +1209,6 @@ if {$hashalgorithm eq "sha1"} {
>  load_config 0
>  apply_config
>  
> -set _gitworktree [git rev-parse --show-toplevel]
> -
> -if {$_prefix ne {}} {
> -	if {$_gitworktree eq {}} {
> -		regsub -all {[^/]+/} $_prefix ../ cdup
> -	} else {
> -		set cdup $_gitworktree
> -	}
> -	if {[catch {cd $cdup} err]} {
> -		catch {wm withdraw .}
> -		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
> -		exit 1
> -	}
> -	set _gitworktree [pwd]
> -	unset cdup
> -} elseif {![is_enabled bare]} {
> -	if {[is_bare]} {
> -		catch {wm withdraw .}
> -		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
> -		exit 1
> -	}
> -	if {$_gitworktree eq {}} {
> -		set _gitworktree [file dirname $_gitdir]
> -	}
> -	if {[catch {cd $_gitworktree} err]} {
> -		catch {wm withdraw .}
> -		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
> -		exit 1
> -	}
> -	set _gitworktree [pwd]
> -}
>  set _reponame [file split [file normalize $_gitdir]]
>  if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end-1]
> @@ -1217,9 +1216,6 @@ if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end]
>  }
>  
> -# Export the final paths
> -set_gitdir_vars
> -
>  ######################################################################
>  ##
>  ## global init

-- Hannes

