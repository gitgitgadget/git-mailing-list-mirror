From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] rebase -i: return control to the caller, for housekeeping
Date: Tue, 23 Apr 2013 09:57:14 -0700
Message-ID: <7vzjwpi3rp.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgWw-0008B3-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab3DWQ5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:57:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757585Ab3DWQ5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:57:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2396916974;
	Tue, 23 Apr 2013 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qtwr86RKthPrxB3a4AvCeTZtwtE=; b=eGPTpW
	dXGZxRR7muHd+F78ir6Kkkahj47780RmIx/y/xoMR1TZ5E/A70xgBYqjQAIfCOwW
	NwGZwt+O0QyHGKqXvK5r6QwFvJgpkBGr2UsjXK0Kk8MBUe+s+e2DrTxnMZpH8F2M
	ktX0hnCSPkCWu6WsccUxFUHQXe6VYH19KPLYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cKb789cCNnMJ4Ojnx8eNnK5UuhRaDAqj
	UzkctTqrlOJihONOaN8HVZuJr3nG1/bhU/MzGr7nbNeiTCUeM7FCq00dvRlPPVBa
	MJtuRBzfr1QOotxFR1nNMItUbSCD7beeHrazJn4da6HpkoMeEzQyORv3qih1DeCP
	wzp5V0KZBsY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E7916973;
	Tue, 23 Apr 2013 16:57:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 516DF16972;
	Tue, 23 Apr 2013 16:57:16 +0000 (UTC)
In-Reply-To: <1366725724-1016-6-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 23 Apr 2013 19:32:02 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA31BAA4-AC36-11E2-AAD8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222194>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> On a successful interactive rebase, git-rebase--interactive.sh
> currently cleans up and exits on its own.  Instead of doing these
> two things ourselves:
>
>     rm -fr "$dotest"
>     git gc --auto
>
> let us return control to the caller (git-rebase.sh), to do the
> needful.  The advantage of doing this is that the caller can implement
> a generic cleanup routine (and possibly other things) independent of
> specific rebases.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

And this answers the question in my review for [4/7].  It would make
sense to have these two patch subseries asn three patches (prepare
git-rebase.sh, and then convert each backends separately), or a
single patch; two patches like this does not make much sense to me.

>  git-rebase--interactive.sh | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index cc3a9a7..9514e31 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -597,7 +597,7 @@ do_next () {
>  		fi
>  		;;
>  	esac
> -	test -s "$todo" && return
> +	test -s "$todo" && return 1
>  
>  	comment_for_reflog finish &&
>  	newhead=$(git rev-parse HEAD) &&
> @@ -623,17 +623,15 @@ do_next () {
>  		"$GIT_DIR"/hooks/post-rewrite rebase < "$rewritten_list"
>  		true # we don't care if this hook failed
>  	fi &&
> -	rm -rf "$state_dir" &&
> -	git gc --auto &&
>  	warn "Successfully rebased and updated $head_name."
>  
> -	exit
> +	return 0
>  }
>  
>  do_rest () {
>  	while :
>  	do
> -		do_next
> +		do_next && break
>  	done
>  }

This is somewhat suspicious.  We used to die when do_next failed, or
let do_next exit with success.

But now you let do_rest return (what does it return???)...

>  
> @@ -799,12 +797,12 @@ first and then run 'git rebase --continue' again."
>  	record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
>  
>  	require_clean_work_tree "rebase"
> -	do_rest
> +	do_rest && return 0

... and its caller reports success here only when it succeeds.  What
happens do_rest returns a failure?

>  	;;
>  skip)
>  	git rerere clear
>  
> -	do_rest
> +	do_rest && return 0
>  	;;
>  edit-todo)
>  	git stripspace --strip-comments <"$todo" >"$todo".new
