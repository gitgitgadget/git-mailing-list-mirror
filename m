From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_write: omit system call when length is zero
Date: Thu, 25 Feb 2016 17:40:48 -0800
Message-ID: <xmqqy4a8l04f.fsf@gitster.mtv.corp.google.com>
References: <1456439678-5433-1-git-send-email-sbeller@google.com>
	<CACsJy8DgjmdX681fRwB-JajPBRN+cNy=jFwEDW6D-dXhNi=_6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 02:40:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7Oq-00013o-IP
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 02:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbcBZBkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 20:40:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752822AbcBZBkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 20:40:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3EBA48B55;
	Thu, 25 Feb 2016 20:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rAIFilCAk5W1S1peKQ08xJqifq4=; b=SleQjZ
	4e2oSZRG2wCyaN+atTFbJrWEjtHSdbhzyUWWRhivj4MzlFv6rLthrHuRYo4bt5wf
	hCqx8YwnSmRpL7K48Uc27DuSQ1BZ63UsmgEi/mo+fqyNWFOWmOSjoNKQ0PTQKlsQ
	K///N3B/HydSB712RYXx1unkt2529zy/g+iQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yG8XaROfW74qFD2WoAAdMXzW+cz/dYC3
	didVwrNA5RdSUBUEpFo1uLjss2PsJhpJvCHyZsgYcK5cACXIWwnX0TBuSJY4isDi
	YrkejcvjE3YrjjNH6wsz+ASSDuLkQZ2xhg6V4uKpy5S7dVKBnYcvUWFP+W4o9S+L
	QD9zLafC46U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98BFD48B54;
	Thu, 25 Feb 2016 20:40:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 148E848B52;
	Thu, 25 Feb 2016 20:40:50 -0500 (EST)
In-Reply-To: <CACsJy8DgjmdX681fRwB-JajPBRN+cNy=jFwEDW6D-dXhNi=_6g@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 26 Feb 2016 07:47:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F713B2E6-DC29-11E5-8831-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287511>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 26, 2016 at 5:34 AM, Stefan Beller <sbeller@google.com> wrote:
>> In case the length of the buffer is zero, we do not need to call the
>> fwrite system call as a performance improvement.
>
> fwrite is a libc call, not system call. Are you sure it always calls
> write() (assuming buffering is off)?

I do not think so, but I suspect that the patch misstates its
rationale (I said I get uncomfortable every time I see a function
that takes size and nelem separately used by a caller that can
potentially pass nleme=0, when I wondered it it is OK that no caller
of this funtion checks its return value).


>
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  This applies on top of v17 for origin/sb/submodule-parallel-update.
>>
>>  In case there are other reasons for origin/sb/submodule-parallel-update
>>  to need a reroll I'll squash it in. But as this is a pure performance
>>  optimization in a case we are not running into with that series and that
>>  series is clashing with Davids refs backend series, I figure we may not
>>  want to have a reroll for this fix alone.
>>
>>  Thanks,
>>  Stefan
>>
>>
>>  strbuf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index 71345cd..5f6da82 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -397,7 +397,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
>>
>>  ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>>  {
>> -       return fwrite(sb->buf, 1, sb->len, f);
>> +       return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
>>  }
>>
>>
>> --
>> 2.7.2.374.ga5f0819.dirty
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
