Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA892208DB
	for <e@80x24.org>; Sat, 26 Aug 2017 01:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbdHZBAX (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 21:00:23 -0400
Received: from avasout07.plus.net ([84.93.230.235]:33813 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdHZBAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 21:00:22 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id 1cxK1w0020M91Ur01cxLWr; Sat, 26 Aug 2017 01:57:20 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=EBOSESyhAAAA:8 a=BbSOwUQuxqhCuBP-v9YA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: cat-file timing window on Cygwin
To:     Jeff King <peff@peff.net>, Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
Date:   Sat, 26 Aug 2017 01:57:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/08/17 16:08, Jeff King wrote:
> On Fri, Aug 25, 2017 at 12:25:29PM +0100, Adam Dinwoodie wrote:
> 
>> As of v2.10.0-rc1-4-g321459439 ("cat-file: support --textconv/--filters
>> in batch mode"), t8010-cat-file-filters.sh has been failing on Cygwin.
>> Digging into this, the test looks to expose a timing window: it appears
>> that if `git cat-file --textconv --batch` receives input on stdin too
>> quickly, it fails to parse some of that input.

This has not been failing since the above commit (when this
feature was first introduced), but (for me) when testing the
v2.13.0-rc0 build. Please refer to my original email:

https://public-inbox.org/git/bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com/

... where I was reasonably sure this was caused by a change in
the cygwin dll while upgrading from 2.7.0-1 -> 2.8.0-1.

> Hmm. That commit doesn't seem to actually touch the stdin loop. That
> happens via strbuf_getline(), which should be pretty robust to timing.
> But here are a few random thoughts:
> 
>   1. Do you build with HAVE_GETDELIM? Does toggling it have any effect?

If Adam builds using the configure script, then yes, else no. ;-)
I never use configure, so I don't have HAVE_GETDELIM set.

>   2. Does the problem happen only with --textconv?
> 
>      If so, I wonder if spawning the child process is somehow draining
>      stdin. I don't see how the child would accidentally read from our
>      stdin; we replace its stdin with a pipe so it shouldn't get a
>      chance to see our descriptor at all.

As I said in my previous email, "the loop in batch_objects()
(builtin/cat-file.c lines #489-505) only reads one line from
stdin, then gets EOF on the stream."

>      If we accidentally called fflush(stdin) that would discard buffered
>      input and give the results you're seeing. We don't do that
>      directly, of course, but we do call fflush(NULL) in run-command
>      before spawning the child. That _should_ just flush output handles,
>      but it's possible that there's a cygwin bug, I guess.

I suspect so, see previous email ...

> I can't reproduce here on Linux. But does the patch below have any
> impact?
> 
> diff --git a/run-command.c b/run-command.c
> index 98621faca8..064ebd1995 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -641,7 +641,6 @@ int start_command(struct child_process *cmd)
>  	}
>  
>  	trace_argv_printf(cmd->argv, "trace: run_command:");
> -	fflush(NULL);
>  
>  #ifndef GIT_WINDOWS_NATIVE
>  {

I suspect not, but I can give it a try ...

... oh, wow, that works! Ahem. (Hmm, so it's flushing stdin?!)

Also, t5526-fetch-submodules.sh still works as well (see commit
13af8cbd6a "start_command: flush buffers in the WIN32 code path
as well", 04-02-2011).

ATB,
Ramsay Jones


