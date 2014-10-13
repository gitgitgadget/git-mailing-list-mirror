From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetool: use more conservative temporary filenames
Date: Mon, 13 Oct 2014 12:30:57 -0700
Message-ID: <xmqqfver3gy6.fsf@gitster.dls.corp.google.com>
References: <1412929187-57936-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Sergio Ferrero <sferrero@ensoftcorp.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 21:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdlKk-0000Ub-0c
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 21:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbaJMTbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 15:31:01 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751998AbaJMTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 15:31:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB49316058;
	Mon, 13 Oct 2014 15:30:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MY7NZP+etWZRsiCPUU6KlFXMNek=; b=M96ah3
	6bTrNLm9ul6BVsn+SYax67U6JGQvbGtJV/AImD7PyMGZQ8EI9AqJ8aPcaAH6VSg6
	5MiSxXOedADZtANQUeVvjEOF89vqXqKCLh2M36OLglF+y8Mgsmd/2/K6vv3MZL4k
	Upn/1hVLP3YoM3ukM2b8s+9aBJwHwxdLWV0uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YXZWIME34MUFReSOlfnath3wDoHcpi1w
	eLuBzL9Q3RP1CBZUYS/IcyNQCKMnZLcpq/OvaxLKmwO+ohcucv3iCJ+5MX/GHuuc
	JzkoqeyAfJ0IGE0N4cgDdp3w+EzfW66lna5m9Ws01YkwskgGNok0eTEyrLBvPTjE
	8IxK4R2b874=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1D4A16057;
	Mon, 13 Oct 2014 15:30:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30DDE16056;
	Mon, 13 Oct 2014 15:30:58 -0400 (EDT)
In-Reply-To: <1412929187-57936-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 10 Oct 2014 01:19:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75186600-530F-11E4-9F77-855A93717476-77302942!pb-smtp1.pobox.com
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
> 	./foo/bar.ext.BASE.1234.ext
>
> This can be improved by having only a single .ext and using
> underscore instead of dot so that the extension cannot be
> misinterpreted.  The resulting path becomes:
>
> 	./foo/bar_BASE_1234.ext
>
> Suggested-by: Sergio Ferrero <sferrero@ensoftcorp.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Changes since v1
>
> The commit message changed to say "./foo" instead of "foo".
>
> The patch now uses Junio's suggestion to minimize variables,
> and preserves the original leading ./ just in case there are
> tools that rely on having ./ in front of relative paths.

;-)

Perhaps together with the "allow temporary directory" patch, we
would want to have a few tests for these changes?

>
>  git-mergetool.sh | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9a046b7..96a61ba 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -228,11 +228,17 @@ merge_file () {
>  		return 1
>  	fi
>  
> -	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
> -	BACKUP="./$MERGED.BACKUP.$ext"
> -	LOCAL="./$MERGED.LOCAL.$ext"
> -	REMOTE="./$MERGED.REMOTE.$ext"
> -	BASE="./$MERGED.BASE.$ext"
> +	if BASE=$(expr "$MERGED" : '\(.*\)\.[^/]*$')
> +	then
> +		ext=$(expr "$MERGED" : '.*\(\.[^/]*\)$')
> +	else
> +		BASE=$MERGED
> +		ext=
> +	fi
> +	BACKUP="./${BASE}_BACKUP_$$$ext"
> +	LOCAL="./${BASE}_LOCAL_$$$ext"
> +	REMOTE="./${BASE}_REMOTE_$$$ext"
> +	BASE="./${BASE}_BASE_$$$ext"
>  
>  	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
>  	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
