From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-commit-interactive: Allow rebasing to preserve
 empty commits
Date: Fri, 30 Mar 2012 13:59:02 -0700
Message-ID: <7v4nt5lsa1.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-5-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 22:59:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDiuf-0001In-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 22:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761391Ab2C3U7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 16:59:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761132Ab2C3U7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 16:59:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5D6F450A;
	Fri, 30 Mar 2012 16:59:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TtGfRUjWYHb2RfX11DJTIoaVb+4=; b=AGeUgn
	P9kc1d22pEa4tnzEzZwmVUKYghEM+wHSuUoYVnLTisHyRnxLLMiSQByugYX4VvRZ
	e5ewmuPewhCOmqGi6RD7MlIsnKBuHEe1NU51lliBSIVfNKWCVQeVubU3Qj1Xb4vj
	p3zu6kNyJqWn2lzfS/us8RbOsUy1hjksVNFi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=osMifd2NprH8IRkh+1cjNST3XVyxNpBy
	wVPHDNcBmFSHweQM2EnAhcpgDQadq+y+ZH6H/5yy3SR3u5BXdUMiV5mHpldTHX7g
	QsqqA4Gfkx/OV/BieT12sA9giZeLB+j53k66VSugUcd22wkzIbpMqQYQxo6x/VSH
	PFauBHNuhdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1B74509;
	Fri, 30 Mar 2012 16:59:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08B864507; Fri, 30 Mar 2012
 16:59:03 -0400 (EDT)
In-Reply-To: <1333136922-12872-5-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Fri, 30 Mar 2012 15:48:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EC4D24A-7AAB-11E1-821F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194408>

Neil Horman <nhorman@tuxdriver.com> writes:

> This updates git-commit-interactive to recognize and make use of the keep_empty
> flag.  When not set, git-rebase -i will now comment out commits that are empty,
> and informs the user that commits which they wish to explicitly keep that are
> empty should be uncommented, or --keep-empty should be specified.  if keep_empty
> is specified, all commits, regardless of their empty status are included.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Jeff King <peff@peff.net>
> CC: Phil Hord <phil.hord@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>
> ---
>  git-rebase--interactive.sh |   38 +++++++++++++++++++++++++++++++++++---
>  1 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5812222..97eeb21 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -191,12 +191,24 @@ git_sequence_editor () {
>  
>  pick_one () {
>  	ff=--ff
> +	is_empty=$(git show --pretty=format:%b "$@" | wc -l)

That is a very expensive way to see if the commit is empty, no?

If and only if commit C is empty, "git rev-parse" on C^{tree} and
C^^{tree}" will yield the same tree object name.

> +	if [ $is_empty -eq 0 ]

Also this test (which by the way is against our coding style guideline)
shows that the variable is misnamed.

> +	then
> +		empty_args=--keep-empty
> +	fi
> +
> +	if [ -n "$keep_empty" ]
> +	then
> +		empty_args=--keep_empty
> +	fi
> +
>  	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>  	case "$force_rebase" in '') ;; ?*) ff= ;; esac
>  	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
>  	test -d "$rewritten" &&
>  		pick_one_preserving_merges "$@" && return
> -	output git cherry-pick $ff "$@"
> +	output git cherry-pick $empty_args $ff "$@"
>  }
>  
>  pick_one_preserving_merges () {
> @@ -780,9 +792,24 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
>  	sed -n "s/^>//p" |
>  while read -r shortsha1 rest
>  do
> +	local comment_out

bashism.

> +
> +	if [ -z "$keep_empty" ]
> +	then
> +		comment_out=$(git show --pretty=format:%b $shortsha1 | wc -l)

Ditto.

> +		if [ $comment_out -eq 0 ]
> +		then
> +			comment_out="#pick"

Perhaps it is easier to read if you say "# pick"?

> +		else
> +			comment_out="pick"
> +		fi
> +	else
> +		comment_out="pick"
> +	fi
> +
>  	if test t != "$preserve_merges"
>  	then
> -		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
> +		printf '%s\n' "$comment_out $shortsha1 $rest" >> "$todo"

The variable comment_out is grossly misnamed.  Why not do it this way?

	comment_out=
	if test -z "$keep_empty" && is_empty_commit $shortsha1
        then
        	comment_out="# "
	fi

        if ...
        then
		printf "%s\n" "${leader}pick $shortsha1 $rest" >>"$todo"

> @@ -849,6 +876,11 @@ cat >> "$todo" << EOF
>  # If you remove a line here THAT COMMIT WILL BE LOST.
>  # However, if you remove everything, the rebase will be aborted.
>  #
> +# Note that commits which are empty at the time of rebasing are 
> +# commented out.  If you wish to keep empty commits, either 
> +# specify the --keep-empty option to the rebase command, or 
> +# uncomment the commits you wish to keep
> +#

Good.

I do not think " either specify...rebase command, or" is necessary here,
though.  This message is meant to be a quick reminder, not a tutorial.
Keep it short and sweet.

Also, you may probably want to add this text _only_ when you have actually
commented out something.
