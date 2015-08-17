From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 06/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Mon, 17 Aug 2015 20:16:43 +0530
Message-ID: <CAOLa=ZRqs4fWOn_5s18KbacYgV0ti5G1idXdEc4H5Hz0=p9UFA@mail.gmail.com>
References: <1439661643-16094-7-git-send-email-Karthik.188@gmail.com> <CAPig+cTZvSW8ZRLFLhmQTYBwotVjMWANZy0OAZHpA79vW8GfGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:47:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRLh0-0001xC-J7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 16:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbbHQOrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 10:47:14 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33959 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbHQOrN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 10:47:13 -0400
Received: by obbfr1 with SMTP id fr1so113850569obb.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F2/xJIXFEWmBGYYAJJdV5Oc0e68Uf4azXj+L6+UK/zI=;
        b=l9Ob6BYhYsrASHW9w239mTL1l3fXfwmrqv8Ik/u7cGy2UpMbttsOlxp3dcfpIvRpev
         g+SBrgNjmH8EDGwD//5aONYmImQ+IyOZhqimo6LMqvTJZYx+6yDltg4SxhROaR/soBVd
         FN+BvVp87PhfNzv0hnKldJk4GH/s1wJ7hSoJfA/OENg3G0SEwnhtKNLoqVng6GpIt5sr
         6ivwtWk1dnsWltbryEJXW2YHMpq/xxBVOJqTn4fz21OlfFEFInoi0eSYygShGBCNJIwX
         jo/6vE5f5GTOKnjbVS5V2Cjv9Z3h2SrAego7PFdrKfBzsl078fFn+Ddohx5R0+2mVwRK
         +vYA==
X-Received: by 10.60.42.230 with SMTP id r6mr1603857oel.9.1439822832821; Mon,
 17 Aug 2015 07:47:12 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 07:46:43 -0700 (PDT)
In-Reply-To: <CAPig+cTZvSW8ZRLFLhmQTYBwotVjMWANZy0OAZHpA79vW8GfGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276053>

On Mon, Aug 17, 2015 at 10:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add a function called 'for_each_reftype_fullpath()' to refs.{c,h}
>> which iterates through each ref for the given path without trimming
>> the path and also accounting for broken refs, if mentioned.
>>
>> Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
>> handled and return the kind to 'ref_filter_handler()', where we
>> discard refs which we do not need and assign the kind to needed refs.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> index eac99d0..abcd235 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1226,16 +1262,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>>  {
>>         struct ref_filter_cbdata ref_cbdata;
>>         int ret = 0;
>> +       unsigned int broken = 0;
>>
>>         ref_cbdata.array = array;
>>         ref_cbdata.filter = filter;
>>
>>         /*  Simple per-ref filtering */
>> -       if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
>> -               ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
>> -       else if (type & FILTER_REFS_ALL)
>> -               ret = for_each_ref(ref_filter_handler, &ref_cbdata);
>> -       else if (type)
>> +       if (type & FILTER_REFS_INCLUDE_BROKEN) {
>> +               type -= FILTER_REFS_INCLUDE_BROKEN;
>
> The above is a somewhat unusual way to say the more idiomatic:
>
>     type &= ~FILTER_REFS_INCLUDE_BROKEN;
>
> when dealing with bit flags. Is there precedence elsewhere in the
> project for choosing '-' over '~'?
>

I just preferred it this way, but will change it.

>> +               broken = 1;
>> +       }
>> +
>> +       filter->kind = type;
>> +       if (type == FILTER_REFS_BRANCHES)
>> +               ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
>> +       else if (type == FILTER_REFS_REMOTES)
>> +               ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
>> +       else if (type == FILTER_REFS_TAGS)
>> +               ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
>> +       else if (type & FILTER_REFS_ALL) {
>> +          e      ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
>
> These cases are all the same except for the (string) second argument,
> aren't they? This might be less noisy and easier to follow if you
> assign the appropriate string to a variable first, and then invoke
> for_each_reftype_fullpath() once with the string variable as an
> argument.
>

The problem is when we have FILTER_REFS_DETACHED_HEAD we need
to call head_ref() after collecting all other refs, this is because in
branch.c we
need to print the detached head first, hence it's inserted to the end of the
ref_array. Doing it the way you suggested would require to check FILTER_REFS_ALL
again after the first time for setting the string variable. I'd find
that a bit more
confusing.

>> +               if (type & FILTER_REFS_DETACHED_HEAD)
>> +                       head_ref(ref_filter_handler, &ref_cbdata);
>> +       } else
>>                 die("filter_refs: invalid type");
>>
>>         /*  Filters that need revision walking */
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 144a633..64fedd3 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -14,8 +14,14 @@
>> -#define FILTER_REFS_INCLUDE_BROKEN 0x1
>> -#define FILTER_REFS_ALL 0x2
>> +#define FILTER_REFS_INCLUDE_BROKEN 0x0001
>> +#define FILTER_REFS_TAGS           0x0002
>> +#define FILTER_REFS_BRANCHES       0x0004
>> +#define FILTER_REFS_REMOTES        0x0008
>> +#define FILTER_REFS_OTHERS         0x0010
>> +#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
>> +                                   FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
>> +#define FILTER_REFS_DETACHED_HEAD  0x0020
>
> I suppose there's some good reason that FILTER_REFS_DETACHED_HEAD is
> not a member of FILTER_REFS_ALL? Perhaps add a comment explaining it?
>
>> diff --git a/refs.c b/refs.c
>> index 2db2975..0f18c34 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2145,6 +2145,13 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>>                                strlen(git_replace_ref_base), 0, cb_data);
>>  }
>>
>> +int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
>> +{
>> +       if (broken)
>> +               broken = DO_FOR_EACH_INCLUDE_BROKEN;
>
> It's a bit ugly and confusing to have the same variable, 'broken', act
> as both a boolean input argument and as a bit flag argument to the
> called function.
>

Ill change that :)

-- 
Regards,
Karthik Nayak
