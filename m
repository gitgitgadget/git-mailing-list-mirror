Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43CC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 19:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJJTG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 15:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJJTGG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 15:06:06 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B4A75FDC
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 12:05:44 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B1D3CA1246;
        Mon, 10 Oct 2022 15:05:43 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3E2EECC833C;
        Mon, 10 Oct 2022 15:05:43 -0400 (EDT)
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
References: <xmqqr0zkipva.fsf@gitster.g>
 <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cb9f8321-d9e6-6f80-a590-a9ad49c7f557@jeffhostetler.com>
Date:   Mon, 10 Oct 2022 15:05:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/6/22 9:10 PM, Ævar Arnfjörð Bjarmason wrote:
> Since ee4512ed481 (trace2: create new combined trace facility,
> 2019-02-22) the "thread_name" member of "struct tr2tls_thread_ctx" has
> been copied from the caller, but those callers have always passed a
> constant string:
> 
> 	$ git -P grep '^\s*trace2_thread_start\('
> 	Documentation/technical/api-trace2.txt: trace2_thread_start("preload_thread");
> 	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-health");
> 	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-listen");
> 	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-worker");
> 	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-accept");
> 	compat/simple-ipc/ipc-win32.c:  trace2_thread_start("ipc-server");
> 	t/helper/test-fsmonitor-client.c:       trace2_thread_start("hammer");
> 	t/helper/test-simple-ipc.c:     trace2_thread_start("multiple");
> 
> This isn't needed for optimization, but apparently[1] there's been
> some confusion about the non-const-ness of the previous "struct
> strbuf".
> 
> Using the caller's string here makes this more straightforward, as
> it's now clear that we're not dynamically constructing these. It's
> also what the progress API does with its "title" string.
> 
> Since we know we're hardcoding these thread names let's BUG() out when
> we see that the length of the name plus the length of the prefix would
> exceed the maximum length for the "perf" format.
> 
> 1. https://lore.kernel.org/git/82f1672e180afcd876505a4354bd9952f70db49e.1664900407.git.gitgitgadget@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

PLEASE DON'T DO THIS.

If you don't like my patch, fine.  Let's discuss it.  But DON'T submit
a new one to replace it.  Or worse, try to inject it into the middle
of an existing series.


Yes, current callers are passing a string literal and thread-start
could take a "const char*" to it, but there is no way to guarantee
that that is safe if someone decides to dynamically construct their
thread-name and pass it in (since we don't know the lifetime of that
pointer).  So it is safer to copy it into the thread context so that
it can be used by later trace messages.


[...]
> +void jw_strbuf_add_thread_name(struct strbuf *buf, const char *thread_name,
> +			       int thread_id);
> +void jw_object_string_thread(struct json_writer *jw, const char *thread_name,
> +			     int thread_id);

This violates a separation of concerns.  json-writer is ONLY concerned
with formatting valid JSON from basic data types.  It does not know
about threads or thread contexts.

`js_strbuf_add_thread_name()` also violates the json-writer conventions
-- that it takes a "struct json_writer *" pointer.  There is nothing
about JSON here.

You might write a helper (inside of tr2_tgt_event.c) that formats a
thread-name from the id and hint, but that is specific to the Event
target -- not to JSON, nor the JSON writer.

But then again, why make every trace message from every target format
that "th%0d:%s" when we could save some time and format it in the
thread-start and just USE it.


[...]
> @@ -107,9 +109,11 @@ static void perf_fmt_prepare(const char *event_name,
>   	}
>   
>   	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
> -	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
> -		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
> -		    event_name);
> +	oldlen = buf->len;
> +	jw_strbuf_add_thread_name(buf, ctx->thread_name, ctx->thread_id);

This stands out as very wrong.  The _Perf target does not use JSON
at all, yet here we are calling a jw_ routine.  Again, that code is
in the wrong place.


I'm going to clip the rest of this commit, since the above invalidates
it.

Jeff
