Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3151739B971
	for <git@vger.kernel.org>; Fri, 15 May 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860856; cv=none; b=k8t/hMSda7vSQ5O2vDnYeSVfI/LNakF6E0jmUSKYzDOQJPHMGb1MyXJR53iFW/osMWkTkfRqN2uMAqp5odHqWP/KVIGylBPyXYP1AcsujRb4823VgzCYD6pW7c0xozf+/viClYqw/xrov1uHi40ZYADQHJI18xTUA0s8T5XyE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860856; c=relaxed/simple;
	bh=Rbec7JfLL0y9pOONUkY+BdqbiypkR96lWdPHDsdtDE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a78eCehFfvIqsTV5d5C3K23t1vEqKoSvZnb9qyhIdCWAGlzAbG4spLG16pg2/ggJNxgrFXDjVNhf6T4nwf6H0LCeLSVJUOe3jGGkx5CJwg9CR+5LTQUg7Malx3IWwst6ptO7QHz9yLhy64rIfqqEzu+/yMXxmvQKApOe1QpX9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4gHBkW3bdHzRnlt;
	Fri, 15 May 2026 18:00:51 +0200 (CEST)
Message-ID: <948f9f9f-8225-4bfe-be7d-e9b03c912aeb@kdbg.org>
Date: Fri, 15 May 2026 18:00:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] git-gui: use --absolute-git-dir
Content-Language: en-US
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-6-mlevedahl@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260514143322.865587-6-mlevedahl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 14.05.26 um 16:33 schrieb Mark Levedahl:
> git-gui uses git rev-parse --git-dir to get the pathname of the
> discovered git repository. The returned value can be relative, and is
> '.' if the current directory is the top of the repository directory
> itself.  git-gui has code to change '.' to [pwd] in this case so that
> subsequent logic runs.
> 
> But, git rev-parse supports --absolute-git-dir from fac60b8925
> ("rev-parse: add option for absolute or relative path formatting",
> 2020-12-13), and included in git 2.31. git-gui requires git >= 2.36, so
> this more useful form is always available. Use --absolute-git-dir to
> always get an absolute path, avoiding the need for other checks.

Nice!

However, the patch is incomplete. We set _gitdir also from
lib/choose_repository.tcl. I think it would be best to swap this patch
with patch 4/11, remove the _gitdir setters from the picker
implementation, and call `rev-parse --absolute-git-dir` like you did in
4/11. This depends on that the picker sets the current directory to the
top-level of the working tree with the embeded .git directory.

BTW, missing sign-off.

> ---
>  git-gui.sh | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 0b73c35..c2cf5f1 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1156,7 +1156,7 @@ if {[catch {
>  	&& [catch {
>  		# beware that from the .git dir this sets _gitdir to .
>  		# and _prefix to the empty string
> -		set _gitdir [git rev-parse --git-dir]
> +		set _gitdir [git rev-parse --absolute-git-dir]
>  		set _prefix [git rev-parse --show-prefix]
>  	} err]} {
>  		pick_repo
> @@ -1173,18 +1173,12 @@ if {$hashalgorithm eq "sha1"} {
>  	exit 1
>  }
>  
> -# we expand the _gitdir when it's just a single dot (i.e. when we're being
> -# run from the .git dir itself) lest the routines to find the worktree
> -# get confused
> -if {$_gitdir eq "."} {
> -	set _gitdir [pwd]
> -}
> -
>  if {![file isdirectory $_gitdir]} {
>  	catch {wm withdraw .}
>  	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
>  	exit 1
>  }
> +
>  # _gitdir exists, so try loading the config
>  load_config 0
>  apply_config

-- Hannes

