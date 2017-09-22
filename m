Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B270F202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 19:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdIVTXV (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 15:23:21 -0400
Received: from avasout07.plus.net ([84.93.230.235]:59055 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdIVTXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 15:23:20 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id CjPH1w0050M91Ur01jPJbq; Fri, 22 Sep 2017 20:23:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=T01vTosiYOF-wdXBhFoA:9
 a=Ia-tGoq3EiCOk3Pc:21 a=A2-wdGUZBDZTvBzY:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/4] ALLOC_GROW: avoid -Wsign-compare warnings
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
References: <20170922162512.7398-1-szeder.dev@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <49da282f-3a9d-4d0a-c21f-a96e5eb4410f@ramsayjones.plus.com>
Date:   Fri, 22 Sep 2017 20:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922162512.7398-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/17 17:25, SZEDER Gábor wrote:
> 
> At first I was somewhat puzzled by the "ALLOC_GROW:" prefix in the
> subject line, because this patch doesn't touch ALLOC_GROW() at all.
> However, since ALLOC_GROW() is a macro, of course, and since this
> patch changes the data type of variables "passed" to ALLOC_GROW(),
> that's sort of fine...

Yes, the original subject line was "... when using the ALLOC_GROW macro",
but vim scolded me for busting the line length. I tried several other
variations, but I couldn't come up with anything better.

So, yes, given that the subject left a little to be desired, I probably
should have included a commit message body. :(

[This patch was originally written years ago, as part of a much larger
series to fix all -Wextra warnings. I was pleasantly surprised that it
applied to master without conflicts. However, I had to add to the patch
because new instances of -Wsign-compare due to using the ALLOC_GROW macro
had appeared since then.]

> But then I was even more puzzled to see that this patch also changes
> the data type of several variables that are never passed to
> ALLOC_GROW(), but only compared to other variables that are indeed
> passed to ALLOC_GROW(), i.e. most of (all?) the changes in line-log.c.
> Perhaps it would be worth mentioning that all those changes are
> fallout of the type change in 'struct range_set' in line-log.h. (and
> all those changes silence only two warnings!)

Hmm, I did consider splitting this patch up, so that this (and other
issues you mention below) could be called out separately, but well ... ;-)

>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  builtin/pack-objects.c |  4 ++--
>>  config.c               |  2 +-
>>  diff.c                 |  2 +-
>>  line-log.c             | 18 +++++++++---------
>>  line-log.h             |  2 +-
>>  revision.c             |  2 +-
>>  tree-walk.c            |  3 +--
>>  7 files changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index a57b4f058..a6ee653bf 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -2563,8 +2563,8 @@ struct in_pack_object {
>>  };
>>  
>>  struct in_pack {
>> -	int alloc;
>> -	int nr;
>> +	unsigned int alloc;
>> +	unsigned int  nr;
>>  	struct in_pack_object *array;
>>  };
>>  
>> diff --git a/config.c b/config.c
>> index cd5a69e63..aeab02c06 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2200,7 +2200,7 @@ static struct {
>>  	size_t *offset;
>>  	unsigned int offset_alloc;
>>  	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
>> -	int seen;
>> +	unsigned int seen;
>>  } store;
> 
> On first sight this looked like an independent change, but on closer
> inspection it turns out that the variables 'seen' and 'offset_alloc'
> are used to manage the allocation of the '*offset' array.
> 
> I wish we would have named these fields more consistently with '_nr'
> and '_alloc' suffixes, or, if there is a compelling reason to diverge,
> then at least put the two fields on subsequent lines (or even on the
> same line), with a comment explaining the connection between the two
> fields and the array.

Yes, I agree. If I had split this patch up, I would have considered
adding such modifications to that patch. (That's easy to say now, of
course!)

>>  static int matches(const char *key, const char *value)
>> diff --git a/diff.c b/diff.c
>> index ea7e5978b..be94ad4f4 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1541,7 +1541,7 @@ static void emit_rewrite_diff(const char *name_a,
>>  
>>  struct diff_words_buffer {
>>  	mmfile_t text;
>> -	long alloc;
>> +	unsigned long alloc;
> 
> This one is interesting.  'alloc' and 'mmfile_t's 'text.size' manage
> the allocation of 'text.ptr', and both are signed longs...  so where
> does the warning come from?  Well, just a couple of lines later we
> have this:
> 
>   static void diff_words_append(char *line, unsigned long len,
>                   struct diff_words_buffer *buffer)
>   {
>           ALLOC_GROW(buffer->text.ptr, buffer->text.size + len, buffer->alloc);
> 
> Note the addition of the signed long 'buffer->text.size' and the
> unsigned long 'len', which, according to "6.3.1.8 Usual arithmetic
> conversions", converts the signed long to unsigned.  ALLOC_GROW() then
> compares the resulting unsigned long sum to the signed long
> 'buffer->alloc', hence the warning.
> 
> So, while the change in this hunk is technically correct and indeed
> eliminates the warning, it is subtle and the resulting code with a
> signed long 'text.size' in 'mmfile_t' and unsigned long 'alloc' might
> raise the eyebrows of future readers.  I think this would be worth
> mentioning in the commit message or in a comment.
> 
> Ultimately 'text.size' should be turned into unsigned, too, maybe even
> size_t, but that change would be much more difficult to make and
> review, because mmfile_t is used over hundred times in our codebase,
> and 'size' is not a grep-friendly field name to look for.

Indeed, ... :-P

>>  	struct diff_words_orig {
>>  		const char *begin, *end;
>>  	} *orig;
> 
> The very next line of 'struct diff_words_buffer's definition is:
> 
>     int orig_nr, orig_alloc;
> 
> These two fields are used to manage the allocation of the struct's
> '*orig' array.  While these are not involved in any warnings, having
> an 'unsigned long alloc' and a signed 'orig_alloc' so close to each
> other in the same struct might raise some eyebrows, too.
Thanks for the detailed review.

ATB,
Ramsay Jones


