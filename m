Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366244C0418
	for <git@vger.kernel.org>; Fri, 15 May 2026 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861168; cv=none; b=hbgXO5+H+w39fNCng2rohTgdwIp7sDUCqUnoB2/pULW0phJbF5Jd714quCY3tICjmm1V0znzndV49Yya0DnTfb2KaCQa6uyLElLMl/QFMSIBAQlwnoLCJp86Wzc7NrCDN+BKyAeZIUZQcA38LDUgVUX4EmkgYmgsmsmNLQPhjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861168; c=relaxed/simple;
	bh=HWH0hSd8F1vAAXkSST6lYgh+4zxuY70IWI2gKMWUnTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IADwpAXqATE53JCqpUbzsi76KBhKHze3cyCAnqWnA8GT/qYNDJwCIqDAQx/DjojEOqz1aoBPxPUuje5C3hZc5jR/y0ZtGSc+4faCpKynEnbomp/d6ML6kdXRPuWY91B/hoL1SBb0yCPn9/c9mHYnJ6Om76whF5abAnNdHRjuuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4gHBrW57ddzRnlS;
	Fri, 15 May 2026 18:06:03 +0200 (CEST)
Message-ID: <d8844726-0b08-4035-946e-c5ada0759f32@kdbg.org>
Date: Fri, 15 May 2026 18:06:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] git-gui: use rev-parse exclusively to find a
 repository
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-8-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-8-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui attempts to use env(GIT_DIR) directly as the git repository,
> accepting GIT_DIR if it is a directory. Only if that fails is git
> rev-parse used to discover the repository.  But, this avoids all of
> git-core's validity checking on a repository, thus possibly deferring an
> error to a later step, possibly unexpected. Repository validation should
> be part of initial setup so that later processing does not need error
> trapping for configuration errors.

OK. If the user gave us GIT_DIR with our without GIT_WORK_TREE, then
that combination better be workable.

> 
> Let's just invoke rev-parse so all error checking is done. Stop here if
> the user set GIT_DIR or GIT_WORK_TREE. Otherwise, continue the existing
> behavior and show the repository picker.

OK. But the paragraph is confusing, because a big "If an error occurs"
is missing after the first sentence.

> 
> Also, remove a later check on whether _gitdir is a directory: that code
> cannot be reached without rev-parse having validating the repository.

Good.

> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 2e2ddc0..81789dd 100755
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
> @@ -1167,19 +1168,18 @@ proc pick_repo {} {
>  	set picked 1
>  }
>  
> +# find repository.
>  if {[catch {
> -		set _gitdir $env(GIT_DIR)
> -		set _prefix {}
> -		}]
> -	&& [catch {
> -		# beware that from the .git dir this sets _gitdir to .
> -		# and _prefix to the empty string
> -		set _gitdir [git rev-parse --absolute-git-dir]
> -		set _prefix [git rev-parse --show-prefix]
> -	} err]} {
> +	set _gitdir [git rev-parse --absolute-git-dir]

Please do also set _prefix. It should fix the bug that the file chooser
uses an empty prefix after

cd lib
GIT_DIR=$PWD/../.git GIT_WORK_TREE=$PWD/.. ../git-gui.sh browser master .

(this is an old bug.)

Please keep the additional indentation of the catch body.

> +} err]} {
> +	if {[is_gitvars_error $err]} {
> +		exit 1
> +	} else {
>  		pick_repo
> +	}

Treat the 'if' as an early exist without an else, and we don't need the
previously strange indentation of 'pick_repo'.

>  }
>  
> +
>  # Use object format as hash algorithm (either "sha1" or "sha256")
>  set hashalgorithm [git rev-parse --show-object-format]
>  if {$hashalgorithm eq "sha1"} {
> @@ -1191,12 +1191,6 @@ if {$hashalgorithm eq "sha1"} {
>  	exit 1
>  }
>  
> -if {![file isdirectory $_gitdir]} {
> -	catch {wm withdraw .}
> -	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
> -	exit 1
> -}
> -
>  # _gitdir exists, so try loading the config
>  load_config 0
>  apply_config

(Stopping the review here for today.)

-- Hannes

