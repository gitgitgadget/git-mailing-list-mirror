From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 12/14] git submodule update: cmd_update_clone
Date: Wed, 23 Sep 2015 13:13:02 -0700
Message-ID: <xmqqy4fwx5bl.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-13-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 22:13:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeqPe-0003UX-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 22:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbbIWUNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 16:13:06 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36445 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbbIWUNF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 16:13:05 -0400
Received: by pablk4 with SMTP id lk4so2167626pab.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6NcWAdvl2Ml+KHL3s3KV2+dvy1M95HI9OMpxDpVoTco=;
        b=oGrCN0x0Q50C7zBw4TTgtn8szRYJgNmElTh4T+owdDpGhfOnNpNnhA2VOkfNb7/bkm
         WgJCEYPRAbhF+jfo6IMguak+5dC0GnoIEEbzAyWKxE2TYrAWMR/OmmlVn9zEDWaz9HPV
         LmZBrIeGTmuQm8/30c5n76uGUA67OiyV2S8FQZiIYd3gErnjXHV0c3RJJds/08e8k7Am
         8dNImPRWOqr/FMcmloL0PB8nuCLhhxXj32YxpHUXqs+ICeFkrQuKPMdQFE0AYmzi6RAY
         c7LK/zBx22c4bUDKbTb3uijnhY7GGwHbE1ZqmC1Jvirrz2+OSIAFVzg4v4osOHX18XyO
         TJFA==
X-Received: by 10.68.137.202 with SMTP id qk10mr39622360pbb.30.1443039183953;
        Wed, 23 Sep 2015 13:13:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id fb1sm528392pab.9.2015.09.23.13.13.03
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 13:13:03 -0700 (PDT)
In-Reply-To: <1442972732-12118-13-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 22 Sep 2015 18:45:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278511>

Stefan Beller <sbeller@google.com> writes:

> Split the cloning part out to its own function,
> this allow us in a later patch to convert cmd_update in C.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

It appears that this is not just a refactor and loses the logic
around $cloned_modules variable that seems to avoid doing the same
thing twice.  An explanation on the reason why it no longer is
necessary in the proposed log message would be nice.

Thanks.


>  git-submodule.sh | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ea3260e..7f11158 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -607,6 +607,24 @@ cmd_update_recursive()
>  	fi
>  }
>  
> +cmd_update_clone()
> +{
> +	command="git checkout $subforce -q"
> +	die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> +	say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> +
> +	git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> +
> +	if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
> +	then
> +		say "$say_msg"
> +	else
> +		err="${err};$die_msg"
> +		return
> +	fi
> +	cmd_update_recursive
> +}
> +
>  #
>  # Update each submodule path to correct revision, using clone and checkout as needed
>  #
> @@ -680,7 +698,6 @@ cmd_update()
>  		cmd_init "--" "$@" || return
>  	fi
>  
> -	cloned_modules=
>  	git submodule--helper list --prefix "$wt_prefix" "$@" | {
>  	err=
>  	while read mode sha1 stage sm_path
> @@ -725,9 +742,8 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>  		then
> -			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> -			cloned_modules="$cloned_modules;$name"
> -			subsha1=
> +			cmd_update_clone
> +			continue
>  		else
>  			subsha1=$(clear_local_git_env; cd "$sm_path" &&
>  				git rev-parse --verify HEAD) ||
> @@ -767,13 +783,6 @@ Maybe you want to use 'update --init'?")"
>  				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>  			fi
>  
> -			# Is this something we just cloned?
> -			case ";$cloned_modules;" in
> -			*";$name;"*)
> -				# then there is no local change to integrate
> -				update_module=checkout ;;
> -			esac
> -
>  			must_die_on_failure=
>  			case "$update_module" in
>  			checkout)
