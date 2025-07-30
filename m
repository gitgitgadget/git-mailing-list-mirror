Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D621A1E1A33
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902279; cv=none; b=snNOrYW3nR1KaSZA4rikFYq+miIlSTHvvE962VmwmyT0nIG2Ch61mggNigB9svDavTj8AmAzRxzYrqgk5z6BLUW46ReA6W+qXlaR8dYqyZhuAh13jZgRxV+d79CeLuBY6tV2UlD72gLYZ3DYHaAdoYkE1lxwdvQMjlFRUejhCnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902279; c=relaxed/simple;
	bh=n8EJAndnG1PadY4rEc9AylR+F+nkq2YU5JXdd4DBAgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mL1fz0UMhUpqX1FkLZq2VPG03160vwjlA8XCRgp4eyJXl4l92ARtYgFLy05tB0Bqz88fh3M+g+LbFyzI8JjESSsmNKxOIea2tHJJf64H4JvPiGlXABWxNo4HQa5Xpzbip9PXJVDrL361sFdpFqd6BrRe9d7KY9XBTzHAhdJpoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bshTv5ZWlz7RhrD
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:04:35 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bshTk4Rf6zRpKm;
	Wed, 30 Jul 2025 21:04:26 +0200 (CEST)
Message-ID: <ce964e5a-fe30-42da-bf8d-969893e3907f@kdbg.org>
Date: Wed, 30 Jul 2025 21:04:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] git-gui: ensure own version of git-gui--askpass is
 used
Content-Language: en-US
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250730164052.15371-6-carenas@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250730164052.15371-6-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 30.07.25 um 18:40 schrieb Carlo Marcelo Arenas Belón:
> Propagate the `git --exec-path` that is defined at build time
> and use it when defining which askpass helper to use by default.
> 
> This is specially useful in macOS where a broken version of that
> helper is provided by the system git.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---

This patch breaks Git GUI on builds with RUNTIME_PREFIX, I think,
because it hard-codes the path to some exec-path that might not exist
during runtime.

>  generate-git-gui.sh |  1 +
>  git-gui.sh          | 10 +++++++++-
>  lib/about.tcl       |  4 ++--
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/generate-git-gui.sh b/generate-git-gui.sh
> index 39dfafd..f804686 100755
> --- a/generate-git-gui.sh
> +++ b/generate-git-gui.sh
> @@ -22,6 +22,7 @@ sed \
>  	-e "s|@@SHELL_PATH@@|$SHELL_PATH|" \
>  	-e "1,30s|^ exec wish | exec '$TCLTK_PATH' |" \
>  	-e "s|@@GITGUI_VERSION@@|$GITGUI_VERSION|g" \
> +	-e "s|@@GITGUI_GITEXECDIR@@|$GITGUI_GITEXECDIR|" \
>  	-e "s|@@GITGUI_RELATIVE@@|$GITGUI_RELATIVE|" \
>  	-e "${GITGUI_RELATIVE}s|@@GITGUI_LIBDIR@@|$GITGUI_LIBDIR|" \
>  	"$INPUT" >"$OUTPUT"+
> diff --git a/git-gui.sh b/git-gui.sh
> index 8bb121d..9e6c152 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -364,6 +364,7 @@ set _isbare {}
>  set _githtmldir {}
>  set _reponame {}
>  set _shellpath {@@SHELL_PATH@@}
> +set _gitexecdir {@@GITGUI_GITEXECDIR@@}
>  
>  set _trace [lsearch -exact $argv --trace]
>  if {$_trace >= 0} {
> @@ -387,6 +388,13 @@ if {[string match @@* $_shellpath]} {
>  	}
>  }
>  
> +if {[string match @@* $_gitexecdir]} {
> +	if {[catch {set _gitexecdir [exec git --exec-path]} err]} {

We can't use [git --exec-path] here, because proc git is not defined,
yet. Good.

> +		error "Git not installed?\n\n$err"

We barely use 'error'. This is for developers, I would think, so it may
be ok-ish. An alternative would be 'puts stderr ...' that we use elsewhere.

We must exit here, but 'error' doesn't do it for us. Insert 'exit 1'.

> +	}
> +	set _gitexecdir [file normalize $_gitexecdir]
> +}
> +
>  if {[is_Windows]} {
>  	set _shellpath [safe_exec [list cygpath -m $_shellpath]]
>  }
> @@ -1114,7 +1122,7 @@ citool {
>  
>  # Suggest our implementation of askpass, if none is set
>  if {![info exists env(SSH_ASKPASS)]} {
> -	set env(SSH_ASKPASS) [file join [git --exec-path] git-gui--askpass]
> +	set env(SSH_ASKPASS) [file join $_gitexecdir git-gui--askpass]
>  }
>  
>  ######################################################################
> diff --git a/lib/about.tcl b/lib/about.tcl
> index 122ebfb..d68e23b 100644
> --- a/lib/about.tcl
> +++ b/lib/about.tcl
> @@ -2,7 +2,7 @@
>  # Copyright (C) 2006, 2007 Shawn Pearce
>  
>  proc do_about {} {
> -	global appvers copyright oguilib
> +	global appvers copyright oguilib _gitexecdir
>  	global tcl_patchLevel tk_patchLevel
>  	global ui_comm_spell
>  
> @@ -44,7 +44,7 @@ proc do_about {} {
>  
>  	set d {}
>  	append d "git wrapper: $::_git\n"
> -	append d "git exec dir: [git --exec-path]\n"
> +	append d "git exec dir: $_gitexecdir\n"

Nice touch to change this case as well!

>  	append d "git-gui lib: $oguilib"
>  
>  	paddedlabel $w.vers -text $v

-- Hannes

