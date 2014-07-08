From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 03/19] rebase -i: reword executes pre-commit hook on interim commit
Date: Tue, 08 Jul 2014 13:43:24 -0700
Message-ID: <xmqqlhs38tub.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
	<12171cf0323b3d10b12b02e3b7d42ff4b7964724.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:43:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4cEh-0007Bh-V3
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbaGHUnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 16:43:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52607 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677AbaGHUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 16:43:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6902C265E3;
	Tue,  8 Jul 2014 16:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sABLDrlp5RoUfOH32rIXLTuvTFk=; b=pNjG64
	RWqDd8zie7zirL0rRnMkkgOD5ELto1wLer+LdVdvNxtJAPO/WH6mYT5Jdd9RxL9N
	emIY0//IkgF0cnRYxI3v/TmGOzZJs8YV2sk6RMx+7H1a/uPxjz/TaFY5d6MCvhn+
	WEJIDIvqUZjnGM55nFrkJ7OR6uL13I4cqODO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=filxiqnLcxY5BWFX81GA/b+2dmtJ8Lel
	AEfIHLtG7dwA8bSk/kzQOBHKkGh2v/PlsJ2pcQy4b2hggNxW1UTmaIT0BJP5atQZ
	G6OheonBnMnmb5pHa7dLxRjK2W1nz4EcSlPu13yUc6tYX5Jhs6PBv2vgmKBv3QJb
	q78ShmirgPs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B433265E2;
	Tue,  8 Jul 2014 16:43:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F8DC265E1;
	Tue,  8 Jul 2014 16:43:10 -0400 (EDT)
In-Reply-To: <12171cf0323b3d10b12b02e3b7d42ff4b7964724.1404323078.git.bafain@gmail.com>
	(Fabian Ruch's message of "Wed, 2 Jul 2014 19:47:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 799D941E-06E0-11E4-B76D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253046>

Fabian Ruch <bafain@gmail.com> writes:

> The to-do list command `reword` replays a commit like `pick` but lets
> the user also edit the commit's log message. This happens in two
> steps. Firstly, the named commit is cherry-picked. Secondly, the
> commit created in the first step is amended using an unchanged index
> to edit the log message. The pre-commit hook is meant to verify the
> changes introduced by a commit (for instance, catching inserted
> trailing white space). Since the committed tree is not changed
> between the two steps, do not execute the pre-commit hook in the
> second step.

It is not like the second step is built as a child commit of the
result from the first step, recording the same tree without any
change.  Why is it a good thing not to run the pre-commit hook (or
other hooks for that matter)?  After all, the result of the second
step is what is recorded in the final history; it just feels wrong
not to test that one, even if it were a good idea to test only once.

> Specify the git-commit option `--no-verify` to disable the pre-commit
> hook when editing the log message. Because `--no-verify` also skips
> the commit-msg hook, execute the hook from within
> git-rebase--interactive after the commit is created. Fortunately, the
> commit message is still available in `$GIT_DIR/COMMIT_EDITMSG` after
> git-commit terminates. Caveat: In case the commit-msg hook finds the
> new log message ill-formatted, the user is only notified of the
> failed commit-msg hook but the log message is used for the commit
> anyway. git-commit ought to offer more fine-grained control over
> which hooks are executed.
>
> Signed-off-by: Fabian Ruch <bafain@gmail.com>
> ---
>  git-rebase--interactive.sh | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 689400e..b50770d 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -504,10 +504,19 @@ do_next () {
>  
>  		mark_action_done
>  		do_pick $sha1 "$rest"
> -		git commit --allow-empty --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
> -			warn "Could not amend commit after successfully picking $sha1... $rest"
> -			exit_with_patch $sha1 1
> -		}
> +		# TODO: Work around the fact that git-commit lets us
> +		# disable either both the pre-commit and the commit-msg
> +		# hook or none. Disable the pre-commit hook because the
> +		# tree is left unchanged but run the commit-msg hook
> +		# from here because the log message is altered.
> +		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
> +			if test -x "$GIT_DIR"/hooks/commit-msg
> +			then
> +				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
> +			fi || {
> +				warn "Could not amend commit after successfully picking $sha1... $rest"
> +				exit_with_patch $sha1 1
> +			}
>  		record_in_rewritten $sha1
>  		;;
>  	edit|e)
