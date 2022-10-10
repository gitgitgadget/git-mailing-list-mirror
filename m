Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA62C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJJSjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJSjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:39:40 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B0D74
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:39:38 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D2925CA1246;
        Mon, 10 Oct 2022 14:39:37 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9221DCC833C;
        Mon, 10 Oct 2022 14:39:37 -0400 (EDT)
Subject: Re: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
 <xmqq7d1eqhbf.fsf@gitster.g> <221006.86ilkwr6wy.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3fbc1d79-4b7d-ef5d-1056-0512a3aa4e9a@jeffhostetler.com>
Date:   Mon, 10 Oct 2022 14:39:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221006.86ilkwr6wy.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/6/22 5:05 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 05 2022, Junio C Hamano wrote:
> 
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
>>> to a "flex array" at the end of the context structure.
>>>
[...]
> 
> We don't even need that, AFAICT. My reply at [1] is rather long, but the
> tl;dr is that the interface for this API is:
> 	
> 	$ git grep '^\s+trace2_thread_start'
> 	Documentation/technical/api-trace2.txt: trace2_thread_start("preload_thread");
> 	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-health");
> 	builtin/fsmonitor--daemon.c:    trace2_thread_start("fsm-listen");
> 	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-worker");
> 	compat/simple-ipc/ipc-unix-socket.c:    trace2_thread_start("ipc-accept");
> 	compat/simple-ipc/ipc-win32.c:  trace2_thread_start("ipc-server");
> 	t/helper/test-fsmonitor-client.c:       trace2_thread_start("hammer");
> 	t/helper/test-simple-ipc.c:     trace2_thread_start("multiple");
> 	trace2.h:       trace2_thread_start_fl((thread_hint), __FILE__, __LINE__)
> 
> And we are taking e.g. "preload_thread" and turning it into strings like
> these, and saving it into "struct tr2tls_thread_ctx".
> 
> 	"preload_thread", // main thread
> 	"th01:preload_thread", // 1st thread
> 	"th02:preload_thread" // 2nd thread
> 	[...]
> 
> So, we don't need to strdup() and store that "preload_thread" anywhere.
> It's already a constant string we have hardcoded in the program. We just
> need to save a pointer to it.

Current callers tend to pass a string literal.  There's nothing
to say that they will continue to do so in the future.


> Then we just format the "%s" or (if ".thread_id" == 0) or "th%02d:%s"
> (if ".thread_id" > 0) on-the-fly, the two codepaths that end up using
> this are already using strbuf_addf(), so just adding to the format there
> is easy.
[...]

But then you'd be formatting this "th%0d:%s" on every message
printer.  Whereas we can format it once in the thread-start and
save the extra work -- at the expense of a string buffer in the
thread context.

Granted, the event handlers are generating output lines with many
"%" fields, so they are doing non-trivial amounts of work on every
event, but by using a pre-formatted thread-name, we don't need to
increase that workload.

Jeff


