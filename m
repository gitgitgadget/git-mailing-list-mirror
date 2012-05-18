From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] submodule: fix handling of supermodules with relative origin
 URLs.
Date: Fri, 18 May 2012 21:58:03 +0200
Message-ID: <4FB6A9CB.5050702@web.de>
References: <AH3Anrr6mLVedBPcgfVwy=5KRjUgdp5W8P0DQ3qaX_UjH-npDw@mail.gmail.com> <1337343220-26717-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 21:58:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVTK1-0003BL-4H
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 21:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967209Ab2ERT6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 15:58:40 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:48232 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967137Ab2ERT6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 15:58:39 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id DFA4C1AE825CF
	for <git@vger.kernel.org>; Fri, 18 May 2012 21:58:37 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.166.43]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MTxxp-1SeZyP2EHR-00QniU; Fri, 18 May 2012 21:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337343220-26717-1-git-send-email-jon.seymour@gmail.com>
X-Provags-ID: V02:K0:4eCc/QuMKJt2Cl0+TCvLF7m1jD4rdn9/EZ5PF5E2m5H
 pQLBl9VsGakFA/w0oqStZUKtVaJ2z0lF/xf6n8PhIr/mAsuunp
 ciTKLMWgXuBhkb2Hfa4xuEOKbOjzm5NPC+eJLH2a4eCLhIV01F
 xtPI+0R+bUUM7ohcTAfRl8FaumIdz8roeDl9HABg2IN9sGD2/x
 5gxpbbYVwQCmDYrhhSqGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197969>

Am 18.05.2012 14:13, schrieb Jon Seymour:
> Prior to this change, operations such as git submodule sync produces
> the wrong result when the origin URL of the super module
> is itself a relative URL.
> 
> The issue arises because in this case, the origin URL of the supermodule
> needs to be prepended with a prefix that navigates from the submodule to
> the supermodule.
> 
> This change adds that prefix.

Thanks, sounds sane. Please see my comments below.

> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  git-submodule.sh | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> If people are ok with the fix, I'll roll this as a patch together
> with some tests.

Yeah, tests would be great (and while at it please drop the trailing
'.' from the subject ;-).

This version of the patch does break some existing tests, but your
follow up suggests you already found that out yourself ;-)

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 64a70d6..5008867 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -37,7 +37,8 @@ resolve_relative_url ()
>  	remoteurl=$(git config "remote.$remote.url") ||
>  		remoteurl=$(pwd) # the repository is its own authoritative upstream
>  	url="$1"
> -	remoteurl=${remoteurl%/}
> +	up_path="$(echo "$2" | sed "s/[^/]*/../g")"

Me thinks up_path should be set in the case below, which is the only
place where it is used.

> +	remoteurl=${remoteurl%/*}

As you mentioned in your follow up this change is not correct.

>  	sep=/
>  	while test -n "$url"
>  	do
> @@ -45,6 +46,9 @@ resolve_relative_url ()
>  		../*)
>  			url="${url#../}"
>  			case "$remoteurl" in
> +			.*/*)

up_path should be set here.

> +				remoteurl="${up_path%/}/${remoteurl%/*}"
> +				;;
>  			*/*)
>  				remoteurl="${remoteurl%/*}"
>  				;;
> @@ -235,11 +239,24 @@ cmd_add()
>  		usage
>  	fi
>  
> +	# normalize path:
> +	# multiple //; leading ./; /./; /../; trailing /
> +	sm_path=$(printf '%s/\n' "$sm_path" |
> +		sed -e '
> +			s|//*|/|g
> +			s|^\(\./\)*||
> +			s|/\./|/|g
> +			:start
> +			s|\([^/]*\)/\.\./||
> +			tstart
> +			s|/*$||
> +		')
> +
>  	# assure repo is absolute or relative to parent
>  	case "$repo" in
>  	./*|../*)
>  		# dereference source url relative to parent's url
> -		realrepo=$(resolve_relative_url "$repo") || exit
> +		realrepo=$(resolve_relative_url "$repo" "$sm_path") || exit
>  		;;
>  	*:*|/*)
>  		# absolute url
> @@ -250,18 +267,6 @@ cmd_add()
>  	;;
>  	esac
>  
> -	# normalize path:
> -	# multiple //; leading ./; /./; /../; trailing /
> -	sm_path=$(printf '%s/\n' "$sm_path" |
> -		sed -e '
> -			s|//*|/|g
> -			s|^\(\./\)*||
> -			s|/\./|/|g
> -			:start
> -			s|\([^/]*\)/\.\./||
> -			tstart
> -			s|/*$||
> -		')
>  	git ls-files --error-unmatch "$sm_path" > /dev/null 2>&1 &&
>  	die "$(eval_gettext "'\$sm_path' already exists in the index")"
>  
> @@ -401,13 +406,14 @@ cmd_init()
>  		if test -z "$(git config "submodule.$name.url")"
>  		then
>  			url=$(git config -f .gitmodules submodule."$name".url)
> +			sm_path=$(git config -f .gitmodules submodule."$name".path)

Isn't sm_path already set correctly here? I think this line should
be dropped.

>  			test -z "$url" &&
>  			die "$(eval_gettext "No url found for submodule path '\$sm_path' in .gitmodules")"
>  
>  			# Possibly a url relative to parent
>  			case "$url" in
>  			./*|../*)
> -				url=$(resolve_relative_url "$url") || exit
> +				url=$(resolve_relative_url "$url" "$sm_path") || exit
>  				;;
>  			esac
>  			git config submodule."$name".url "$url" ||
> @@ -960,11 +966,12 @@ cmd_sync()
>  	do
>  		name=$(module_name "$sm_path")
>  		url=$(git config -f .gitmodules --get submodule."$name".url)
> +		sm_path=$(git config -f .gitmodules --get submodule."$name".path)

Same here.

>  
>  		# Possibly a url relative to parent
>  		case "$url" in
>  		./*|../*)
> -			url=$(resolve_relative_url "$url") || exit
> +			url=$(resolve_relative_url "$url" "$sm_path") || exit
>  			;;
>  		esac
>  

Other than that the patch looks fine.
