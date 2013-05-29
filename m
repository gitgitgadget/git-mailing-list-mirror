From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: fix for simple rebase
Date: Wed, 29 May 2013 11:26:48 -0700
Message-ID: <7vehcptzfb.fsf@alter.siamese.dyndns.org>
References: <1369808488-16977-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Zoltan Klinger <zoltan.klinger@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 20:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhl5P-00055b-4n
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 20:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965582Ab3E2S0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 14:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965160Ab3E2S0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 14:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C025A23FE9;
	Wed, 29 May 2013 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SupEpUBKDAqYRWw1t+WFobbD7BY=; b=f5Yskj
	Zi8KjH/Ahy+c/iEXegl0qLU/akdsx56aNw2m25wXCy9ojHEPu7m/uDjIsc4SiVis
	RXHcwnwjBGRzdE8xrV8e/Y3+DIeWUuhBRcLXx0EhScXPyTNV4Lv2u8R0VXVtFGbS
	7TQcMP4yp23lQfDD0XvXKpv+T8uE0dOkNP+RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XaInhxSt8ebmnpEAWyDgOKPMQi7x2gGf
	BQOu7TdHeH2naemasOMEBqxHzTM8sc7S90LzgPuEL/E8Lc7D8tbQunA+00HehtMC
	eQuTgE06MU0PNM3FbTrMYnc8gnxLmPXlf9uMimSnQBDHfABJWL37UpZyh1a0nzlt
	2hYispt+HJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B461823FE8;
	Wed, 29 May 2013 18:26:50 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1286923FE4;
	Wed, 29 May 2013 18:26:49 +0000 (UTC)
In-Reply-To: <1369808488-16977-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 29 May 2013 01:21:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 541123CE-C88D-11E2-BC9C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225860>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When we are rebasing without options ('am' mode), the head rebased lives
> in '$g/rebase-apply/head-name', so lets use that information so it's
> reported the same way as if we were doing other rebases (-i or -m).
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 2 ++
>  t/t9903-bash-prompt.sh           | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index eaf5c36..bbf7657 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -279,6 +279,7 @@ __git_ps1 ()
>  				step=$(cat "$g/rebase-apply/next")
>  				total=$(cat "$g/rebase-apply/last")
>  				if [ -f "$g/rebase-apply/rebasing" ]; then
> +					b="$(cat "$g/rebase-apply/head-name")"
>  					r="|REBASE"
>  				elif [ -f "$g/rebase-apply/applying" ]; then
>  					r="|AM"

Looks correct to me, and the resulting behaviour is better

I wonder if the overall structure can be improved on top of this
change, though.

	if [ -d rebase-merge ]; then
        	set b, step, total and r to show REBASE-kind stuff
	else
        	if [ -d rebase-apply]; then
                	set step, total and r to show AM,
                        but if rebasing is there, show REBASE
		elif ...
                	handle all the other non rebase state
		elif ...
			in many different elif-then pieces
		fi

		if $b is not set; then
			set b to show the current branch
		fi
	fi

It looks somewhat strange that this has to be nested, not a straight
cascade of if/elif/.../fi.

> @@ -295,6 +296,7 @@ __git_ps1 ()
>  				r="|BISECTING"
>  			fi
>  
> +			test -n "$b" ||
>  			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
>  				detached=yes
>  				b="$(
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 083b319..15521cc 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -276,7 +276,7 @@ test_expect_success 'prompt - rebase merge' '
>  '
>  
>  test_expect_success 'prompt - rebase' '
> -	printf " ((t2)|REBASE 1/3)" > expected &&
> +	printf " (b2|REBASE 1/3)" > expected &&
>  	git checkout b2 &&
>  	test_when_finished "git checkout master" &&
>  	test_must_fail git rebase b1 b2 &&
