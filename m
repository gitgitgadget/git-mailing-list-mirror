From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 06/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Wed, 2 Sep 2015 06:57:48 +0530
Message-ID: <CAOLa=ZQQia58_9c+KDh9mZ_UdcpUn96yuPOdABYvs1gno04CmQ@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-7-git-send-email-Karthik.188@gmail.com> <xmqqa8t5rfng.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 03:28:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWwqp-0008G6-55
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 03:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbbIBB2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 21:28:20 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35904 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbbIBB2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 21:28:19 -0400
Received: by obqa2 with SMTP id a2so14710594obq.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 18:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5HCA16poMpDaKF2JC94nLQgL+PK1zzn+pOFJ/mIZWVY=;
        b=bV/rlEeUID0iQm3oMMhhkQoCUElXsMop85R7iuqQQnuAdF8qvFfneZ285Kc3zV263J
         5taoBqI50DPIvCIwXlxc0veDqlLQabna4cQEXJF61ojTUProQ0iGdGFTtUaOstPQA0FH
         bVQeUjYOCYBgbZpZjCT51xCy77kkkjyULoNENitITvjqRE689A5eM1Uk5Eso8jkRBDe0
         yvV+4vgwGc+YWG5rok78TQGqs3RK+SSoSCSOWbLKzAte10JnFSeo5/+AVMcOok+iaYrh
         jldrAdICmA6HQN1xd6oWdrCrIDnoU+lh1bizczJPSO61JR8GO7u73dmxrtaHSSLjMu7Z
         4bJA==
X-Received: by 10.182.196.101 with SMTP id il5mr8415077obc.41.1441157298258;
 Tue, 01 Sep 2015 18:28:18 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 1 Sep 2015 18:27:48 -0700 (PDT)
In-Reply-To: <xmqqa8t5rfng.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277073>

On Wed, Sep 2, 2015 at 3:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +     if (!filter->kind)
>>               die("filter_refs: invalid type");
>> +     else {
>> +             if (filter->kind == FILTER_REFS_BRANCHES)
>> +                     ret = for_each_fullref_in("refs/heads/", ref_filter_handler, &ref_cbdata, broken);
>> +             else if (filter->kind == FILTER_REFS_REMOTES)
>> +                     ret = for_each_fullref_in("refs/remotes/", ref_filter_handler, &ref_cbdata, broken);
>> +             else if (filter->kind == FILTER_REFS_TAGS)
>> +                     ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
>> +             else if (filter->kind & FILTER_REFS_ALL)
>> +                     ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata, broken);
>
> This if/else if/else if/ cascade and ...

Did you notice the "==" for others and "&" for the ALL?

>
>> +             if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
>> +                     head_ref(ref_filter_handler, &ref_cbdata);
>> +     }
>> +
>>
>>       /*  Filters that need revision walking */
>>       if (filter->merge_commit)
>> diff --git a/ref-filter.h b/ref-filter.h
>> index 45026d0..0913ba9 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -13,8 +13,15 @@
>>  #define QUOTE_PYTHON 4
>>  #define QUOTE_TCL 8
>>
>> -#define FILTER_REFS_INCLUDE_BROKEN 0x1
>> -#define FILTER_REFS_ALL 0x2
>> +#define FILTER_REFS_INCLUDE_BROKEN 0x0001
>> +#define FILTER_REFS_TAGS           0x0002
>> +#define FILTER_REFS_BRANCHES       0x0004
>> +#define FILTER_REFS_REMOTES        0x0008
>> +#define FILTER_REFS_OTHERS         0x0010
>
> ... the bit assignment here conceptually do not mesh well with each
> other.  These bits look as if I can ask for both tags and branches
> by passing 0x0006, and if the code above were
>
>         empty the result set;
>         if (filter->kind & FILTER_REFS_BRANCHES)
>                 add in things from refs/heads/ to the result set;
>         if (filter->kind & FILTER_REFS_TAGS)
>                 add in things from refs/tags/ to the result set;
>         ...
>
> without "else if", that would conceptually make sense.
>
> Alternatively, if the code does not (and will not ever) support such
> an arbitrary mixing of bits and intends to only allow "one of
> BRANCHES, REMOTES, TAGS or ALL, and no other choice", then it is
> wrong to pretend as if they can be mixed by defining the constant
> with values with non-overlapping bit patterns.  If you defined these
> constants as

Hmm, The code does support mixing if you see, whenever we mix and match
these bits (consider 0x0006) we satisfy the ` else if (filter->kind &
FILTER_REFS_ALL)`
condition. Which would then go through the entire set of refs and pick
only refs we
need using filter_ref_kind(). This may seem a little confusing but this avoids
ref type filtering when we do not mix bits up.

>
> #define FILTER_REFS_TAGS           100
> #define FILTER_REFS_BRANCHES       101
> #define FILTER_REFS_REMOTES        102
> #define FILTER_REFS_OTHERS         103
>
> then nobody would be think that the function can collect both tags
> and branches by passing FILTER_REFS_TAGS|FILTER_REFS_BRANCHES.
>
> The former, i.e. keep the bits distinct and allow them to be OR'ed
> together by updating the code to allow such callers, would be more
> preferrable, of course.
>

Just to confirm, I even changed the function call of for-each-ref to
    filter_refs(&array, &filter, FILTER_REFS_BRANCHES |
FILTER_REFS_TAGS | FILTER_REFS_INCLUDE_BROKEN);
and it printed only "refs/heads/" and "refs/tags/".
Thanks :)

-- 
Regards,
Karthik Nayak
