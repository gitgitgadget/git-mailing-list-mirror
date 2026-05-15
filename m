Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD96282F1A
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860783; cv=none; b=UJB2qJn/92wS9t3eDlMoJpMI6Ng3yG23erU2F1IbcmRREzoK+GmCeLaW6ePOIF3zIvCAuy0N8haIxs3fnphC4NaBLvFTjRX/rbu1HxalrQGHqtL/Chzq7TQmuaafWK9ZUcr3tRoIUhJ3ry9gZ+lD56H8iGzmOTKG8V71KBrCrds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860783; c=relaxed/simple;
	bh=gQPrfOAQ2UzMwQMiT4jEfFBOxmownEbLpomkbB4DuvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNiGtnPjXyEM3DrY3FZ21jypeYIdv9tjl8+FyU6tsDx81B6a+SCMfVvOTX4P0kwFxJmxAgluaMR2iwbPZAJLgVS3yb0/5oL4heGNNeJyuL3frXRXcdKxKiAexSw/O+qGcd1lzeSRTJ8pEdYflOhn2dWpnvBEWjTiSv2Lx9iprlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gHBj60nt8zRnlt;
	Fri, 15 May 2026 17:59:38 +0200 (CEST)
Message-ID: <7544deeb-163c-4444-833a-7b840a7caa4a@kdbg.org>
Date: Fri, 15 May 2026 17:59:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] git-gui: put choose_repository::pick in a proc
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-5-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-5-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui includes a 'repository picker', which allows creating a new
> repository + worktree, or selecting a worktree from a recent list.
> git-gui runs the picker when a valid git repository is not found. All of
> the code for this is embedded in the discovery process block, making the
> latter more difficult to read, and also making things more difficult if
> we want to have an explicit 'pick' subcommand to force this to run.

OK, let's see how useful this becomes.

> 
> Let's move this invocation and supporting code to a separate proc,
> aiding in subsequent refactoring. Assure GIT_DIR and GIT_WORK_TREE are
> unset, configuration is loaded, ant that _gitdir is correctly set

s/ant/and/

> afterwards. As this is invoked before worktree discovery, later code
> will set that anyway so need not be included here.
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-gui.sh | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 387cad6..0b73c35 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1139,6 +1139,16 @@ proc unset_gitdir_vars {} {
>  }
>  
>  set picked 0
> +proc pick_repo {} {
> +	unset_gitdir_vars
> +	load_config 1
> +	apply_config
> +	choose_repository::pick
> +	set _gitdir [git rev-parse --absolute-git-dir]
> +	set _prefix {}
> +	set picked 1
> +}
> +

So, this isn't intended as a plain move of code? Since we set _gitdir
here, we could remove the corresonding lines from lib/choose_repository.tcl.

Is the variable "picked" only needed for this particular picker
invocation? Then it should not be set in the function, but at the call site.

>  if {[catch {
>  		set _gitdir $env(GIT_DIR)
>  		set _prefix {}
> @@ -1149,13 +1159,7 @@ if {[catch {
>  		set _gitdir [git rev-parse --git-dir]
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
> -	load_config 1
> -	apply_config
> -	choose_repository::pick
> -	if {![file isdirectory $_gitdir]} {
> -		exit 1
> -	}
> -	set picked 1
> +		pick_repo

The indentation is off here.

>  }
>  
>  # Use object format as hash algorithm (either "sha1" or "sha256")

-- Hannes

