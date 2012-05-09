From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 18/19] bash prompt: avoid command substitution when
 checking for untracked files
Date: Wed, 09 May 2012 13:32:55 -0700
Message-ID: <7vr4utqemg.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-19-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:33:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDZH-0008Pa-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275Ab2EIUc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 16:32:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab2EIUc6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 16:32:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C9C649D;
	Wed,  9 May 2012 16:32:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qpefEmtUrE/p
	LzC260Yn9Onz2ag=; b=mG4OhQSKZxLJOvAZSdTRafAmrQuq37o1cpDLZl8pVv1T
	toZqUhYnV9cqKQuriQ3bdbEv2EEqEO6UX6FGSj53Xt9q/LzpYSncIp+hmTFK6W1e
	cRfY99CawhPemesqzBZQbW5fh04VqBTmWrMp8m6SyazPo3bo9baWRQybXa1+Zx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aPcR0n
	D5T9tVMmHiQ9o99I6ZWbja3ehYAmgsHbwyrMeiXiAjJBvS+eRLTiS0WDKIEKidhp
	bRPQqd0rQYLcN7zvTxTf9hHiuK7Xxt7+mfu5e35Moc+CdfYISohTBjXKuQG0ubZT
	y7kwqYznC/+bOVk7s++kV0PiYKi8P0UvBcWoA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59779649C;
	Wed,  9 May 2012 16:32:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0DBB6498; Wed,  9 May 2012
 16:32:56 -0400 (EDT)
In-Reply-To: <1336524290-30023-19-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 291A033A-9A16-11E1-86EB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197509>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> When enabled, the bash prompt can indicate the presence of untracked
> files with a '%' sign.  __git_ps1() checks for untracked files by run=
ning the
> '$(git ls-files --others --exclude-standard)' command substitution,
> and displays the indicator when there is no output.
>
> Avoid this command substitution by additionally passing
> '--error-unmatch *', and checking the command's return value.

This is too subtle and needs to be explained in a in-code comment.  For
example, it is unclear to me how this '*' pathspec and an untracked fil=
e
that does not fnmatch(3) with the pattern (e.g. ".trash").


        $ rm -fr /var/tmp/x && git init /var/tmp/x && cd /var/tmp/x
	$ args=3D'ls-files --others --exclude-standard'

	$ git $args | wc -l
        0
        $ git $args --error-unmatch -- '*' >/dev/null 2>&1 ; echo $?
        1

        $ >a
        $ git $args | wc -l
	1
        $ git $args --error-unmatch -- '*' >/dev/null 2>&1 ; echo $?
	0

	$ mv a .a
        $ git $args | wc -l
	1
        $ git $args --error-unmatch -- '*' >/dev/null 2>&1 ; echo $?
	0

The first two cases seem to be fine, but isn't the last one showing tha=
t
your update is incorrect?

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>
> This seems to do the right thing, but I'm not quite sure, so I would
> appreciate a pair of expert eyeballs on it.
>
>  contrib/completion/git-completion.bash | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index c4feab68..5ea19018 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -348,9 +348,8 @@ __git_ps1 ()
>  			fi
> =20
>  			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
> -				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
> -					u=3D"%"
> -				fi
> +				git ls-files --others --exclude-standard --error-unmatch -- '*' =
>/dev/null 2>/dev/null &&
> +				u=3D"%"
>  			fi
>  		fi
>  	fi
