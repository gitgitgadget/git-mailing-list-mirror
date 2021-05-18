Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A43EC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A43600CD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhERLXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 07:23:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:33362 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhERLW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 07:22:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E49153F40B7;
        Tue, 18 May 2021 07:21:33 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A105B3F4047;
        Tue, 18 May 2021 07:21:33 -0400 (EDT)
Subject: Re: [BUG] Unix Builds Requires Pthread Support (was [PATCH v4 00/12]
 Simple IPC Mechanism)
To:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?J1NaRURFUiBHw6Fib3In?= <szeder.dev@gmail.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, jeffhost@microsoft.com
References: <009d01d74b44$9efe8a60$dcfb9f20$@nexbridge.com>
 <YKN5lXs4AoK/JFTO@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8540e41e-3ba6-8d40-9424-8f62ea785f42@jeffhostetler.com>
Date:   Tue, 18 May 2021 07:21:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YKN5lXs4AoK/JFTO@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/18/21 4:23 AM, Jeff King wrote:
> On Mon, May 17, 2021 at 01:46:46PM -0400, Randall S. Becker wrote:
> 
>> On Wed, 17 Feb 2021 21:48:36, Jeff Hostetler wrote:
>>
>>> Here is V4 of my "Simple IPC" series. It addresses Gábor's comment WRT
>>> shutting down the server to make unit tests more predictable on CI servers.
>>> (https://lore.kernel.org/git/20210213093052.GJ1015009@szeder.dev)
>>
>> I missed this at the time, but it appears that ipc-unix-socket.c
>> forces a dependency on pthreads for Git under Unix-like platforms.
>> This is probably not a correct assumption (or likely intended), but
>> causes git to no longer build on NonStop x86 and ia64 as of
>> 2.32.0-rc0. I am not suggesting undoing this, but amending to make the
>> change more sensitive to a lack of pthread support.
>> pthread_sigmask() showed up as an undefined external:
> 
> Hrm. Usually we do not assume that threads are available. For "async"
> stuff via run-command, we allow it to be implemented via fork(), and
> insist that the async process talk back to us only over a pipe
> descriptor (so it works whether it's a thread or a separate process).
> In cases where we use worker threads for performance (like index-pack or
> pack-objects), we just run a single "thread" instead, waiting for it to
> complete.
> 
> In the simple-ipc API, there's an explicit "async" interface. But it's
> not clear to me how rich it expects the communication with the caller to
> be (i.e., whether we could get away with the fork() trick here). Or if
> it would be OK for the threading to remain an implementation detail,
> with one "worker" upon whom we wait for completion.
> 

TBH I forgot that we still support NO_PTHREAD systems.
I seem to remember that we got rid of some of the non-pthread
stub functions at one point, but I'm fuzzy on the details.

WRT to "simple ipc" (and future "builtin fsmonitor"), it's heavily
threaded.  There's no point in trying to fake it with forks.

The server side of simple ipc implements a thread pool.  And
the builtin fsmonitor will use a thread to monitor FS events
and that thread pool to respond to clients.  All driven from a
shared queue of events.

It would be a major overhaul to do all that without threads
-- and even that assumes that nonstop has a sufficient file
system notification mechanism.

So, yes, we should ifdef it out as Peff suggests.

Jeff



>> **** ERROR **** [1210]:
>>     libgit.a(ipc-unix-socket.o): In function `thread_block_sigpipe':
>>     ipc-unix-socket.o(.text+0xb87): unresolved reference to pthread_sigmask.
>>
>> On NonStop, pthread_sigmask is defined in -lput or -lspt, which are not used in our build  and would cause a bunch of other issues
>> if referenced. The build does define NO_PTHREADS.
> 
> So yeah, you hit that problem because you only have a
> sort-of-pthreads-ish case. But it seems like a system which truly has no
> pthread support at all and defines NO_PTHREADS to tell us so will have
> much more of its compilation broken (because it's also missing obvious
> bits like pthread_create()).
> 
> We already make simple-ipc compilation conditional on NO_UNIX_SOCKETS. I
> think we could probably just do the same for NO_PTHREADS?
> 
> Something like:
> 
> diff --git a/Makefile b/Makefile
> index 3a2d3c80a8..bd7fe0fc24 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1687,14 +1687,20 @@ ifdef NO_UNIX_SOCKETS
>   else
>   	LIB_OBJS += unix-socket.o
>   	LIB_OBJS += unix-stream-server.o
> +endif
> +
> +# All simple-ipc requires threads, and then individual
> +# mechanisms have their own requirements.
> +ifndef NO_PTHREADS
> +	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
>   	LIB_OBJS += compat/simple-ipc/ipc-shared.o
> +ifndef NO_UNIX_SOCKETS
>   	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
>   endif
> -
>   ifdef USE_WIN32_IPC
> -	LIB_OBJS += compat/simple-ipc/ipc-shared.o
>   	LIB_OBJS += compat/simple-ipc/ipc-win32.o
>   endif
> +endif
>   
>   ifdef NO_ICONV
>   	BASIC_CFLAGS += -DNO_ICONV
> diff --git a/simple-ipc.h b/simple-ipc.h
> index dc3606e30b..0f58be7945 100644
> --- a/simple-ipc.h
> +++ b/simple-ipc.h
> @@ -4,11 +4,6 @@
>   /*
>    * See Documentation/technical/api-simple-ipc.txt
>    */
> -
> -#if defined(GIT_WINDOWS_NATIVE) || !defined(NO_UNIX_SOCKETS)
> -#define SUPPORTS_SIMPLE_IPC
> -#endif
> -
>   #ifdef SUPPORTS_SIMPLE_IPC
>   #include "pkt-line.h"
>   
> 
