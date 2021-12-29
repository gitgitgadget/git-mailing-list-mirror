Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7005C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhL2RPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:15:46 -0500
Received: from siwi.pair.com ([209.68.5.199]:32496 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229568AbhL2RPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 12:15:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 01A413F4823;
        Wed, 29 Dec 2021 12:15:45 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B31323F4163;
        Wed, 29 Dec 2021 12:15:44 -0500 (EST)
Subject: Re: [PATCH v2 5/9] trace2: add thread-name override to perf target
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <pull.1099.v2.git.1640720202.gitgitgadget@gmail.com>
 <82c445b75f1002bcfa0a770bd47038a747d98970.1640720202.git.gitgitgadget@gmail.com>
 <211229.86ilv8gos7.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0ac9ce53-55d0-624d-8386-47b2243cfbd6@jeffhostetler.com>
Date:   Wed, 29 Dec 2021 12:15:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211229.86ilv8gos7.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/28/21 8:48 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Dec 28 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach the message formatter in the Trace2 perf target to accept an
>> optional thread name argument.  This will override the thread name
>> inherited from the thread local storage data block.
>>
>> This will be used in a future commit for global events that should
>> not be tied to a particular thread, such as a global stopwatch timer.
> 
> We already have a "ctx", and that "ctx" has a "thread_name", but here
> and in the preceding commit we're adding a "thread_name" to every caller
> of these functions in case we'd like to override it.
> 
> Wouldn't it make more sense to just pass a "ctx" to these functions? One
> of them already takes it, here's an (obviously incomplete) fixup on top
> of your series to make the one that doesn't take a "ctx", and for the
> only non-NULL users of "thread_name" to just use a trivial helper to
> pass in a "ctx" with a new "thread_name", then to swap it back.
> 
> It would make for a smaller diffstat for this already large series, or
> we could do exactly what we're doing now, but avoid the churn of
> adjusting every caller by introducing a new sister function for those
> who want this parameter to be non-NULL.

I suppose it is possible to have a helper version of
`event_fmt_prepare()` that takes the extra argument and
fixup the existing function to call it with NULL.

I'll see if that makes sense.


[...]
>   
> +static void event_fmt_prepare_tn(const char *event_name, const char *file,
> +				 int line, const struct repository *repo,
> +				 struct json_writer *jw,
> +				 const char *thread_name)
> +{
> +	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
> +	const char *tmp;
> +
> +	tmp = ctx->thread_name;
> +	ctx->thread_name = thread_name;
> +	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, jw, ctx);
> +	ctx->thread_name = tmp;
> +}
[...]

This only works if we agree that thread name is a pointer inside
the structure and not a flex-array.

Personally, I think this is trying to do things backwards by
temporarily changing the ctx->thread_name field.  I think it
would be better to `event_fmt_prepare_tn()` do the actual
work with the supplied thread name and have the existing
`event_fmt_prepare()` just call it with ctx->thread_name.
Then we don't need to hack up the ctx.

I'll see if this makes the diffs a little cleaner.

Jeff

