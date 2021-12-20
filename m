Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AF2C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhLTTob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:44:31 -0500
Received: from siwi.pair.com ([209.68.5.199]:14184 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhLTTo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:44:28 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D92C03F47F6;
        Mon, 20 Dec 2021 14:44:27 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A82D53F4155;
        Mon, 20 Dec 2021 14:44:27 -0500 (EST)
Subject: Re: [PATCH 6/9] trace2: add timer events to perf and event target
 formats
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <c5d5ff05e6ca5729993133ce0b6b94af2503808a.1640012469.git.gitgitgadget@gmail.com>
 <211220.86lf0fut2i.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <511dc3c7-96c6-1d4a-4537-616f7c4093f2@jeffhostetler.com>
Date:   Mon, 20 Dec 2021 14:44:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211220.86lf0fut2i.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/21 11:39 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach Trace2 "perf" and "event" formats to handle "timer" events for
>> stopwatch timers.  Update API documentation accordingly.
>>
>> In a future commit, stopwatch timers will be added to the Trace2 API
>> and it will emit these "timer" events.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
 >>...
>> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
>> index bb13ca3db8b..e6ed94ba814 100644
>> --- a/Documentation/technical/api-trace2.txt
>> +++ b/Documentation/technical/api-trace2.txt
>> @@ -391,7 +391,7 @@ only present on the "start" and "atexit" events.
>>   {
>>   	"event":"version",
>>   	...
>> -	"evt":"3",		       # EVENT format version
>> +	"evt":"4",		       # EVENT format version
>>   	"exe":"2.20.1.155.g426c96fcdb" # git version
>>   }
> 
> FWIW this seems like a time not to bump the version per the proposed
> approach in:
> https://lore.kernel.org/git/211201.86zgpk9u3t.gmgdl@evledraar.gmail.com/
> 
> Not directly related to this series, which just preserves the status
> quo, but it would be nice to get feedback on that proposal from you.

Frankly, my eyes glazed over every time I tried to read it....

Your proposal looks fine.  And yes, our assumptions are that because
we have structured data, new event types and/or new fields can be
added and safely ignored by JSON parsers, so we should be OK.
So we're assuming that only if we drop events or fields or change
the meaning of one of them, would a parser need to react and so
we can limit version bumps to those instances.

I'm OK with this.

I'll let you draft the wording in api-trace2.txt to explain the
how/when/why we want to update the version number in the future.
Thanks.


> 
>> [...]
>> + * Verison 1: original version
> 
> A typo of "Version".
> 
>> + * Version 2: added "too_many_files" event
>> + * Version 3: added "child_ready" event
>> + * Version 4: added "timer" event
>>    */
>> -#define TR2_EVENT_VERSION "3"
>> +#define TR2_EVENT_VERSION "4"
>>   

I'll roll this back in my next version.

>>   /*
>>    * Region nesting limit for messages written to the event target.
>> @@ -615,6 +620,38 @@ static void fn_data_json_fl(const char *file, int line,
>>   	}
>>   }
>>   
>> +static void fn_timer(uint64_t us_elapsed_absolute,
>> +		     const char *thread_name,
>> +		     const char *category,
>> +		     const char *timer_name,
>> +		     uint64_t interval_count,
>> +		     uint64_t us_total_time,
>> +		     uint64_t us_min_time,
>> +		     uint64_t us_max_time)
>> +{
>> +	const char *event_name = "timer";
>> +	struct json_writer jw = JSON_WRITER_INIT;
>> +	double t_abs = (double)us_elapsed_absolute / 1000000.0;
>> +
> 
> nit: Odd placement of \n\n
> 
>> +	double t_total = (double)us_total_time / 1000000.0;
>> +	double t_min   = (double)us_min_time   / 1000000.0;
>> +	double t_max   = (double)us_max_time   / 1000000.0;
> 
> Both for this...
> 
>> +	jw_object_begin(&jw, 0);
>> +	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw, thread_name);
>> +	jw_object_double(&jw, "t_abs", 6, t_abs);
>> +	jw_object_string(&jw, "name", timer_name);
>> +	jw_object_intmax(&jw, "count", interval_count);
>> +	jw_object_double(&jw, "t_total", 6, t_total);
>> +	jw_object_double(&jw, "t_min", 6, t_min);
>> +	jw_object_double(&jw, "t_max", 6, t_max);
> 
> [...]
> 
>> +static void fn_timer(uint64_t us_elapsed_absolute,
>> +		     const char *thread_name,
>> +		     const char *category,
>> +		     const char *timer_name,
>> +		     uint64_t interval_count,
>> +		     uint64_t us_total_time,
>> +		     uint64_t us_min_time,
>> +		     uint64_t us_max_time)
>> +{
>> +	const char *event_name = "timer";
>> +	struct strbuf buf_payload = STRBUF_INIT;
>> +
>> +	double t_total = (double)us_total_time / 1000000.0;
>> +	double t_min   = (double)us_min_time   / 1000000.0;
>> +	double t_max   = (double)us_max_time   / 1000000.0;
>> +
>> +	strbuf_addf(&buf_payload, "name:%s", timer_name);
>> +	strbuf_addf(&buf_payload, " count:%"PRIu64, interval_count);
>> +	strbuf_addf(&buf_payload, " total:%9.6f", t_total);
>> +	strbuf_addf(&buf_payload, " min:%9.6f", t_min);
>> +	strbuf_addf(&buf_payload, " max:%9.6f", t_max);
> 
> ....and this, wouldn't it be better/more readable to retain the uint64_t
> for the math, and just cast if needed when we're doing the formatting?
> 

I had those expressions inline at first and it really junked up the
lines and made things hard to read -- partially because of the need
to wrap the lines a lot.  I went with the local t_* temp vars to make
it more clear what we were doing.  This style also matched the existing
code in _tgt_event.c for `t_abs` and `t_rel` in all of the fn_*.

Jeff
