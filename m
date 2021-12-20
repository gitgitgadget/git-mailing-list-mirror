Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0FDC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhLTTHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:07:04 -0500
Received: from siwi.pair.com ([209.68.5.199]:11568 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240710AbhLTTHD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:07:03 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 64B2D3F480B;
        Mon, 20 Dec 2021 14:07:01 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 30F723F4818;
        Mon, 20 Dec 2021 14:07:01 -0500 (EST)
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
 <211220.86pmprutbz.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <289f525b-93b8-6f33-e0fc-3b24fa8a54ea@jeffhostetler.com>
Date:   Mon, 20 Dec 2021 14:07:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211220.86pmprutbz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/21 11:31 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 20 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
>> The thread name is set when the thread is created and should not be
>> be modified afterwards.  Replace the strbuf with an allocated pointer
>> to make that more clear.
>>
>> This was discussed in: https://lore.kernel.org/all/xmqqa6kdwo24.fsf@gitster.g/
 >>...
>> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
>> index 7da94aba522..cd8b9f2f0a0 100644
>> --- a/trace2/tr2_tls.c
>> +++ b/trace2/tr2_tls.c
>> @@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>>   					     uint64_t us_thread_start)
>>   {
>>   	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
>> +	struct strbuf buf_name = STRBUF_INIT;
>>   
>>   	/*
>>   	 * Implicitly "tr2tls_push_self()" to capture the thread's start
>> @@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>>   
>>   	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
>>   
>> -	strbuf_init(&ctx->thread_name, 0);
>>   	if (ctx->thread_id)
>> -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
>> -	strbuf_addstr(&ctx->thread_name, thread_name);
>> -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
>> -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
>> +		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
>> +	strbuf_addstr(&buf_name, thread_name);
>> +	if (buf_name.len > TR2_MAX_THREAD_NAME)
>> +		strbuf_setlen(&buf_name, TR2_MAX_THREAD_NAME);
>> +
>> +	ctx->thread_name = strbuf_detach(&buf_name, NULL);
>>   
>>   	pthread_setspecific(tr2tls_key, ctx);
>>   
 >>..
>> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
>> index a90bd639d48..d968da6a679 100644
>> --- a/trace2/tr2_tls.h
>> +++ b/trace2/tr2_tls.h
>> @@ -9,7 +9,7 @@
>>   #define TR2_MAX_THREAD_NAME (24)
>>   
>>   struct tr2tls_thread_ctx {
>> -	struct strbuf thread_name;
>> +	char *thread_name;
>>   	uint64_t *array_us_start;
>>   	size_t alloc;
>>   	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
> 
> Junio's suggestion in the linked E-Mail was to make this a "const char *".

Yes, it was.  To me a "const char *" in a structure means that
the structure does not own the pointer and must not free it.
Whereas as "char *" means that the structure might own it and
should maybe free it when the structure is freed.  My usage here
is that the structure does own it (because it took it from the
temporary strbuf using strbuf_detach()) and so it must free it.
Therefore it should not be "const".  This has nothing to do with
whether or not we allow the thread name to be changed after the
fact.  (We don't, but that is a different issue).

> 
> Narrowly, I don't see why not just add a "const" to the "struct strbuf
> *" instead.

Adding "const" to a strbuf would be wrong in this case, since the
structure owns the strbuf and needs to strbuf_release the contained
buffer and (now) free the strbuf pointer, right?

This also makes things confusing -- all callers of tr2tls_create_self()
would now be responsible for allocating a strbuf to pass in -- and who
would own those.  This would also create opportunities for mistakes if
they pass in the address of a stack-based strbuf, right?

This is being used to initialize thread-based data, so the caller
can't just use a "function local static" or a "global static" strbuf.


> 
> But less narrowly if we're not going to change it why malloc a new one
> at all? Can't we just use the "const char *" passed into
> tr2tls_create_self(), and for the "th%02d:" case have the code that's
> formatting it handle that case?
> 
> I.e. have the things that use it as a "%s" now call a function that
> formats things as a function of the "ctx->thread_id" (which may be 0)
> and limit it by TR2_MAX_THREAD_NAME?
> 

This would be less efficient, right?  That thread name is included in
*EVERY* _perf and _event message emitted.  If we were to change the
design to have basically a callback to get the formatted value based
on the `ctx` or `cts->thread_id` and dynamically formatting the name,
then we would have to hit that callback once (or twice) for every Trace2
message, right?  That would be much slower than just having a fixed
string (formatted when the thread is created) that we can just use.
And even if we said that the callback could cache the result (like
we do when we lookup env vars), where would it cache it?  It would have
to cache it in the `ctx`, which is where it currently is and without
any of the unnecessary overhead, right?

I think you're assuming that callers of `tr2tls_create_self()` always
pass a literal string such that that string value is always safe to
reference later.  Nothing would prevent a caller from passing the
address of a stack buffer.  It is not safe to assume that that string
pointer will always be valid, such as after the thread exits.  It is
better for _create_self() to copy the given string (whether we format
it immediately or not) than to assume that the pointer will always be
valid, right?


So I don't think we should deviate from the patch that I submitted.

Jeff
