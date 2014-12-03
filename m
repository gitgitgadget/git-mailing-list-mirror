From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v5 1/1] http: Add Accept-Language header if possible
Date: Wed, 3 Dec 2014 14:00:17 -0800
Message-ID: <CAO2U3QgDzDTt-zujw1yk51HFdp4oACusXeZ59h-CUgU41vgDHw@mail.gmail.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
 <1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
 <1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
 <CAPig+cTsULQPxoaSQ-ZvjWJ9Rgpdf3zG7ObPg4TnxFbXT9TwnA@mail.gmail.com> <xmqqppc0wh33.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:00:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHyV-0003aU-JI
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbaLCWAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:00:40 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:49447 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbaLCWAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:00:39 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so1840940obc.6
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 14:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PjpWUljTyKqu/qF77X/TtLjMsxUcnCMSQJAGTCtObE4=;
        b=egusQ3Rju+qABHmpPNzGQxy1NLnTfuKAhibv+XOU8vDG7SbS74wd6Sa71B7EigaajZ
         selDemHJifIZIZCh5uEgW7d8ecdel3APMYFmBDbONanWJTFAK4LUdFR+GuPjjeK/4jKZ
         U8mHHUEzoXLNKp/UjNAdlR38+yHk/GqGaDFe+zLTwiA6XVVsVxHmYPiNnuPJZBpXKvQY
         ZRTqUAxEO87Xgtye8yr8i//+fVBXEIavhj1Uu9uJ+fhYK0RvrgHQPWuno5gYW52VfyPM
         H2UMQWo7iWCKQxynV3v3PLifkBkbXLiN87DcUHGZgNQilbhdax/CwE4b3EZFXlkAcSDa
         qLfQ==
X-Received: by 10.60.115.227 with SMTP id jr3mr4593099oeb.33.1417644039065;
 Wed, 03 Dec 2014 14:00:39 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Wed, 3 Dec 2014 14:00:17 -0800 (PST)
In-Reply-To: <xmqqppc0wh33.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260700>

On Wed, Dec 3, 2014 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> @@ -515,6 +517,9 @@ void http_cleanup(void)
>>>                 cert_auth.password = NULL;
>>>         }
>>>         ssl_cert_password_required = 0;
>>> +
>>> +       if (cached_accept_language)
>>> +               strbuf_release(cached_accept_language);
>>
>> Junio already mentioned that this is leaking the memory of the strbuf
>> struct itself which was xmalloc()'d by get_accept_language().
>
> I actually didn't ;-)  A singleton cached_accept_language strbuf
> itself being kept around, with its reuse by get_accept_language(),
> is fine and is not a leak.  But clearing the strbuf alone will
> introduce correctness problem---the second HTTP connection will see
> an empty strbuf, get_accept_language() will say "we've already
> computed and the header we must issue is an empty string", which is
> not correct.
>
> In the fix-up "SQUASH???" commit I queued on top of this patch on
> 'pu', I had to run "sort -u" on the output to the standard error
> stream, as there seemed to be two HTTP connections and the actual
> output had two headers, even though the test expected only one in
> the output.  I suspect that it is a fallout from this bug that the
> original code passed that test that expects only one.
>
>>> +static struct strbuf *get_accept_language(void)
>>
>> I find this API a bit strange. Use of strbuf to construct the returned
>> string is an implementation detail of this function. From the caller's
>> point of view, it should just be receiving a constant string: one
>> which it needs neither to modify nor free. Also, if the caller were to
>> modify the returned strbuf for some reason, then that modification
>> would impact all future calls to get_accept_language() since the
>> strbuf is 'static' and not recomputed. Instead, I would expect the
>> declaration to be:
>>
>>     static const char *get_accept_language(void)
>
> Makes sense to me.
>
>>> +                       /* Put a q-factor only if it is less than 1.0. */
>>> +                       if (q < max_q)
>>> +                               strbuf_addf(cached_accept_language, q_format, q);
>>> +
>>> +                       if (q > 1)
>>> +                               q--;
>
> I didn't mention this but if q ever goes below 1, wouldn't it mean
> that there is no point continuing this loop?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
This seems to be failing under Mac OS for me

not ok 25 - git client sends Accept-Language based on LANGUAGE,
LC_ALL, LC_MESSAGES and LANG
#
# check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8
en_US.UTF-8 &&
# check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8
en_US.UTF-8 &&
# check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8
en_US.UTF-8 &&
# check_language "en-US, *;q=0.1" ""          ""          ""
en_US.UTF-8
#
