From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] mergetool--lib: remove use of $status global
Date: Fri, 21 Nov 2014 11:16:49 -0800
Message-ID: <xmqqsihcz7mm.fsf@gitster.dls.corp.google.com>
References: <1416532829-68662-1-git-send-email-davvid@gmail.com>
	<1416532829-68662-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 20:17:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrthV-0000Cl-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 20:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbaKUTQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 14:16:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751374AbaKUTQw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 14:16:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A41EA20C4C;
	Fri, 21 Nov 2014 14:16:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8qoeOVHWK4N1FKjYh0NMfIRGloc=; b=MinDg0
	Nv4/I3XEZ8xYWV/OAzdfpvbV8BTKbzDzXDER4ypPADzUqLyB7gZ96JLrt3oC/TAg
	UDciRNlYbu01BM4e4RUpiJyZT8A89Y4W2u2+B392Ql8gUeor04c0sF5f8Xk2Citg
	HUQHQIRcgQlz/TmUd4im1swc7Sy23dgKppIYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZRxse0b8amIwLNbXweyuzi8GT+Jy21W
	ThDST/T5AGGUBl3/yPFTjblacedU5NgqpBC22fyk3UF0bEKeZ230XHdWoDAUngI8
	9viJT7nk+7xAbpzMAzP5DivdLJmq+5a0Czpflh1jdK5CWqtMMakRL4lnDmUN3UQ/
	N4bu7j4pr/4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A1ED20C4B;
	Fri, 21 Nov 2014 14:16:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23C3620C4A;
	Fri, 21 Nov 2014 14:16:50 -0500 (EST)
In-Reply-To: <1416532829-68662-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Thu, 20 Nov 2014 17:20:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F1BAA0D0-71B2-11E4-A487-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Remove return statements and rework check_unchanged() so that the exit
> status from the last evaluated expression bubbles up to the callers.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 2b66351..fe61e89 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -92,7 +92,7 @@ translate_merge_tool_path () {
>  check_unchanged () {
>  	if test "$MERGED" -nt "$BACKUP"
>  	then
> -		status=0
> +		return 0
>  	else
>  		while true
>  		do
> @@ -100,8 +100,8 @@ check_unchanged () {
>  			printf "Was the merge successful? [y/n] "
>  			read answer || return 1
>  			case "$answer" in
> -			y*|Y*) status=0; break ;;
> -			n*|N*) status=1; break ;;
> +			y*|Y*) return 0 ;;
> +			n*|N*) return 1 ;;
>  			esac
>  		done
>  	fi

Note: The above left in the response not because I have any comment
on or objection to it but because it is relevant to the comment on
the next hunk.

> @@ -130,13 +128,10 @@ setup_user_tool () {
>  		then
>  			touch "$BACKUP"
>  			( eval $merge_tool_cmd )
> -			status=$?
>  			check_unchanged
>  		else
>  			( eval $merge_tool_cmd )
> -			status=$?
>  		fi
> -		return $status
>  	}
>  }

The caller of this funciton used to get the status from running
$merge_tool_cmd, but now it gets the result from check_unchanged.

Maybe that is more correct thing to report, but this does change the
behaviour, no?

    ... goes and looks ...

Ahh, the assignment to $status before running check_unchanged was not
doing anything useful, because check_unchanged stomped on $status
before it returned anyway.

So the net effect of this hunk to the caller's is unchanged.  It is
a bit tricky but the end result looks correct.
