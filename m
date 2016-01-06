From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 01/15] strbuf: introduce strbuf_split_str_omit_term()
Date: Wed, 6 Jan 2016 12:57:52 +0530
Message-ID: <CAOLa=ZTKiGM1XLr7UuNVX_e_qN4RAGfvOh6daaxcOeZ9xa2TdA@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-2-git-send-email-Karthik.188@gmail.com> <xmqq7fjnkexv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 08:28:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGiWB-0001TJ-4L
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 08:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbcAFH2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 02:28:24 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34465 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbcAFH2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 02:28:23 -0500
Received: by mail-vk0-f44.google.com with SMTP id a123so121008167vkh.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 23:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9l+vsnIxcefKjTDOOatiTflekj0a7ysv1ODIQGE4kBY=;
        b=nrXZGd7O3+d4gRzziJQO9Qv/OZgnRZHMWoq4USI9iXOLUenG8Y7a8xJRSBlQ3i0cdV
         gu898+zhPxwsHkSl2a5j63hvJxzmxklngLzxmYe1eYl6gzfA/YD9cJ4ZCuNithmcH602
         j4veS6cGmBVoZAGT5tXK8Z3hGmNLK3luxqc1Dt6nzGlvbvmZjhfi2zJ5xdKfyQhcFcDM
         Ti/FCX9FWVMUnZs8AeG4KuNNsyKZZ0I837g7po9v3u7fIu5EBmn4ESH4LOEaH94DIBHa
         pHiSO6juRc1nMX0iRw05W9O2l1bq3b9sb9RUU/ywYBzwME1hhH8lVd1IbMMT9uqe023I
         CTkw==
X-Received: by 10.31.142.16 with SMTP id q16mr66637980vkd.95.1452065302297;
 Tue, 05 Jan 2016 23:28:22 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 5 Jan 2016 23:27:52 -0800 (PST)
In-Reply-To: <xmqq7fjnkexv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283418>

On Wed, Jan 6, 2016 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The current implementation of 'strbuf_split_buf()' includes the
>> terminator at the end of each strbuf post splitting. Add an option
>> wherein we can drop the terminator if desired. In this context
>> introduce a wrapper function 'strbuf_split_str_omit_term()' which
>> splits a given string into strbufs without including the terminator.
>>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  strbuf.c |  7 ++++---
>>  strbuf.h | 25 ++++++++++++++++---------
>>  2 files changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index b552a13..b62508e 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
>>  }
>>
>>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>> -                              int terminator, int max)
>> +                              int terminator, int max, int omit_term)
>>  {
>>       struct strbuf **ret = NULL;
>>       size_t nr = 0, alloc = 0;
>> @@ -123,14 +123,15 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>>
>>       while (slen) {
>>               int len = slen;
>> +             const char *end = NULL;
>>               if (max <= 0 || nr + 1 < max) {
>> -                     const char *end = memchr(str, terminator, slen);
>> +                     end = memchr(str, terminator, slen);
>>                       if (end)
>>                               len = end - str + 1;
>>               }
>>               t = xmalloc(sizeof(struct strbuf));
>>               strbuf_init(t, len);
>> -             strbuf_add(t, str, len);
>> +             strbuf_add(t, str, len - !!end * !!omit_term);
>
> You initialize with "len" but sometimes copy less than that, which
> looks somewhat sloppy.
>
> Maybe I am old-fashioned, but use of a multiplication when you do
> not mean to numerically multiply but merely to perform a logical
> operation made me go "Huh?".
>
> Perhaps using another variable would make it easier to follow?
> Either using a boolean that tells us that the terminating byte
> is to be omitted, i.e.
>
>         int len = slen;
>         int omit = 0;
>         if ( ... we are still splitting ... ) {
>                 const char *end = memchr(...);
>                 if (end) {
>                         len = end - str + 1;
>                         omit = !!omit_term;
>                 }
>         }
>         strbuf_init(t, len - omit);
>         strbuf_add(t, str, len - omit);
>
> or an integer "copylen" that tells us how many bytes to copy, which
> often is the same as "len" but sometimes different by 1 byte?

This is done based on Eric's suggestion [1]. Although its a little off normal
convention. I find it small and simple. So I'm okay with either, your suggested
change or the existing code.

[1]: http://article.gmane.org/gmane.comp.version-control.git/281882

-- 
Regards,
Karthik Nayak
