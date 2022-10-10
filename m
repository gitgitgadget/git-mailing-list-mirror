Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86128C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 19:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJJTQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJJTQr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 15:16:47 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D183220D1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:16:46 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F0422CA1246;
        Mon, 10 Oct 2022 15:16:45 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B251CCC833C;
        Mon, 10 Oct 2022 15:16:45 -0400 (EDT)
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
References: <xmqqr0zkipva.fsf@gitster.g>
 <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
 <xmqqo7uoh1q0.fsf@gitster.g> <221007.865ygvrjs7.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <afc73d87-b2d9-72e9-1be5-156f37102747@jeffhostetler.com>
Date:   Mon, 10 Oct 2022 15:16:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221007.865ygvrjs7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/7/22 6:03 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 06 2022, Junio C Hamano wrote:
> 
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> A cleaned up version of the test code I had on top of "master", RFC
>>> because I may still be missing some context here. E.g. maybe there's a
>>> plan to dynamically construct these thread names?
>>
>> That's nice to learn, indeed.
>>
>>> +void jw_object_string_thread(struct json_writer *jw, const char *thread_name,
>>> +			     int thread_id)
>>> +{
>>> +	object_common(jw, "thread");
>>> +	strbuf_addch(&jw->json, '"');
>>> +	jw_strbuf_add_thread_name(&jw->json, thread_name, thread_id);
>>> +	strbuf_addch(&jw->json, '"');
>>> +}
>>
>> ...
>>
>>> @@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_name,
>>>   	}
>>>   
>>>   	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
>>> -	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
>>> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
>>> -		    event_name);
>>> +	oldlen = buf->len;
>>> +	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);
>>> +	padlen = TR2_MAX_THREAD_NAME - (buf->len - oldlen);;
>>> +	strbuf_addf(buf, "%-*s | %-*s | ", padlen, "",
>>> +		    TR2FMT_PERF_MAX_EVENT_NAME, event_name);
>>
>> Having to do strbuf_addf() many times may negatively affect perf_*
>> stuff, if this code is invoked in the hot path.  I however tend to
>> treat anything that involves an I/O not performance critical, and
>> this certainly falls into that category.
> 
> Yes, and that function already called strbuf_addf() 5-7 times, this adds
> one more, but only if "thread_id" is > 0.
> 
> The reason I added jw_object_string_thread() was to avoid the malloc() &
> free() of a temporary "struct strbuf", it would have been more
> straightforward to call jw_object_string() like that.
> 
> I don't think anyone cares about the raw performance of the "perf"
> output, but the "JSON" one needs to be fast(er).
> 
> But even that output will malloc()/free() for each line it emits, and
> often multiple times within one line (e.g. each time we format a
> double).
> 
> So if we do want to optimize this in terms of memory use the lowest
> hanging fruit seems to be to just have a per-thread "scratch" buffer
> we'd write to, we could also observe that we're writing to a file and
> just directly write to it in most cases (although we'd need to be
> careful to write partial-and-still-invalid JSON lines in that case...).
> 

WRT optimizing memory usage.  We're talking about ~25 byte buffer
per thread.  Most commands execute in 1 thread -- if they read the
index they may have ~10 threads (depending on the size of the index
and if preload-index is enabled).  So, I don't think we really need
to optimize this.  Threading is used extensively in fsmonitor-daemon,
but it creates a fixed thread-pool at startup, so it may have ~12
threads.  Again, not worth optimizing for the thread-name field.

Now, if you want to optimize over all trace2 events (a completely
different topic), you could create a large scratch strbuf buffer in
each thread context and use it so that we don't have to malloc/free
during each trace message.  That might be worth while.


We must not do partial writes to the trace2 files as we're
constructing fields.  The trace2 files are opened with O_APPEND
so that we get the atomic lseek(2)+write(2) so that lines get
written without overwrites when multiple threads and/or processes
are tracing.

Also, when writing to a named pipe, we get "message" semantics
on write() boundaries, which makes post-processing easier.

Jeff
