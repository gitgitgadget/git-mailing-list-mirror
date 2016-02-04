From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] convert.c: simplify text_stat
Date: Thu, 04 Feb 2016 12:37:03 -0800
Message-ID: <xmqqh9hogqkw.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1454608200-5535-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Feb 04 21:37:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRQeQ-000090-0X
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 21:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbcBDUhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 15:37:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751411AbcBDUhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 15:37:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 95C144137C;
	Thu,  4 Feb 2016 15:37:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ksHxYDX1451PJY1eNaGxhwK5WVE=; b=LNLek/
	mq5QItykmVCnq5m0If5guIzZRl9OgXvCBDDPXa5GXwQVInLaMD4QNam1tgZPu6qH
	l3GywJSfl94FLFff897nGv9Zx2XmH3UAMb+z1kVogZkqpeGvw9RAciMdLy8aZm5I
	8R0xWX3aITiXG0+WFdKS3ydqksQCpa2uwUV7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QP5ZHNibrDvZpc5GVqyBcCvfoUXjEXqe
	2oKOyFsEo0deWuUnoKMUGHTr6o1laEU57j4jOJ9gZmFz+DgA+P1S/N1SFUqUuj9Q
	rMKb6mZrDrkL9Bj/0A6ZIhSTrqppfwzzCVLmz2ljj0OtiUjcZG1b1meAQ+6mBmod
	ExagusJiVuY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D7FE4137B;
	Thu,  4 Feb 2016 15:37:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F364841379;
	Thu,  4 Feb 2016 15:37:04 -0500 (EST)
In-Reply-To: <1454608200-5535-1-git-send-email-tboegi@web.de> (tboegi@web.de's
	message of "Thu, 4 Feb 2016 18:50:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D5CAE10-CB7F-11E5-B010-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285492>

tboegi@web.de writes:

>  static int convert_is_binary(unsigned long size, const struct text_stat *stats)
>  {
> -	if (stats->cr != stats->crlf)
> +	if (stats->lonecr)
>  		return 1;

This is an equivalent conversion, but...

> @@ -266,8 +267,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
>  
>  	check_safe_crlf(path, crlf_action, &stats, checksafe);
>  
> -	/* Optimization: No CR? Nothing to convert, regardless. */
> -	if (!stats.cr)
> +	/* Optimization: No CRLF? Nothing to convert, regardless. */
> +	if (!stats.crlf)
>  		return 0;

... this is not.  In fact this is even better, as we used to try the
remainder of the function when we saw a lone CR, but we no longer
do.  I am of course assuming that the original turned into a no-op
if we had a lone CR in the input--otherwise this patch changes the
behaviour.

However, I see this comment after the function returns with the
above optimization:

       /*
        * If we guessed, we already know we rejected a file with
        * lone CR, and we can strip a CR without looking at what
        * follow it.
        */

So the code around there used to have a reason to worry about a lone
CR (i.e. it didn't want to lose them).  With the change in this hunk
for the "optimization", it no longer is necessary to do so, i.e. we
know we do not have a lone CR so every CR can be stripped because it
must be followed by LF, isn't it?

But I do not see a matching change to simplify that here.  Am I
following the current code incorrectly or something?

Puzzled...

>  	/*
> @@ -315,21 +316,16 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
>  	gather_stats(src, len, &stats);
>  
>  	/* No LF? Nothing to convert, regardless. */
> -	if (!stats.lf)
> -		return 0;
> -
> -	/* Was it already in CRLF format? */
> -	if (stats.lf == stats.crlf)
> +	if (!stats.lonelf)

Doesn't the comment above need adjustment?

>  		return 0;

Otherwise, the output side looks correct to me.
