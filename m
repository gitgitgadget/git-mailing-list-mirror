From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: teach git-am to apply a patch to an unborn
 branch
Date: Thu, 19 Mar 2009 15:21:17 -0700
Message-ID: <7viqm56tnm.fsf@gitster.siamese.dyndns.org>
References: <20090320071231.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:23:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQdc-0001Or-CM
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760335AbZCSWVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759952AbZCSWVY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:21:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbZCSWVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:21:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B84B2779B;
	Thu, 19 Mar 2009 18:21:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DEA85779A; Thu,
 19 Mar 2009 18:21:18 -0400 (EDT)
In-Reply-To: <20090320071231.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 20 Mar 2009 07:12:31 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46948234-14D4-11DE-89A3-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113850>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>  git-am.sh     |   33 ++++++++++++++++++++++++++++-----
>  t/t4150-am.sh |   15 +++++++++++++++
>  2 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index d339075..c21642b 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -36,6 +36,13 @@ cd_to_toplevel
>  git var GIT_COMMITTER_IDENT >/dev/null ||
>  	die "You need to set your committer info first"
>  
> +if git rev-parse --verify -q HEAD >/dev/null
> +then
> +	HAS_HEAD=yes
> +else
> +	HAS_HEAD=
> +fi
> +

Probably nicer this way than Peff's as I suspect we would need to special
case the unborn-branch case a lot more.  Have you tried --skip and --abort
codepaths with your patch?

>  sq () {
>  	for sqarg
>  	do
> @@ -290,16 +297,26 @@ else
>  		: >"$dotest/rebasing"
>  	else
>  		: >"$dotest/applying"
> -		git update-ref ORIG_HEAD HEAD
> +		if test -n "$HAS_HEAD"
> +		then
> +			git update-ref ORIG_HEAD HEAD
> +		else
> +			git update-ref -d ORIG_HEAD >/dev/null 2>&1
> +		fi

So is this part.

>  	fi
>  fi
>  
>  case "$resolved" in
>  '')
> -	files=$(git diff-index --cached --name-only HEAD --) || exit
> +	if test -n "$HAS_HEAD"
> +	then
> +		files=$(git diff-index --cached --name-only HEAD --)
> +	else
> +		files=$(git ls-files)
> +	fi || exit
>  	if test "$files"
>  	then
> -		: >"$dotest/dirtyindex"
> +		test -n "$HAS_HEAD" && : >"$dotest/dirtyindex"
>  		die "Dirty index: cannot apply patches (dirty: $files)"
>  	fi
>  esac

And here...

> @@ -541,7 +558,13 @@ do
>  	fi
>  
>  	tree=$(git write-tree) &&
> -	parent=$(git rev-parse --verify HEAD) &&
> +	if parent=$(git rev-parse --verify -q HEAD)
> +	then
> +		pparent="-p $parent"
> +	else
> +		echo >&2 "applying to an empty history"
> +		parent= pparent=
> +	fi &&
>  	commit=$(
>  		if test -n "$ignore_date"
>  		then
> @@ -552,7 +575,7 @@ do
>  			GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
>  			export GIT_COMMITTER_DATE
>  		fi &&
> -		git commit-tree $tree -p $parent <"$dotest/final-commit"
> +		git commit-tree $tree $pparent <"$dotest/final-commit"

Peff's ${a+something $a} trick looks more "expert" here ;-).

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 5e65afa..b97d102 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -290,4 +290,19 @@ test_expect_success 'am --ignore-date' '
>  	echo "$at" | grep "+0000"
>  '
>  
> +test_expect_success 'am in an unborn branch' '
> +	rm -fr subdir &&
> +	mkdir -p subdir &&
> +	git format-patch --numbered-files -o subdir -1 first &&
> +	(
> +		cd subdir &&
> +		git init &&
> +		git am 1
> +	) &&
> +	result=$(
> +		cd subdir && git rev-parse HEAD^{tree}
> +	) &&
> +	test "z$result" = "z$(git rev-parse first^{tree})"
> +'
> +

Looks good.
