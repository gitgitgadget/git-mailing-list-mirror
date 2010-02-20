From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] git_mkstemps_mode: don't set errno to EINVAL for any
 error.
Date: Sat, 20 Feb 2010 10:13:12 -0800
Message-ID: <7v4olbpyh3.fsf@alter.siamese.dyndns.org>
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
 <1266621718-4879-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Feb 20 20:53:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NitpZ-000804-L3
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 19:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794Ab0BTSNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 13:13:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785Ab0BTSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 13:13:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38B889B167;
	Sat, 20 Feb 2010 13:13:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dwquhlxMZwZNs8P5o8gVJIjxufQ=; b=vjVMuC
	BvHQFcqtmm+ZrP61rKTtw+/dGjDpMjfQ+E5g/a5MXA71aro5ZWHaRTJg6a1KFSET
	WGhkkmrIuGkt5cN3OidRAeScozpiccHusPrbdIWglE47P79Q6J99PbitZcW3UMH4
	VE8DWeD4Rz3Mgtq5Bo7ovINKsgtrYsY9xwNKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FvoePP4sndku/cEx+wD3eD0TlL1VjXsL
	bVr9eE/URAQG1qmG2jN4RYf/3Cy9ENaDCdpbE2kTIgIwQQpOlmbiFnHQbK5ADotv
	qUXs6hdr/npZ/+TEhVH2dZkyA2Q2ndsTkaURRQwLLYVWc/5G/72vMJ1sGp+kobs0
	nP4YDKlVFcw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 109A69B166;
	Sat, 20 Feb 2010 13:13:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58D6A9B165; Sat, 20 Feb
 2010 13:13:14 -0500 (EST)
In-Reply-To: <1266621718-4879-5-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sat\, 20 Feb 2010 00\:21\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E399930-1E4B-11DF-B64E-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140546>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  path.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/path.c b/path.c
> index 005b836..2886eb6 100644
> --- a/path.c
> +++ b/path.c
> @@ -222,7 +222,9 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  	}
>  	/* We return the null string if we can't find a unique file name.  */
>  	pattern[0] = '\0';
> -	errno = EINVAL;
> +	/* Make sure errno signals an error on failure */
> +	if (errno <= 0)
> +		errno = EINVAL;
>  	return -1;
>  }

Please explain this change a bit better.

A successful call into system library does not have to clear errno (POSIX
even says "no function in ... POSIX ... shall set errno to 0"), and you do
not clear errno to zero anywhere in this function either, so it looks as
if you are reading an undefined errno and basing your action on that
result.

Because TMP_MAX is non-zero, you are always reading from errno left by
open() in the loop, so the above paragraph is a misunderstanding.  But
that needs to be in the log message, no?

I think you are trying to avoid stomping on the errno when we broke out of
the loop early, due to getting an error.  But errno is always valid at
this point in this codepath, and errno.h macros shall expand to integer
constant expressions with type int, distinct positive values.  So I think
you can safely remove the assignment without "if (errno <= 0)".  Returning
EINVAL from a variant of mkstemp when the error is anything but "The last
six characters were not XXXXXX" is wrong.
