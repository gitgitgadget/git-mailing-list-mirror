From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] completion: fix completion of certain aliases
Date: Wed, 09 Apr 2014 12:33:35 -0700
Message-ID: <xmqqa9bu1enk.fsf@gitster.dls.corp.google.com>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
	<1397069404-7451-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 21:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXyFt-00011j-WB
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbaDITdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:33:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933342AbaDITdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:33:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3074B7B09A;
	Wed,  9 Apr 2014 15:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Oy+2hz87z23WIT4bDpMWQ8YTsR4=; b=P6IIWm
	GUle+Nvk6495f2oV15IEYkF6CUHDs41KzxlZr9n4kUpmG7uSLEta0dGEFluyNE3i
	h0AppPpI7tnFd3Mjc95JW+qzWd2cqcDDyFzGs5xefqF+uyQxi/tP7Sz9nx9zjrgH
	QnYTMEkN+aYDHRoI82mJIqNfvAY3GPzjHralE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gIrFG7l7PShNvU/oCMot9ysmN/Vtblo9
	ZjExngSOeFwUFygzInXQhKKTy7HxAqlWiOAugO93K8de45U6b1rvMjzgio2rxkGf
	YGReXqRWbeeSAqYSPK65wE45aOCchwBo+NzLMz3fFQSAb6WRlkTCzUkfgaWlyQtf
	COBwEFo+mCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 222887B099;
	Wed,  9 Apr 2014 15:33:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2DDA7B095;
	Wed,  9 Apr 2014 15:33:42 -0400 (EDT)
In-Reply-To: <1397069404-7451-6-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 9 Apr 2014 13:50:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DBF4BEC6-C01D-11E3-B3BB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245994>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some commands need the first word to determine the actual action that is
> being executed, however, the command is wrong when we use an alias, for
> example 'alias.p=push', if we try to complete 'git p origin ', the
> result would be wrong because __git_complete_remote_or_refspec() doesn't
> know where it come from.
>
> So let's override words[1], so the alias 'p' is override by the actual
> command, 'push'.
>
> Reported-by: Aymeric Beaumet <aymeric.beaumet@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Does "some commands" above refer to anything that uses
__git_complete_remote_or_refspec, or is the set of commands larger
than that?

I am wondering if it is safer to introduce a new "local" variable
that is set by the caller of __git_complete_remote_or_refspec and
inspected by __git_complete_remote_or_refspec (instead of words[1])
to communiate the real name of the git subcommand being completed,
without touching words[] in place.

That way, we wouldn't have to worry about all the other references
of words[c], words[i], words[CURRENT] etc. in the script seeing the
word that the end-user did not type and did not actually appear on
the command line.

But perhaps we muck with the contents of words[] in a similar way in
many different places in the existing completion code often enough
that such an attempt not to touch the words[] array does not buy us
much safety anyway.  I didn't check (and that is why I am asking
with "I am wondering...").

Thanks, will queue.

[Ram and Szeder CC'ed as they appear in shortlog for the past 12
months].

>  contrib/completion/git-completion.bash | 1 +
>  contrib/completion/git-completion.zsh  | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9525343..893ae5d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2547,6 +2547,7 @@ __git_main ()
>  
>  	local expansion=$(__git_aliased_command "$command")
>  	if [ -n "$expansion" ]; then
> +		words[1]=$expansion
>  		completion_func="_git_${expansion//-/_}"
>  		declare -f $completion_func >/dev/null && $completion_func
>  	fi
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 6b77968..9f6f0fa 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -104,6 +104,7 @@ __git_zsh_bash_func ()
>  
>  	local expansion=$(__git_aliased_command "$command")
>  	if [ -n "$expansion" ]; then
> +		words[1]=$expansion
>  		completion_func="_git_${expansion//-/_}"
>  		declare -f $completion_func >/dev/null && $completion_func
>  	fi
