From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Wed, 03 Dec 2014 14:40:35 -0800
Message-ID: <xmqq388wwe58.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051016.GK6527@google.com>
	<xmqqbnnkwgpg.fsf@gitster.dls.corp.google.com>
	<20141203215918.GF6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:40:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwIbD-0001qU-RE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaLCWkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:40:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751270AbaLCWkj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:40:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 28CAB2474F;
	Wed,  3 Dec 2014 17:40:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lfdtmuEGBCFfkGJX9ckakA2B6IY=; b=piI8B4
	3wpDvmPqWWPpp2oTanLTL05eVhtOsHmRy9xaW1fV6aaPhD+uUtpcgrUlVnI31sIc
	1k7v4D5nMhzV22oNIkEPmcoBBAc0z+jFDPYiPQ55bn4GEO57g+tbzOIJ7w/DkVOr
	y1EW5cbW45gJOuVipAa+aghYIRtH3zHjYvh3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rsmGBMBFfK/qXuvhAhTpu3JDsuqWvAfO
	fQ9IKieFDuMJUBDFckdM8Oi/47izLXykQNy18cTotq4nIOJcTZgu5lve5jBgMqPO
	zW1pNsRs/9Ez3OL/SU6U4BKBdVZaXTB4Y5ymAG7NVgpaxs9s8iP3eWZjnbZLmzDv
	Rf1jYdvXzMo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 138F72474E;
	Wed,  3 Dec 2014 17:40:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88BCD2474B;
	Wed,  3 Dec 2014 17:40:36 -0500 (EST)
In-Reply-To: <20141203215918.GF6527@google.com> (Jonathan Nieder's message of
	"Wed, 3 Dec 2014 13:59:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6631D2A6-7B3D-11E4-AC0F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260705>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> +void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
>>> +{
>>> +	va_list ap;
>>> +	size_t pos, len;
>>> +
>>> +	pos = sb->len;
>>> +
>>> +	va_start(ap, fmt);
>>> +	strbuf_vaddf(sb, fmt, ap);
>>> +	va_end(ap);
>>> +
>>> +	len = sb->len - pos;
>>> +	strbuf_insert(sb, 0, sb->buf + pos, len);
>>> +	strbuf_remove(sb, pos + len, len);
>>> +}
>>
>> This indeed is strange to read; it would be more straightforward to
>> use a second strbuf for temporary storage you need to do this,
>> instead of using the tail-end of the original strbuf and shuffling
>> bytes around.
>
> I could do that.  It's less efficient but if the prevailing sentiment
> is that it's worth it then I don't mind.
>
> Would adding a comment to the implementation of strbuf_prefixf help?

Perhaps.

The reason why it felt strange to me was primarily because this was
a short-hand way of writing something like this in the caller:

	if (transaction_commit(&t, err)) {
		struct strbuf scratch = STRBUF_INIT;
		strbuf_addf(&scratch, "cannot fetch '%s': ", remotename);
		strbuf_splice(err, 0, 0, sctach.buf, scratch.len);
                strbuf_reset(&scratch);
	}

Coming from that point of view, it looked strange not to be using a
separate scratch area; that's all.
