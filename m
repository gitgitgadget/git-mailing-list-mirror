From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/6] submodule: Explicit local branch creation in module_clone
Date: Thu, 16 Jan 2014 11:18:00 -0800
Message-ID: <xmqqr487zqfr.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:18:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sSE-00024D-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbaAPTSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:18:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaAPTSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 14:18:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A007E62873;
	Thu, 16 Jan 2014 14:18:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ud2ypaRd7Lgi2XLDWETirTSE/pQ=; b=Og4aek
	Y+kug6ah6Lh3VlpYvb6k6weG66tfQW/kmzsk8MiP2PKeqqMK5Ez8tEWOsOH3HpGt
	H9ZBHLhFIxg8qxt3NZFMDETz/uYRXFmxuIU9RYdyME0oc1nNWOAiGfFOOURLOi1/
	nciX9Qdt7EI/VvoBfKpuhKiQsyCPyul77cMBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ruj0cIXaQkbQQEWH55Ni5Yp1LphUQq64
	Vu43WGFgU6TrVyuttX7zvQLIdqvkTQxMozWySpZR1DJte9z6YG8SRc1s0/KX0/c+
	7HboHov09vFy6z9T9abBHuaEUCCixOvt7zeHRLAMOFZDHCU4Gj+K9VX145dLjTXv
	4FldDJ4N3tE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9194A62872;
	Thu, 16 Jan 2014 14:18:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33CA962870;
	Thu, 16 Jan 2014 14:18:06 -0500 (EST)
In-Reply-To: <96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
	(W. Trevor King's message of "Wed, 15 Jan 2014 20:10:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED6C4114-7EE2-11E3-ADB1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240520>

"W. Trevor King" <wking@tremily.us> writes:

> The previous code only checked out branches in cmd_add.  This commit
> moves the branch-checkout logic into module_clone, where it can be
> shared by cmd_add and cmd_update.  I also update the initial checkout
> command to use 'reset' to preserve branches setup during module_clone.
>
> With this change, folks cloning submodules for the first time via:
>
>   $ git submodule update ...
>
> will get a local branch instead of a detached HEAD, unless they are
> using the default checkout-mode updates.  This is a change from the
> previous situation where cmd_update always used checkout-mode logic
> (regardless of the requested update mode) for updates that triggered
> an initial clone, which always resulted in a detached HEAD.
>
> This commit does not change the logic for updates after the initial
> clone, which will continue to create detached HEADs for checkout-mode
> updates, and integrate remote work with the local HEAD (detached or
> not) in other modes.
>
> The motivation for the change is that developers doing local work
> inside the submodule are likely to select a non-checkout-mode for
> updates so their local work is integrated with upstream work.
> Developers who are not doing local submodule work stick with
> checkout-mode updates so any apparently local work is blown away
> during updates.  For example, if upstream rolls back the remote branch
> or gitlinked commit to an earlier version, the checkout-mode developer
> wants their old submodule checkout to be rolled back as well, instead
> of getting a no-op merge/rebase with the rolled-back reference.
>
> By using the update mode to distinguish submodule developers from
> black-box submodule consumers, we can setup local branches for the
> developers who will want local branches, and stick with detached HEADs
> for the developers that don't care.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  git-submodule.sh | 53 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 68dcbe1..4a09951 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -246,6 +246,9 @@ module_name()
>  # $3 = URL to clone
>  # $4 = reference repository to reuse (empty for independent)
>  # $5 = depth argument for shallow clones (empty for deep)
> +# $6 = (remote-tracking) starting point for the local branch (empty for HEAD)
> +# $7 = local branch to create (empty for a detached HEAD, unless $6 is
> +#      also empty, in which case the local branch is left unchanged)
>  #
>  # Prior to calling, cmd_update checks that a possibly existing
>  # path is not a git repository.
> @@ -259,6 +262,8 @@ module_clone()
>  	url=$3
>  	reference="$4"
>  	depth="$5"
> +	start_point="$6"
> +	local_branch="$7"
>  	quiet=
>  	if test -n "$GIT_QUIET"
>  	then
> @@ -312,7 +317,16 @@ module_clone()
>  	echo "gitdir: $rel/$a" >"$sm_path/.git"
>  
>  	rel=$(echo $a | sed -e 's|[^/][^/]*|..|g')
> -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=. git config core.worktree "$rel/$b")
> +	(
> +		clear_local_git_env
> +		cd "$sm_path" &&
> +		GIT_WORK_TREE=. git config core.worktree "$rel/$b" &&
> +		# ash fails to wordsplit ${local_branch:+-B "$local_branch"...}

Interesting...

> +		case "$local_branch" in
> +		'') git checkout -f -q ${start_point:+"$start_point"} ;;
> +		?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_point"} ;;
> +		esac

I am wondering if it makes more sense if you did this instead:

	git checkout -f -q ${start_point:+"$start_point"} &&
	if test -n "$local_branch"
        then
        	git checkout -B "$local_branch" HEAD
	fi

The optional "re-attaching to the local_branch" done with the second
"checkout" would be a non-destructive no-op to the working tree and
to the index, but it does distinguish between creating the branch
anew and resetting the existing branch in its output (note that
there is no "-q" to squelch it).  By doing it this way, when we
later teach "git branch -f" and "git checkout -B" to report more
about what commits have been lost by such a resetting, you will get
the safety for free if you made the switching with "-B" run without
"-q" here.

> +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path'")"
>  }
>  
>  isnumber()
> @@ -475,16 +489,14 @@ Use -f if you really want to add it." >&2
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
> +		if test -n "$branch"
> +		then
> +			start_point="origin/$branch"
> +			local_branch="$branch"
> +		else
> +			start_point=""
> +		fi

I'd feel safer if the "else" clause explicitly cleared $local_branch
by assigning an empty string to it; it would make it a lot clearer
that "when $branch is an empty string here, we do not want to
trigger the new codepath to run checkout with "-B $local_branch" in
module_clone" is what you mean.

> +		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth" "$start_point" "$local_branch" || exit
