Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C605CC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhLVQ21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 11:28:27 -0500
Received: from siwi.pair.com ([209.68.5.199]:51724 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236333AbhLVQ20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 11:28:26 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BA6323F47F9;
        Wed, 22 Dec 2021 11:28:24 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 88DAC3F47F6;
        Wed, 22 Dec 2021 11:28:24 -0500 (EST)
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
 <xmqqsfumqv62.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ea4eb7f2-863f-2439-d175-cd4e97ad63a6@jeffhostetler.com>
Date:   Wed, 22 Dec 2021 11:28:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfumqv62.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/21/21 2:22 AM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
>> The thread name is set when the thread is created and should not be
>> be modified afterwards.  Replace the strbuf with an allocated pointer
>> to make that more clear.
> 
> Sounds good.  Use of strbuf is perfectly fine while you compute the
> final value of the string, but as a more permanent location to store
> the result, it often is unsuitable (and strbuf_split_buf() is a prime
> example of how *not* to design your API function around the type).
> 
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
> 
> This is not exactly a new problem, but if we use a mechanism to
> allow arbitrary long string (like composing with strbuf and
> detaching the resulting string as is), instead of having a fixed
> name[] array embedded in the ctx structure, I wonder if applying the
> maximum length this early makes sense.  Such a truncation would
> allow more than one ctx structures to share the same name, which
> somehow feels error prone, inviting a mistake to use .thread_name
> member as an identifier, when its only intended use is to give a
> human-readable and not necessarily unique label.  Of course, if the
> maximum is reasonably low, like a few dozen bytes, it may even make
> sense to embed an array of the fixed size and not worry about an
> extra pointer.
> 

I'll convert it to a flex-array at the bottom of the CTX structure
and then defer the truncation to the _perf target (which only does
that to keep the columns lined up).

That will simplify things considerably.

Thanks
Jeff

