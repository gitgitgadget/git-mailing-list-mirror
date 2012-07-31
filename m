From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i: handle fixup of root commit correctly
Date: Tue, 31 Jul 2012 11:14:12 +0200
Message-ID: <5017A1E4.1070800@kdbg.org>
References: <20120724121703.GG26014@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 11:14:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw8X9-0007vw-Nm
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 11:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab2GaJO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 05:14:27 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:61117 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752827Ab2GaJO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 05:14:26 -0400
Received: from [10.74.90.22] (178.115.250.22.wireless.dyn.drei.com [178.115.250.22])
	by bsmtp.bon.at (Postfix) with ESMTP id 3CF5ACDF95;
	Tue, 31 Jul 2012 11:14:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120724121703.GG26014@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202640>

Am 24.07.2012 14:17, schrieb Chris Webb:
> There is a bug with git rebase -i --root when a fixup or squash line is
> applied to the new root. We attempt to amend the commit onto which they
> apply with git reset --soft HEAD^ followed by a normal commit. Unlike a
> real commit --amend, this sequence will fail against a root commit as it
> has no parent.
>
> Fix rebase -i to use commit --amend for fixup and squash instead, and
> add a test for the case of a fixup of the root commit.
>
> Signed-off-by: Chris Webb<chris@arachsys.com>
> ---
>
> Sorry, I should have spotted this issue when I did the original root-rebase
> series. I've checked that this patch doesn't break any of the existing
> tests, as well as satisfying the newly introduced check for the root-fixup
> case.
>
>   git-rebase--interactive.sh    | 25 +++++++++++++------------
>   t/t3404-rebase-interactive.sh |  8 ++++++++
>   2 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index bef7bc0..0d2056f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -493,25 +493,28 @@ do_next () {
>   		author_script_content=$(get_author_ident_from_commit HEAD)
>   		echo "$author_script_content">  "$author_script"
>   		eval "$author_script_content"
> -		output git reset --soft HEAD^
> -		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
> +		if ! pick_one -n $sha1
> +		then
> +			git rev-parse --verify HEAD>"$amend"
> +			die_failed_squash $sha1 "$rest"
> +		fi
>   		case "$(peek_next_command)" in
>   		squash|s|fixup|f)
>   			# This is an intermediate commit; its message will only be
>   			# used in case of trouble.  So use the long version:
> -			do_with_author output git commit --no-verify -F "$squash_msg" ||
> +			do_with_author output git commit --amend --no-verify -F "$squash_msg" ||
>   				die_failed_squash $sha1 "$rest"

This new sequence looks *VERY* suspicious. It makes a HUGE difference in 
what is left behind if the cherry-pick fails. Did you think about what 
happens when the cherry-pick fails in a squash+squash+fixup+fixup sequence 
(or any combination thereof) and then the rebase is continued (after a 
manual resolution)?

>   			;;
>   		*)
>   			# This is the final command of this squash/fixup group
>   			if test -f "$fixup_msg"
>   			then
> -				do_with_author git commit --no-verify -F "$fixup_msg" ||
> +				do_with_author git commit --amend --no-verify -F "$fixup_msg" ||
>   					die_failed_squash $sha1 "$rest"
>   			else
>   				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
>   				rm -f "$GIT_DIR"/MERGE_MSG
> -				do_with_author git commit --no-verify -e ||
> +				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e ||
>   					die_failed_squash $sha1 "$rest"
>   			fi
>   			rm -f "$squash_msg" "$fixup_msg"
> @@ -748,7 +751,6 @@ In both case, once you're done, continue with:
>   		fi
>   		. "$author_script" ||
>   			die "Error trying to find the author identity to amend commit"
> -		current_head=
>   		if test -f "$amend"
>   		then
>   			current_head=$(git rev-parse --verify HEAD)
> @@ -756,13 +758,12 @@ In both case, once you're done, continue with:
>   			die "\
>   You have uncommitted changes in your working tree. Please, commit them
>   first and then run 'git rebase --continue' again."
> -			git reset --soft HEAD^ ||
> -			die "Cannot rewind the HEAD"
> +			do_with_author git commit --amend --no-verify -F "$msg" -e ||
> +				die "Could not commit staged changes."
> +		else
> +			do_with_author git commit --no-verify -F "$msg" -e ||
> +				die "Could not commit staged changes."
>   		fi
> -		do_with_author git commit --no-verify -F "$msg" -e || {
> -			test -n "$current_head"&&  git reset --soft $current_head
> -			die "Could not commit staged changes."
> -		}
>   	fi
>
>   	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8078db6..3f75d32 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -903,4 +903,12 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
>   	git rebase --abort
>   '
>
> +test_expect_success 'rebase -i --root fixup root commit' '
> +	git checkout B&&
> +	FAKE_LINES="1 fixup 2" git rebase -i --root&&
> +	test A = $(git cat-file commit HEAD | sed -ne \$p)&&
> +	test B = $(git show HEAD:file1)&&
> +	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
> +'
> +
>   test_done

-- Hannes
