From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase: Print name of rev when using shorthand
Date: Mon, 14 Apr 2014 12:22:48 -0700
Message-ID: <xmqqwqerogvr.fsf@gitster.dls.corp.google.com>
References: <1397419474-31999-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 21:23:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZmT8-0006W9-J6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 21:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbaDNTW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 15:22:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbaDNTWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 15:22:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F037E7DBC1;
	Mon, 14 Apr 2014 15:22:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kSAe4cWKyO1/djbFH5fhbX6RjQo=; b=X9RVR6
	dO+dc+nO8feDHjhkM6wRGhrGoNrwk12EwDMpEB/ZTxGoSwQd3UnbGLH6eiMj2H3R
	XR2+s+Zm9VnZhjvk9AgVipbTzpHYGqWmvhvl+c3Fdvp/EV1XNR+sP5IL3wpJdWyX
	Vj4yDvETUmjbDJweZ6TCqMkiw1b/diSR8frxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c0lbqgL3lADeiYfZbqszJS5lEw1xfP2d
	OyI/iQV0FZV5Ax1TpqO+RP/+c1Y3+HiyrtasJQ8E0U6cs25ecqlGwNus5JIp2AS3
	Tmp3Lm6JqypEg7w8AzCjU3lNalgMdduRpfOCm04kM2+ghswVsXW0O2hUuwY7FfoX
	tmfv61lYcRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D93DA7DBC0;
	Mon, 14 Apr 2014 15:22:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2338A7DBBC;
	Mon, 14 Apr 2014 15:22:52 -0400 (EDT)
In-Reply-To: <1397419474-31999-1-git-send-email-modocache@gmail.com> (Brian
	Gesiak's message of "Mon, 14 Apr 2014 05:04:34 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C358A7E-C40A-11E3-95E6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246258>

Brian Gesiak <modocache@gmail.com> writes:

> The output from a successful invocation of the shorthand command
> "git rebase -" is something like "Fast-forwarded HEAD to @{-1}",
> which includes a relative reference to a revision. Other commands
> that use the shorthand "-", such as "git checkout -", typically
> display the symbolic name of the revision.
>
> Change rebase to output the symbolic name of the revision when using
> the shorthand. For the example above, the new output is
> "Fast-forwarded HEAD to master", assuming "@{-1}" is a reference to
> "master".
>
> - Use "git name-rev" to retreive the name of the rev.
> - Update the tests in light of this new behavior.
>
> Requested-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---

What the patch wants to implement sounds sensible, but I do not
think name-rev is a right tool for this.  Imagine the case where
there are more than one branches whose tip points at the commit you
came from.  name-rev will not be able to pick correctly which one to
report.

Also think what happens if you were previously on a detached HEAD?

I think you would want to use something like:

        upstream_name=$(git rev-parse --symbolic-full-name @{-1})
        if test -n "$upstream"
        then
                upstream_name=${upstream_name#refs/heads/}
        else
                upstream_name="@{-1}"
        fi

if the change is to be made at that point in the code.

I also wonder if "git rebase @{-1}" deserve a similar translation
like you are giving "git rebase -".

> Previous discussion on this issue:
> http://article.gmane.org/gmane.comp.version-control.git/244340
>
>  git-rebase.sh     | 2 +-
>  t/t3400-rebase.sh | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2c75e9f..ab0e081 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -455,7 +455,7 @@ then
>  	*)	upstream_name="$1"
>  		if test "$upstream_name" = "-"
>  		then
> -			upstream_name="@{-1}"
> +			upstream_name=`git name-rev --name-only @{-1}`
>  		fi
>  		shift
>  		;;
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 80e0a95..2b99940 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -91,7 +91,7 @@ test_expect_success 'rebase from ambiguous branch name' '
>  test_expect_success 'rebase off of the previous branch using "-"' '
>  	git checkout master &&
>  	git checkout HEAD^ &&
> -	git rebase @{-1} >expect.messages &&
> +	git rebase master >expect.messages &&

OK.

>  	git merge-base master HEAD >expect.forkpoint &&
>  
>  	git checkout master &&
> @@ -100,8 +100,6 @@ test_expect_success 'rebase off of the previous branch using "-"' '
>  	git merge-base master HEAD >actual.forkpoint &&
>  
>  	test_cmp expect.forkpoint actual.forkpoint &&
> -	# the next one is dubious---we may want to say "-",
> -	# instead of @{-1}, in the message
>  	test_i18ncmp expect.messages actual.messages
>  '
