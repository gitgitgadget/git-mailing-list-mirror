From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] sh-setup: introduce require_clean_work_tree --quiet
Date: Tue, 23 Apr 2013 10:00:50 -0700
Message-ID: <7vvc7di3lp.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:00:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgaQ-0003f4-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab3DWRAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:00:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250Ab3DWRAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:00:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F68916C44;
	Tue, 23 Apr 2013 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3ZcwcVL2v2FOgIQEApTtKu2TMTU=; b=XyFd2s
	WN1zqdhU1VeDSaNx6wy67Vt9AFf1ewtja+YdOFnTiE1uVhO1YjIUmnWIi7drPpwT
	7AdLpkykOcsXwELABTDfaMjEPt004On7jgmfV2VLujT3kKX+mjLP5cRin9SETkBT
	7Q9R8RtjtymMjcREM3rOAUGkMMNYieVeVmNCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/Qau66YZAbEsvGFgh996OXTHIlEymDm
	xy8EIh2ljUKruz2OynbjGKn8mZJ5R6UeWFRm8Q59KUB2vJ5rBnKztOA5qLU8RvVE
	43/jYdlAH0fRhtPKJaDr9BA+Np2nm6eyriFkNfd+3irWCIocITyj5mozjt2ApXvu
	N6Il6QSK8ko=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6401F16C43;
	Tue, 23 Apr 2013 17:00:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDF8C16C3F;
	Tue, 23 Apr 2013 17:00:51 +0000 (UTC)
In-Reply-To: <1366725724-1016-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 23 Apr 2013 19:32:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A9C4394-AC37-11E2-A084-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222195>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Some callers might want to know whether or not the worktree is clean,
> and require_clean_work_tree() has the logic for this.  The current
> implementation of the function prints a message and exits if the
> worktree wasn't clean.  Introduce a --quiet switch to get it to report
> the status of the worktree back to the caller.

This makes 75% sense, but I find it an extremely bad taste to tie
exit vs return with --quiet.  They are orthogonal and unrelated
concepts.

Doing this

	if (require_clean_work_tree) 2>/dev/null
        then
		: happy, the working tree is clean
	else
		... let's stash ...
	fi

without changing anything else may be better than adding such a
conflating --quiet option.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-sh-setup.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 2f78359..5fa22a8 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -172,6 +172,7 @@ require_clean_work_tree () {
>  
>  	if ! git diff-files --quiet --ignore-submodules
>  	then
> +		test "$1" = "--quiet" ||
>  		echo >&2 "Cannot $1: You have unstaged changes."
>  		err=1
>  	fi
> @@ -180,9 +181,11 @@ require_clean_work_tree () {
>  	then
>  		if [ $err = 0 ]
>  		then
> -		    echo >&2 "Cannot $1: Your index contains uncommitted changes."
> +			test "$1" = "--quiet" ||
> +			echo >&2 "Cannot $1: Your index contains uncommitted changes."
>  		else
> -		    echo >&2 "Additionally, your index contains uncommitted changes."
> +			test "$1" = "--quiet" ||
> +			echo >&2 "Additionally, your index contains uncommitted changes."
>  		fi
>  		err=1
>  	fi
> @@ -190,8 +193,9 @@ require_clean_work_tree () {
>  	if [ $err = 1 ]
>  	then
>  		test -n "$2" && echo >&2 "$2"
> -		exit 1
> +		test "$1" = "--quiet" || exit 1
>  	fi
> +	return $err
>  }
>  
>  # Generate a sed script to parse identities from a commit.
