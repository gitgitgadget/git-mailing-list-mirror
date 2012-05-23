From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 2/2] submodule: fix handling of relative superproject
 origin URLs
Date: Wed, 23 May 2012 23:50:04 +0200
Message-ID: <4FBD5B8C.60605@web.de>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com> <1337791554-31294-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 23:50:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXJRg-0003bW-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 23:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760830Ab2EWVuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 17:50:10 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43856 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab2EWVuI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 17:50:08 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id B20851C4D1D75
	for <git@vger.kernel.org>; Wed, 23 May 2012 23:50:06 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.160.4]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0Lsy7e-1S5MAh0JyM-012bTX; Wed, 23 May 2012 23:50:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337791554-31294-3-git-send-email-jon.seymour@gmail.com>
X-Provags-ID: V02:K0:0BE7b/y+KlYUuekxT4zHzySHhtbx/nPQNPQMtnzZTYE
 0fVZ0owIG26S3wTF/dzs03BQBTurV3wQtz7gPH/hCKXEXdiQou
 RB1QVpAQACuD1g3QjK3hfOeSbbnpLVeWtpUyIXx7ReQ4TS4voZ
 0oueXZW+JryfR8nqdZkik7HeSjsj7Kt0PUCTqf2G4r7MuLgqEn
 YJ9zO5na2u0doImkWD62A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198327>

Am 23.05.2012 18:45, schrieb Jon Seymour:
> When the origin URL of the superproject is itself relative, an operation
> such as git submodule add, init or sync may result in either the
> submodule.{name}.url configuration property of the superproject
> referring to the incorrect location or remote.origin.url configuration
> property of the submodule referring to the incorrect location or both
> these conditions. In some cases, git submodule fails to update
> the configuration and fails with an error condition.
> 
> The issue arises in these cases because the origin URL of
> the superproject needs to be prepended with a prefix that navigates
> from the submodule to the superproject so that when the submodule
> URL is concatenated the resulting URL is relative to the working tree
> of the submodule.
> 
> This change fixes handling for relative superproject origin URLs
> for 6 cases:
>   foo
>   foo/bar
>   ./foo
>   ./foo/bar
>   ../foo
>   ../foo/bar
> 
> In each case, the configuration properties in the superproject's
> configuration and the submodule's configuration refer to the
> correct, relative, location of the submodule's origin repo. In all cases,
> the configured paths are relative to the working trees of the
> repositories containing the configuration.
> 
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  git-submodule.sh           | 17 +++++++++++++++--
>  t/t7400-submodule-basic.sh | 12 +++++-------
>  t/t7403-submodule-sync.sh  | 21 +++++++++++----------
>  3 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 64a70d6..3e943de 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -37,6 +37,8 @@ resolve_relative_url ()
>  	remoteurl=$(git config "remote.$remote.url") ||
>  		remoteurl=$(pwd) # the repository is its own authoritative upstream
>  	url="$1"
> +	prefix="$2"

As mentioned last time I'd rather use $2 directly at the only site
where $prefix is used. (On the other hand it might also make sense
to give the parameters a descriptive name at the beginning of the
function, but then I'd vote for a descriptive name like "urlprefix"
or similar to make its meaning clearer)

> +	remoteurl=$(echo "$remoteurl" | sed "s|^[^/:\\.][^:]*\$|./&|")

A comment describing what this line actually does would be nice.

>  	remoteurl=${remoteurl%/}
>  	sep=/
>  	while test -n "$url"
> @@ -45,6 +47,11 @@ resolve_relative_url ()
>  		../*)
>  			url="${url#../}"
>  			case "$remoteurl" in
> +			.*/*)
> +				remoteurl="${remoteurl%/*}"
> +				remoteurl="${remoteurl#./}"
> +				remoteurl="${prefix}${remoteurl}"
> +				;;
>  			*/*)
>  				remoteurl="${remoteurl%/*}"
>  				;;
> @@ -64,7 +71,7 @@ resolve_relative_url ()
>  			break;;
>  		esac
>  	done
> -	echo "$remoteurl$sep${url%/}"
> +	echo "${remoteurl%/.}$sep${url%/}"

Wouldn't that better be handled in the ".*/*)" case above to avoid
accidentally affecting the other cases?

>  }
>  
>  #
> @@ -964,8 +971,14 @@ cmd_sync()
>  		# Possibly a url relative to parent
>  		case "$url" in
>  		./*|../*)
> +			up_path="$(echo "$sm_path" | sed "s/[^/]*/../g")" &&
> +			up_path=${up_path%/}/ &&
> +			remoteurl=$(resolve_relative_url "$url" "$up_path") &&
>  			url=$(resolve_relative_url "$url") || exit
>  			;;
> +		*)
> +			remoteurl="$url"
> +			;;
>  		esac
>  
>  		if git config "submodule.$name.url" >/dev/null 2>/dev/null
> @@ -979,7 +992,7 @@ cmd_sync()
>  				clear_local_git_env
>  				cd "$sm_path"
>  				remote=$(get_default_remote)
> -				git config remote."$remote".url "$url"
> +				git config remote."$remote".url "$remoteurl"
>  			)
>  			fi
>  		fi

I still have to wrap my head around these two hunks (I suspect it's
too late for that in my timezone ;-), but I really wonder how you get
away without changing cmd_add and cmd_init like you did last time.
This looks much different than #2 and #4 of your v3 combined, which
makes me suspicious in what direction this is evolving. Maybe you could
tell us what you found out addressing the last problem you mentioned
and how you handled it?


The only changes following here should be from test_expect_failure
to test_expect_success as mentioned in my response to your first patch.

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 97e7a73..f2f907f 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -507,17 +507,15 @@ test_expect_success 'relative path works with user@host:path' '
>  	)
>  '
>  
> -test_expect_success 'relative path works with foo' "
> +test_expect_success 'relative path works with foo' '
>  	(
>  		cd reltest &&
>  		cp pristine-.git-config .git/config &&
>  		git config remote.origin.url foo &&
> -		echo \"cannot strip one component off url 'foo'\" >expect &&
> -		test_must_fail git submodule init 2>actual &&
> -		cat actual &&
> -		test_cmp expect actual
> +		git submodule init &&
> +		test "$(git config submodule.sub.url)" = ./subrepo
>  	)
> -"
> +'
>  
>  test_expect_success 'relative path works with foo/bar' '
>  	(
> @@ -545,7 +543,7 @@ test_expect_success 'relative path works with ./foo/bar' '
>  		cp pristine-.git-config .git/config &&
>  		git config remote.origin.url ./foo/bar &&
>  		git submodule init &&
> -		test "$(git config submodule.sub.url)" = ./foo/subrepo
> +		test "$(git config submodule.sub.url)" = foo/subrepo
>  	)
>  '
>  
> diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
> index 3784c9b..583fe21 100755
> --- a/t/t7403-submodule-sync.sh
> +++ b/t/t7403-submodule-sync.sh
> @@ -88,21 +88,22 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
>  	)
>  '
>  
> -test_expect_success '"git submodule sync" handles origin URL of the form foo' "
> +test_expect_success '"git submodule sync" handles origin URL of the form foo' '
>  	(cd relative-clone &&
>  	 git remote set-url origin foo
> -	 echo \"cannot strip one component off url 'foo'\" > expect &&
> -	 test_must_fail git submodule sync 2> actual &&
> -	 test_cmp expect actual
> +	 git submodule sync &&
> +	(cd submodule &&
> +	 test "$(git config remote.origin.url)" == "../submodule"
>  	)
> -"
> +	)
> +'
>  
>  test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
>  	(cd relative-clone &&
>  	 git remote set-url origin foo/bar
>  	 git submodule sync &&
>  	(cd submodule &&
> -	 test "$(git config remote.origin.url)" == "foo/submodule"
> +	 test "$(git config remote.origin.url)" == "../foo/submodule"
>  	)
>  	)
>  '
> @@ -112,7 +113,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ./foo'
>  	 git remote set-url origin ./foo
>  	 git submodule sync &&
>  	(cd submodule &&
> -	 test "$(git config remote.origin.url)" == "./submodule"
> +	 test "$(git config remote.origin.url)" == "../submodule"
>  	)
>  	)
>  '
> @@ -122,7 +123,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ./foo/b
>  	 git remote set-url origin ./foo/bar
>  	 git submodule sync &&
>  	(cd submodule &&
> -	 test "$(git config remote.origin.url)" == "./foo/submodule"
> +	 test "$(git config remote.origin.url)" == "../foo/submodule"
>  	)
>  	)
>  '
> @@ -132,7 +133,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ../foo'
>  	 git remote set-url origin ../foo
>  	 git submodule sync &&
>  	(cd submodule &&
> -	 test "$(git config remote.origin.url)" == "../submodule"
> +	 test "$(git config remote.origin.url)" == "../../submodule"
>  	)
>  	)
>  '
> @@ -142,7 +143,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form ../foo/
>  	 git remote set-url origin ../foo/bar
>  	 git submodule sync &&
>  	(cd submodule &&
> -	 test "$(git config remote.origin.url)" == "../foo/submodule"
> +	 test "$(git config remote.origin.url)" == "../../foo/submodule"
>  	)
>  	)
>  '
