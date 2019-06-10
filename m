Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E53C41F462
	for <e@80x24.org>; Mon, 10 Jun 2019 14:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbfFJOXO (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 10:23:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:40121 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390708AbfFJOXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 10:23:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7436A3F484A;
        Mon, 10 Jun 2019 10:23:13 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:7414:a9f:53d2:2961] (unknown [IPv6:2001:4898:a800:1010:254a:a9f:53d2:2961])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D1A043F4844;
        Mon, 10 Jun 2019 10:23:12 -0400 (EDT)
Subject: Re: [PATCH 1/1] diffcore-rename: speed up register_rename_src
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.142.git.gitgitgadget@gmail.com>
 <4ac75dd3635e39f9faa67fb1e88897663e3dc6cd.1560004960.git.gitgitgadget@gmail.com>
 <bcaff0ce-365d-1d17-6ea0-7e3b52fc928b@web.de>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bf63c8cc-7146-6f13-cb77-785763fb77c8@jeffhostetler.com>
Date:   Mon, 10 Jun 2019 10:23:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bcaff0ce-365d-1d17-6ea0-7e3b52fc928b@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/8/2019 6:27 PM, René Scharfe wrote:
> Am 08.06.19 um 16:42 schrieb Jeff Hostetler via GitGitGadget:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach register_rename_src() to see if new file pair
>> can simply be appended to the rename_src[] array before
>> performing the binary search to find the proper insertion
>> point.
>>
>> This is a performance optimization.  This routine is called
>> during run_diff_files in status and the caller is iterating
>> over the sorted index, so we should expect to be able to
>> append in the normal case.  The existing insert logic is
>> preserved so we don't have to assume that, but simply take
>> advantage of it if possible.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>   diffcore-rename.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/diffcore-rename.c b/diffcore-rename.c
>> index 07bd34b631..5bfc5f6c22 100644
>> --- a/diffcore-rename.c
>> +++ b/diffcore-rename.c
>> @@ -82,6 +82,18 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>>
>>   	first = 0;
>>   	last = rename_src_nr;
>> +
>> +	if (last > 0) {
>> +		struct diff_rename_src *src = &(rename_src[last-1]);
>> +		int cmp = strcmp(one->path, src->p->one->path);
>> +		if (!cmp)
>> +			return src;
>> +		if (cmp > 0) {
>> +			first = last;
>> +			goto append_it;
> 
> The goto is not necessary from a logical point of view; the binary
> search is skipped even without it because the loop condition below is
> not met anymore.

Perhaps this is just a personal style thing, but I prefer the
goto because it makes it clear that we know the answer and are
done searching.  I know it's a small thing and I know we do it
all the time, but setting state here in just the right way as
to defeat the loop would work, but is a little less clear.  But
again, that is a personal style thing I guess.


>> +		}
> 
> You could decrement "last" at this point as a micro-optimization, to use
> all three possible outcomes of the comparison to make some progress.
> 
> Not sure if any of that would have a _measurable_ impact, though, so I
> don't mind the patch going in as is.

Yes, it looks like we could decrement "last" here.  And yes, I
suspect it would have minimal impact.  I'll pass on that in this
series to keep it focused on the advertised goal of simply
appending if possible.

> 
>> +	}
>> +
>>   	while (last > first) {
>>   		int next = (last + first) >> 1;
> 
> Hmm, "last" and "first" are ints as well, so this will give weird results
> when "last" > INT_MAX / 2.  I thought 19716b21a4 ("cleanup: fix possible
> overflow errors in binary search", 2017-10-08) got us rid of those, but
> git grep -n '(.*+.*) >> 1' actually finds some more cases:
> 
>     builtin/ls-files.c:376:         int next = (last + first) >> 1;
>     diffcore-rename.c:26:           int next = (last + first) >> 1;
>     diffcore-rename.c:86:           int next = (last + first) >> 1;
>     dir.c:704:              int cmp, next = (last + first) >> 1;
>     name-hash.c:349:                        int mid = (begin + end) >> 1;
>     read-cache.c:552:               int next = (last + first) >> 1;
>     sh-i18n--envsubst.c:252:          size_t j = (j1 + j2) >> 1;
> 
> (Not caused by this patch, of course, just noticed it in the context.)
> 
>>   		struct diff_rename_src *src = &(rename_src[next]);
>> @@ -95,6 +107,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>>   		first = next+1;
>>   	}
>>
>> +append_it:
>>   	/* insert to make it at "first" */
>>   	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
>>   	rename_src_nr++;
>>
> 
> Anyway, this here should work as well (and fix the possible overflow),
> but may be too terse and quirky:
> 
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 07bd34b631..f2a9007e08 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -76,14 +76,13 @@ static int rename_src_nr, rename_src_alloc;
> 
>   static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>   {
> -	int first, last;
> +	int first, last, next;
>   	struct diff_filespec *one = p->one;
>   	unsigned short score = p->score;
> 
>   	first = 0;
>   	last = rename_src_nr;
> -	while (last > first) {
> -		int next = (last + first) >> 1;
> +	for (next = last - 1; last > first; next = first + (last - first) / 2) {
>   		struct diff_rename_src *src = &(rename_src[next]);
>   		int cmp = strcmp(one->path, src->p->one->path);
>   		if (!cmp)
> 

I'd like to limit the scope of this patch series to just
the advertised topic and save the arithmetic fixes to
another patch series like 19716b21a4.

Jeff
