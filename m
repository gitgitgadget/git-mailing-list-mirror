From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] http: Add Accept-Language header if possible
Date: Wed, 03 Dec 2014 13:37:04 -0800
Message-ID: <xmqqppc0wh33.fsf@gitster.dls.corp.google.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
	<1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
	<1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
	<CAPig+cTsULQPxoaSQ-ZvjWJ9Rgpdf3zG7ObPg4TnxFbXT9TwnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yi EungJun <semtlenori@gmail.com>, Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHbq-0005Su-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbaLCVhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:37:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124AbaLCVhK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:37:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F13A23B29;
	Wed,  3 Dec 2014 16:37:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hZHpF3IbhT5ssCuXxeiMi3+SK4Y=; b=Zf56Ug
	WbuOrEn63HoG6C/cCBfWkaZbT4F+ZP1f0mmjpldm5id4TbbGNzlatETf1I7/D9Pj
	p1OsPE8n8JZZ0+ITEBWxrQhM0tOC2DK17uxHaQK7JF7IpXZth4gQquo3HkS/XLpH
	6KSATzWQUkYUJmNMuNL01l/FQ7VZR+6KSiFbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qw68k7AzuwDVaA7jsYLeP+Ly8ECIUiBF
	m3BWzL+ODmlSCxodn3my8iX6tHO9bFlHj4uULAEAYDmHZ5suZEGdglyIbOi7p8q4
	IpjI0TI7Dy+FQQXPn3pt2K1X6hn+cqp/IBcmMp6oik07tqt1j7UNmBjqs9QVsZGq
	BtQd1wfPDbU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78E5323B28;
	Wed,  3 Dec 2014 16:37:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D700C23B27;
	Wed,  3 Dec 2014 16:37:07 -0500 (EST)
In-Reply-To: <CAPig+cTsULQPxoaSQ-ZvjWJ9Rgpdf3zG7ObPg4TnxFbXT9TwnA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 3 Dec 2014 14:31:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8817494A-7B34-11E4-AB7D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260694>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -515,6 +517,9 @@ void http_cleanup(void)
>>                 cert_auth.password = NULL;
>>         }
>>         ssl_cert_password_required = 0;
>> +
>> +       if (cached_accept_language)
>> +               strbuf_release(cached_accept_language);
>
> Junio already mentioned that this is leaking the memory of the strbuf
> struct itself which was xmalloc()'d by get_accept_language().

I actually didn't ;-)  A singleton cached_accept_language strbuf
itself being kept around, with its reuse by get_accept_language(),
is fine and is not a leak.  But clearing the strbuf alone will
introduce correctness problem---the second HTTP connection will see
an empty strbuf, get_accept_language() will say "we've already
computed and the header we must issue is an empty string", which is
not correct.

In the fix-up "SQUASH???" commit I queued on top of this patch on
'pu', I had to run "sort -u" on the output to the standard error
stream, as there seemed to be two HTTP connections and the actual
output had two headers, even though the test expected only one in
the output.  I suspect that it is a fallout from this bug that the
original code passed that test that expects only one.

>> +static struct strbuf *get_accept_language(void)
>
> I find this API a bit strange. Use of strbuf to construct the returned
> string is an implementation detail of this function. From the caller's
> point of view, it should just be receiving a constant string: one
> which it needs neither to modify nor free. Also, if the caller were to
> modify the returned strbuf for some reason, then that modification
> would impact all future calls to get_accept_language() since the
> strbuf is 'static' and not recomputed. Instead, I would expect the
> declaration to be:
>
>     static const char *get_accept_language(void)

Makes sense to me.

>> +                       /* Put a q-factor only if it is less than 1.0. */
>> +                       if (q < max_q)
>> +                               strbuf_addf(cached_accept_language, q_format, q);
>> +
>> +                       if (q > 1)
>> +                               q--;

I didn't mention this but if q ever goes below 1, wouldn't it mean
that there is no point continuing this loop?
