From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: use more conservative temporary filenames
Date: Thu, 09 Oct 2014 11:36:00 -0700
Message-ID: <xmqq8ukp6qgf.fsf@gitster.dls.corp.google.com>
References: <1412758562-25402-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 20:36:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcIZP-0003wX-8p
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 20:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbaJISgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 14:36:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751639AbaJISgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 14:36:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3693C14002;
	Thu,  9 Oct 2014 14:36:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CDc+drI7UxWWIECb8kLAL8pTl0Q=; b=pLpwcy
	kGKHoYY76941Hh9yP+xByJ9qKfD6W/LCbPJovXCFnYA9l4fpZPenKA0uxeX8hYLd
	sLszUtII0fsTeN6NSXt7etbLoUrG2Ba1TU/NfyVCNlLnnCduz09LfFOEu4OGW1Gt
	67FA9k2xrEeGEOYegMdzQ+jT/Um1HDl61OK/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PsSlXwCscQbv68fpBqZ3PNKmPxbfa4Fc
	uU9dtP3BFTLfnW28eywBHNw/tGY8zIuK6365QU3MpTXE8LzJMWUweFEPWKmjhKYL
	va2d3bAJa7SPPsbHR5reZyKFjh2K+h3O8kVAy3Gc6uvJbO+KFv+F7AtdfjQMC8Gp
	vx/K0CIxItE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DECE14001;
	Thu,  9 Oct 2014 14:36:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCD7513FFE;
	Thu,  9 Oct 2014 14:36:01 -0400 (EDT)
In-Reply-To: <1412758562-25402-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 8 Oct 2014 01:56:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E9E9C74-4FE3-11E4-862C-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Avoid filenames with multiple dots so that overly-picky tools do
> not misinterpret their extension.
>
> Previously, foo/bar.ext in the worktree would result in e.g.
>
> 	foo/bar.ext.BASE.1234.ext
>
> This can be improved by having only a single .ext and using
> underscore instead of dot so that the extension cannot be
> misinterpreted.  The resulting path becomes:
>
> 	foo/bar_BASE_1234.ext
>
> Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool.sh | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9a046b7..1f33051 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -228,11 +228,15 @@ merge_file () {
>  		return 1
>  	fi
>  
> -	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
> -	BACKUP="./$MERGED.BACKUP.$ext"
> -	LOCAL="./$MERGED.LOCAL.$ext"
> -	REMOTE="./$MERGED.REMOTE.$ext"
> -	BASE="./$MERGED.BASE.$ext"
> +	ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> +	base=$(basename "$MERGED" "$ext")
> +	dir=$(dirname "$MERGED")
> +	suffix="$$""$ext"
> +
> +	BACKUP="$dir/$base"_BACKUP_"$suffix"
> +	BASE="$dir/$base"_BASE_"$suffix"
> +	LOCAL="$dir/$base"_LOCAL_"$suffix"
> +	REMOTE="$dir/$base"_REMOTE_"$suffix"

We used to feed "./foo/bar.ext.BASE.1234.ext"; with this patch we
feed "foo/bar_BASE_1234.ext".  

It does make this particular example look prettier, but is the
droppage of "./" intentional and is free of unintended ill side
effects?

We avoid "local" and bash-isms, so I'd prefer to see us not to
introduce new temporary variables unnecessarily.  I think we can at
least do without basename/dirname in this case, perhaps like so:

	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
        then
        	ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
	else
        	ext= BASE=$MERGED
	fi
        BACKUP="${BASE}_BACKUP_$$$ext"
        LOCAL="${BASE}_LOCAL_$$$ext"
        REMOTE="${BASE}_REMOTE_$$$ext"
        BASE="${BASE}_BASE_$$$ext"
        
But I do not have very strong opinion either way.  I just didn't
want to have to think about the leading "./" ;-)
