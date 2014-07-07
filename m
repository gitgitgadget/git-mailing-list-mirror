From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase no longer omits local commits
Date: Mon, 07 Jul 2014 10:56:23 -0700
Message-ID: <xmqqbnt1dpdk.fsf@gitster.dls.corp.google.com>
References: <53B57352.50202@tedfelix.com>
	<20140703190917.GE13153@serenity.lan>
	<20140703222501.GF13153@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Felix <ted@tedfelix.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4D9X-0001qb-R9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbaGGR4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:56:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54151 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbaGGR4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:56:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDF0F2649B;
	Mon,  7 Jul 2014 13:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQ/TreJfgsSUpvgKu6ekHpcl258=; b=KRFyxk
	iRfxU4kVelBERbq011kbwc2bCPwvqua3TLglU/UIJOQjyuU064CjUT0oDY1i05sQ
	D2tJx8lRjewoJPYbnHXBMdvlbNup0GOWVucloWbdJPtFw04US9/9lKwagahsw9J3
	1FUfYmdBurgbfy7XaBiSLN0QRC7hWK/tSX8b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ir1GOH4EB6S3qWXRxxTnfzt4G0d3XZe9
	/xaupAk2pHDZoFW6LomEMkD5kzeHYWbnFanhV7Nsh3pCMfbjpNQ/RXoTgoGEZJvk
	3w7M7alymgdmDackiahdeuxNCS56GTd9l+Fz9CyBj2pGbBB80wRspLpYB+6AzCxu
	EEesRFktzuc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E409F2649A;
	Mon,  7 Jul 2014 13:56:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A43E126493;
	Mon,  7 Jul 2014 13:56:11 -0400 (EDT)
In-Reply-To: <20140703222501.GF13153@serenity.lan> (John Keeping's message of
	"Thu, 3 Jul 2014 23:25:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB2D7BCA-05FF-11E4-AC7E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252977>

John Keeping <john@keeping.me.uk> writes:

> Perhaps we shuld do something like this (which passes the test suite):
>
> -- >8 --
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 06c810b..0c6c5d3 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -544,7 +544,8 @@ if test "$fork_point" = t
>  then
>  	new_upstream=$(git merge-base --fork-point "$upstream_name" \
>  			"${switch_to:-HEAD}")
> -	if test -n "$new_upstream"
> +	if test -n "$new_upstream" &&
> +	   ! git merge-base --is-ancestor "$new_upstream" "$upstream_name"
>  	then
>  		upstream=$new_upstream
>  	fi
> -- 8< --
>
> Since the intent of `--fork-point` is to find the best starting point
> for the "$upstream...$orig_head" range, if the fork point is behind the
> new location of the upstream then should we leave the upstream as it
> was?

Probably; but the check to avoid giving worse fork-point should be
in the implementation of "merge-base --fork-point" itself, so that
we do not have to do the above to both "rebase" and "pull --rebase",
no?

> I haven't thought through this completely, but it seems like we should
> be doing a check like the above, at least when we're in
> "$fork_point=auto" mode.
