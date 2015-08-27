From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 05/12] ref-filter: add option to filter out tags,
 branches and remotes
Date: Thu, 27 Aug 2015 21:05:08 +0530
Message-ID: <CAOLa=ZS3_sSaMjkSchdQGE1s5bgg00DPWe=F+KsUdjQt=opDyg@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <1440214788-1309-6-git-send-email-Karthik.188@gmail.com> <55DDE4DB.2070504@alum.mit.edu>
 <CAOLa=ZQh0MNwjAOLameh1f22LB=JyD7=FeROzDRikpoRXse7cw@mail.gmail.com> <55DF2BA1.2020107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:35:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUzDL-0006d9-39
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 17:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbbH0Pfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 11:35:39 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34341 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbbH0Pfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 11:35:38 -0400
Received: by oiex83 with SMTP id x83so13610894oie.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JYXTIllBb8v75t26pkct6lnT/6fPJ3GuSBU0tM3abZ8=;
        b=ZpLehXJxwcPe8kAEH/6y5XlCW3Ii3moRl9y2HTS+LgW78V2ZmwLcwGBG6l9T0Xd2Ii
         KZbMcjF86ORUea7HGy9wgbOCPxQmJYIJyYH2vEJzBp+uU/UWIi8YEbal++s+45zJNDeg
         EXrWFUrA3r96uVIq6Wi6LPxeHU5mC3Jo+XliucnLYarx8H3TreGPN2uivAgrDPuHK/Et
         BuFKXHSHnQiVs/iHa9S7+XpQNfRaY24YBn4ptEexp6ejayv4ek8ILPrw0upkA3fP/FfL
         1GOkt1yH3/VTSkdIraj0SNDD6i79giwyfmR5aH8PaL0jC9GeWLFvVkbWhzURnhy4DSwV
         pmfw==
X-Received: by 10.202.105.133 with SMTP id e127mr2831492oic.60.1440689737638;
 Thu, 27 Aug 2015 08:35:37 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 27 Aug 2015 08:35:08 -0700 (PDT)
In-Reply-To: <55DF2BA1.2020107@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276677>

On Thu, Aug 27, 2015 at 8:54 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/27/2015 02:42 PM, Karthik Nayak wrote:
>> On Wed, Aug 26, 2015 at 9:40 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On 08/22/2015 05:39 AM, Karthik Nayak wrote:
>>>> [...]
>>>> +     if (type == FILTER_REFS_BRANCHES)
>>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
>>>> +     else if (type == FILTER_REFS_REMOTES)
>>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
>>>> +     else if (type == FILTER_REFS_TAGS)
>>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
>>>> +     else if (type & FILTER_REFS_ALL) {
>>>> +             ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
>>>> +             if (type & FILTER_REFS_DETACHED_HEAD)
>>>> +                     head_ref(ref_filter_handler, &ref_cbdata);
>>>
>>> The usual promise of the for_each_ref functions is that they stop
>>> iterating if the function ever returns a nonzero value. So the above
>>> should be
>>>
>>>                 if (! ret && (type & FILTER_REFS_DETACHED_HEAD))
>>>                         ret = head_ref(ref_filter_handler, &ref_cbdata);
>>>
>>> Also, these functions usually iterate in lexicographic order, so I think
>>> you should process HEAD before the others.
>>
>> This is done on purpose, cause we need to print the HEAD ref separately
>> so we print the last ref_array_item in the ref_array, free that memory and
>> sort and print the rest, hence HEAD ref is attached to the last.
>
> Without having looked at the other patches, this makes me wonder whether
> it makes sense to store HEAD in the ref_array at all or whether it
> should be handled separately.
>

Well then we'd need another ref_array just for that, that also could
be an option.
But apart from printing it first, everything else is the same for all the refs.

>>> But there's another problem here. It seems like
>>> FILTER_REFS_DETACHED_HEAD is only processed if (type & FILTER_REFS_ALL)
>>> is nonzero. But shouldn't it be allowed to process *only* HEAD?
>>>
>>> So, finally, I think this code should look like
>>>
>>>         else if (!filter->kind)
>>>                 die("filter_refs: invalid type");
>>>         else {
>>>                 if (filter->kind & FILTER_REFS_DETACHED_HEAD)
>>>                         ret = head_ref(ref_filter_handler, &ref_cbdata);
>>>                 if (! ret && (filter->kind & FILTER_REFS_ALL))
>>>                         ret =
>>> for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
>>>         }
>>>
>>
>> So finally something like this perhaps
>>
>>     if (!filter->kind)
>>         die("filter_refs: invalid type");
>>     else {
>>         if (filter->kind == FILTER_REFS_BRANCHES)
>>             ret = for_each_reftype_fullpath(ref_filter_handler,
>> "refs/heads/", broken, &ref_cbdata);
>>         else if (filter->kind == FILTER_REFS_REMOTES)
>>             ret = for_each_reftype_fullpath(ref_filter_handler,
>> "refs/remotes/", broken, &ref_cbdata);
>>         else if (filter->kind == FILTER_REFS_TAGS)
>>             ret = for_each_reftype_fullpath(ref_filter_handler,
>> "refs/tags/", broken, &ref_cbdata);
>>         else if (filter->kind & FILTER_REFS_ALL)
>>             ret = for_each_reftype_fullpath(ref_filter_handler, "",
>> broken, &ref_cbdata);
>>         if (filter->kind & FILTER_REFS_DETACHED_HEAD)
>>             head_ref(ref_filter_handler, &ref_cbdata);
>>     }
>
> Yes, but the last test should be
>
>         if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
>
> unless you have a reason not to follow the usual convention that a
> nonzero return value from fn means that the iteration should be aborted.
>

No, of course, I missed that while typing here.

-- 
Regards,
Karthik Nayak
