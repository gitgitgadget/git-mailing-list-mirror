From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-rebase-interactive: do not squash commits on
 abort
Date: Mon, 08 Sep 2008 17:06:04 -0700
Message-ID: <7v7i9mdvyr.fsf@gitster.siamese.dyndns.org>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 09 02:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcqlS-0002Vz-Mf
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 02:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbYIIAGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 20:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbYIIAGS
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 20:06:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbYIIAGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 20:06:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A013C79E5B;
	Mon,  8 Sep 2008 20:06:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2003479E56; Mon,  8 Sep 2008 20:06:08 -0400 (EDT)
In-Reply-To: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Tue, 9 Sep 2008 00:42:48 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F520DBC-7E03-11DD-961D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95320>

Dmitry Potapov <dpotapov@gmail.com> writes:

> If git rebase interactive is stopped by "edit" command and then the user
> said "git rebase --continue" while having some stage changes, git rebase
> interactive is trying to amend the last commit by doing:
>   git --soft reset && git commit
>
> However, the user can abort commit for some reason by providing an empty
> log message, and that would leave the last commit undone, while the user
> being completely unaware about what happened. Now if the user tries to
> continue, by issuing "git rebase --continue" that squashes two previous
> commits.
>
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>  git-rebase--interactive.sh |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 929d681..5b2b1e5 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -429,12 +429,15 @@ do
>  				die "Cannot find the author identity"
>  			if test -f "$DOTEST"/amend
>  			then
> +				amend=$(git rev-parse --verify HEAD)
>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"
>  			fi
>  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> -			git commit --no-verify -F "$DOTEST"/message -e ||
> -			die "Could not commit staged changes."
> +			git commit --no-verify -F "$DOTEST"/message -e || {
> +				test -n "$amend" && git reset --soft $amend
> +				die "Could not commit staged changes."
> +			}
>  		fi

Feels obviously correct from a cursory look, although I admit I haven't
thought about other possible corner cases that this additional reset may
fire when it shouldn't.  Dscho?

>  
>  		require_clean_work_tree
> -- 
> 1.6.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
