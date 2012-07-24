From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: handle fixup of root commit correctly
Date: Tue, 24 Jul 2012 12:22:34 -0700
Message-ID: <7vlii9ezgl.fsf@alter.siamese.dyndns.org>
References: <20120724121703.GG26014@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stkgr-0005GF-8K
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab2GXTWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:22:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464Ab2GXTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:22:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A5E78B07;
	Tue, 24 Jul 2012 15:22:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bU1UeT7RHOqcr4fD2RxHFxfJuV4=; b=bXxSdj
	PsUs87OPkSwBjLBXFcuAVUz83MgE6ZhjW/rhRSAk27gE5FCv/tDh9Dxu7pahEKmg
	7K46HtGHSJEZfdiB3scnN3gTnm9VYEjQGYFQh2WVqxtpc746/5R5L3pNFMa8fCsL
	+sym2d/BHUl5fEg6NZYGjBUcIfB85CBmH05ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AAjrBNEhyhG+dewNDSj8gRjssMOonM+B
	fv0n+IwrO4zEwS0MXN4kISF7uSKLudQ/+v35IjbcltNmpVrOGnmbiGo+Irx4wRp/
	HK1SVca78iWndVQHDXzg4bPPWBFY/nvxrZYoESqF4oH19w7u2JRqiWx4r8cEXIi9
	PDEwJhU/5oc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44A168B06;
	Tue, 24 Jul 2012 15:22:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7800F8B02; Tue, 24 Jul 2012
 15:22:35 -0400 (EDT)
In-Reply-To: <20120724121703.GG26014@arachsys.com> (Chris Webb's message of
 "Tue, 24 Jul 2012 13:17:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC719796-D5C4-11E1-8326-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202059>

Chris Webb <chris@arachsys.com> writes:

> There is a bug with git rebase -i --root when a fixup or squash line is
> applied to the new root. We attempt to amend the commit onto which they
> apply with git reset --soft HEAD^ followed by a normal commit. Unlike a
> real commit --amend, this sequence will fail against a root commit as it
> has no parent.
>
> Fix rebase -i to use commit --amend for fixup and squash instead, and
> add a test for the case of a fixup of the root commit.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>
> Sorry, I should have spotted this issue when I did the original root-rebase
> series. I've checked that this patch doesn't break any of the existing
> tests, as well as satisfying the newly introduced check for the root-fixup
> case.

OK, so instead of "reset --soft HEAD^ && pick -n && commit -F msg"
to back up one step and then build on top of it, the new sequence
"pick -n && commit --amend -F msg" modifies and then amends, whose
end result should be the same but the important difference is that
the latter would work even if the current commit is a root one.

Makes sense.  Thanks for catching and fixing it.

>
>  git-rebase--interactive.sh    | 25 +++++++++++++------------
>  t/t3404-rebase-interactive.sh |  8 ++++++++
>  2 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index bef7bc0..0d2056f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -493,25 +493,28 @@ do_next () {
>  		author_script_content=$(get_author_ident_from_commit HEAD)
>  		echo "$author_script_content" > "$author_script"
>  		eval "$author_script_content"
> -		output git reset --soft HEAD^
> -		pick_one -n $sha1 || die_failed_squash $sha1 "$rest"
> +		if ! pick_one -n $sha1
> +		then
> +			git rev-parse --verify HEAD >"$amend"
> +			die_failed_squash $sha1 "$rest"
> +		fi
>  		case "$(peek_next_command)" in
>  		squash|s|fixup|f)
>  			# This is an intermediate commit; its message will only be
>  			# used in case of trouble.  So use the long version:
> -			do_with_author output git commit --no-verify -F "$squash_msg" ||
> +			do_with_author output git commit --amend --no-verify -F "$squash_msg" ||
>  				die_failed_squash $sha1 "$rest"
>  			;;
>  		*)
>  			# This is the final command of this squash/fixup group
>  			if test -f "$fixup_msg"
>  			then
> -				do_with_author git commit --no-verify -F "$fixup_msg" ||
> +				do_with_author git commit --amend --no-verify -F "$fixup_msg" ||
>  					die_failed_squash $sha1 "$rest"
>  			else
>  				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
>  				rm -f "$GIT_DIR"/MERGE_MSG
> -				do_with_author git commit --no-verify -e ||
> +				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e ||
>  					die_failed_squash $sha1 "$rest"
>  			fi
>  			rm -f "$squash_msg" "$fixup_msg"
> @@ -748,7 +751,6 @@ In both case, once you're done, continue with:
>  		fi
>  		. "$author_script" ||
>  			die "Error trying to find the author identity to amend commit"
> -		current_head=
>  		if test -f "$amend"
>  		then
>  			current_head=$(git rev-parse --verify HEAD)
> @@ -756,13 +758,12 @@ In both case, once you're done, continue with:
>  			die "\
>  You have uncommitted changes in your working tree. Please, commit them
>  first and then run 'git rebase --continue' again."
> -			git reset --soft HEAD^ ||
> -			die "Cannot rewind the HEAD"
> +			do_with_author git commit --amend --no-verify -F "$msg" -e ||
> +				die "Could not commit staged changes."
> +		else
> +			do_with_author git commit --no-verify -F "$msg" -e ||
> +				die "Could not commit staged changes."
>  		fi
> -		do_with_author git commit --no-verify -F "$msg" -e || {
> -			test -n "$current_head" && git reset --soft $current_head
> -			die "Could not commit staged changes."
> -		}
>  	fi
>  
>  	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8078db6..3f75d32 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -903,4 +903,12 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
>  	git rebase --abort
>  '
>  
> +test_expect_success 'rebase -i --root fixup root commit' '
> +	git checkout B &&
> +	FAKE_LINES="1 fixup 2" git rebase -i --root &&
> +	test A = $(git cat-file commit HEAD | sed -ne \$p) &&
> +	test B = $(git show HEAD:file1) &&
> +	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
> +'
> +
>  test_done
