From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 00:23:29 +0200
Message-ID: <5089BBE1.3040107@web.de>
References: <507EF86C.4050807@web.de> <1351034141-2641-1-git-send-email-hordp@cisco.com> <1351034141-2641-2-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com, Jeff King <peff@peff.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 00:23:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRVq4-00020J-D3
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 00:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab2JYWXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 18:23:32 -0400
Received: from mout.web.de ([212.227.17.11]:56270 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737Ab2JYWXb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 18:23:31 -0400
Received: from [192.168.178.41] ([91.3.191.79]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lcgp5-1T2Jkr0Ctb-00jbIz; Fri, 26 Oct 2012 00:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1351034141-2641-2-git-send-email-hordp@cisco.com>
X-Provags-ID: V02:K0:ujiwmVzTT4XUeIQgR29lX2r9+d5Q0/O5hJj7xAEzEvu
 Va/ElZdpxx+IPK4n9IhOlMjCBKwUkhXtG3lbjAYMzRNqA593++
 hgvhd8whr1u0JuQpWlBed0YZSAbXtaHHy05F2CcMiqykNttCc0
 zV4bHPhHYicuGxp+ZxK33yRg0aL3F4xgr2IAYoJofVN1OaeUgo
 CWDtM3MfydVj/aik2AU9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208422>

Am 24.10.2012 01:15, schrieb Phil Hord:
> The submodule sync command was somehow left out when
> --recursive was added to the other submodule commands.
> 
> Teach sync to handle the --recursive switch by recursing
> when we're in a submodule we are sync'ing.
> 
> Change the report during sync to show submodule-path
> instead of submodule-name to be consistent with the other
> submodule commands and to help recursed paths make sense.
> 
> Signed-off-by: Phil Hord <hordp@cisco.com>

This makes perfect sense to me. Two things though:

First it would be nice to initialize orig_flags like all the other
call sites do:

@@ -1003,6 +1003,7 @@ cmd_status()
 #
 cmd_sync()
 {
+	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in

> ---
>  git-submodule.sh | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ab6b110..6dd2338 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -11,7 +11,7 @@ USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <r
>     or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
>     or: $dashless [--quiet] foreach [--recursive] <command>
> -   or: $dashless [--quiet] sync [--] [<path>...]"
> +   or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
>  OPTIONS_SPEC=
>  . git-sh-setup
>  . git-sh-i18n
> @@ -1008,7 +1008,9 @@ cmd_sync()
>  		case "$1" in
>  		-q|--quiet)
>  			GIT_QUIET=1
> -			shift
> +			;;
> +		--recursive)
> +			recursive=1
>  			;;
>  		--)
>  			shift
> @@ -1021,6 +1023,8 @@ cmd_sync()
>  			break
>  			;;
>  		esac
> +		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
> +		shift
>  	done
>  	cd_to_toplevel
>  	module_list "$@" |
> @@ -1051,7 +1055,7 @@ cmd_sync()
>  
>  		if git config "submodule.$name.url" >/dev/null 2>/dev/null
>  		then
> -			say "$(eval_gettext "Synchronizing submodule url for '\$name'")"
> +			say "$(eval_gettext "Synchronizing submodule url for '\$prefix\$sm_path'")"
>  			git config submodule."$name".url "$super_config_url"
>  
>  			if test -e "$sm_path"/.git
> @@ -1061,6 +1065,14 @@ cmd_sync()
>  				cd "$sm_path"
>  				remote=$(get_default_remote)
>  				git config remote."$remote".url "$sub_origin_url"
> +
> +				if test -n "$recursive"
> +				then
> +				(
> +					prefix="$prefix$sm_path/"
> +					eval cmd_sync "$orig_args"

This should read 'eval cmd_sync "$orig_flags"'. I think you copied that
from cmd_status(), where this is also incorrect, I just sent a patch to
correct that one.

> +				)
> +			fi
>  			)
>  			fi
>  		fi
> 
