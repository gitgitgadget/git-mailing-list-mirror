Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ABC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJJSbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJJSbm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:31:42 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9342AE5
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:31:40 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B3B1BCA123B;
        Mon, 10 Oct 2022 14:31:38 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7F0A4CC833B;
        Mon, 10 Oct 2022 14:31:38 -0400 (EDT)
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
 <221005.86y1tus9ps.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8e3524e7-5e92-99d6-294e-4c309a3d44ee@jeffhostetler.com>
Date:   Mon, 10 Oct 2022 14:31:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221005.86y1tus9ps.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/5/22 7:14 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 04 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
>> to a "flex array" at the end of the context structure.
>>
>> The `thread_name` field is a constant string that is constructed when
>> the context is created.  Using a (non-const) `strbuf` structure for it
>> caused some confusion in the past because it implied that someone
>> could rename a thread after it was created.
> 
> I think it's been long enough that we could use a reminder about the
> "some confusion", i.e. if it was a bug report or something else.
> 
>> That usage was not intended.  Changing it to a "flex array" will
>> hopefully make the intent more clear.
> 
> I see we had some back & forth back in the original submission, although
> honestly I skimmed this this time around, had forgetten about that, and
> had this pop out at me, and then found my earlier comments.
> 
> I see that exchange didn't end as well as I'd hoped[1], and hopefully we
> can avoid that here. So having looked at this with fresh eyes maybe
> these comments/questions help:
> 
>   * I'm unable to bridge the cap from (paraphrased) "we must change the
>     type" to "mak[ing] the [read-only] intent more clear".
> 
>     I.e. if you go across the codebase and look at various non-const
>     "char name[FLEX_ARRAY]" and add a "const" to them you'll find cases
>     where we re-write the "FLEX_ARRAY" string, e.g. the one in archive.c
>     is one of those (the first grep hit, I stopped looking for others at
>     that point).
> 
>     Making it "const" will yield:
>     
>        archive.c: In function ‘queue_directory’:
>     archive.c:206:29: error: passing argument 1 of ‘xsnprintf’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>       206 |         d->len = xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf, filename);
> 
>     So aside from anything else (and I may be misunderstanding this) why
>     does changing it to a FLEX_ARRAY give us the connotation in the
>     confused API user's mind that it shouldn't be messed with that the
>     "strbuf" doesn't give us?
[...]

My change in how we store the thread-name in the thread context was JUST
to clarify that it should be treated as a constant string and that code
should not try to modify it.  There was a comment to that effect last
year -- that having it be a strbuf invited one to modify it, when that
was not the intent.

That was all I was trying to do here.  Just make it "not be a strbuf".
Perhaps I lept too far by making it a flex-array.  I probably could
have just changed the field to a "char *" and detached it from the
(now local) strbuf.  That would give the same impression, right?


[...]
>>   	/*
>>   	 * Implicitly "tr2tls_push_self()" to capture the thread's start
>> @@ -45,15 +56,6 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
>>   	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
>>   	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
>>   
>> -	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
>> -
>> -	strbuf_init(&ctx->thread_name, 0);
>> -	if (ctx->thread_id)
>> -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
>> -	strbuf_addstr(&ctx->thread_name, name_hint);
>> -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
>> -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
>> -
>>   	pthread_setspecific(tr2tls_key, ctx);
>>   
>>   	return ctx;
> 
> I found this quote hard to follow because there's functional changes
> there mixed up with code re-arangement, consider leading with a commit
> like:
[...]

sorry about that.  yes, there's a bit of churn here because i
needed to reorder the thread-name construction to be before we
allocated the context so that we'd know the buffer size.

and yes, i accidentally mixed in a function change to move the
truncation to the perf backend.

i'll redo all of this.


[...]
> <tries it out>
> 
> Anyway, if this area was actually performance critical and we *really
> cared* about avoiding allocations wouldn't we want to skip both the
> "strbuf" there and the "FLEX_ARRAY", and just save away the
> "thread_hint" (which the caller hardcodes) and "thread_nr", and then
> append on-the-fly?
> 
> I came up with the below to do that, it passes all tests, but contains
> micro-optimizations that I don't think we need (e.g. I understood you
> wanted to avoid printf, so it does that).
> 
> But I think it's a useful point of discussion. What test(s) do you have
> where the "master" version, FLEX_ARRAY version, and just not strbuf
> formatting the thing at all differ?
[...]

none of this was about micro-optimization.  i was just trying to get
the buffer away from a strbuf.  i still want it pre-formatted once
at thread-start, but that's it.

FWIW, I don't think having it formatted in each event helps anything.
it would have to go thru sprintf on every message.  it's much better
to just format it once in the thread-start.


[...]
> 	diff --git a/json-writer.c b/json-writer.c
[...] 	
> 	+void jw_strbuf_add_thread_name(struct strbuf *out, const char *thread_hint,
> 	+			       int thread_id, int max_len)
> 	+{
[...]
> 	+}
> 	+
> 	+void jw_object_thread(struct json_writer *jw, const char *thread_hint,
> 	+		      int thread_id)
> 	+{
[...]
> 	+}
[...]

We should not do this.  Just format the name in thread-start and
let json-writer print the string as we have been.

Adding thread formatting to json-writer also violates a separation
of concerns.

I'll re-roll this commit completely.

thanks
Jeff
