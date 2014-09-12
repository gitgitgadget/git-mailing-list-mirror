From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] stash: prefer --quiet over shell redirection
Date: Fri, 12 Sep 2014 12:05:48 -0700
Message-ID: <xmqqoaukacc3.fsf@gitster.dls.corp.google.com>
References: <1409470973-67707-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:06:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSWAe-0004mV-F1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaILTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 15:05:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50214 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbaILTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:05:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 256ED36000;
	Fri, 12 Sep 2014 15:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zsdwRYacFb9hx1weGAY/ZeccMlw=; b=F3ABo5
	RDkd7+vMpeDN45lzF7fvGHyBHeEsFHGsFoq+cKWZ6+kU7fA/8qepBU/nD4mxQbhS
	hnsugJgHmj8laXA4X68cKub+BNHW1YVsOGBA13f2RF6nu35jwUoO2TN6UWNa0MH8
	HvT9mwsvrP6YLd7Ni8gOAjmqok6cABGRvXhX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kM9n/Uj8QHl4sGwEI2qGsOST/WAQ5M5L
	ABuilBrc35fX5lO0v1z2HC2SaM5KMCAUmuxU+4kiuI/JIhxjx/1wguUXLR2/bvBb
	BIrFEDLn7rCbC+DfY2+c8axcG17Pntitg54Nbhphn7tl+3W2Na9+vywvheR7yJHe
	fzBCpx6ihRo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BF8E35FFF;
	Fri, 12 Sep 2014 15:05:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9108635FFC;
	Fri, 12 Sep 2014 15:05:49 -0400 (EDT)
In-Reply-To: <1409470973-67707-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 31 Aug 2014 00:42:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF175E7C-3AAF-11E4-A327-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256942>

David Aguilar <davvid@gmail.com> writes:

> Use `git rev-parse --verify --quiet` instead of redirecting
> stderr to /dev/null.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

Has this patch ever been tested?  t3903 seems to break with this at
least for me.

>  git-stash.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index bcc757b..2ff8b94 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -50,7 +50,7 @@ clear_stash () {
>  	then
>  		die "$(gettext "git stash clear with parameters is unimplemented")"
>  	fi
> -	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
> +	if current=$(git rev-parse --verify --quiet $ref_stash)
>  	then
>  		git update-ref -d $ref_stash $current
>  	fi
> @@ -292,7 +292,7 @@ save_stash () {
>  }
>  
>  have_stash () {
> -	git rev-parse --verify $ref_stash >/dev/null 2>&1
> +	git rev-parse --verify --quiet $ref_stash >/dev/null
>  }
>  
>  list_stash () {
> @@ -392,12 +392,12 @@ parse_flags_and_rev()
>  		;;
>  	esac
>  
> -	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
> +	REV=$(git rev-parse --symbolic --verify --quiet "$1") || {
>  		reference="$1"
>  		die "$(eval_gettext "\$reference is not valid reference")"
>  	}
>  
> -	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
> +	i_commit=$(git rev-parse --verify --quiet "$REV^2") &&
>  	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
>  	s=$1 &&
>  	w_commit=$1 &&
> @@ -409,7 +409,7 @@ parse_flags_and_rev()
>  	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
>  	IS_STASH_REF=t
>  
> -	u_commit=$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
> +	u_commit=$(git rev-parse --verify --quiet "$REV^3") &&
>  	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
>  }
>  
> @@ -531,7 +531,8 @@ drop_stash () {
>  		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
>  
>  	# clear_stash if we just dropped the last stash entry
> -	git rev-parse --verify "$ref_stash@{0}" >/dev/null 2>&1 || clear_stash
> +	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
> +	clear_stash
>  }
>  
>  apply_to_branch () {
