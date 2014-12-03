From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Wed, 03 Dec 2014 13:45:15 -0800
Message-ID: <xmqqbnnkwgpg.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051016.GK6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:45:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHjh-0002bp-Cy
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbaLCVpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:45:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030AbaLCVpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:45:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C77023D2B;
	Wed,  3 Dec 2014 16:45:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=UqTiHgWgW9QZcJS3i7Tbdwlx9S4=; b=QVGhux8qTZcfwDvp6cbt
	M/2z9Io3Z4SuSBxcHanNPwEGEohW2zwn+YYypu8C45MMquM+7C40U/ssLqi8gXkt
	OWwrI+8rmQTP2vHZryv7k7YqRx7Mq2hg+THtgs1vLJNg+BDcU7nRmvptA1ah0nvv
	w4Nz8vtFr1QVvyFlCr47N+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=M52sYOMomTmK87TEfiy6Fq4aSu5VGXIIlO2j7l0ALWbmGQ
	SXfOnbawwJjsqQrwsvGi4ltS+LSgaa9WsRgAVNIASeSDHECIoJlNWQNlusautN3t
	d+cOtJrcv2HkgjS+YKa/thkSNY8lYtjK6lV/THDbfqNetIpA2hmOwl3CX7A5s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92B2B23D2A;
	Wed,  3 Dec 2014 16:45:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2C0823D1E;
	Wed,  3 Dec 2014 16:45:16 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB950CF8-7B35-11E4-BEF7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260697>

Jonathan Nieder <jrnieder@gmail.com> writes:

> When preparing an error message in a strbuf, it can be convenient
> to add a formatted string to the beginning:
>
> 	if (transaction_commit(&t, err)) {
> 		strbuf_prefixf(err, "cannot fetch '%s': ", remotename);
> 		return -1;
> 	}

I am somewhat unhappy with this justification, as it is not very
clear why "cannot fetch '%s': " must come at the beginning without
knowing what kind of string transaction_commit() is expected to add
to err when it is called.  It could be a sign that the convention
for transaction_commit() to report its errors is screwed up, and
not a sign that prefixf is necessary (not that I think that is the
case---there is not enough explanation here to decide).

> +void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
> +{
> +	va_list ap;
> +	size_t pos, len;
> +
> +	pos = sb->len;
> +
> +	va_start(ap, fmt);
> +	strbuf_vaddf(sb, fmt, ap);
> +	va_end(ap);
> +
> +	len = sb->len - pos;
> +	strbuf_insert(sb, 0, sb->buf + pos, len);
> +	strbuf_remove(sb, pos + len, len);
> +}

This indeed is strange to read; it would be more straightforward to
use a second strbuf for temporary storage you need to do this,
instead of using the tail-end of the original strbuf and shuffling
bytes around.

In any case, instead of this:

	struct strbuf tc_err = STRBUF_INIT;
        if (transaction_commit(&t, &tc_err)) {
		strbuf_addf(err, "cannot fetch '%s': %s", remotename, 
			tc_err.buf);        
		strbuf_release(&tc_err);
		return -1;
	}	                

you can use the four-line version you cited above, which might be an
improvement.  I dunno if it is such a big deal, though.
