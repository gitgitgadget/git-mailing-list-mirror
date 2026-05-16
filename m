Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23A3C4149
	for <git@vger.kernel.org>; Sat, 16 May 2026 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778919391; cv=none; b=NPT5nID+hOKKHbpwWks4hwzV9luTNuQS1ijRhLdrqdr7WjLCYKRPW7XyO5Em5VmkcCjTQBz8HRPJvxFf3EVQpB+Ckt7ueF5zT8dOZK83KBGVQn2OPb/G78sy7W8Z0yxbRydXnTUrFWbeK8z63JdQ4q51x17zMmxCKSqK9ppm1Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778919391; c=relaxed/simple;
	bh=wq9qr6a07W2G+b2J6ohsD53yOL1GF10Ji+igEofMJ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq3Pbaxv5ykDn9kS8xdKr4UgNixf1SvydrkOfgNK3oOJdqZv7tKAnk+iNc8miOlNplpUYjs4MKPhiJclSE4HHvqeTTv8gEDt8XxWQIAffQTqFa3OeQ8NTxbz3OLmSMTMR3cF9w+75kxtcT/fub4fHtpcEkJPq0BALPhl3ziEgOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gHcNC0LDDzRnlJ;
	Sat, 16 May 2026 10:16:27 +0200 (CEST)
Message-ID: <8b8feffa-1651-41aa-ac76-d2721d656b45@kdbg.org>
Date: Sat, 16 May 2026 10:16:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] git-gui: improve worktree discovery
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-11-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-11-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git gui's worktree discovery needs update based upon prior work in this
> series. In the normal case, all information we need comes directly from
> git rev-parse (--show-toplevel, and --show-prefix). Should this work, we
> have a valid worktree and all git gui commands can run.
> 
> If not, we need to consider:
> - if GIT_DIR or GIT_WORK_TREE are in the environment, just stop as we
>   the input configuration was wrong, the user must fix that.
> - if we have a browser or blame subcommand, no worktree is needed so
>   git-gui can run without.
> - using the git repository's parent is a valid worktree (if possible),
>   restoring prior behavior.
> 
> The current directory should be either the root of the worktree, if one
> is found, or the top-level of the git repository.

I disagree in the case where no working tree is found. Then there is no
point in changing the current directory.

> 
> Make it so. Also, make worktree discover directly follow repository
> discovery, reducing the locations that might need error trapping to
> catch configuration issues.

Good!

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>

BTW, please make the subject line more descriptive. The word "improve"
does not convey anything of importance.

> ---
>  git-gui.sh | 56 ++++++++++++++++++++++--------------------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index e326401..3a83dd5 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1173,6 +1173,28 @@ if {[catch {
>  	}
>  }
>  
> +# find worktree, continue without if not required
> +if {[catch {
> +	set _gitworktree [git rev-parse --show-toplevel]
> +	set _prefix [git rev-parse --show-prefix]
> +	cd $_gitworktree
> +} err]} {

We have three commands, each with their own possible failure sources.
One of the outcomes of an error is that we proceed anyway. I think that
this is incorrect if the 'cd' fails: we must not proceed if it fails.
Therefore, we must handle its failure separately.

> +	if {[is_gitvars_error $err]} {
> +		exit 1
> +	}
> +	set _gitworktree {}
> +	set _prefix {}
> +	if {[is_enabled bare]} {
> +		cd $_gitdir

Why change the directory here? If we run `git gui browser master dir` we
do not want to change the directory in an uncontrolled manner. The
argument parser will want to check for the existence of files, and then
we do not want to operate from a random directory.

Also, I think that the check must be for [is_bare] and not [is_enabled
bare].

> +	} elseif {![is_parent_worktree]} {
> +		catch {wm withdraw .}
> +		error_popup [strcat [mc "Cannot use bare repository:"] "\n\n" $_gitdir]
> +		exit 1
> +	}
> +}
> +
> +# repository and worktree config are complete, export them
> +set_gitdir_vars
>  
>  # Use object format as hash algorithm (either "sha1" or "sha256")
>  set hashalgorithm [git rev-parse --show-object-format]

This moves code around. In particular, we see load_config and
apply_config in the context below, which now happens only after these
calls. How certain are we that these have no effect on the code that
runs now earlier?

> @@ -1189,37 +1211,8 @@ if {$hashalgorithm eq "sha1"} {
>  load_config 0
>  apply_config
>  
> -set _gitworktree [git rev-parse --show-toplevel]
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
> +# Derive a human-readable repository name
>  set _reponame [file split [file normalize $_gitdir]]
>  if {[lindex $_reponame end] eq {.git}} {
>  	set _reponame [lindex $_reponame end-1]
> @@ -1227,9 +1220,6 @@ if {[lindex $_reponame end] eq {.git}} {
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

