From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 01:43:05 -0700
Message-ID: <7vr4i4uvdy.fsf@alter.siamese.dyndns.org>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTprf-0003mE-A1
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585Ab3DUInK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:43:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab3DUInI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:43:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9737E13A36;
	Sun, 21 Apr 2013 08:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P0YmSQcGFzB0bt5wERSAaWCAFlk=; b=m0zFdw
	ovo6Ew/BO7twT56iSlgQdkm0FoK0IpTan95NU3BX1LOoQYH7pqwe/XJJ5qrQ79rj
	0Dzon50zmnI5Y0JG0Z5TSJLibiUsnC05biASx1X5sOd3cacJBljZM5y0nYJ9qaK9
	w87EuM7ZnGYHmupcOsCv19Kkw4VWBqtZ/70yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=un/gbt+/YOMDjlZI3tKRl+VqSMrvrJw0
	v6DPmF82oTeRQlbnWVKmnM5pWTsSvxDZOLX/Z68nIQpvyqlgLLcGVorRM1v3J54P
	4/dvUHyWaUFJzTk21TSv9F8NN1xea8IXGwQZ5g86iTRZO0/7vMnYfUZxfeji3y6K
	gDNSEkvbTdo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 834A013A35;
	Sun, 21 Apr 2013 08:43:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F25EC13A33;
	Sun, 21 Apr 2013 08:43:06 +0000 (UTC)
In-Reply-To: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 21 Apr 2013 03:11:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CFBC2D6-AA5F-11E2-B51C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221923>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When this option is enabled, the prompt gets totally screwed in zsh
> because all the codes start with % in zsh (like they are \ in bas). So
> we need to escape the % character.

It is not that I do not believe that $u needs to duplicate %% in
ZSH, but I hate it when I do not understand the explanation.  Could
you help me clarify what you meant by "codes" and "like they are \ in bas"?

Are you referring to things like \u (user) \h (host) as "code" and
"bas" was a simple typo of "bash"?  In other words, is my reading
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
