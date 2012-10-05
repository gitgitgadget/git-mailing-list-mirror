From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] rebase: Handle cases where format-patch fails
Date: Fri, 05 Oct 2012 13:17:55 -0700
Message-ID: <7vipaou0zw.fsf@alter.siamese.dyndns.org>
References: <506E1327.1070602@gmail.com>
 <1349412790-6087-1-git-send-email-andrew.kw.w@gmail.com>
 <1349412790-6087-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.kostikov@gmail.com
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:18:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKELZ-00063N-9E
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 22:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab2JEUR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 16:17:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173Ab2JEUR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 16:17:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B0781CE;
	Fri,  5 Oct 2012 16:17:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UUamnqBuhJ7gLTAqzmEb0yLJmRc=; b=S69EVn
	Y0g8yn0tZ4MDSwuV20kG8D1/7M3Pyg+nkpkaPwCAfxDNaBhkYCh/S163dzd6vdKO
	innJ+Pp/v0WQsYAShOGYWZbiAma3wJGrYSir/iZh96MraYANe/OEPwMJoZiDK86v
	IdhWwX6815M2wRanFWO9lzcD3mGqYDVuLoyOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EVeA/eD8uAqDocrD6LoQPxUkPv4mUoMb
	bI1j4ZoqeGzqS2boT3x71KX8Vm/kNgadZKBA9L+GQyKlZWA7MuHELCYBfAGi6VSe
	KxzDd7Pemu+UgBD2ZG2m4BDDCNyLsZQ+A+AuqG2t6vIMga4SkOofVEuFqwBvl3nP
	SlNWmbk17iU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CFE81CD;
	Fri,  5 Oct 2012 16:17:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96D0181CC; Fri,  5 Oct 2012
 16:17:56 -0400 (EDT)
In-Reply-To: <1349412790-6087-2-git-send-email-andrew.kw.w@gmail.com> (Andrew
 Wong's message of "Fri, 5 Oct 2012 00:53:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C024E050-0F29-11E2-A629-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207118>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> 'format-patch' could fail due to reasons such as out of memory. Such
> failures are not detected or handled, which causes rebase to incorrectly
> think that it completed successfully and continue with cleanup. i.e.
> calling move_to_original_branch
>
> Since only the exit status of the last command in the pipeline is
> available, we rely on || to detect whether 'format-patch' has failed.
>
> Also print messages to help user with how to recover from such failures.
>
> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  git-rebase--am.sh | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 392ebc9..8dae804 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -26,10 +26,43 @@ then
>  	# makes this easy
>  	git cherry-pick --allow-empty "$revisions"
>  else
> -	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> +	( git format-patch -k --stdout --full-index --ignore-if-in-upstream \
>  		--src-prefix=a/ --dst-prefix=b/ \
> -		--no-renames $root_flag "$revisions" |
> +		--no-renames $root_flag "$revisions" ||
> +		echo $? > "$GIT_DIR"/format-patch-failed ) |

Please make sure there is no marker-file that was leftover from
previous invocation or whatever reason, e.g.

	rm -f "$GIT_DIR/format-patch-failed"
        (
		git format-patch -k --stdout --full-index --ignore-if-in-upstream \
			--src-prefix=a/ --dst-prefix=b/ \
			--no-renames $root_flag "$revisions" ||
		echo $? >"$GIT_DIR"/format-patch-failed
	) |
  	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"

But when format-patch dies for whatever reason, it is likely that
the partial output will cause "am" to barf on the last part of it
(either "missing patch text" if it stops in the middle of commit log
message, or "corrupt patch" if it stops in the middle of a hunk).
It may make sense to make this all-or-none, i.e. when format-patch
fails, you do not even start "am", something like...

	rm -f "$GIT_DIR/patch-input"
        if ! git format-patch -k --stdout >"$GIT_DIR/patch-input" \
	        --full-index --ignore-if-in-upstream \
		--src-prefix=a/ --dst-prefix=b/ \
		--no-renames $root_flag "$revisions"
	then
		... format-patch barfed, here is how to deal with it...
	else
        	git am <"$GIT_DIR/patch-input" $git_am_opt ...
	fi
	rm -f "$GIT_DIR/patch-input"

but I wonder what the performance implication would be for normal cases.

> +	ret=$?
> +	if test -f "$GIT_DIR"/format-patch-failed
> +	then
> +		ret=1
> +		rm -f "$GIT_DIR"/format-patch-failed
> +		if test -d "$state_dir"
> +		then
> +			echo
> +			echo "'git format-patch' seems to have failed in the middle of 'git am'."
> +			echo "If you continue rebasing, you will likely be losing some commits."
> +			echo "It is recommended that you abort rebasing by running:"
> +			echo
> +			echo "    git rebase --abort"
> +			echo
> +		else
> +			echo
> +			echo "'git format-patch' seems to have failed before 'git am' started."
> +			echo "It is impossible to continue or abort rebasing."
> +			echo "You have to use the following to return to your original head:"
> +			echo
> +			case "$head_name" in
> +			refs/*)
> +				echo "    git checkout $head_name"
> +				;;
> +			*)
> +				echo "    git checkout $orig_head"
> +				;;
> +			esac
> +			echo
> +		fi
> +	fi
> +	test 0 != $ret && false
>  fi && move_to_original_branch
>  
>  ret=$?
