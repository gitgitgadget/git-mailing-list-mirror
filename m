From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/19] reset.c: share call to die_if_unmerged_cache()
Date: Wed, 09 Jan 2013 11:48:30 -0800
Message-ID: <7vlic25e9d.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-9-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:48:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1du-0003ih-QF
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab3AITse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:48:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231Ab3AITsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:48:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E83ABD0E;
	Wed,  9 Jan 2013 14:48:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VMSMAWVxOhdCh3RmzkJcgiWG2do=; b=LY5IN3
	nWt/4GACNm2VOZCpC15WKxn/DaIQtc1WrN8cWljgvEKCMi0jBINETDUL0HXbyE+0
	Z1WRPHn2KXxW0cn1KVkSj1d29pfJbG+3+HI4Y5eUWhJ5IRMbFdBkCrbGi9+tdJL/
	EReA9wvmPheEqSIBeckyH8CWXibZYpAX5kG9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LNv3aVet7VtTqgKB3OdGCSHOeniFXXxt
	VKz96wlZnPdI/hM6uX1OWR2/rZfvlOmCoGdBzIbOnUKKd6q1dGpXz0/TALTQqt9K
	Q/jbjfh9U2VbMVEJTVFW52a47cL8QuvG02p4tpTLzGd40Y69ME6rqtUsI/LlZaik
	bmrbHFlHuCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92381BD0D;
	Wed,  9 Jan 2013 14:48:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9854BD08; Wed,  9 Jan 2013
 14:48:31 -0500 (EST)
In-Reply-To: <1357719376-16406-9-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Wed, 9 Jan 2013 00:16:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C04E38A-5A95-11E2-8502-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213088>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> Use a single condition to guard the call to die_if_unmerged_cache for
> both --soft and --keep. This avoids the small distraction of the
> precondition check from the logic following it.
>
> Also change an instance of
>
>   if (e)
>     err = err || f();
>
> to the almost as short, but clearer
>
>   if (e && !err)
>     err = f();
>
> (which is equivalent since we only care whether exit code is 0)

It is not just equivalent, but should give us identical result, even
if we cared the actual value.

And I tend to agree that the latter is more readable, especially
when f() can be longer, which is often the case in real life.

Happy to see this change.

> ---
>  builtin/reset.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4d556e7..42d1563 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -336,15 +336,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	/* Soft reset does not touch the index file nor the working tree
>  	 * at all, but requires them in a good order.  Other resets reset
>  	 * the index file to the tree object we are switching to. */
> -	if (reset_type == SOFT)
> +	if (reset_type == SOFT || reset_type == KEEP)
>  		die_if_unmerged_cache(reset_type);
> -	else {
> -		int err;
> -		if (reset_type == KEEP)
> -			die_if_unmerged_cache(reset_type);
> -		err = reset_index_file(sha1, reset_type, quiet);
> -		if (reset_type == KEEP)
> -			err = err || reset_index_file(sha1, MIXED, quiet);
> +
> +	if (reset_type != SOFT) {
> +		int err = reset_index_file(sha1, reset_type, quiet);
> +		if (reset_type == KEEP && !err)
> +			err = reset_index_file(sha1, MIXED, quiet);
>  		if (err)
>  			die(_("Could not reset index file to revision '%s'."), rev);
>  	}
