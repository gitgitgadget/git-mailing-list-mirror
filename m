From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 07 Jan 2014 10:15:25 -0800
Message-ID: <xmqqlhyrek02.fsf@gitster.dls.corp.google.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
	<d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 07 19:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0bBm-0003fR-GP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 19:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbaAGSPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 13:15:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbaAGSPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 13:15:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39CCF5F6D2;
	Tue,  7 Jan 2014 13:15:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/Z8RrG/2XLbA6r2GajDoyASwP4=; b=WaYeVP
	o1m0kteLdwoSc5EQ0jXbk5Py/tEOS4JtjAWEYr41JLfvzRf6Jm0KHWZjkHi1iSba
	EJKZeh6NenTQTmtr0n1KL2S7W9Q+kesNprkzbcLPxZtdVITd/NhVSxJq1y9Hcm7d
	ZqK5nCiNHDuEClWruUNm4rwnO64tykP6TXqKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ungqJiNWV8UDcWqJWQERtPz53prEAmcz
	QGJtVlh3n8xnqCzgzb0lh1gQ9Z3BtRf/Vhi2EJngao0r1YQ6c0XXHnLbkHfxQTwE
	dcuBJvaoF726YEFtXYMPtM63xIY+1ob7gstjVtSFCJoA39DEty9E/DNHmOStpjrA
	gsByM28UIpM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 018F85F6D1;
	Tue,  7 Jan 2014 13:15:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E3BE5F6CC;
	Tue,  7 Jan 2014 13:15:29 -0500 (EST)
In-Reply-To: <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
	(W. Trevor King's message of "Sun, 5 Jan 2014 08:17:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B08B013A-77C7-11E3-9485-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240123>

"W. Trevor King" <wking@tremily.us> writes:

> From: "W. Trevor King" <wking@tremily.us>
>
> The previous code only checked out the requested branch in cmd_add.
> This commit moves the branch-checkout logic into module_clone, where
> it can be shared by cmd_add and cmd_update.  I also update the initial
> checkout command to use 'rebase' to preserve branches setup during
> module_clone.

I want to see the log message explain the motivation behind it
(i.e. instead of stopping after saying "We used to do X, now we do
Y", but also explain why we consider that Y is better than X).  Here
is my attempt.

    submodule: respect requested branch on all clones

    The previous code only checked out the requested branch in cmd_add
    but not in cmd_update; this left the user on a detached HEAD after
    an update initially cloned, and subsequent updates using rebase or
    merge mode will kept the HEAD detached, unless the user moved to the
    desired branch himself.

    Move the branch-checkout logic into module_clone, where it can be
    shared by cmd_add and cmd_update.  Also update the initial checkout
    command to use 'rebase' to preserve branches setup during
    module_clone.  This way, unless the user explicitly asks to work on
    a detached HEAD, subsequent updates all happen on the specified
    branch, which matches the end-user expectation much better.

    Signed-off-by: W. Trevor King <wking@tremily.us>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Please correct me if I misunderstood the intention.

Having writing all the above and then looking at the patch again, it
is not immediately obvious to me where you use "rebase" when doing
the initial checkout, though.

> The current Documentation/git-submodule.txt has:
>
>   update::
>     Update the registered submodules, i.e. clone missing submodules
>     and checkout the commit specified in the index of the containing
>     repository.  This will make the submodules HEAD be detached unless
>     `--rebase` or `--merge` is specified or the key
>     `submodule.$name.update` is set to `rebase`, `merge` or `none`.

Side note but doesn't Francesco's "'checkout' is a valid update mode"
need to update this part of the documentation as well?


>  git-submodule.sh | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..167d4fa 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -253,6 +253,7 @@ module_clone()
>  	url=$3
>  	reference="$4"
>  	depth="$5"
> +	branch="$6"
>  	quiet=
>  	if test -n "$GIT_QUIET"
>  	then
> @@ -306,7 +307,15 @@ module_clone()
>  	echo "gitdir: $rel/$a" >"$sm_path/.git"
>  
>  	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> +	(
> +		clear_local_git_env
> +		cd "$sm_path" &&
> +		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> +		case "$branch" in
> +		'') git checkout -f -q ;;
> +		?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> +		esac
> +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
>  }
>  
>  isnumber()
> @@ -469,16 +478,7 @@ Use -f if you really want to add it." >&2
>  				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>  			fi
>  		fi
> -		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" || exit
> -		(
> -			clear_local_git_env
> -			cd "$sm_path" &&
> -			# ash fails to wordsplit ${branch:+-b "$branch"...}
> -			case "$branch" in
> -			'') git checkout -f -q ;;
> -			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> -			esac
> -		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
> +		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$branch" || exit
>  	fi
>  	git config submodule."$sm_name".url "$realrepo"
>  
> @@ -787,7 +787,8 @@ cmd_update()
>  		fi
>  		name=$(module_name "$sm_path") || exit
>  		url=$(git config submodule."$name".url)
> -		branch=$(get_submodule_config "$name" branch master)
> +		config_branch=$(get_submodule_config "$name" branch)
> +		branch="${config_branch:-master}"
>  		if ! test -z "$update"
>  		then
>  			update_module=$update
> @@ -815,7 +816,7 @@ Maybe you want to use 'update --init'?")"
>  
>  		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
>  		then
> -			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
> +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$config_branch" || exit
>  			cloned_modules="$cloned_modules;$name"
>  			subsha1=
>  		else
> @@ -861,7 +862,12 @@ Maybe you want to use 'update --init'?")"
>  			case ";$cloned_modules;" in
>  			*";$name;"*)
>  				# then there is no local change to integrate
> -				update_module= ;;
> +				if test -n "$config_branch"; then
> +					update_module="!git reset --hard -q"
> +				else
> +					update_module=
> +				fi
> +				;;
>  			esac
>  
>  			must_die_on_failure=
