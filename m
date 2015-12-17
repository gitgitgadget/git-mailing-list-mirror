From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 01/11] strbuf: introduce strbuf_split_str_without_term()
Date: Thu, 17 Dec 2015 13:54:04 +0530
Message-ID: <CAOLa=ZTDjo=eXWes1Ryzpj81gBoO7Lto3jEMGaeFioBfK_YOxA@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-2-git-send-email-Karthik.188@gmail.com> <CAPig+cQcCGVuzqYT3zXUMK=sF+QLCXUbbzcoqmaAe2zf+faWsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 09:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Trh-0003kl-3n
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 09:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbbLQIYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 03:24:36 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35308 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbbLQIYf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 03:24:35 -0500
Received: by mail-vk0-f50.google.com with SMTP id a189so42116014vkh.2
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 00:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LTXX8Zvqnyz6/pmEQ5enRNc0nhEtsuWCjjUTxPu661w=;
        b=wsJxO+CkC3IjT+nRRnCBb9P84ciIJ9fk+zMPB77GH0EddagnkIYL4bEKmy/ET0ZqRG
         BDzoEaiSTgAjGwV9x3hL9axzsalwbTckM1dMcGzCdbkn9fzlLkKyJecDp7PKqbGXSz38
         i91rstIkoz1pvD3DePTmG64/Vb93bLTlX9zvDgOM7vtGUmT5y/WITMYtOa3JmmKJxrdT
         57GUT6DfBNnjy59PPqmUMIPyadK9Isy6nu9CarwIAICpVrHczTvIKX/2hENi43VR6Cs5
         ZBnRhmqXzM0ZFduzakygSndmrnruNeb+HIxWfATtwvR2sNiw00sT/TXQ3voD8hDC5cAz
         7qOQ==
X-Received: by 10.31.155.23 with SMTP id d23mr33152111vke.146.1450340674410;
 Thu, 17 Dec 2015 00:24:34 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Thu, 17 Dec 2015 00:24:04 -0800 (PST)
In-Reply-To: <CAPig+cQcCGVuzqYT3zXUMK=sF+QLCXUbbzcoqmaAe2zf+faWsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282641>

On Thu, Dec 17, 2015 at 2:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> strbuf: introduce strbuf_split_str_without_term()
>
> s/without/omit/
>
>> The current implementation of 'strbuf_split_buf()' includes the
>> terminator at the end of each strbuf post splitting. Add an option
>> wherein we can drop the terminator if desired. In this context
>> introduce a wrapper function 'strbuf_split_str_without_term()' which
>
> s/without/omit/
>

Oops! will change that,

>> splits a given string into strbufs without including the terminator.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/strbuf.c b/strbuf.c
>> @@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
>>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>> -                                int terminator, int max)
>> +                                int terminator, int max, int omit_term)
>>  {
>>         struct strbuf **ret = NULL;
>>         size_t nr = 0, alloc = 0;
>> @@ -123,14 +123,15 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>>
>>         while (slen) {
>>                 int len = slen;
>> +               const char *end = NULL;
>>                 if (max <= 0 || nr + 1 < max) {
>> -                       const char *end = memchr(str, terminator, slen);
>> +                       end = memchr(str, terminator, slen);
>>                         if (end)
>>                                 len = end - str + 1;
>>                 }
>>                 t = xmalloc(sizeof(struct strbuf));
>>                 strbuf_init(t, len);
>> -               strbuf_add(t, str, len);
>> +               strbuf_add(t, str, len - !!end * !!omit_term);
>
> This version of the patch with its minimal[1] change is much easier to
> review for correctness than the original attempt[2].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/281882
> [2]: http://article.gmane.org/gmane.comp.version-control.git/281189
>
>>                 ALLOC_GROW(ret, nr + 2, alloc);
>>                 ret[nr++] = t;
>>                 str += len;
>> diff --git a/strbuf.h b/strbuf.h
>> index 6ae7a72..a865a74 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -450,11 +450,12 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
>>  /**
>>   * Split str (of length slen) at the specified terminator character.
>>   * Return a null-terminated array of pointers to strbuf objects
>> - * holding the substrings.  The substrings include the terminator,
>> - * except for the last substring, which might be unterminated if the
>> - * original string did not end with a terminator.  If max is positive,
>> - * then split the string into at most max substrings (with the last
>> - * substring containing everything following the (max-1)th terminator
>> + * holding the substrings.  The substrings include the terminator if
>> + * the value of omit_term is '0' else the terminator is excluded.  The
>
> Perhaps just say "if omit_term is false" rather than "if the value of ... is 0".
>
>> + * last substring, might be unterminated if the original string did
>> + * not end with a terminator.  If max is positive, then split the
>
> This bit about the last substring is perhaps too disconnected from the
> previous sentence. What if you re-word the entire thing something like
> this:
>
>     If omit_term is true, the terminator will be stripped from all
>     substrings. Otherwise, substrings will include the terminator,
>     except for the final substring, if the original string lacked a
>     terminator.
>

Im quite bad at this, thanks :)

>>
>> This version of the patch with its minimal[1] change is much easier to
>> review for correctness than the original attempt[2].
>
> Perhaps worthy of a Helped-by:?

Definitely! Sorry for not including that, slipped off my mind.

-- 
Regards,
Karthik Nayak
