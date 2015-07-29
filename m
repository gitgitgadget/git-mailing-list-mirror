From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Thu, 30 Jul 2015 01:08:37 +0530
Message-ID: <CAOLa=ZQRWK2c45H7RuFaJSiYuuOBXT5PK__nhWPmA333yGTWyw@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
 <CAP8UFD3L4QEYQMCda7AbByXGZcvgy5r9y0LMBqEysb6AZ+ydOQ@mail.gmail.com>
 <vpqa8ugwfyf.fsf@anie.imag.fr> <CAOLa=ZTXSutXd4HCrXoVoLT0kQzppiC7gUJpnk8DYYCo7M5XNw@mail.gmail.com>
 <vpq7fpjmg35.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:39:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKXC5-0006RI-7w
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbbG2TjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:39:08 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36639 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbbG2TjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:39:07 -0400
Received: by oibn4 with SMTP id n4so10767500oib.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C7wrAdx8i9dV2m7tK2seJTQI95gHorhFNLK6BlwVxvc=;
        b=0C38m3eJs6t7d8Qqlb3guApC1m0TNW11fdsUU7Y5aFQ5sNh54TVqyv1zHyPRCBcg2q
         Silkk+ji0mvZAXM33VotdU+sIt8PcFB1i8Ir74wyBRRHovzRuOEslLUcxguLjsfOSgdM
         MkiGP/epLdCyG2WyuRd+TyHtRcjUmA3aFa6MwxSs3yxK83J4ojLeBf8Q9miaTLqOUVSW
         oZqYrHrZFbfi4N5AHGG5XS+yRO4aE26BL3wVt6Xly7unMEAkITKEktCxZr5Cs3UjR5hg
         ET5L7pJJayQeDQC759/55xsze06Q4jS1awv01IPnzyG6FQXifmri6PVq7QPVZB2HpEr1
         sJKw==
X-Received: by 10.202.186.132 with SMTP id k126mr40617505oif.60.1438198746500;
 Wed, 29 Jul 2015 12:39:06 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 29 Jul 2015 12:38:37 -0700 (PDT)
In-Reply-To: <vpq7fpjmg35.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274945>

On Wed, Jul 29, 2015 at 3:38 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Tue, Jul 28, 2015 at 7:18 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>
>>>>> +static void ref_array_append(struct ref_array *array, const char *refname)
>>>>> +{
>>>>> +       size_t len = strlen(refname);
>>>>> +       struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item) + len + 1);
>>>>> +       memcpy(ref->refname, refname, len);
>>>>> +       ref->refname[len] = '\0';
>>>
>>> This looks very much like new_ref_array_item, except that the later also
>>> takes an objectname parameter. I find it suspicious that you leave the
>>> objectname field uninitialized.
>>>
>>
>> Well the objectname is not required here, the idea is to retain the way branch.c
>> works.
>>
>>> Why is this code not calling new_ref_array_item?
>>>
>>
>> Because no objectname is there.
>
> You do have the object_id in the scope of the call-site, so why not use
> it?
>
> (Well, in any case, do as you think is best, it's temporary throw-away
> code, we shouldn't loose too much time polishing it)
>

Also the fact the new_ref_array_item() is static and not shared. Wouldn't make
sense to make it an API only for a single commit, when the code itself
is temporary.

>>> The function disapears in the next commit, but I also think that this
>>> function deserves to exist in ref-filter.{c,h} and remain after the end
>>> of the series.
>>>
>>
>> Why though? I don't see the need when new_ref_array_item() is present.
>
> OK, if the function is specificly for "append an item but leave the
> objectname uninitialized", it's too specific to be useful somewhere
> else. But then, make it more explicit in the name of the function and/or
> in a comment.
>

Will add a comment :)

-- 
Regards,
Karthik Nayak
