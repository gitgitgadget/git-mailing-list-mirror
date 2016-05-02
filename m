From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/41] usage.c: move format processing out of die_errno()
Date: Mon, 02 May 2016 11:26:02 -0700
Message-ID: <xmqqlh3stiyt.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462101297-8610-2-git-send-email-pclouds@gmail.com>
	<CAPig+cQhQ2C-gOuQwJ9RBXM7HBBJkWORfRkq-t-PY=vvxgAonA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:26:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axIXs-0004Qt-ER
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbcEBS0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 14:26:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754781AbcEBS0G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 14:26:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E918216A8C;
	Mon,  2 May 2016 14:26:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QRGknIifYD6D
	x5Acsn8OoVOpsSU=; b=b2I9CBQKBKRTSw6AvwnW3ohKEMBobS9MiNSPVK7YF4Nh
	NsciUMuJe86QVACaGYaESTAJPNG0uhYs6RYdsojsstAgnb9yvh7cbxczHheS3JlU
	sUH3OU1nuhRbi9l2nhjCGUMboz7Fdzsl+KCS0H4i0slGyh2PAKoqFRj0JOzgtOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K4qhTJ
	xiRfB0PQ9SbCmWtgiza9AMhduWEwSg3BmWfALJa/YSIO3lgOWflS1nkA0kDoMGLY
	TwqQI4RN65FUEP6l/HkiCG/9x/ozoQ3ZsOXkbVmYdpMEwvjesxgkStuO82S7uCzg
	0zrDnmB30MN0XUA1h+7eq0/LzchMPj5MWGriQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E014116A8A;
	Mon,  2 May 2016 14:26:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DE5016A89;
	Mon,  2 May 2016 14:26:04 -0400 (EDT)
In-Reply-To: <CAPig+cQhQ2C-gOuQwJ9RBXM7HBBJkWORfRkq-t-PY=vvxgAonA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 1 May 2016 14:23:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5461C6DE-1093-11E6-AB31-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293263>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> fmt_with_err() will be shared with the coming error_errno() and
>> warning_errno().
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/usage.c b/usage.c
>> @@ -109,19 +109,12 @@ void NORETURN die(const char *err, ...)
>> -void NORETURN die_errno(const char *fmt, ...)
>> +static const char *fmt_with_err(const char *fmt)
>>  {
>> -       va_list params;
>> -       char fmt_with_err[1024];
>> +       static char fmt_with_err[1024];
>
> Rather than this static buffer, did you consider having the caller
> pass in the buffer?
>
>     static const char *fmt_with_err(char *buf, size_t n, const char *=
fmt)
>     {
>         ...
>         snprintf(buf, n, "%s: %s", fmt, str_error);
>         return buf;
>     }
>
>     void die_errno(const char *fmt, ...)
>     {
>         char fmtbuf[1024];
>         ...
>         die_routine(fmt_with_err(fmtbuf, sizeof(fmtbuf), fmt),
>             params);
>         ...
>     }
>
> Better? Worse? Indifferent?

Caller supplied buffer would be the way to go when multiple threads
could be showing errors and warnings, right?

It would not make too much of a difference for die(), though.
