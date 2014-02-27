From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rewrite skip_prefix() as loop
Date: Thu, 27 Feb 2014 11:34:38 -0800
Message-ID: <xmqqha7kz6wh.fsf@gitster.dls.corp.google.com>
References: <1393502562-28025-1-git-send-email-faizkothari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6jG-0002xX-2l
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbaB0Tem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:34:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbaB0Tel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:34:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE6887054E;
	Thu, 27 Feb 2014 14:34:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6xYPfv1I5xQekShJTphHGlI6WVc=; b=mxLfz/
	q2bU5y9hAlc1brromZJC1wCYl0IZrIK2nN/9U4KUy3XwWq5VV0tkzw3KC1sbmPB3
	1zDtLk8lcphQuMqWeuixQVD6+Z70qGBjpcZoIv9/6R7l6UPa0Sp0xyp32KMHDTum
	rzZFTQsLS6eNYIaKL5yLhATOGo5llootvlzB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DWFDsHZQKGCmUoC0Lk+ApGMZSk8mUSr1
	d7ENFb6BvsF3acfn0medoKZLTmsm9IhMMwwToSnbh0t0QrFoxpyN0VhOtDyKPF2T
	wXy4lLV1B3VxEW04/D/F3wSbp5PdE1zU3ZiG6D9RPbu+nFTdhZgV0BlUOAH9kRLl
	FKR3NH24YYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFD9A7054C;
	Thu, 27 Feb 2014 14:34:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D71757054B;
	Thu, 27 Feb 2014 14:34:39 -0500 (EST)
In-Reply-To: <1393502562-28025-1-git-send-email-faizkothari@gmail.com> (Faiz
	Kothari's message of "Thu, 27 Feb 2014 17:32:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 330AD9BE-9FE6-11E3-8D56-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242840>

Faiz Kothari <faiz.off93@gmail.com> writes:

> From: Faiz Kothari <faiz.off93@gmail.com>

Notice that this matches From: in your e-mail message, which means
it is unnecessary.  Drop it.

>
>
> Signed-off-by: Faiz Kothari <django@dj-pc.(none)>

And make sure this matches how you call yourself above.

> ---
>  git-compat-util.h |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cbd86c3..bb2582a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
>  
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) ? NULL : str + len;
> +	for (; ; str++, prefix++)
> +		if (!*prefix)
> +			return str;//code same as strbuf.c:starts_with()

Drop that comment.  As already has been pointed out, say that in the
proposed commit log message, perhaps like this:

	Subject: skip_prefix(): rewrite as a loop

	Instead of letting strlen() to scan the prefix once and then
        strncmp() to scan it again, rewrite it as a single loop,
        using the logic similar to starts_with() in strbuf.c.

	Signed-off-by: ...

> +		else if (*str != *prefix)
> +			return NULL;
>  }

This for() loop that does not have a loop-control condition looks a
bit weird, though.  If we were to use for() that is not "for (;;)",
it would be more natural to write something like this:

	for (; *prefix && *str == *prefix; prefix++, str++)
		; /* keep going while they match */
	... decide what to return here ...

but that would make you check *prefix/*str twice for the final
round, so it is not very optimal.  If we want to say "the loop is
endless and we exit explicitly from inside with our own logic", then

	while (1) {
		... what you have inside the loop ...
		prefix++;
                str++;
        }

would be easier on the eyes (you can do s/while (1)/for (;;)/, too).

Thanks.
