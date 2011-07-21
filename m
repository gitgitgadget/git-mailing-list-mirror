From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Move git-dir for submodules
Date: Thu, 21 Jul 2011 13:28:50 -0700
Message-ID: <7vhb6f1ipp.fsf@alter.siamese.dyndns.org>
References: <1311267139-14658-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:29:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjzrf-0003Xe-PJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1GUU2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 16:28:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab1GUU2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 16:28:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4779544CF;
	Thu, 21 Jul 2011 16:28:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JrWKM7F6Rb7pEtikhr0KepcTpT4=; b=k/erQz
	Vd6yg+DCBfDZVRhrWTrEp+nf9jm8DAvlYSdL7DN0DgMvidLBMG1H3z7FJR9bsoZE
	Wp1QetnmS7zrDQLuglyBaWh8zp1+JFJaPhbq13SbbRDeAvVhCq1O9FnPxHb3RFqk
	wGiToGNIXqz9M2EL3zs/zKRaPTavgV89fplM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BUYPPH4ombihewkC75kwXK57fxrWIS+j
	uaxTPZyMT18R63D4OZ+EQ8EldFDCOb8mBr5JDPKEXMkNBpH+DxxObdSVfZiu9pwW
	1g3fY2bwNy1jethHD++PIEwdp1vDGNxj20je+2IXT5XoXecNczi8p/gqHzRcKe0T
	mB2JEz8X5Tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F31444CE;
	Thu, 21 Jul 2011 16:28:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7963344CB; Thu, 21 Jul 2011
 16:28:52 -0400 (EDT)
In-Reply-To: <1311267139-14658-1-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Thu, 21 Jul 2011 18:52:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0C7F4C82-B3D8-11E0-B75D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177621>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 87c9452..3ad3012 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -122,14 +122,56 @@ module_clone()
>  	path=$1
>  	url=$2
>  	reference="$3"
> +	gitdir=
> +	gitdir_base=
> +	base_path=`echo $path | sed -e 's|[^/]*$||'`

We prefer $() over `` these days, no?  Without dq around $path, you would
not be able to preserve $IFS inside $PATH. You are stripping a run of non
slash at the trailing end --- is 'dirname "$path"' insufficient?

I think you are using the path the submodule happens to be at in the
current checkout to decide where in the .git/modules in the superproject
to keep the submodule metadata directory. Shouldn't you be using
module_name to convert the $path to the name of the submodule (this is
important, as the same submodule that used to be at path P1 can be moved
to a different path P2 in the history).

> +	if test -z "$GIT_DIR"
>  	then
> +		gitdir=$(git rev-parse --git-dir)
> +		gitdir_base="$gitdir/modules/$base_path"
> +		gitdir="$gitdir/modules/$path"
>  	else
> +		gitdir="$GIT_DIR/modules/$path"
> +		gitdir_base="$GIT_DIR/modules/$base_path"
> +	fi

Why do you need to switch on "test -z $GIT_DIR" yourself to have two
paths?  Doesn't "git rev-parse --git-dir" already know to take $GIT_DIR
into account?

> +	case $gitdir in
> +		/*)

Indent case arm labels at the same level as "case/esac".

> +	if test -d "$gitdir"
> +	then
> +		mkdir -p "$path"
> +		echo "gitdir: $rel_gitdir" > "$path/.git"

Good: if it already exists, do not clone, but just reuse what .git/modules
hierarchy of the superproject has. Is it really necessary to have an ugly
loop to make things relative, though?

Also please lose the extra SP after redirection, i.e.

	command >"$path/.git"

> +	else
> +		if !(test -d "$gitdir_base")

Do you need subshell for this?

> +		then
> +			mkdir -p "$gitdir_base"
> +		fi

Doesn't unconditional "mkdir -p" do the right thing?

> +		if test -n "$reference"
> +		then
> +			git-clone "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
> +		else
> +			git-clone -n "$url" "$path" --separate-git-dir "$gitdir"
> +		fi ||
> +		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
> +	fi
>  }

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index b2b26b7..57f5306 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -358,10 +358,10 @@ test_expect_success 'update --init' '
>  	git submodule update init > update.out &&
>  	cat update.out &&
>  	test_i18ngrep "not initialized" update.out &&
> -	! test -d init/.git &&
> +	! test -f init/.git &&
>  	git submodule update --init init &&
> -	test -d init/.git
> +	test -n $(grep "/^gitdir: /" init/.git)

I wonder if we want a new option to "git rev-parse" so that we can say

	git rev-parse --is-well-formed-git-dir init/.git

to perform these checks without exposing the implimentation detail.

> diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
> index d600583..b0517f0 100755
> --- a/t/t7403-submodule-sync.sh
> +++ b/t/t7403-submodule-sync.sh
> @@ -55,7 +55,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
>  	 git pull --no-recurse-submodules &&
>  	 git submodule sync
>  	) &&
> -	test -d "$(git config -f super-clone/submodule/.git/config \
> +	test -d "$(git config -f super-clone/.git/modules/submodule/config \
>  	                        remote.origin.url)" &&

Is "submodule" initialized at this point?  If so, I would think it is
vastly preferrable to say it like this:

	test -d "$(
        	cd super-clone/submodule &&
                git config --local remote.origin.url
	)"

I won't comment on the rest, but I think you can follow the same line of
thought to come up with a fix so that they do not have to know the
implementation detail of where the subproject metainfo directory is.
