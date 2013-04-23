From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] am: don't do housekeeping when rebasing
Date: Tue, 23 Apr 2013 09:51:19 -0700
Message-ID: <7v4nexjim0.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:51:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgRE-0001q1-0h
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552Ab3DWQvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:51:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757549Ab3DWQvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:51:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B487165F8;
	Tue, 23 Apr 2013 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y+3JrfNRBvNPjwQUfHiLRIpb050=; b=LSxak7
	nTRC+71kTZ5GVAW2v3Rc+R4E+5NW2uUi1YQnKkwz4UkiDFAucc7cF/+hB3W4RssL
	tjgm3VT6VSkj3FO2ymU9Jnck7PgAyvL7xwBA0vVSS0fBUFmKc1DAe92nWILitc9P
	3WYh+xGWW5AD/Q/beB9FeeHvQlwbWFzUHSf5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C/wepYqDJXNoSiUW41zgzn3c0eENs4bv
	itm02VLk7s2C4m2ecagScEETnbv3hFCkPahrmBn+B/UwMw2rvux/aJuFskYDk+6e
	fv6pQXM1ENOWOdTySR37UefCM3lG4kOqDYUQ0+zQGr3UIDHG1DPVrnq+/BqwIXWs
	bLVXfIYgMTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2634165F7;
	Tue, 23 Apr 2013 16:51:21 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F942165F3;
	Tue, 23 Apr 2013 16:51:21 +0000 (UTC)
In-Reply-To: <1366725724-1016-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 23 Apr 2013 19:32:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06A2225A-AC36-11E2-ABC2-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222192>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Perform these two tasks:
>
>     git gc --auto
>     rm -fr "$dotest"
>
> only when not called with --rebasing (from git-rebase--am.sh).
> Otherwise, return control to the caller so that it can do the needful.
> The advantage of doing this is that the caller can implement a generic
> cleanup routine (that possibly does other things) independent of
> specific rebases.

The above justification and the patch text make a lot of sense, but
they make me wonder why there is no corresponding removal from the
other git-rebase--*backend*.

Unconditional changes from "exit" to "return $?" looked somewhat
suspicious, but this is a sourced script so it should be safe.

>  git-am.sh         | 9 +++++++--
>  git-rebase--am.sh | 8 ++++----
>  git-rebase.sh     | 7 +++++++
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index f4ef8fc..47c1021 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -904,5 +904,10 @@ if test -s "$dotest"/rewritten; then
>      fi
>  fi
>  
> -rm -fr "$dotest"
> -git gc --auto
> +# If am was called with --rebasing (from git-rebase--am), it's up to
> +# the caller to take care of housekeeping.
> +if ! test -f "$dotest/rebasing"
> +then
> +	rm -fr "$dotest"
> +	git gc --auto
> +fi
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index f84854f..8230094 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -7,12 +7,12 @@ case "$action" in
>  continue)
>  	git am --resolved --resolvemsg="$resolvemsg" &&
>  	move_to_original_branch
> -	exit
> +	return $?
>  	;;
>  skip)
>  	git am --skip --resolvemsg="$resolvemsg" &&
>  	move_to_original_branch
> -	exit
> +	return $?
>  	;;
>  esac
>  
> @@ -56,7 +56,7 @@ else
>  
>  		As a result, git cannot rebase them.
>  		EOF
> -		exit $?
> +		return $?
>  	fi
>  
>  	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
> @@ -68,7 +68,7 @@ fi
>  if test 0 != $ret
>  then
>  	test -d "$state_dir" && write_basic_state
> -	exit $ret
> +	return $ret
>  fi
>  
>  move_to_original_branch
> diff --git a/git-rebase.sh b/git-rebase.sh
> index b2f1c76..8412d81 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -150,6 +150,13 @@ run_specific_rebase () {
>  		autosquash=
>  	fi
>  	. git-rebase--$type
> +	ret=$?
> +	if test $ret = 0
> +	then
> +		git gc --auto &&
> +		rm -rf "$state_dir"
> +	fi
> +	exit $ret
>  }
>  
>  run_pre_rebase_hook () {
