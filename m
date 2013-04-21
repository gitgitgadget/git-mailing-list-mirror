From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 01:43:14 -0700
Message-ID: <7vppxouvdp.fsf@alter.siamese.dyndns.org>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:43:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTprm-0003sA-BF
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab3DUInS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:43:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab3DUInQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:43:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E79913A46;
	Sun, 21 Apr 2013 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=l9HLf0cmAs/EYQZDoCNt+lTniFE=; b=UEzCWs
	9ufcbsg1yYe9rwvEU/kdYar1c6+SAaE4d7gLtqMh8plQIOLQ4/BKVp11Ywv0+mYE
	E7rBSrcfymF7hO0q89Rmy+zO4I1ax5M7M6NrzkYy4FDAu0r6DwRNJswbevJDLgMF
	SXvnwOrvBsUHWQPp647Bu5ipatz/Zsyc9dbS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBmnUCB8aRc97/yKYQS351FElOLhR7Fw
	hcfd9OvVGcus8VwT5HGKBTtAuXa74q/cgcQguIawn4W37XD0hRBi86ZC0ssxzual
	79DGpsi7zhHXEF/Ute0JBw6dNqgcKDV8WWlPmMvaa0b+kXY60m8wHLNMv39yuWz6
	xR135WTfsqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55D9E13A45;
	Sun, 21 Apr 2013 08:43:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2BF113A41;
	Sun, 21 Apr 2013 08:43:15 +0000 (UTC)
In-Reply-To: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 21 Apr 2013 03:11:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 823170E8-AA5F-11E2-A1AF-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221925>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When this option is enabled, the prompt gets totally screwed in zsh
> because all the codes start with % in zsh (like they are \ in bas). So
> we need to escape the % character.

It is not that I do not believe that $u needs to duplicate %% in
ZSH, but I hate it when I do not understand the explanation.  Could
you help me clarify what you meant by "codes" and "like they are \ in bas"?

Are you referring to things like \u (user) \h (host) as "code" and
"bas" was a simple typo of "bash"?  In other words, does my reading
below:

	... because '%' is used as an introducer of prompt
	customization in zsh (just like bash prompt uses '\' to
	introduce \u, \h, etc.), we need to give '%%' to get a
	literal per-cent character.

match what you meant to say?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 756a951..4bedbcc 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -340,7 +340,11 @@ __git_ps1 ()
>  			   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
>  			   [ -n "$(git ls-files --others --exclude-standard)" ]
>  			then
> -				u="%"
> +				if [ -n "${ZSH_VERSION-}" ]; then
> +					u="%%"
> +				else
> +					u="%"
> +				fi
>  			fi
>  
>  			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
