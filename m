From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] sha1_name.c: don't waste cycles in the @-parsing loop
Date: Wed, 01 May 2013 17:04:58 -0700
Message-ID: <7vmwse2qmt.fsf@alter.siamese.dyndns.org>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-3-git-send-email-artagnon@gmail.com>
	<CAMP44s1j6GdQBjgCdBrG3xvXr_XifCTRZWJAQUrzts-MzFg--g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 02:05:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXh1H-0008ME-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 02:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab3EBAFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 20:05:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3EBAFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 20:05:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90712E17E;
	Thu,  2 May 2013 00:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6vewhFHfh4ZmPqyr5L/2W0GBuA=; b=g273lv
	tqBAxJlqf9RMozat3GqS+aH5D3Ooz8J4UNH6F2MSCyn/NasrRGSiIpBRO62uW0Nw
	a8DGhfjkIA4a3YPHpd1oQYqKFbmpNJeZDBTQDjrJIFQSoltDHQ517Ax+JT0H3iTG
	Tv0b/GjB9r5QxvF6Y5WKZMcZwEH68l/AhJ6OU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IsBnmMxHYDdAkSa7ulAK6Gc2Bw+aAjOJ
	ejJWdzL1WSU4P8U/5kAvr2odqM7huMPcobWiPLyYrXfzersrAWuABOEvKpsv6AUx
	N0s5y8cUTFsVkxMVUB57ER6kBxtNLHrvKvvrB2u0HZWd94lN+twcTGtCBeDjXNPP
	HK4AKFfyzpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87F32E17C;
	Thu,  2 May 2013 00:05:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9556E17A;
	Thu,  2 May 2013 00:04:59 +0000 (UTC)
In-Reply-To: <CAMP44s1j6GdQBjgCdBrG3xvXr_XifCTRZWJAQUrzts-MzFg--g@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 1 May 2013 12:57:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE21949A-B2BB-11E2-8918-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223168>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> The @-parsing loop unnecessarily checks for the sequence "@{" from
>> len - 2 unnecessarily.  We can safely check from len - 4: write out a
>> comment justifying this.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  sha1_name.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 3820f28..be1d12c 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -445,7 +445,23 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>         /* basic@{time or number or -number} format to query ref-log */
>>         reflog_len = at = 0;
>>         if (len && str[len-1] == '}') {
>> -               for (at = len-2; at >= 0; at--) {
>> +               /* str = @}
>> +                *       ^
>> +                *       len - 2; expression is senseless
>> +                *
>> +                * str = @{}
>> +                *       ^
>> +                *       len - 3; expression is still senseless
>> +                *
>> +                * str = @{.}
>> +                *       ^
>> +                *       len - 4 where . is any character; expression
>> +                *       is worth investigating
>> +                *
>> +                * Therefore, if str ends with }, search three
>> +                * characters earlier for @{
>> +                */
>
> I think this comment is overkill.
>
>> +               for (at = len - 4; at >= 0; at--) {
>
> The change seems OK to me, but there's no need to explain where you
> are starting, and if there's a need:
>
> /* start from where reflogs can start: @{.} */
>
> Does the trick nicely.

As the fact that nobody noticed nor bothered with the two-byte
optimization opportunity shows that this is trickier than trivial, I
agree with both of you that this change deserves an in-code comment.

    Start checking at len - 4, because there has to be at least one
    byte inside "@{.}" for it to be worth checking.

would be sufficient.  The 16-line comment is way overkill.

Not that I think this change really matters, though.

>>                         if (str[at] == '@' && str[at+1] == '{') {
>>                                 if (!upstream_mark(str + at, len - at)) {
>>                                         reflog_len = (len-1) - (at+2);
>> --
