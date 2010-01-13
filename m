From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Wed, 13 Jan 2010 11:47:18 -0800
Message-ID: <7vwrzln5x5.fsf@alter.siamese.dyndns.org>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154153.GB24957@coredump.intra.peff.net>
 <7viqb6trwu.fsf@alter.siamese.dyndns.org>
 <20100113170636.GA21318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9Bl-0002J9-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab0AMTr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288Ab0AMTr3
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:47:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab0AMTr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:47:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03524909D6;
	Wed, 13 Jan 2010 14:47:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=C+GYtAfYs6ddo1XuiB1wmh1/omI=; b=eas6MYKQTA/L6T3lmoPbQAp
	eVWIfrp1Z4ZzNcN0D/Ms9bXvle8H9NBMKkwH+pMcpuLEeNw8b5JQS5xevZvWq2cz
	eR8KIpoxVzIaiz3gZUogKGf7WcMw/JqqpCXQaLuD7mmPmkSGXACILock0sZXRRxg
	55uJFMoCZ0zmttpaEtl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=gIga1AWNswXhVtjYxO+XKioodhaLei4MzGA9wOHsEx87NHbWQ
	2Fx1AYT0c3Z9CKLW+9xf+Z66x+w1N2VWJTnQ1Q+ismYa6q0R1BiYKQCyO/ehwxzM
	MnM8MfMMsllO7Pcm4DJ3eoM+kSVvYSG9y5OZ5q0dcw769NCQXyc/BI4GLE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4414909D3;
	Wed, 13 Jan 2010 14:47:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFAC7909CF; Wed, 13 Jan
 2010 14:47:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 783E45BA-007C-11DF-8153-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136863>

Jeff King <peff@peff.net> writes:

>>  (2) perhaps have assert(dst != src).  The loop won't terminate when
>>      called with src == dst, I think.
>
> Oops again. I think it is sensible to protect against this. I thought
> about trying to make it magically work in-place, but I don't think there
> is a simple way to do so.

As I said, I don't think appending p-quoted version of itself to a string
makes much sense, but I don't think in-place is too difficult.

	strbuf_addbuf_pquote(*dst, *src)
        {
		int len = src->len, i;
		for (i = 0; i < len; i++) {
			if (src->buf[i] == '%')
                        	strbuf_addch(dst, '%');
			strbuf_addch(dst, src->buf[i]);
		}
        }

>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -105,7 +105,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
>>  	strbuf_add(sb, s, strlen(s));
>>  }
>>  static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2) {
>> -	strbuf_add(sb, sb2->buf, sb2->len);
>> +	char *buf = sb2->buf;
>> +	int len = sb2->len;
>> +	if (sb->buf == sb2->buf) {
>> +		strbuf_grow(sb, len);
>> +		buf = sb->buf;
>> +	}
>> +	strbuf_add(sb, buf, len);
>>  }
>
> Shouldn't this be "if (sb == sb2)"? Two strbufs in the initial state
> will point to the same strbuf_slopbuf, but obviously growing sb will not
> impact sb2. Though that would simply provoke a false positive, which I
> don't think has any negative consequences.

Ok, that is a good catch.  And two strbufs that share the same allocated
string is a user error

> Also, since reallocating sb will reallocate sb2, can't you just write it
> safely like this:
>
>   strbuf_grow(sb, sb2->len);
>   strbuf_add(sb, sb2->buf, sb2->len);

I didn't want to worry about a semi-clever (read: broken) compilers doing
semi-clever things assuming sb and sb2 do not alias, but I agree that your
approach is much simpler.

Thanks.
