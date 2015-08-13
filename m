From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Thu, 13 Aug 2015 16:21:29 +0530
Message-ID: <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-1-git-send-email-Karthik.188@gmail.com> <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 12:52:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPq7C-0001dw-TC
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 12:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbbHMKwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 06:52:01 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34860 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbHMKwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 06:52:00 -0400
Received: by obbop1 with SMTP id op1so34106578obb.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Gn7h6lt6dgdWTwofjDiv0vYI6LEiH8LIUAKDKKO5gA=;
        b=TJdP2c4RDg8YW9H+dTwS/qlsi5u26W/jEbqdUEhAcC88VAmwWbXMZufu/QZdDquYIB
         OwNyQjmRCy2GbT9OySVm3ovwZWhth6yai71gvgBxNF5ZBvTEoZi1j/EhN2Hxi50WU86i
         DWqVP2JcMGrs3SPlEvJGMLSlSsAbxdtZFIGurIVOnKrUeecqBrpYjJJEDAGiT30OwICw
         er7BZ/y+2oD+I+REpThr3FuaWyAJNt0S0uJGjJrJCrS4Nd5+h0mwzRbiLW9xsDIjUtRu
         dgTlEvXwObAmRkRwEk6BWFHpezCYHjsDZkw5uMh8ISlqjbOxZknruB83LOk4Plgi1alA
         PAsA==
X-Received: by 10.60.62.105 with SMTP id x9mr33801395oer.1.1439463119109; Thu,
 13 Aug 2015 03:51:59 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 13 Aug 2015 03:51:29 -0700 (PDT)
In-Reply-To: <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275841>

On Tue, Aug 11, 2015 at 11:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> Add an option in 'filter_refs()' to use 'for_each_branch_ref()'
>> and filter refs. This type checking is done by adding a
>> 'FILTER_REFS_BRANCHES' in 'ref-filter.h'.
>>
>> Add an option in 'ref_filter_handler()' to filter different
>> types of branches by calling 'filter_branch_kind()' which
>> checks for the type of branch needed.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  ref-filter.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>  ref-filter.h | 10 ++++++++--
>>  2 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index de84dd4..c573109 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -1044,6 +1044,46 @@ static const unsigned char *match_points_at(struct sha1_array *points_at,
>>       return NULL;
>>  }
>>
>> +/*
>> + * Checks if a given refname is a branch and returns the kind of
>> + * branch it is. If not a branch, 0 is returned.
>> + */
>> +static int filter_branch_kind(struct ref_filter *filter, const char *refname)
>> +{
>> +     int kind, i;
>> +
>> +     static struct {
>> +             const char *prefix;
>> +             int kind;
>
> Make a mental note that this is signed int.
>
>> +     } ref_kind[] = {
>> +             { "refs/heads/" , REF_LOCAL_BRANCH },
>> +             { "refs/remotes/" , REF_REMOTE_BRANCH },
>> +     };
>> +
>> +     /*  If no kind is specified, no need to filter */
>> +     if (!filter->branch_kind)
>> +             return REF_NO_BRANCH_FILTERING;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
>> +             if (starts_with(refname, ref_kind[i].prefix)) {
>> +                     kind = ref_kind[i].kind;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     if (ARRAY_SIZE(ref_kind) <= i) {
>> +             if (!strcmp(refname, "HEAD"))
>> +                     kind = REF_DETACHED_HEAD;
>> +             else
>> +                     return 0;
>> +     }
>> +
>> +     if ((filter->branch_kind & kind) == 0)
>> +             return 0;
>> +
>> +     return kind;
>> +}
>
> While this looks fine, I am not sure if this is a good interface for
> filtering, though.
>
> If you start from already having everything and want to limit things
> down to "refs/heads/", this might make sense but it would be far
> more efficient, if you know that you want to limit to "refs/heads/"
> upfront, not to collect everything but just limit the collection to
> those under "refs/heads/" without wasting cycles in the first place.
>

Yes, considering this and what you've said below about how the
bits don't make sense, I re-wrote filter_refs() to filter based on what we want
So this part will be removed entirely. Thanks for pointing me in the
right direction.

>> diff --git a/ref-filter.h b/ref-filter.h
>> index 5be3e35..b5a13e8 100644
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -16,6 +16,12 @@
>>  #define FILTER_REFS_INCLUDE_BROKEN 0x1
>>  #define FILTER_REFS_ALL 0x2
>>  #define FILTER_REFS_TAGS 0x4
>> +#define FILTER_REFS_BRANCHES 0x8
>
> Is this a sensible set of bits?  Does it make sense to have ALL and
> TAGS at the same time (and what does that mean?)?
>
>> +#define REF_DETACHED_HEAD   0x01
>> +#define REF_LOCAL_BRANCH    0x02
>> +#define REF_REMOTE_BRANCH   0x04
>> +#define REF_NO_BRANCH_FILTERING 0x08
>
> Where do these values go?  It is a returned by filter-branch-kind
> for each ref, i.e. given "refs/heads/bar", it answers "Yeah, that is
> a local branch".  Why are these values pretending to be a set of
> bits that can be combined together, as if a branch can be both LOCAL
> and REMOTE?  This does not make _any_ sense.
>

This was taken from branch.c, I thought of using an enum instead but that
would again require most of branch.c, hence it's been carried over
without changing
I'm thinking of changing it, any suggestions?

>
>>  #define ALIGN_LEFT 0x01
>>  #define ALIGN_RIGHT 0x02
>> @@ -50,7 +56,7 @@ struct ref_sorting {
>>
>>  struct ref_array_item {
>>       unsigned char objectname[20];
>> -     int flag;
>> +     int flag, kind;
>
> For readability, do not define multiple structure fields on a single
> line.
>
> If you are storing a set of bits in an integer, use unsigned.  If it
> is an enumeration, int is fine.
>

Thanks will change.

>>       const char *symref;
>>       struct commit *commit;
>>       struct atom_value *value;
>> @@ -76,7 +82,7 @@ struct ref_filter {
>>
>>       unsigned int with_commit_tag_algo : 1,
>>               match_as_path : 1;
>> -     unsigned int lines;
>> +     unsigned int lines, branch_kind;
>
> For readability, do not define multiple structure fields on a single
> line.
>
>>  };
>>
>>  struct ref_filter_cbdata {

Will do.

-- 
Regards,
Karthik Nayak
