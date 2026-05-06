Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9403033DF
	for <git@vger.kernel.org>; Wed,  6 May 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051745; cv=none; b=d0UEBKNU4B8XYKwx48wTAFerJkDOFW+RHERGuC2dgByV8aUObrrS9PxRRY40tWOS89jH3p2UpcXg2bh2AEdjLnXFTckzzXG6Pr3Usb4cerTPtl44Dst2js9bARAzRWHDdXA2opBdlEAzBbukzYbZ8bVVM/n4o/P+kWb4JTXtSk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051745; c=relaxed/simple;
	bh=THS/bvQzWBjTKF7dRZRF5im/TTwIoTIe8yLu4gSMERM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4/M/ZbqV16wCthQrKhJOlDRxnWSQvztEPS64Bj+hQUtWpxWLUXmBzkAuYPJ09yr+UHY+Nrlkfu5CDKqSeCGvD5n6cI/7rYxtAobvW3cTO2XRRcU7KBvuh9eUoJrTUFQKUoZefIBBlPta6cy1JUDVotP6Dl3Rw2zUBKsGicdxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4g9RVZ5fzSzRpX9;
	Wed,  6 May 2026 09:15:33 +0200 (CEST)
Message-ID: <28db8297-c995-4e29-ae44-ade304b2aad5@kdbg.org>
Date: Wed, 6 May 2026 09:15:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] git-gui: restructure repository startup
Content-Language: en-US
To: Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
References: <tencent_277823B7C5D69914E168E5679A907C655606@qq.com>
 <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.05.26 um 16:59 schrieb Shroom Moo:
> When git-gui is started inside a .git directory of a non-bare
> repository, it should treat the parent directory as the worktree,
> as it did before commit 2d92ab32fd (rev-parse: make --show-toplevel
> without a worktree an error, 2019-11-19).  However, a bare repository
> or a separated gitdir without a worktree must be rejected early.
> 
> Protect the previously unguarded calls to `git rev-parse
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

Very good. This does things in the right order, IMO.

> 
> - Wrap `rev-parse --show-object-format` in a catch to avoid a crash
>   when the repository configuration is broken (e.g. core.worktree
>   pointing to an invalid path).

Nice catch. This could be moved into its own patch. But it is acceptable
in this patch as it loosely fits the topic.

> 
> Also removes the old `_prefix`‑based fallback that computed a relative
> path to the worktree top from a subdirectory, and the unconditional
> `[file dirname $_gitdir]` guess.  Both are unnecessary now that
> `rev‑parse --show‑toplevel` directly provides the absolute top‑level
> path and we can `cd` to it.  The guess is further unsafe in
> multi‑worktree setups, where a gitdir may have more than one worktree.
> The only remaining fallback is the explicit “.git directory” rule for
> non‑bare repositories, which mirrors the historical behaviour.

Nice cleanup.

> 
> This fixes the fatal Tcl error when the working tree is missing, while
> keeping the .git startup feature and avoiding any automatic directory
> switching that could be dangerous in multi‑worktree setups.

Good!

However, this doesn't fix `git gui blame HEAD file` in a bare
repository, because `git branch --show-current` fails with an empty
GIT_WORK_TREE value. Fixing this needs to consider whether to set
GIT_DIR and GIT_WORK_TREE at all, as alluded to by Mark in a near-by
message. This is a separate topic.

> 
> Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
> ---
>  git-gui/git-gui.sh | 72 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..c06d85b8d9 100755
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
> @@ -1160,46 +1173,50 @@ if {$_gitdir eq "."} {
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
> +# Handle bare repository early: if not allowed, abort
> +if {[is_bare] && ![is_enabled bare]} {
> +	catch {wm withdraw .}
> +	error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" [file normalize $_gitdir]]
> +	exit 1
> +}
>  
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
> +# Determine the working tree
> +if {[is_bare] && [is_enabled bare]} {
> +	set _gitworktree {}

I strongly suggest to collapse this branch and the previous 'if
{[is_bare] && ![is_enabled bare]}' into a single 'if {[is_bare]}',
because then in the else-branch below we can be sure not to have a bare
repository.

> +} else {
> +	if {[catch {set _gitworktree [git rev-parse --show-toplevel]} err]} {
> +		# If we are inside a .git directory of a non-bare repo,
> +		# the worktree is the parent directory
> +		set inside_gitdir 0
> +		catch {set inside_gitdir [git rev-parse --is-inside-git-dir]}
> +		if {![is_bare] && $inside_gitdir eq {true} && [file tail [file normalize $_gitdir]] eq {.git}} {

Do we need to 'file normalize' before taking the 'file tail'? If not,
then the line would be shorter.

> +			set _gitworktree [file normalize [file dirname $_gitdir]]
> +		} else {
> +			catch {wm withdraw .}
> +			error_popup [strcat [mc "Cannot determine working tree:"] "\n\n$err"]
> +			exit 1
> +		}
>  	}
> -	set _gitworktree [pwd]
> -	unset cdup
> -} elseif {![is_enabled bare]} {
> -	if {[is_bare]} {
> +
> +	if {$_gitworktree eq {}} {
>  		catch {wm withdraw .}
> -		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n$_gitdir"]
> +		error_popup [mc "Cannot determine working tree (unexpected empty result)"]
>  		exit 1
>  	}
> -	if {$_gitworktree eq {}} {
> -		set _gitworktree [file dirname $_gitdir]
> -	}
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
> @@ -1207,6 +1224,7 @@ if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end]
>  }
>  
> +# Export the final paths
>  set env(GIT_DIR) $_gitdir
>  set env(GIT_WORK_TREE) $_gitworktree
>  

-- Hannes

