Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D45F1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 15:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfFYPhb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 11:37:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:36848 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbfFYPhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 11:37:31 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 31B693F40F0;
        Tue, 25 Jun 2019 11:37:30 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:ddd7:be83:9231:cc41] (unknown [IPv6:2001:4898:a800:1010:8f0d:be83:9231:cc41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B0C1A3F4051;
        Tue, 25 Jun 2019 11:37:29 -0400 (EDT)
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-2-pclouds@gmail.com>
 <755a4cfe-fd6b-044b-dca2-05eebfa518b1@jeffhostetler.com>
 <CACsJy8CEaT7QGrOsoQw6k9H2A5DYW5ZJR1=Qs45TiJv+9sMBdQ@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9a95bfcf-9fc7-dedb-d7b5-ebb4855c9ef3@jeffhostetler.com>
Date:   Tue, 25 Jun 2019 11:37:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACsJy8CEaT7QGrOsoQw6k9H2A5DYW5ZJR1=Qs45TiJv+9sMBdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/25/2019 5:52 AM, Duy Nguyen wrote:
> On Tue, Jun 25, 2019 at 2:15 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>> @@ -202,6 +202,28 @@ void jw_object_null(struct json_writer *jw, const char *key)
>>>        strbuf_addstr(&jw->json, "null");
>>>    }
>>>
>>> +void jw_object_filemode(struct json_writer *jw, const char *key, mode_t mode)
>>> +{
>>> +     object_common(jw, key);
>>> +     strbuf_addf(&jw->json, "\"%06o\"", mode);
>>> +}
>>> +
>>> +void jw_object_stat_data(struct json_writer *jw, const char *name,
>>> +                      const struct stat_data *sd)
>>
>> Should this be in json_writer.c or in read-cache.c ?
>> Currently, json_writer.c is concerned with formatting
>> JSON on basic/scalar types.  Do we want to start
>> extending it to handle arbitrary structures?  Or would
>> it be better for the code that defines/manipulates the
>> structure to define a "stat_data_dump_json()" function.
>>
>> I'm torn on the jw_object_filemode() function, JSON format
>> limits us to decimal integers and there are places where
>> I'd like to have hex, or in this case octal values.
>>
>> I'm thinking it'd be better to have a helper function in
>> read-cache.c that formats a local strbuf and calls
>> js_object_string(&jw, key, buf);
> 
> I can move these back to read-cache.c. Though if we have a lot more jw
> helpers like this (hard to tell at the moment) then perhaps we can
> have json-writer-utils.c or something to group them together. That
> keep the "boring" code out of main logic code in read-cache.c and
> other call sites.

yeah, in an utils file or close to the "constructors" of the
structure types.  either one works.

> 
>>> @@ -1952,6 +1953,49 @@ static void *load_index_extensions(void *_data)
>>>        return NULL;
>>>    }
>>>
>>> +static void dump_cache_entry(struct index_state *istate,
>>> +                          int index,
>>> +                          unsigned long offset,
>>> +                          const struct cache_entry *ce)
>>> +{
>>> +     struct json_writer *jw = istate->jw;
>>> +
>>> +     jw_array_inline_begin_object(jw);
>>> +
>>> +     /*
>>> +      * this is technically redundant, but it's for easier
>>> +      * navigation when there hundreds of entries
>>> +      */
>>> +     jw_object_intmax(jw, "id", index);
>>> +
>>> +     jw_object_string(jw, "name", ce->name);
>>> +
>>> +     jw_object_filemode(jw, "mode", ce->ce_mode);
>>> +
>>> +     jw_object_intmax(jw, "flags", ce->ce_flags);
>>
>> It would be nice to have the flags as a hex-formatted string
>> in addition to (or instead of) the decimal integer value.
> 
> I'm not against reformatting it in hex string, but is there a value in
> it? ce_flags is expanded in the code below so that you don't have to
> decode it yourself when you read each entry. The "flags" field here is
> for further processing in tools. I'm trying to see if looking at hex
> values helps, but I'm still not seeing it...
> 

I guess I was thinking of the in-memory bits and thinking
it'd be useful to be able to dump the index immediately
after reading it and then later after some operation or
traversal and see the intermediate states.  But I realize
now that that's not what you're building.  This is a dump
it while you're reading it feature (and that's fine).

So, as long as you have all of the on-disk bits, we should
be fine as you suggest.

Jeff


>>> +     /*
>>> +      * again redundant info, just so you don't have to decode
>>> +      * flags values manually
>>> +      */
>>> +     if (ce->ce_flags & CE_EXTENDED)
>>> +             jw_object_true(jw, "extended_flags");
>>> +     if (ce->ce_flags & CE_VALID)
>>> +             jw_object_true(jw, "assume_unchanged");
>>> +     if (ce->ce_flags & CE_INTENT_TO_ADD)
>>> +             jw_object_true(jw, "intent_to_add");
>>> +     if (ce->ce_flags & CE_SKIP_WORKTREE)
>>> +             jw_object_true(jw, "skip_worktree");
>>> +     if (ce_stage(ce))
>>> +             jw_object_intmax(jw, "stage", ce_stage(ce));
