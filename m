From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 4/9] ref-filter: add support to sort by version
Date: Mon, 20 Jul 2015 22:04:57 +0530
Message-ID: <CAOLa=ZR8d37s4rHuDuASzb_YEs-UBRN0AiY2scEJQe+jFdGxEA@mail.gmail.com>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
 <1437246749-14423-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRkwy_Dq3oYgHdNH6naaUDHZ_6DPopec1EG3aNwz56rzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 18:35:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHE2R-00061f-7k
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 18:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409AbbGTQf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 12:35:28 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35251 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112AbbGTQf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 12:35:27 -0400
Received: by oihq81 with SMTP id q81so112396873oih.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 09:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JuTBXqliWf3S9vE42X0Sqd8VcctDL6H/QnYeCguvEGo=;
        b=dopBkdltyma9Fl0L/fV3eFdAP59XgIu9tUsUUI4QBisXqmTbsNdczS1TkFCHYDnLI/
         6fNKQUpseXkeXz63DTFmMUihB7izFUCva2OKwbPwmmnozoHQN8wyBBQ0rytXZ1PVQU2z
         /ofo2Tn4Rwi1L1M+F1GVh3WgNbvluZdwQ3pzdWpVTGoDZ2Grfi8sMjYE56yLZaN6zAA8
         ovRoTDEkYqSJbyCCSQaBiK6GMLjyKU6HPpym/tcXlwg7uxMrCW7ieEbe6vOD2o3GHhly
         j52rSP/08sqJzB0Guw7CHASGvv+iFkwMhIfZDBR4gpkShlpDgHt2+q+FpL0eUXd9eeH3
         14hw==
X-Received: by 10.202.92.6 with SMTP id q6mr25780398oib.11.1437410126612; Mon,
 20 Jul 2015 09:35:26 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 20 Jul 2015 09:34:57 -0700 (PDT)
In-Reply-To: <CAPig+cRkwy_Dq3oYgHdNH6naaUDHZ_6DPopec1EG3aNwz56rzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274329>

On Mon, Jul 20, 2015 at 7:09 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> To agree with the actual code: s/version_cmp/versioncmp/
>

Yeah! will change.

>
> Assuming I'm a reader without prior knowledge, the first question
> which pops into my mind is "what's the difference between
> 'version:refname' and 'v:refname'?" Is one just shorthand for the
> other, or is there some subtle difference in behavior, or what? The
> documentation should explain this better.
>

Will include more explanation.

> Also, why are there parentheses around 'version:refname' or
> 'v:refname'? And, you should use backticks rather than apostrophes, as
> is done with the other field names.
>

Wanted to show that they are the same command. Seems confusing now that
you mentioned, will change it.

>>  In any case, a field name that refers to a field inapplicable to
>>  the object referred by the ref does not cause an error.  It
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 82731ac..85c561e 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1169,18 +1170,22 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>>
>>         get_ref_atom_value(a, s->atom, &va);
>>         get_ref_atom_value(b, s->atom, &vb);
>> -       switch (cmp_type) {
>> -       case FIELD_STR:
>> -               cmp = strcmp(va->s, vb->s);
>> -               break;
>> -       default:
>> -               if (va->ul < vb->ul)
>> -                       cmp = -1;
>> -               else if (va->ul == vb->ul)
>> -                       cmp = 0;
>> -               else
>> -                       cmp = 1;
>> -               break;
>> +       if (s->version)
>> +               cmp = versioncmp(va->s, vb->s);
>> +       else {
>> +               switch (cmp_type) {
>> +               case FIELD_STR:
>> +                       cmp = strcmp(va->s, vb->s);
>> +                       break;
>> +               default:
>> +                       if (va->ul < vb->ul)
>> +                               cmp = -1;
>> +                       else if (va->ul == vb->ul)
>> +                               cmp = 0;
>> +                       else
>> +                               cmp = 1;
>> +                       break;
>> +               }
>
> The logic might be slightly easier to follow, and give a much less
> noisy diff if you rewrite it like this instead:
>
>     if (s->version)
>         cmp = versioncmp(va->s, vb->s);
>     else if (cmp_type == FIELD_STR)
>         cmp = strcmp(va->s, vb->s);
>     else {
>         if (va->ul < vb->ul)
>             cmp = -1;
>         else if (va->ul == vb->ul)
>             cmp = 0;
>         else
>             cmp = 1;
>     }
>
> Or, if you don't mind a noisy diff, you can outdent the other branches, as well:
>
>     if (s->version)
>        cmp = versioncmp(va->s, vb->s);
>     else if (cmp_type == FIELD_STR)
>        cmp = strcmp(va->s, vb->s);
>     else if (va->ul < vb->ul)
>        cmp = -1;
>     else if (va->ul == vb->ul)
>        cmp = 0;
>     else
>        cmp = 1;
>
> (I rather prefer the latter, despite the noisy diff.)
>

Err! just didn't want to existing code. Your latter code usage seems
easier and simpler to follow. Will use that thanks :D

>>         }
>>         return (s->reverse) ? -cmp : cmp;
>>  }
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 7dfdea0..6f1646b 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -25,7 +25,7 @@ struct atom_value {
>>  struct ref_sorting {
>>         struct ref_sorting *next;
>>         int atom; /* index into used_atom array (internal) */
>> -       unsigned reverse : 1;
>> +       unsigned reverse : 1, version : 1;
>
> This is difficult to read. Style elsewhere (if I'm not mistaken) is to
> place the declaration on a line by itself.
>

Yes just checked, thats the style. Thank you.

>>  };
>>
>>  struct ref_array_item {
>> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
>> index 505a360..c31fd2f 100755
>> --- a/t/t6302-for-each-ref-filter.sh
>> +++ b/t/t6302-for-each-ref-filter.sh
>> @@ -81,4 +81,30 @@ test_expect_success 'filtering with --contains' '
>>         test_cmp expect actual
>>  '
>>
>> +test_expect_success 'version sort' '
>> +       git tag -l --sort=version:refname | grep "foo" >actual &&
>> +       cat >expect <<-\EOF &&
>> +       foo1.3
>> +       foo1.6
>> +       foo1.10
>> +       EOF
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'reverse version sort' '
>> +       git tag -l --sort=-version:refname | grep "foo" >actual &&
>
> Maybe use 'v:refname' in one of these tests in order to exercise that
> alias as well?
>

The idea was to only include a minimal test as t7004 has tests for the same,
but I guess a minimal test for 'v:refname' is also required.

-- 
Regards,
Karthik Nayak
