From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Wed, 28 Jan 2015 20:59:28 +0900
Message-ID: <CAFT+Tg9Pkv1m-Lq-gs-N1t5OEqqVACEj_LP=x8PkcJ6afQ3nYg@mail.gmail.com>
References: <xmqq7fwfuu62.fsf@gitster.dls.corp.google.com>
	<1422373918-14132-1-git-send-email-eungjun.yi@navercorp.com>
	<1422373918-14132-2-git-send-email-eungjun.yi@navercorp.com>
	<xmqqwq47iyrn.fsf@gitster.dls.corp.google.com>
	<CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGeDi-0004R1-7V
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197AbbA2Bs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:48:28 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:51944 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbbA2Bs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:48:26 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so22363789qgd.11
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 17:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6I2tZkM2wA0AY1CifySAr8W4cXGK6GjOZqad6SdmlIs=;
        b=U158oI8aztfkmgjKJmI/kG5A8tEGJMY5IX6xf++eFR9bINQQ2oFWUQd2/CGc4YpVzt
         25oHfkoNciOBk8mu0NQDFmP0ps9kg0eCXaAqSbatFP1+UX8Cn8dF7R5GVEpE9NsCMTXE
         fgyxyp9OQfhkVsI211x6JsigN7h4BXyoeA7MDh69cMRMiOXm0GYKbkz7p/q6ytXj6tZJ
         MXmyP0LSs2rk6j9jDxwCRZeP7YiYLjt88N94YCuOYACjBw4C5m9chkyPqhz1S4rf/N0V
         /NxT1xT0IRFtihPQk0q1t5eb4qvZ60PKm6ewHwl7nSWuSTs+bEQBBjbdrzN6prZfIaL1
         efCg==
X-Received: by 10.140.33.162 with SMTP id j31mr11822665qgj.10.1422446369034;
 Wed, 28 Jan 2015 03:59:29 -0800 (PST)
Received: by 10.140.95.19 with HTTP; Wed, 28 Jan 2015 03:59:28 -0800 (PST)
In-Reply-To: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263130>

I agree that a list of char* is enough for language_tags.

Thanks for your review and patch. I'll apply your patch and send v9.

On Wed, Jan 28, 2015 at 3:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, Jan 27, 2015 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Yi EungJun <semtlenori@gmail.com> writes:
>>
>>> +
>>> +             sprintf(q_format, ";q=0.%%0%dd", decimal_places);
>>> +
>>> +             strbuf_addstr(buf, "Accept-Language: ");
>>> +
>>> +             for(i = 0; i < num_langs; i++) {
>>> +                     if (i > 0)
>>> +                             strbuf_addstr(buf, ", ");
>>> +
>>> +                     strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
>>
>> This is not wrong per-se, but it looks somewhat convoluted to me.
>> ...
>
> Actually, this is wrong, isn't it?
>
> strbuf_detach() removes the language_tags[i].buf from the strbuf,
> and the caller now owns that piece of memory. Then strbuf_addstr()
> appends a copy of that string to buf, and the piece of memory
> that was originally held by language_tags[i].buf is now lost forever.
>
> This is leaking.
>
>>> +     /* free language tags */
>>> +     for(i = 0; i < num_langs; i++) {
>>> +             strbuf_release(&language_tags[i]);
>>> +     }
>
> ... because this loop does not free memory for earlier parts of language_tags[].
>
>> I am wondering if using strbuf for each of the language_tags[] is
>> even necessary.  How about doing it this way instead?
>
> And I think my counter-proposal does not leak (as it does not us strbuf for
> language_tags[] anymore).
>
>>
>>  http.c | 22 +++++++++-------------
>>  1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/http.c b/http.c
>> index 6111c6a..db591b3 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1027,7 +1027,7 @@ static void write_accept_language(struct strbuf *buf)
>>         const int MAX_DECIMAL_PLACES = 3;
>>         const int MAX_LANGUAGE_TAGS = 1000;
>>         const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
>> -       struct strbuf *language_tags = NULL;
>> +       char **language_tags = NULL;
>>         int num_langs = 0;
>>         const char *s = get_preferred_languages();
>>         int i;
>> @@ -1053,9 +1053,7 @@ static void write_accept_language(struct strbuf *buf)
>>                 if (tag.len) {
>>                         num_langs++;
>>                         REALLOC_ARRAY(language_tags, num_langs);
>> -                       strbuf_init(&language_tags[num_langs - 1], 0);
>> -                       strbuf_swap(&tag, &language_tags[num_langs - 1]);
>> -
>> +                       language_tags[num_langs - 1] = strbuf_detach(&tag, NULL);
>>                         if (num_langs >= MAX_LANGUAGE_TAGS - 1) /* -1 for '*' */
>>                                 break;
>>                 }
>> @@ -1070,13 +1068,12 @@ static void write_accept_language(struct strbuf *buf)
>>
>>                 /* add '*' */
>>                 REALLOC_ARRAY(language_tags, num_langs + 1);
>> -               strbuf_init(&language_tags[num_langs], 0);
>> -               strbuf_addstr(&language_tags[num_langs++], "*");
>> +               language_tags[num_langs++] = "*"; /* it's OK; this won't be freed */
>>
>>                 /* compute decimal_places */
>>                 for (max_q = 1, decimal_places = 0;
>> -                               max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
>> -                               decimal_places++, max_q *= 10)
>> +                    max_q < num_langs && decimal_places <= MAX_DECIMAL_PLACES;
>> +                    decimal_places++, max_q *= 10)
>>                         ;
>>
>>                 sprintf(q_format, ";q=0.%%0%dd", decimal_places);
>> @@ -1087,7 +1084,7 @@ static void write_accept_language(struct strbuf *buf)
>>                         if (i > 0)
>>                                 strbuf_addstr(buf, ", ");
>>
>> -                       strbuf_addstr(buf, strbuf_detach(&language_tags[i], NULL));
>> +                       strbuf_addstr(buf, language_tags[i]);
>>
>>                         if (i > 0)
>>                                 strbuf_addf(buf, q_format, max_q - i);
>> @@ -1101,10 +1098,9 @@ static void write_accept_language(struct strbuf *buf)
>>                 }
>>         }
>>
>> -       /* free language tags */
>> -       for(i = 0; i < num_langs; i++) {
>> -               strbuf_release(&language_tags[i]);
>> -       }
>> +       /* free language tags -- last one is a static '*' */
>> +       for(i = 0; i < num_langs - 1; i++)
>> +               free(language_tags[i]);
>>         free(language_tags);
>>  }
>>
