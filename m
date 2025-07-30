Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AE111A8
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753902192; cv=none; b=B7JxxBZW/FkBb0dNbe+j74QrpHpkXYsuzJx2+DatHy8FNp75yt57Xit6qXrIWKTn5ZRK8w4NlfVTuDDEs02YBX7KYi2EWsl9si2JxuurgFzKv07P4yjTyb7E91Gh9E3B/MIX2c2l+SsY6pyv3JI25af+4FXmLOgEPu63EK/yj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753902192; c=relaxed/simple;
	bh=j1C5rm20lW0rgTjDHn/srzhAJhkquLjOQ1ZZ3nulgNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSTwGVSgjwrggEvziGQTIF+nG1O+4HAT1WCCiP/GMMa+ehAsDNF23jBdPL0iUKjSN/0Zxtp4gWkABwt6Q7hmKMTzrPqaJssnNZYzNXWt0PtYS74+dVaynstFrvXvz9n6W9woMu8QJ1x5g3Mi06OmdAwDVwmIL4WRB080/p5tOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4bshS516Gxz7QVWd
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:03:01 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bshRv1h4WzRpKg;
	Wed, 30 Jul 2025 21:02:51 +0200 (CEST)
Message-ID: <cb63b63b-4a74-4649-bebb-002d1e6e66f7@kdbg.org>
Date: Wed, 30 Jul 2025 21:02:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] git-gui: honor TCLTK_PATH in git-gui--askpass
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250730164052.15371-1-carenas@gmail.com>
 <20250730164052.15371-5-carenas@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250730164052.15371-5-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 30.07.25 um 18:40 schrieb Carlo Marcelo Arenas Belón:
> Since its introduction in 8c76212 (git-gui: Add a simple implementation
> of SSH_ASKPASS., 2008-10-15), git-gui--askpass has been calling whatever
> wish interpreter is in the path, unlike git-gui.
> 
> Correct that by turning it into a script that would be processed at build
> time.
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  .gitignore                              |  1 +
>  Makefile                                |  9 ++++++---
>  generate-script.sh                      | 22 ++++++++++++++++++++++
>  git-gui--askpass => git-gui--askpass.sh |  0
>  meson.build                             | 22 ++++++++++++++--------
>  5 files changed, 43 insertions(+), 11 deletions(-)
>  create mode 100755 generate-script.sh
>  rename git-gui--askpass => git-gui--askpass.sh (100%)
> 
> diff --git a/.gitignore b/.gitignore
> index ba845f3..5130b4f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -4,4 +4,5 @@ git-gui.tcl
>  GIT-GUI-BUILD-OPTIONS
>  GIT-VERSION-FILE
>  git-gui
> +git-gui--askpass
>  lib/tclIndex
> diff --git a/Makefile b/Makefile
> index 2ac5f44..b2d7ffb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -173,10 +173,13 @@ GIT-GUI-BUILD-OPTIONS: FORCE
>  	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
>  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
>  
> +git-gui--askpass: git-gui--askpass.sh GIT-GUI-BUILD-OPTIONS generate-script.sh
> +	$(QUIET_GEN)$(SHELL_PATH) generate-script.sh $@ $< GIT-GUI-BUILD-OPTIONS
> +
>  ifdef GITGUI_WINDOWS_WRAPPER
> -all:: git-gui
> +all:: git-gui git-gui--askpass
>  endif
> -all:: $(GITGUI_MAIN) lib/tclIndex $(ALL_MSGFILES)
> +all:: $(GITGUI_MAIN) git-gui--askpass lib/tclIndex $(ALL_MSGFILES)

I'm not a Makefile expert concerning double-colon targets. Therefore, I
wonder why do we need git-gui--ask-pass twice on Windows.

>  
>  install: all
>  	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
> @@ -215,7 +218,7 @@ dist-version: GIT-VERSION-FILE
>  	@sed 's|^GITGUI_VERSION=||' <GIT-VERSION-FILE  >$(TARDIR)/version
>  
>  clean::
> -	$(RM_RF) $(GITGUI_MAIN) lib/tclIndex po/*.msg $(PO_TEMPLATE)
> +	$(RM_RF) $(GITGUI_MAIN) git-gui--askpass lib/tclIndex po/*.msg $(PO_TEMPLATE)
>  	$(RM_RF) GIT-VERSION-FILE GIT-GUI-BUILD-OPTIONS
>  ifdef GITGUI_WINDOWS_WRAPPER
>  	$(RM_RF) git-gui

Some dependency must be missing here, since my build fails with

git-gui@cb/no-tcl86-on-macos:1015> make
GITGUI_VERSION=0.21.0.221.g8045a
    GEN git-gui
    GEN git-gui--askpass
generate-script.sh: line 15: .: GIT-GUI-BUILD-OPTIONS: file not found
make: *** [Makefile:177: git-gui--askpass] Error 1

> diff --git a/generate-script.sh b/generate-script.sh
> new file mode 100755
> index 0000000..0dd2da9
> --- /dev/null
> +++ b/generate-script.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +set -e
> +
> +if test $# -ne 3
> +then
> +	echo >&2 "USAGE: $0 <OUTPUT> <INPUT> <GIT-GUI-BUILD-OPTIONS>"
> +	exit 1
> +fi
> +
> +OUTPUT="$1"
> +INPUT="$2"
> +BUILD_OPTIONS="$3"
> +
> +. "$BUILD_OPTIONS"
> +
> +sed \
> +	-e "1s|#!.*/sh|#!$SHELL_PATH|" \
> +	-e "1,3s|^exec wish|exec '$TCLTK_PATH'|" \
> +	"$INPUT" >"$OUTPUT"
> +
> +chmod a+x "$OUTPUT"
> diff --git a/git-gui--askpass b/git-gui--askpass.sh
> similarity index 100%
> rename from git-gui--askpass
> rename to git-gui--askpass.sh
> diff --git a/meson.build b/meson.build
> index 1cedc82..320ba09 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -38,14 +38,6 @@ version_file = custom_target(
>    build_always_stale: true,
>  )
>  
> -configure_file(
> -  input: 'git-gui--askpass',
> -  output: 'git-gui--askpass',
> -  copy: true,
> -  install: true,
> -  install_dir: get_option('libexecdir') / 'git-core',
> -)
> -
>  gitgui_main = 'git-gui'
>  gitgui_main_install_dir = get_option('libexecdir') / 'git-core'
>  
> @@ -61,6 +53,20 @@ if target_machine.system() == 'windows'
>    )
>  endif
>  
> +custom_target(
> +  output: 'git-gui--askpass',
> +  input: 'git-gui--askpass.sh',
> +  command: [
> +    shell,
> +    meson.current_source_dir() / 'generate-script.sh',
> +    '@OUTPUT@',
> +    '@INPUT@',
> +    meson.current_build_dir() / 'GIT-GUI-BUILD-OPTIONS',
> +  ],
> +  install: true,
> +  install_dir: get_option('libexecdir') / 'git-core',
> +)
> +
>  custom_target(
>    input: 'git-gui.sh',
>    output: gitgui_main,

I can't comment on the meson part at all.

-- Hannes

