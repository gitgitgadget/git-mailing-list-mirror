Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3138D686
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448297; cv=none; b=i0RUwJ7yLlxQJNMEQ+lsv0HEt6DhqpVpzTzVZbK8outFVyq7bAD7POPlAabG1zf2HIpnTJpPtqyLvEv6uNc4IbpBkzG040rwzLJOsyBsaXllKgYsdll4e1oxnluq+GNgtvxeObue59vCXqJ6kdLdOfmbb1iFI8r+drMk/Ax3KL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448297; c=relaxed/simple;
	bh=frpjGL9ERtJkiU/QE7nrG7G6PFVGRIkk48B/kz8mpmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=OtFFR84Th00N8MjFfdIarQ/d1oLdRGRGO79FdDIyNRx9/jjcGtrvps7EmPHB9Ydvj2WexIIcqgAz5sd6vaGa5ATvV57e2m781Oak9uGvCWj3tfTKIZ2RGE9uKp8IblcitHJNCbaZv+GESXcTtW/WMUC1ORc4XzYX+RFZh/EIr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4g57Ss528Fz7VPZc
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 08:59:09 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4g57Sj17jGzRmcT;
	Wed, 29 Apr 2026 08:58:59 +0200 (CEST)
Message-ID: <308229f2-0d20-4f3b-8e6a-c962bd9c3a6e@kdbg.org>
Date: Wed, 29 Apr 2026 08:58:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: handle bare repo or missing worktree
To: Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_3FF7B35FE8AD7236FC9BBB628B45EA65F405@qq.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <tencent_3FF7B35FE8AD7236FC9BBB628B45EA65F405@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 21.04.26 um 18:28 schrieb Shroom Moo:
> When starting git-gui from a directory that Git recognizes as a valid
> repository but the repository is either bare or its working tree is
> missing, git-gui previously attempted to execute 'rev-parse
> --show-toplevel' without error handling. This caused a fatal Tcl error
> ("this operation must be run in a work tree") and prevented the user
> from opening the repository selection dialog.
> 
> Improve the repository setup logic:
> - After obtaining the git directory via 'rev-parse --git-dir', check
>   whether the repository is bare or if the working tree can be
>   successfully located.
> - If the repository is unusable as a working tree, display a warning
>   and present the "Create/Clone/Open" repository selection dialog.

I consider it harmful to allow the user to create (or clone) a
repository after Git GUI has already determined the existence of a
repository. If the worktree was not found, we should report an error and
exit after the message is dismissed, and not give the option to create a
repository.

> 
> This makes git-gui robust when launched from a bare repository, from
> inside a .git directory without a worktree, or when GIT_DIR points to
> an invalid location. No regressions observed in normal working trees.
> 
> Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
> ---
>  git-gui/git-gui.sh | 75 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 18 deletions(-)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 23fe76e498..2e4bc2f226 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1123,24 +1123,63 @@ unset argv0dir
>  ## repository setup
>  
>  set picked 0
> -if {[catch {
> -		set _gitdir $env(GIT_DIR)
> -		set _prefix {}
> -		}]
> -	&& [catch {
> -		# beware that from the .git dir this sets _gitdir to .
> -		# and _prefix to the empty string
> -		set _gitdir [git rev-parse --git-dir]
> -		set _prefix [git rev-parse --show-prefix]
> -	} err]} {
> -	load_config 1
> -	apply_config
> -	choose_repository::pick
> -	if {![file isdirectory $_gitdir]} {
> -		exit 1
> -	}
> -	set picked 1
> -}
> +# Save temporarily for restoration later
> +set _startup_cwd [pwd]
> +
> +set need_pick 0
> +if {[catch {set _gitdir $env(GIT_DIR); set _prefix {}}]} {
> +    # GIT_DIR not set in environment, attempt auto-detection
> +	# beware that from the .git dir this sets _gitdir to .
> +	# and _prefix to the empty string
> +    if {[catch {set _gitdir [git rev-parse --git-dir]; set _prefix [git rev-parse --show-prefix]} err]} {
> +        # Not inside any Git repository, proceed to repository selection UI
> +        set need_pick 1
> +    } else {
> +        # Inside a Git repository, but need to verify its usability
> +        cd [file dirname $_gitdir]
> +        set bare 0
> +        set worktree_missing 0
> +		# Check if this is a bare repository (no working tree)
> +        if {![catch {set bare [git rev-parse --is-bare-repository]}]} {
> +            if {$bare eq "true"} {
> +                set bare 1
> +            }
> +        }
> +		# Check if working tree is present and accessible
> +        if {[catch {git rev-parse --show-toplevel}]} {
> +            set worktree_missing 1
> +        }
> +
> +        cd $_startup_cwd
> +
> +        # For bare repos or missing worktrees, warn and guide to selection
> +        if {$bare || $worktree_missing} {
> +            set msg [mc "The repository at '%s' cannot be opened:" [file normalize $_gitdir]]
> +            if {$bare} {
> +                append msg "\n\n" [mc "It is a bare repository (no working tree)."]
> +            } else {
> +                append msg "\n\n" [mc "The working tree appears to be missing or inaccessible."]
> +            }
> +            append msg "\n\n" [mc "Please select a valid working repository, or create/clone one."]
> +            tk_messageBox -icon warning -type ok -title [mc "Repository Unusable"] -message $msg
> +
> +            set need_pick 1
> +        }
> +    }
> +}
> +
> +if {$need_pick} {
> +    load_config 1
> +    apply_config
> +    choose_repository::pick
> +    if {![file isdirectory $_gitdir]} {
> +        exit 1
> +    }
> +    set picked 1
> +}
> +
> +# Clean up working tree checking temporary variables
> +unset -nocomplain _startup_cwd need_pick bare worktree_missing

This adds quite a lot of code with failure cases, but after this point
we already have some quite extensive error diagnosis, too. Except that
the call to git rev-parse --show-toplevel is not protected.

If we do not invoke the Create/Clone/Open dialog after a repository has
already been discovered, would it not be sufficient to just add the
protection around the --show-toplevel call? Or is there something else
missing in the existing error paths?

-- Hannes

