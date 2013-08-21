From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Revert "bash prompt: avoid command substitution when finalizing gitstring"
Date: Wed, 21 Aug 2013 14:47:55 -0700
Message-ID: <xmqq7gfeu35g.fsf@gitster.dls.corp.google.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
	<1377118173-23405-3-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	<szeder@ira.uka.de>
To: Brandon Casey <bcasey@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 23:48:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCGG3-0003LK-Ky
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 23:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab3HUVr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 17:47:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab3HUVr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 17:47:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B7AF3BA1A;
	Wed, 21 Aug 2013 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W7CtAJIxcbUcqK1Wj9qLpHz1scA=; b=jObQsY
	w1yQhYeDPkcphG+9pkNMD/+ZuR/eJXGTn0879pAwjO2ENlvvnWui6LfB5IxdvO0V
	JN0UtBx9sEhPciDgE/2hfzJG5ZQ2w556GBpsP4kj67DjIjRPJ6Gc8grOVzqLXl5T
	7d3YpgTblsj9+LQSB1ZhSWb5mjdlX6Ef/6tyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sy02wR8PdMuZc2ue31NmaSMPxqS+UOSW
	eg5uUToclBEUyLseGhjp3/Sh5yfUHlLKDAeBFZDR+k7cMiOzXmBpQOyyYsISfkTi
	pPOHbVrVhiG/sKGD7tGVfjNFKLIuMtnEvsJnyzYoq9lhhAysdgaUr147SBlyH5nF
	ER4bXFMKHzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90DD03BA19;
	Wed, 21 Aug 2013 21:47:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBD1D3BA17;
	Wed, 21 Aug 2013 21:47:57 +0000 (UTC)
In-Reply-To: <1377118173-23405-3-git-send-email-bcasey@nvidia.com> (Brandon
	Casey's message of "Wed, 21 Aug 2013 13:49:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 57AB7CAE-0AAB-11E3-AEE2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232739>

Brandon Casey <bcasey@nvidia.com> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> This reverts commit 69a8141a5d81925b7e08cb228535e9ea4a7a02e3.
>
> Old Bash (3.0) which is distributed with RHEL 4.X and other ancient
> platforms that are still in wide use, does not have a printf that
> supports -v.  Let's revert this patch and go back to using printf
> in the traditional way.
>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---

Is this something you can detect at load-time once, store the result
in a private variable and then switch on it at runtime, something
along the lines of...


	# on load...
	printf -v __git_printf_supports_v -- "%s" yes >/dev/null 2>&1
        
	...

	if test "${__git_printf_supports_v}" = yes
        then
		printf -v gitstring -- "$printf_format" "$gitstring"
	else
		gitstring=$(printf -- "$printf_format" "$gitstring")
        fi


>  contrib/completion/git-prompt.sh | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index a81ef5a..7698ec4 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -433,11 +433,7 @@ __git_ps1 ()
>  	local gitstring="$c${b##refs/heads/}${f:+$z$f}$r$p"
>  
>  	if [ $pcmode = yes ]; then
> -		if [[ -n ${ZSH_VERSION-} ]]; then
> -			gitstring=$(printf -- "$printf_format" "$gitstring")
> -		else
> -			printf -v gitstring -- "$printf_format" "$gitstring"
> -		fi
> +		gitstring=$(printf -- "$printf_format" "$gitstring")
>  		PS1="$ps1pc_start$gitstring$ps1pc_end"
>  	else
>  		printf -- "$printf_format" "$gitstring"
