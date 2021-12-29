Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730AAC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 16:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbhL2Qqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 11:46:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:30481 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240897AbhL2Qqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 11:46:46 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CFDB03F47EF;
        Wed, 29 Dec 2021 11:46:45 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7F48B3F47EE;
        Wed, 29 Dec 2021 11:46:45 -0500 (EST)
Subject: Re: [PATCH v2 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to flex array
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
 <ff8df1b148ec486f565a59cb8a227bfa2ef48313.1640720202.git.gitgitgadget@gmail.com>
 <211229.86mtkkgql4.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e3fd64ef-9e26-19da-7327-38ab77ae359a@jeffhostetler.com>
Date:   Wed, 29 Dec 2021 11:46:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211229.86mtkkgql4.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/28/21 8:11 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Move the thread name to a flex array at the bottom of the Trace2
>> thread local storage data and get rid of the strbuf.
>>
>> Let the flex array have the full computed value of the thread name
>> without truncation.
>>
>> Change the PERF target to truncate the thread name so that the columns
>> still line up.
> 
> This commit message really doesn't help in explaining what we're trying
> to do here and why it's needed. I'm not saying it's not, but why not a
> strbuf, why a flex array? The diff below also shows changes unrelated to
> this.
> 
> I tried this local fixup on top of this series which works, so I wonder
> if we're just trying to get rid of the strbuf to signal that this
> shouldn't change why not just strbuf_detach() and keep a "const char
> *thread_name"?
> 
> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> index 28ea55863d1..35d49b27b2e 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -48,7 +48,7 @@ void tr2tls_start_process_clock(void)
>   struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>   					     uint64_t us_thread_start)
>   {
> -	struct tr2tls_thread_ctx *ctx;
> +	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(struct tr2tls_thread_ctx));
>   	struct strbuf buf_name = STRBUF_INIT;
>   	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
>   
> @@ -56,8 +56,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>   		strbuf_addf(&buf_name, "th%02d:", thread_id);
>   	strbuf_addstr(&buf_name, thread_name);
>   
> -	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
> -	strbuf_release(&buf_name);
> +	ctx->thread_name = strbuf_detach(&buf_name, NULL);
>   
>   	ctx->thread_id = thread_id;
>   
> @@ -188,6 +187,7 @@ void tr2tls_release(void)
>   	while (ctx) {
>   		struct tr2tls_thread_ctx *next = ctx->next_ctx;
>   
> +		free((char *)ctx->thread_name);
>   		free(ctx->array_us_start);
>   		free(ctx);
>   
> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index 503829bbd44..bc6c6f12e38 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -6,6 +6,7 @@
>   #include "trace2/tr2_tmr.h"
>   
>   struct tr2tls_thread_ctx {
> +	const char *thread_name;
>   	struct tr2tls_thread_ctx *next_ctx;
>   	uint64_t *array_us_start;
>   	size_t alloc;
> @@ -14,8 +15,6 @@ struct tr2tls_thread_ctx {
>   
>   	struct tr2_timer_block timers;
>   	struct tr2_counter_block counters;
> -
> -	char thread_name[FLEX_ARRAY];
>   };
>   
>   /*

I have to admit that I really don't know how to please you.

In V1 I converted the "strbuf" to a "char *" inside the structure
because there was concern that one might assume that the thread
name could be changed after the thread was created.  You complained
that I made it a "char *" rather than a "const char *".  I explained
pointer ownership and you completely ignored that.  You explained
that I should just "cast away the const during the free" because
other places in the code use that "anti-pattern".  You also complained
that I didn't use a callback to get the thread name dynamically rather
than having a string field in the thread's TLS.  I explained that it
was faster to compute it once than to generate it on every logging
call.  You ignored that and hinted that the message formatting in
each of the target destinations would make that cost irrelevant.
I convert the field to a flex-array to avoid all of the allocation and
ownership issues and now you send me a "fixup" patch that undoes
the flex-array change and makes it look mostly like my previous
version -- but WITH the "const" and the "cast" (that I've already
talked about in this paragraph).

So, where does this leave us?  I'm really trying to "assume good
intentions" here, but we've spent way toooooooo long discussing
this thread_name field.  It's starting to feel like you're going
to just keep nagging me about this field until I make it look
exactly like you would have written it.

So, sorry to rant, but I don't know what else to say about this
field.  It is especially troubling that this "issue" has taken
so much time -- time that would be better spent actually looking
at the new timers and counters feature.


> 
>> [...]
>> index 7da94aba522..ed99a234b95 100644
>> --- a/trace2/tr2_tls.c
>> +++ b/trace2/tr2_tls.c
>> @@ -34,7 +34,18 @@ void tr2tls_start_process_clock(void)
>>   struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>>   					     uint64_t us_thread_start)
>>   {
>> -	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
>> +	struct tr2tls_thread_ctx *ctx;
>> +	struct strbuf buf_name = STRBUF_INIT;
>> +	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
> 
> Here's the looks-to-be-unrelated to this strbuf conversion code I
> mentioned above.

In the flex-array version, we defer the alloc of "ctx" until
after we have computed the thread name -- we to do that so that
we know the length of the thread name (and thus the size of the
flex-array).  To do that we need to know the thread id that we
will be formatting into the thread name.  And to do that we need
to reserve a thread id -- which is a global and requires a lock.

So the call to tr2tls_locked_increment() (as well as the formatting
of the name itself) was moved up to the top of the function rather
than after the "ctx" was allocated.

> 
>> +
>> +	if (thread_id)
>> +		strbuf_addf(&buf_name, "th%02d:", thread_id);
>> +	strbuf_addstr(&buf_name, thread_name);
>> +
>> +	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
>> +	strbuf_release(&buf_name);
>> +
>> +	ctx->thread_id = thread_id;
>>   
>>   	/*
>> [...]

Jeff

