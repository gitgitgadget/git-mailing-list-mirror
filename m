Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8713E3DAF
	for <git@vger.kernel.org>; Fri, 15 May 2026 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833628; cv=none; b=QjDe56oH5m3EtqnyLjiMOIgtY2jnixk/8K2acYE/3a9IQxyqmC0naKNl97YwBJGX4WdFPMBA9ETaUk4MqK5V21G0rKiu/1fvU1L4hu3g3ykBTNNp/tXr2HV1qInRHKKLc30ge/KLy4SO2ntgZ8P/6oseeQ0KeHxK+qmspBxlVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833628; c=relaxed/simple;
	bh=puPT3oZdu/O4ulfhday8ubnBECobRUtJ7e7fR+F8Fvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWtmuv1uCytj7tus7+/+kYlhAB2S75fmhY0TkeBoRMpq31K+HjxQmZ8n9x7xq4AvmlgiQEd5+M8GQh5LjIcmr66BAx9exG9XD3KbQyvVKTWGCyFQcbK1FkMeHF10+TW0FIxcLMDA222INrkSS12I3frW/DF3wA7GvPxYzRpCUJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gH0fp0lsDzRqJW;
	Fri, 15 May 2026 10:26:56 +0200 (CEST)
Message-ID: <d327da74-0949-4310-9816-e18ed01ee317@kdbg.org>
Date: Fri, 15 May 2026 10:26:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] git-gui: restructure repository startup
To: Shroom Moo <egg_mushroomcow@foxmail.com>, git@vger.kernel.org
Cc: Mark Levedahl <mlevedahl@gmail.com>, Aina Boot <bootaina702@gmail.com>
References: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
 <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
 <tencent_2D0A6C14E8B34348B6F236BC8E7B66AB5105@qq.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <tencent_2D0A6C14E8B34348B6F236BC8E7B66AB5105@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 09.05.26 um 15:37 schrieb Shroom Moo:
> When git-gui is started inside a .git directory of a non-bare
> repository, it should treat the parent directory as the worktree,
> as it did before commit 2d92ab32fd (rev-parse: make --show-toplevel
> without a worktree an error, 2019-11-19).  However, a bare repository
> or a separated gitdir without a worktree must be rejected early.
> > Protect the previously unguarded calls to `git rev-parse
> --show-object-format` and `--show-toplevel`.  Restructure the startup
> sequence to:
> 
> - Check for a bare repository right after loading the config.  If the
>   repository is bare and the current subcommand does not allow bare
>   repos (e.g. normal commit mode), show "Cannot use bare repository"
>   and exit.
> 
> - When `rev-parse --show-toplevel` fails and the repository is
>   non-bare, the gitdir path ends with ".git", and we are inside that
>   gitdir, use the parent directory as the worktree.  This preserves
>   the ability to start git-gui from within a regular repository’s
>   .git directory, which was intentionally supported since 87cd09f43e56
>   (git-gui: work from the .git dir, 2010-01-23).
> 
> - Otherwise, show a descriptive error and exit.
> 
> - Wrap `rev-parse --show-object-format` in a catch to avoid a crash
>   when the repository configuration is broken (e.g. core.worktree
>   pointing to an invalid path).
> 
> Also removes the old `_prefix`‑based fallback that computed a relative
> path to the worktree top from a subdirectory, and the unconditional
> `[file dirname $_gitdir]` guess.  Both are unnecessary now that
> `rev‑parse --show‑toplevel` directly provides the absolute top‑level
> path and we can `cd` to it.  The guess is further unsafe in
> multi‑worktree setups, where a gitdir may have more than one worktree.
> The only remaining fallback is the explicit “.git directory” rule for
> non‑bare repositories, which mirrors the historical behaviour.
> Additionally, only export GIT_WORK_TREE when it is not empty, to avoid
> confusing commands in bare-repository subcommands.
> 
> This fixes the fatal Tcl error when the working tree is missing, while
> keeping the .git startup feature and avoiding any automatic directory
> switching that could be dangerous in multi‑worktree setups.

I think that the end result is useful. However, frankly, the patch
attempts to do too many things at once and should still be split further:

- The removal of the cdup fallback could be a preliminary patch.

- The protection of --show-object-format could be a follow-up patch.

> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Helped-by: Mark Levedahl <mlevedahl@gmail.com>
> Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
> ---
>  git-gui/git-gui.sh | 76 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..9eb93a76b5 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1129,7 +1129,8 @@ if {[catch {
>  		}]
>  	&& [catch {
>  		# beware that from the .git dir this sets _gitdir to .
> -		# and _prefix to the empty string
> +		# and _prefix to the empty string; this is handled by
> +		# the startup safety checks below
>  		set _gitdir [git rev-parse --git-dir]
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
> @@ -1142,8 +1143,20 @@ if {[catch {
>  	set picked 1
>  }
>  
> +if {![file isdirectory $_gitdir]} {
> +	catch {wm withdraw .}
> +	error_popup [strcat 
> +		[mc "Git directory not found:"] "\n\n$_gitdir\n\n" \
> +		[mc "Please ensure GIT_DIR points to a valid Git repository"]]
> +	exit 1
> +}
> +

This was moved from below. I would appreciated if there were no changes
in the moved code so that `git diff --color-moved` can show that no
changes were intended. I am not sure that the additional sentence that
mentions GIT_DIR is warranted. If you feel it is needed, please add it
in a separate patch with a justification.

>  # Use object format as hash algorithm (either "sha1" or "sha256")
> -set hashalgorithm [git rev-parse --show-object-format]
> +if {[catch {set hashalgorithm [git rev-parse --show-object-format]} err]} {
> +	catch {wm withdraw .}
> +	error_popup [strcat [mc "Failed to determine hash algorithm:"] "\n\n$err"]
> +	exit 1
> +}
>  if {$hashalgorithm eq "sha1"} {
>  	set hashlength 40
>  } elseif {$hashalgorithm eq "sha256"} {
> @@ -1160,46 +1173,52 @@ if {$_gitdir eq "."} {
>  	set _gitdir [pwd]
>  }
>  
> -if {![file isdirectory $_gitdir]} {
> -	catch {wm withdraw .}
> -	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
> -	exit 1
> -}
>  # _gitdir exists, so try loading the config
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
> +# Handle bare repository and determine working tree
> +if {[is_bare]} {
> +	# Bare repository: only allowed for certain subcommands
> +	if {![is_enabled bare]} {
>  		catch {wm withdraw .}
> -		error_popup [strcat [mc "Cannot move to top of working directory:"] "\n\n$err"]
> +		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" [file normalize $_gitdir]]
>  		exit 1
>  	}
> -	set _gitworktree [pwd]
> -	unset cdup
> -} elseif {![is_enabled bare]} {
> -	if {[is_bare]} {
> -		catch {wm withdraw .}
> -		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
> -		exit 1
> +	# Allowed bare repo does not have a worktree
> +	set _gitworktree {}
> +} else {
> +	# Non-bare repository: we must find a worktree
> +	if {[catch {set _gitworktree [git rev-parse --show-toplevel]} err]} {
> +		# The only acceptable failure is when we are inside
> +		# the .git directory of a regular repository.
> +		set inside_gitdir 0
> +		catch {set inside_gitdir [git rev-parse --is-inside-git-dir]}
> +		if {$inside_gitdir eq {true} && [file tail $_gitdir] eq {.git}} {
> +			# Use the parent directory as worktree (historic behavior)
> +			set _gitworktree [file normalize [file dirname $_gitdir]]
> +		} else {
> +			catch {wm withdraw .}
> +			error_popup [strcat [mc "Cannot determine working tree:"] "\n\n$err"]
> +			exit 1
> +		}
>  	}
> +
>  	if {$_gitworktree eq {}} {
> -		set _gitworktree [file dirname $_gitdir]
> +		catch {wm withdraw .}
> +		error_popup [mc "Cannot determine working tree (unexpected empty result)"]
> +		exit 1
>  	}

An empty $_gitworktree should be practically impossible at this point.
Personally, I would let the following "cd" handle the case (it fails if
the argument is empty).

> +
>  	if {[catch {cd $_gitworktree} err]} {
>  		catch {wm withdraw .}
> -		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
> +		error_popup [strcat [mc "Cannot move to working directory:"] "\n\n$err"]
>  		exit 1
>  	}
>  	set _gitworktree [pwd]
>  }
> +
> +# Derive a human-readable repository name
>  set _reponame [file split [file normalize $_gitdir]]
>  if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end-1]
> @@ -1207,8 +1226,11 @@ if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end]
>  }
>  
> +# Export the final paths
>  set env(GIT_DIR) $_gitdir
> -set env(GIT_WORK_TREE) $_gitworktree
> +if {$_gitworktree ne {}} {
> +	set env(GIT_WORK_TREE) $_gitworktree
> +}
>  
>  ######################################################################
>  ##

-- Hannes

