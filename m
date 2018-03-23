Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80FC71F404
	for <e@80x24.org>; Fri, 23 Mar 2018 14:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCWONL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 10:13:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:38739 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbeCWONK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 10:13:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AB44E3F401D;
        Fri, 23 Mar 2018 10:13:09 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8620E3F401B;
        Fri, 23 Mar 2018 10:13:09 -0400 (EDT)
Subject: Re: [PATCH v2] json_writer: new routines to create data in JSON
 format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180321192827.44330-1-git@jeffhostetler.com>
 <20180321192827.44330-2-git@jeffhostetler.com>
 <xmqq8talnmts.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d6ef7034-351f-c1ef-a5d7-8ed684078ba7@jeffhostetler.com>
Date:   Fri, 23 Mar 2018 10:13:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <xmqq8talnmts.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/21/2018 5:25 PM, Junio C Hamano wrote:
> git@jeffhostetler.com writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Add basic routines to generate data in JSON format.
> 
> And the point of having capability to write JSON data in our
> codebase is...?
> 
>> diff --git a/json-writer.c b/json-writer.c
>> new file mode 100644
>> index 0000000..89a6abb
>> --- /dev/null
>> +++ b/json-writer.c
>> @@ -0,0 +1,321 @@
>> +#include "cache.h"
>> +#include "json-writer.h"
>> +
>> +static char g_ch_open[2]  = { '{', '[' };
>> +static char g_ch_close[2] = { '}', ']' };
> 
> What's "g_" prefix?

Global.

Sorry, very old habits.

>> +
>> +/*
>> + * Append JSON-quoted version of the given string to 'out'.
>> + */
>> +static void append_quoted_string(struct strbuf *out, const char *in)
>> +{
>> +	strbuf_addch(out, '"');
>> +	for (/**/; *in; in++) {
>> +		unsigned char c = (unsigned char)*in;
> 
> It is clear enough to lose /**/, i.e.
> 
> 	for (; *in; in++) {
> 
> but for this one. I wonder if
> 
> 	unsigned char c;
> 	strbuf_addch(out, '"');
> 	while ((c = *in++) != '\0') {
>   		...
> 
> is easier to follow, though.

either way is fine.  will fix.



>> +static inline void begin(struct json_writer *jw, int is_array)
>> +{
>> +	ALLOC_GROW(jw->levels, jw->nr + 1, jw->alloc);
>> +
>> +	jw->levels[jw->nr].level_is_array = !!is_array;
>> +	jw->levels[jw->nr].level_is_empty = 1;
> 
> An element of this array is a struct that represents a level, and
> everybody who accesses an element of that type knows it is talking
> about a level by the field that has the array being named as
> .levels[] (also [*1*]).  In such a context, it is a bit too loud to
> name the fields with level_$blah.  IOW,
> 
> 	struct json_writer_level
> 	{
> 		unsigned is_array : 1;
> 		unsigned is_empty : 1;
> 	};

make sense.  will fix.

>> +struct json_writer_level
>> +{
>> +	unsigned level_is_array : 1;
>> +	unsigned level_is_empty : 1;
>> +};
>> +
>> +struct json_writer
>> +{
>> +	struct json_writer_level *levels;
>> +	int nr, alloc;
>> +	struct strbuf json;
>> +};
> 
> [Footnote]
> 
> *1* I personally prefer to call an array of things "thing[]", not
>      "things[]", because then you can refer to an individual element
>      e.g. "thing[4]" and read it as "the fourth thing".
> 
>      Unless the code often treats an array as a whole, that is, in
>      which case, things[] is OK as you'll be calling the whole thing
>      with the plural name (e.g. call that function and give all the
>      things by passing things[]).
> 
>      In this case, one level instance is an element of a stack, and
>      the code would be accessing one level at a time most of the
>      time, so "writer.level[4].is_empty" would read more naturally
>      than "writer.levels[4].level_is_empty".

yeah, that makes sense.

Thanks
Jeff


