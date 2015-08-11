From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 02/10] branch: refactor width computation
Date: Tue, 11 Aug 2015 18:40:17 +0530
Message-ID: <CAOLa=ZQSm+YRHVUGxrKDLHaUu4jT82XSLaH-BBf-cL0KNNZ82A@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-2-git-send-email-Karthik.188@gmail.com> <CAPig+cRHvkAEM1ayVc5nj6RCih52x1+Bn9YTQPV93ej=3arK2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 15:10:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP9KP-0005vj-M7
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 15:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090AbbHKNKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 09:10:49 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35703 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754634AbbHKNKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 09:10:48 -0400
Received: by obbop1 with SMTP id op1so148048595obb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6N3GtosIY9hv7QQvMf47EupfIpdOWSZKbnyyeXW0fyY=;
        b=DWB0A3sfP/nhxqXTviW4xOJJLDs4gDZ6iCW+MnF8ZE0jCHVJohTez4iddy0ATG9q6F
         To5tyR7rYfwpwSrAaw/byCi+hNwRWmZ2+k1nHBTdol0DdVIYfrgRMF52wtCGNVQahi5D
         t5dU+dyEfLTnaBknDkxPJAkL4QFn6oQeLFWMkP8qY1xqN/ktx9/2he6WqO6bZV5zF8vu
         P6BS1iFwrqjbTKGIfz/iln7bsNzrxYpWNQ72hYPJBd/YQuvHti7OQbNsAF9jXhq3JX0R
         UW4Qyt52yTBVNAVmjk/j0Uxvh2oZOMeB+zHxD3QDftcZmrq2M68MDw+TpEJ1w5Mc5iEH
         80gw==
X-Received: by 10.60.65.68 with SMTP id v4mr16792956oes.84.1439298647564; Tue,
 11 Aug 2015 06:10:47 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 11 Aug 2015 06:10:17 -0700 (PDT)
In-Reply-To: <CAPig+cRHvkAEM1ayVc5nj6RCih52x1+Bn9YTQPV93ej=3arK2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275687>

On Tue, Aug 11, 2015 at 7:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Aug 4, 2015 at 9:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Remove unnecessary variables from ref_list and ref_item which were
>> used for width computation. This is to make ref_item similar to
>> ref-filter's ref_array_item. This will ensure a smooth port of
>> branch.c to use ref-filter APIs in further patches.
>>
>> Previously the maxwidth was computed when inserting the refs into the
>> ref_list. Now, we obtain the entire ref_list and then compute
>> maxwidth.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 4fc8beb..b058b74 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -557,16 +552,21 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
>> -static int calc_maxwidth(struct ref_list *refs)
>> +static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
>>  {
>> -       int i, w = 0;
>> +       int i, max = 0;
>>         for (i = 0; i < refs->index; i++) {
>> +               struct ref_item *it = &refs->list[i];
>> +               int w = utf8_strwidth(it->name);
>> +
>>                 if (refs->list[i].ignore)
>>                         continue;
>
> Nit: Unnecessary work. You compute the width and then immediately
> throw it away when 'ignore' is true.
>
> Also, you use 'it' elsewhere rather than 'refs->list[i]' but not this
> line, which makes it seem out of place. I would have expected to see:
>
>     if (it->ignore)
>         continue;
>
> (Despite the noisier diff, the end result will be more consistent.)
>

Ah right, will put that after the check :D

Yea, that seems out of place. Thanks

-- 
Regards,
Karthik Nayak
