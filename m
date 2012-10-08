From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] rebase: Handle cases where format-patch fails
Date: Mon, 08 Oct 2012 15:38:35 -0700
Message-ID: <7vtxu4io7o.fsf@alter.siamese.dyndns.org>
References: <7vipaou0zw.fsf@alter.siamese.dyndns.org>
 <1349724988-14625-1-git-send-email-andrew.kw.w@gmail.com>
 <1349724988-14625-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alex.kostikov@gmail.com
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 00:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLLyR-00016K-23
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 00:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab2JHWin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 18:38:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab2JHWij (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 18:38:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 215639D32;
	Mon,  8 Oct 2012 18:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xz5em63XfbYKbAVOQd7V/Wgh8jI=; b=YYNX1t
	LtqCuH2u3QxJ19Z6lsliD/bmL2sHcbcdpXwFgTLBN+9Pob+fOvykkxbUs2zu11qc
	OOozJ47xmliECKgMe4XWZaqWz52DK9lLZwARQfvEOmUMJi2g4Nf5llVhUh3e0QPW
	LFfj85UB2uwxnBSM8vz/p+q752wNpxJWB824M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tFlcKwyff+DQgEsX6K6mpE1g90naaZLd
	Tv75V1z2KpPLzcYeDo8OQxH5XjVZDtrRNQoAaaq6mBdtUrzWyRCjvijYjShDiaoh
	wv/ERgYsxCkXSFFlNpUPy4w8EYghXE3uAcPU8l9HEfOKKr9+9oMJooFK7hOOVfPp
	CYbPv+cnKkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EAED9D31;
	Mon,  8 Oct 2012 18:38:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32A959D30; Mon,  8 Oct 2012
 18:38:37 -0400 (EDT)
In-Reply-To: <1349724988-14625-2-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Mon, 8 Oct 2012 15:36:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E65DE16A-1198-11E2-86B2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207277>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> 'format-patch' could fail due to reasons such as out of memory. Such
> failures are not detected or handled, which causes rebase to incorrectly
> think that it completed successfully and continue with cleanup. i.e.
> calling move_to_original_branch
>
> Instead of using a pipe, we separate 'format-patch' and 'am' by using an
> intermediate file. This gurantees that we can invoke 'am' with the
> complete input, or not invoking 'am' at all if 'format-patch' failed.
>
> Also print messages to help user with how to recover from such failures.
>
> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  git-rebase--am.sh | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 392ebc9..a955b38 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -26,10 +26,32 @@ then
>  	# makes this easy
>  	git cherry-pick --allow-empty "$revisions"
>  else
> -	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> +	rm -f "$GIT_DIR/format-patch"
> +	if ! git format-patch -k --stdout --full-index --ignore-if-in-upstream \
>  		--src-prefix=a/ --dst-prefix=b/ \
> -		--no-renames $root_flag "$revisions" |
> -	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
> +		--no-renames $root_flag "$revisions" > "$GIT_DIR/format-patch" && ret=$?
> +	then

Is it just me?  I find this construct

	if ! cmd && ret=$?
        then

very hard to wrap my mind around.  Why not

	git format-patch ... just as before ... \
          ... >"$GIT_DIR/formatted-patches" || {
		# error handling or advices come here...
                rm -f "$GIT_DIR/formatted-patches"
		exit 1
	}

	git am ... just as before ... "$GIT_DIR/formatted-patches" || {
		# possibly another error handling or advices come here...
		rm -f "$GIT_DIR/formatted-patches"
		exit 1
	}

without changing anything else?

> +		rm "$GIT_DIR/format-patch"
> +		echo
> +		echo "'git format-patch' seems to have failed."
> +		echo "It is impossible to continue or abort rebasing."
> +		echo "You have to use the following to return to your original head:"
> +		echo
> +		case "$head_name" in
> +		refs/*)
> +			echo "    git checkout $head_name"
> +			;;
> +		*)
> +			echo "    git checkout $orig_head"
> +			;;
> +		esac

You _know_ format-patch failed, not just "seems to have", at this
point, no?  Why is it impossible to abort?

What have we done before reaching to this point?  We know we are
doing the basic "git rebase", without any funny "-m/-i/-p" business,
so the only thing we have done are (1) detached HEAD at the new
onto, (2) set ORIG_HEAD to point at the original tip of the branch
being rebased (or the commit we were sitting at, if we are rebasing
a detached history), and (3) head_name has the refname of the
original branch (or detached HEAD) and branch_name has the name of
the branch (or HEAD).

Shouldn't we be just rewinding what we have done so far and error
the whole thing out instead?  Perhaps the first "# error handling or
advises come here..." part may simply be

	case "$head_name" in
	refs/heads/*)
		git checkout "$head_name"
                ;;
	*)
		git checkout "$orig_head"
                ;;
	esac
	cat >&2 <<-\EOF
	Error was found while preparing the patches ($revisions) to
        replay on the rewound head. You cannot rebase this history.
        EOF

or something like that.  The format-patch output (and its error) may
be of interest in getting help going forward.
