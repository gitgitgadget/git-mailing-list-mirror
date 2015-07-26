From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/10] ref-filter: add support to sort by version
Date: Sun, 26 Jul 2015 10:37:57 +0530
Message-ID: <CAOLa=ZQ89Vz82ro_V8mTgYKZ0UUgbsbAW6zgSgyiZ1gpwjTOHA@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-6-git-send-email-Karthik.188@gmail.com> <xmqqd1zfkgi3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJEAr-0003x4-OX
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbbGZFI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:08:27 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35528 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbbGZFI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:08:27 -0400
Received: by obbop1 with SMTP id op1so39457454obb.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=roaz3r50TPsMzkKiWofNdH/oJzwTMxjebo9WkcUXd/U=;
        b=x7dWYeX3mpz1YjeUFnttu8OfRcZbw3wLNzekigTQl+fUPOzs0Uhn2JSvKhFF1t0QrJ
         1NBkMkRRNBVxqFUw9+EXFXEGvOO2UZE7u1Kg4tQygveSU/preFJY4bJwn6A6ZF/H+t38
         P5k6SrkMFuR3RlAfaOxBhTOkxD4FWpxJMSMtcjZb79G/ItYOsgH1LMBL8hQHpZcMwQfG
         Ob9fxiW2ILMC5EcEgIO5Vni9i6xpjoxKBLtYcOV8pTqXKaS06YmS5Mp5VzQ0F8TLpt4F
         WjvkCbg0dnM/OCrnf2/Kj8SYi56HaLLdT91JYvHGr+wIxRFS4/865focvXL2MLM04zxm
         qryA==
X-Received: by 10.60.62.105 with SMTP id x9mr21543506oer.1.1437887306575; Sat,
 25 Jul 2015 22:08:26 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 25 Jul 2015 22:07:57 -0700 (PDT)
In-Reply-To: <xmqqd1zfkgi3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274632>

On Sun, Jul 26, 2015 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -1180,19 +1181,17 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
>>
>>       get_ref_atom_value(&state, a, s->atom, &va);
>>       get_ref_atom_value(&state, b, s->atom, &vb);
>> -     switch (cmp_type) {
>> -     case FIELD_STR:
>> +     if (s->version)
>> +             cmp = versioncmp(va->s, vb->s);
>> +     else if (cmp_type == FIELD_STR)
>>               cmp = strcmp(va->s, vb->s);
>> -             break;
>> -     default:
>> -             if (va->ul < vb->ul)
>> -                     cmp = -1;
>> -             else if (va->ul == vb->ul)
>> -                     cmp = 0;
>> -             else
>> -                     cmp = 1;
>> -             break;
>> -     }
>> +     else if (va->ul < vb->ul)
>> +             cmp = -1;
>> +     else if (va->ul == vb->ul)
>> +             cmp = 0;
>> +     else
>> +             cmp = 1;
>> +
>
> So there are generally three kinds of comparison possible:
>
>     - if it is to be compared as versions, do versioncmp
>     - if it is to be compared as strings, do strcmp
>     - if it is to be compared as numbers, do <=> but because
>       we are writing in C, not in Perl, do so as if/else/else
>
> Having understood that, the above is not really easy to read and
> extend.  We should structure the above more like this:
>
>         if (s->version)
>                 ... versioncmp
>         else if (... FIELD_STR)
>                 ... strcmp
>         else {
>                 if (a < b)
>                         ...
>                 else if (a == b)
>                         ...
>                 else
>                         ...
>         }
>
> so that it would be obvious how this code need to be updated
> when we need to add yet another kind of comparison.
>

I find the current version more pleasing to read, The way you've explained
it though, it seems that its better to structure it the way you've
mentioned as this
actually shows the code flow of the three kinds of comparison possible.

> Without looking at the callers, s->version looks like a misdesign
> that should be updated to use the same cmp_type mechanism?  That
> would lead to even more obvious construct that is easy to enhance,
> i.e.
>
>         switch (cmp_type) {
>         case CMP_VERSION:
>                 ...
>         case CMP_STRING:
>                 ...
>         case CMP_NUMBER:
>                 ...
>         }
>
> I dunno.
>
> Other than that (and the structure of that "format-state" stuff we
> discussed separately), the series was a pleasant read.
>
> Thanks.

That was the previous design, but Duy asked me to do this so
that we could support all atoms. And I agree with him on this.

http://article.gmane.org/gmane.comp.version-control.git/273888

-- 
Regards,
Karthik Nayak
