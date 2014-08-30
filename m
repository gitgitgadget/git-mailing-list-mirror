From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] stash: prefer --quiet over shell redirection
Date: Sat, 30 Aug 2014 23:07:13 +0200
Message-ID: <54023D01.6090504@kdbg.org>
References: <1409427029-65886-1-git-send-email-davvid@gmail.com> <1409427029-65886-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:07:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNprn-00017N-RT
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 23:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbaH3VHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 17:07:17 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:25098 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751898AbaH3VHR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 17:07:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6B8B0130047;
	Sat, 30 Aug 2014 23:07:14 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BF87819F497;
	Sat, 30 Aug 2014 23:07:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <1409427029-65886-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256266>

Am 30.08.2014 21:30, schrieb David Aguilar:
> Use `git rev-parse --quiet` instead of redirecting to /dev/null.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-stash.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index bcc757b..5a5185b 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -50,7 +50,7 @@ clear_stash () {
>  	then
>  		die "$(gettext "git stash clear with parameters is unimplemented")"
>  	fi
> -	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
> +	if current=$(git rev-parse --quiet --verify $ref_stash)
>  	then
>  		git update-ref -d $ref_stash $current
>  	fi
> @@ -67,7 +67,7 @@ create_stash () {
>  	fi
>  
>  	# state of the base commit
> -	if b_commit=$(git rev-parse --verify HEAD)
> +	if b_commit=$(git rev-parse --quiet --verify HEAD)
>  	then
>  		head=$(git rev-list --oneline -n 1 HEAD --)
>  	else

The else branch calls die; wouldn't it be useful to keep the error
message of rev-parse?

> @@ -292,7 +292,7 @@ save_stash () {
>  }
>  
>  have_stash () {
> -	git rev-parse --verify $ref_stash >/dev/null 2>&1
> +	git rev-parse --quiet --verify $ref_stash

This change is not correct: --quiet removes only output on stderr, but
not that on stdout.

>  }
>  
>  list_stash () {
> @@ -392,12 +392,12 @@ parse_flags_and_rev()
>  		;;
>  	esac
>  
> -	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
> +	REV=$(git rev-parse --quiet --symbolic --verify "$1") || {
>  		reference="$1"
>  		die "$(eval_gettext "\$reference is not valid reference")"
>  	}
>  
> -	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
> +	i_commit=$(git rev-parse --quiet --verify "$REV^2") &&
>  	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&

I see another rev-parse that you did not modify. An omission?

>  	s=$1 &&
>  	w_commit=$1 &&
> @@ -409,7 +409,7 @@ parse_flags_and_rev()
>  	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
>  	IS_STASH_REF=t
>  
> -	u_commit=$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
> +	u_commit=$(git rev-parse --quiet --verify "$REV^3") &&
>  	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)

I see yet another rev-parse that you did not modify.

>  }
>  
> @@ -531,7 +531,7 @@ drop_stash () {
>  		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
>  
>  	# clear_stash if we just dropped the last stash entry
> -	git rev-parse --verify "$ref_stash@{0}" >/dev/null 2>&1 || clear_stash
> +	git rev-parse --quiet --verify "$ref_stash@{0}" || clear_stash

Again not correct.

>  }
>  
>  apply_to_branch () {
> 

-- Hannes
