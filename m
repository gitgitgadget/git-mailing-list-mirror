From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch names in $PS1
Date: Mon, 21 Apr 2014 15:23:00 -0700
Message-ID: <xmqq61m28gqj.fsf@gitster.dls.corp.google.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sitaramc@gmail.com,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 00:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcMcK-0005Sq-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbaDUWXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:23:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754682AbaDUWXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:23:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79A727F33F;
	Mon, 21 Apr 2014 18:23:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uQZPeubNaYkveOC0R1yEg6QV414=; b=n0lLfd
	D5kHyShMSFWyPNL2GDu/vFQ2Mlb+Ksbzv2WYxHGpTQxK3XunMd98uobrcaBnGDq/
	hw5lj1LB3rzhtytpdWQlROPfxV+aOhnplQefrBUdPVfhhIGfevTNkRZF711ROXTz
	maHQl712eKTXJCrOYY4Kv34NWTQlMjqTXa3KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mxrhyAhhVJ4LoamDI8Wlh3cjlpETfYWr
	0+SM11i9taVWVYc2sJHNqJfidKCUSSexsT9nPWNQB9NAD2rZ09UIdr1o+bmyTEZc
	H8d8zLzS8LZ/kNnw7QYHXAPM+2cPD0ivp41KJo6LQ8XbayxfE17EfZGddVdvAVaJ
	eGg73yQ8k4k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D8297F33E;
	Mon, 21 Apr 2014 18:23:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FF647F33C;
	Mon, 21 Apr 2014 18:23:02 -0400 (EDT)
In-Reply-To: <1398107248-32140-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Mon, 21 Apr 2014 15:07:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80A7E8C4-C9A3-11E3-B463-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246657>

Richard Hansen <rhansen@bbn.com> writes:

> Both bash and zsh subject the value of PS1 to parameter expansion,
> command substitution, and arithmetic expansion.  Rather than include
> the raw, unescaped branch name in PS1 when running in two- or
> three-argument mode, construct PS1 to reference a variable that holds
> the branch name.  Because the shells do not recursively expand, this
> avoids arbitrary code execution by specially-crafted branch names such
> as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.
>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>

I'd like to see this patch eyeballed by those who have been involved
in the script (shortlog and blame tells me they are SZEDER and
Simon, CC'ed), so that we can hopefully merge it by the time -rc1 is
tagged.

Will queue so that I won't lose it in the meantime.

Thanks.

>  contrib/completion/git-prompt.sh | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 7b732d2..bd7ff29 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -207,7 +207,18 @@ __git_ps1_show_upstream ()
>  			p=" u+${count#*	}-${count%	*}" ;;
>  		esac
>  		if [[ -n "$count" && -n "$name" ]]; then
> -			p="$p $(git rev-parse --abbrev-ref "$upstream" 2>/dev/null)"
> +			__git_ps1_upstream_name=$(git rev-parse \
> +				--abbrev-ref "$upstream" 2>/dev/null)
> +			if [ $pcmode = yes ]; then
> +				# see the comments around the
> +				# __git_ps1_branch_name variable below
> +				p="$p \${__git_ps1_upstream_name}"
> +			else
> +				p="$p ${__git_ps1_upstream_name}"
> +				# not needed anymore; keep user's
> +				# environment clean
> +				unset __git_ps1_upstream_name
> +			fi
>  		fi
>  	fi
>  
> @@ -438,8 +449,27 @@ __git_ps1 ()
>  		__git_ps1_colorize_gitstring
>  	fi
>  
> +	b=${b##refs/heads/}
> +	if [ $pcmode = yes ]; then
> +		# In pcmode (and only pcmode) the contents of
> +		# $gitstring are subject to expansion by the shell.
> +		# Avoid putting the raw ref name in the prompt to
> +		# protect the user from arbitrary code execution via
> +		# specially crafted ref names (e.g., a ref named
> +		# '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)' would execute
> +		# 'sudo rm -rf /' when the prompt is drawn).  Instead,
> +		# put the ref name in a new global variable (in the
> +		# __git_ps1_* namespace to avoid colliding with the
> +		# user's environment) and reference that variable from
> +		# PS1.
> +		__git_ps1_branch_name=$b
> +		# note that the $ is escaped -- the variable will be
> +		# expanded later (when it's time to draw the prompt)
> +		b="\${__git_ps1_branch_name}"
> +	fi
> +
>  	local f="$w$i$s$u"
> -	local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
> +	local gitstring="$c$b${f:+$z$f}$r$p"
>  
>  	if [ $pcmode = yes ]; then
>  		if [ "${__git_printf_supports_v-}" != yes ]; then
