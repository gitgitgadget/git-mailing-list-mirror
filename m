From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 15/19] rebase -i: Explicitly distinguish replay commands and exec tasks
Date: Thu, 10 Jul 2014 13:03:08 -0700
Message-ID: <xmqq1ttt7zib.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<07e5f295c0042e78ba83ffb66925e3f09988ae3c.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:03:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5KYr-0004Xb-HA
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbaGJUDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:03:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63204 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbaGJUDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:03:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0B0C27A73;
	Thu, 10 Jul 2014 16:03:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8hxcVvGKaJgOLAtJTHYWiV49PFU=; b=t5QuO2
	Jslra+zXL7oh0qGUzlOzG7XFFw/eWFYaZqc6jRnosVBT9Wpa/tVF/cKW8Fm4U1SA
	HYufqCKwkYZ1J7Fsg7phUxzwLM7glqS81ZWdym9+G0VGBapEZdMMNXMDUO8zP5re
	CpEJ7gKB44ksqBhmSm8xcrxv3OPFITbyranvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gZrVE8tW5FqwseLYyQyyZqyaO3KDGS2H
	/rAEIv3XasTSSu75IPCjJUNHV0Gi7EfkQ8pB0rcBCwtmZ0pDIdAn117Bjn059ZFL
	BaWz0fIJv0poiMa7iMzVeRZUzuixPAiCjjrWX00m5GJ9vOqALDWoMkgJy/aprseA
	vN+ecGP5V+I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D33A327A72;
	Thu, 10 Jul 2014 16:03:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F79D27A67;
	Thu, 10 Jul 2014 16:02:55 -0400 (EDT)
In-Reply-To: <07e5f295c0042e78ba83ffb66925e3f09988ae3c.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:48:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2E8F0EB0-086D-11E4-AE39-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253203>

Fabian Ruch <bafain@gmail.com> writes:

> There are two kinds of to-do list commands available. One kind
> replays a commit (`pick`, `reword`, `edit`, `squash` and `fixup` that
> is) and the other executes a shell command (`exec`). We will call the
> first kind replay commands.
>
> The two kinds of tasks are scheduled using different line formats.
> Replay commands expect a commit hash argument following the command
> name and exec concatenates all arguments to assemble a command line.
>
> Adhere to the distinction of formats by not trying to parse the
> `sha1` field unless we are dealing with a replay command. Move the
> replay command handling code to a new function `do_replay` which
> assumes the first argument to be a commit hash and make no more such
> assumptions in `do_next`.

In do_next(), we used read the first line of the insn sheet into
three variables, assuming the common case of handling one of the
replay commands, and (somewhat wastefully) re-read the same line
into two variables when we realize that the command was "exec".

After you split do_replay() out of do_next() with this patch, we
seem to do exactly the same thing.

What exactly is the problem this change wants to fix?

Puzzled...


>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 008f3a0..9de7441 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -585,13 +585,12 @@ do_pick () {
>  	fi
>  }
>  
> -do_next () {
> -	rm -f "$msg" "$author_script" "$amend" || exit
> -	read -r command sha1 rest < "$todo"
> +do_replay () {
> +	command=$1
> +	sha1=$2
> +	rest=$3
> +
>  	case "$command" in
> -	"$comment_char"*|''|noop)
> -		mark_action_done
> -		;;
>  	pick|p)
>  		comment_for_reflog pick
>  
> @@ -656,6 +655,28 @@ do_next () {
>  		esac
>  		record_in_rewritten $sha1
>  		;;
> +	*)
> +		read -r command <"$todo"
> +		warn "Unknown command: $command"
> +		fixtodo="Please fix this using 'git rebase --edit-todo'."
> +		if git rev-parse --verify -q "$sha1" >/dev/null
> +		then
> +			die_with_patch $sha1 "$fixtodo"
> +		else
> +			die "$fixtodo"
> +		fi
> +		;;
> +	esac
> +}
> +
> +do_next () {
> +	rm -f "$msg" "$author_script" "$amend" || exit
> +	read -r command sha1 rest <"$todo"
> +
> +	case "$command" in
> +	"$comment_char"*|''|noop)
> +		mark_action_done
> +		;;
>  	x|"exec")
>  		read -r command rest < "$todo"
>  		mark_action_done
> @@ -695,14 +716,7 @@ do_next () {
>  		fi
>  		;;
>  	*)
> -		warn "Unknown command: $command $sha1 $rest"
> -		fixtodo="Please fix this using 'git rebase --edit-todo'."
> -		if git rev-parse --verify -q "$sha1" >/dev/null
> -		then
> -			die_with_patch $sha1 "$fixtodo"
> -		else
> -			die "$fixtodo"
> -		fi
> +		do_replay $command $sha1 "$rest"
>  		;;
>  	esac
>  	test -s "$todo" && return
