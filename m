Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941B34F26F
	for <git@vger.kernel.org>; Fri, 22 May 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439620; cv=none; b=uxzgdTaPrOLAsnqpg5CMiANOpPUOMvXB2vlrrVjv5nSriBdwsUYKGJbHF2jo94pxHv6TMxx6OWCQH09O01FELE3X4E4qx5TsN0DRDgvs86gmGtDoZse38jRiWeKdSBRrrQA4ehk5hv2DiQfor1HyCRDDfkUCAVDbnFCb6Y+WWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439620; c=relaxed/simple;
	bh=SfXS3S4r/Un11wSl/AEg7mqlAMDo/aSaK0z8oTe9J40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og0XMK/PhLwu11plzsQzoz6h3+WM73X6GKpxe7Y3v5jgWcBzCE/VGW0wbTA98DYx5LMmehV/smLxaEyUeUO241KLZ71OdewtcWu6dTMfswZnGU37QRA+e6jDWvyyj2f3jo/lWGjfIpa23aj33QR7hKSaENQM58fNKBC6JR6pYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4gMJmT4Rj3zRpWw;
	Fri, 22 May 2026 10:46:49 +0200 (CEST)
Message-ID: <8d1488ec-c4de-4ddd-b3cd-e1e8b4a343bf@kdbg.org>
Date: Fri, 22 May 2026 10:46:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] git-gui: use rev-parse exclusively to find a
 repository
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-5-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260520202411.108764-5-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.05.26 um 22:24 schrieb Mark Levedahl:
> git-gui attempts to use env(GIT_DIR) directly as the git repository,
> accepting GIT_DIR if it is a directory. Only if that fails is git
> rev-parse used to discover the repository.  But, this avoids all of
> git-core's validity checking on a repository, thus possibly deferring an
> error to a later step, possibly unexpected. Repository validation should
> be part of initial setup so that later processing does not need error
> trapping for configuration errors.
> 
> Let's just invoke rev-parse so all error checking is done.
> 
> While here, let's cleanup the error handling.
> 
> Stop if an error occurs and the user set GIT_DIR or GIT_WORK_TREE.
> Use of either or both of those variables is supported by git, but their
> use also means the user has taken responsibility that they are correct,
> so a failure is something the user must address.

Very much so!

> 
> Otherwise on error, continue the existing behavior and show the
> repository picker. But, let's move the possible invocation of
> repository_chooser::pick to a separate code block. This permits adding
> separate conditions on using pick indepent of repository discovery, and
> will be exploited later in the series.  Note that the picker always
> returns with the current directory in the root of a worktree with the
> git repository is in the .git subdirectory.  The variable "picked" is
> used by git-gui to automatically execute the "Explore Working Copy" menu
> item after the repository picker is run.  This is controlled by config
> variable gui.autoexplore, and happens after all discovery is complete.
> 
> Remove a later check on whether _gitdir is a directory: that code
> cannot be reached without rev-parse already validating the repository.
> 
> _prefix should not be set before worktree discovery: the prefix is only
> known after the worktree is found, and at this point we have only
> discovered the repository.

Sorry, but I cannot agree with "prefix is only known after the worktree
is found". The prefix is a property that can be known even if we haven't
asked where the top-level of the working tree is. See more below.

> This is true even when running the repository
> picker: that option provides a list of prior selections, and does no
> validation on the list beyond checking that the directories exist.  For
> now, just initialize _prefix along with other global variables.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 48 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 233c975786..c61a6cbd8f 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -374,6 +374,7 @@ set _gitdir {}
>  set _gitworktree {}
>  set _isbare {}
>  set _githtmldir {}
> +set _prefix {}
>  set _reponame {}
>  set _shellpath {@@SHELL_PATH@@}
>  
> @@ -1122,6 +1123,24 @@ unset argv0dir
>  ##
>  ## repository setup
>  
> +proc is_gitvars_error {err} {
> +	set havevars 0
> +	set GIT_DIR {}
> +	set GIT_WORK_TREE {}
> +	catch {set GIT_DIR $::env(GIT_DIR); set havevars 1}
> +	catch {set GIT_WORK_TREE $::env(GIT_WORK_TREE) ; set havevars 1}
> +
> +	if {$havevars} {
> +		catch {wm withdraw .}
> +		error_popup [strcat [mc "Invalid configuration:"] \
> +		   "\n" "GIT_DIR: " $GIT_DIR \
> +		   "\n" "GIT_WORK_TREE: " $GIT_WORK_TREE \
> +			"\n\n$err"]
> +		return 1
> +	}
> +	return 0
> +}
> +
>  proc set_gitdir_vars {} {
>  	global _gitdir _gitworktree env
>  	if {$_gitdir ne {}} {
> @@ -1138,17 +1157,22 @@ proc unset_gitdir_vars {} {
>  	catch {unset env(GIT_WORK_TREE)}
>  }
>  
> -set picked 0
> -if {[catch {
> -		set _gitdir $env(GIT_DIR)
> -		set _prefix {}
> -		}]
> -	&& [catch {
> -		# beware that from the .git dir this sets _gitdir to .
> -		# and _prefix to the empty string
> +# find repository.
> +set _gitdir {}
> +if {$_gitdir eq {}} {
> +	if {[catch {
>  		set _gitdir [git rev-parse --absolute-git-dir]
> -		set _prefix [git rev-parse --show-prefix]

You cannot leave the _prefix empty, because it breaks `git gui browser
master dir` when invoked from a subdirectory of the working tree.

This line must remain. I see that you add it back in later patch. There
may be some motivation to move prefix discovery, but there is no
motivation to remove it at this point.

>  	} err]} {
> +		if {[is_gitvars_error $err]} {
> +			exit 1
> +		}
> +		set _gitdir {}

BTW, this line would only be needed if the 'set _prefix' line above stays.

> +	}
> +}
> +
> +set picked 0
> +if {$_gitdir eq {}} {
> +	unset_gitdir_vars
>  	load_config 1
>  	apply_config
>  	if {![choose_repository::pick]} {
> @@ -1160,7 +1184,6 @@ if {[catch {
>  		catch {wm withdraw .}
>  		error_popup [strcat [mc "Unusable repo/worktree:"] " [pwd] "\n\n$err"]
>  	}
> -	set _prefix {}
>  	set picked 1
>  }
>  
> @@ -1175,11 +1198,6 @@ if {$hashalgorithm eq "sha1"} {
>  	exit 1
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

-- Hannes

