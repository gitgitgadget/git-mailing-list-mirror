From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] prompt: factor out gitstring coloring logic
Date: Fri, 17 May 2013 10:00:51 -0700
Message-ID: <7v7gix1qyk.fsf@alter.siamese.dyndns.org>
References: <1368780948-28917-1-git-send-email-artagnon@gmail.com>
	<1368780948-28917-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdO1d-0004Cq-Q0
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353Ab3EQRA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:00:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756292Ab3EQRAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:00:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C20B1F2CF;
	Fri, 17 May 2013 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=694QmOnFf9rhaYNFCRoAsSh6Yz0=; b=JyxO2g
	Xc/qSB0PWXoVfnjQXDMgf+4+gYKbfs5pdwDSUkPktlYX4x03csdNaGYhsys81FnK
	cj2QI2DfCZeHZI7dqSJJhKL6sAz8LKzcQwD5pphy7OvJCHpBZo1vX2RjgiNZdnP2
	rP1oWr86tdk90W7NQMVquiocW2KFgs0myY+fI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XyG2AOt+gELZ+glyHOiiucPhSqgSt+4Q
	eeyzxWzr59emeMOvgoyep2L4neO+URcxf2C8PDhCZnlXLEcVbFdEckWawOvgkT/Q
	//l4js782p20iyuB0g5YOIv/982sTgMLgzP3RVw+6Pepl/nAF1apVo1VAYMFDSkG
	Q8YPWlNIJjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22C5E1F2CE;
	Fri, 17 May 2013 17:00:54 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 495361F2CC;
	Fri, 17 May 2013 17:00:53 +0000 (UTC)
In-Reply-To: <1368780948-28917-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 17 May 2013 14:25:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 556DFE14-BF13-11E2-8289-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224704>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So that we can extend it with ZSH-colors in a later patch.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 79 ++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 36 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index fb9296b..263d2d7 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -222,6 +222,48 @@ __git_ps1_show_upstream ()
>  
>  }
>  
> +# Helper function that is meant to be called from __git_ps1.  It
> +# builds up a gitstring injecting color codes into the appropriate
> +# places.
> +__git_ps1_colorize_gitstring ()
> +{
> +	local c_red='\e[31m'
> +	local c_green='\e[32m'
> +	local c_lblue='\e[1;34m'
> +	local c_clear='\e[0m'
> +	local bad_color=$c_red
> +	local ok_color=$c_green
> +	local branch_color="$c_clear"
> +	local flags_color="$c_lblue"
> +	local branchstring="$c${b##refs/heads/}"
> +
> +	if [ $detached = no ]; then
> +		branch_color="$ok_color"
> +	else
> +		branch_color="$bad_color"
> +	fi
> +
> +	# Setting gitstring directly with \[ and \] around colors
> +	# is necessary to prevent wrapping issues!
> +	gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
> +
> +	if [ -n "$w$i$s$u$r$p" ]; then
> +		gitstring="$gitstring$z"
> +	fi
> +	if [ "$w" = "*" ]; then
> +		gitstring="$gitstring\[$bad_color\]$w"
> +	fi
> +	if [ -n "$i" ]; then
> +		gitstring="$gitstring\[$ok_color\]$i"
> +	fi

This is somewhat offtopic, but does anybody remember why $w (and
only $w) has to be checked against '*', instead of [ -n "$w" ]?

The primary reason I ask is because from time to time I hear people
who forget what these *#$% line noises mean and have been wondering
if we can add a GIT_PS1_SHOW_STATE_MNEMONIC option that shows these
with mnemonic letter sequences (e.g. "wsu" for dirty working tree,
unmodified index, with stash and untracked files).

> +	if [ -n "$s" ]; then
> +		gitstring="$gitstring\[$flags_color\]$s"
> +	fi
> +	if [ -n "$u" ]; then
> +		gitstring="$gitstring\[$bad_color\]$u"
> +	fi
> +	gitstring="$gitstring\[$c_clear\]$r$p"
> +}
>  
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
>  # when called from PS1 using command substitution
> @@ -364,42 +406,7 @@ __git_ps1 ()
>  		if [ $pcmode = yes ]; then
>  			local gitstring=
>  			if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
> -				local c_red='\e[31m'
> -				local c_green='\e[32m'
> -				local c_lblue='\e[1;34m'
> -				local c_clear='\e[0m'
> -				local bad_color=$c_red
> -				local ok_color=$c_green
> -				local branch_color="$c_clear"
> -				local flags_color="$c_lblue"
> -				local branchstring="$c${b##refs/heads/}"
> -
> -				if [ $detached = no ]; then
> -					branch_color="$ok_color"
> -				else
> -					branch_color="$bad_color"
> -				fi
> -
> -				# Setting gitstring directly with \[ and \] around colors
> -				# is necessary to prevent wrapping issues!
> -				gitstring="\[$branch_color\]$branchstring\[$c_clear\]"
> -
> -				if [ -n "$w$i$s$u$r$p" ]; then
> -					gitstring="$gitstring$z"
> -				fi
> -				if [ "$w" = "*" ]; then
> -					gitstring="$gitstring\[$bad_color\]$w"
> -				fi
> -				if [ -n "$i" ]; then
> -					gitstring="$gitstring\[$ok_color\]$i"
> -				fi
> -				if [ -n "$s" ]; then
> -					gitstring="$gitstring\[$flags_color\]$s"
> -				fi
> -				if [ -n "$u" ]; then
> -					gitstring="$gitstring\[$bad_color\]$u"
> -				fi
> -				gitstring="$gitstring\[$c_clear\]$r$p"
> +				__git_ps1_colorize_gitstring
>  			else
>  				gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
>  			fi
