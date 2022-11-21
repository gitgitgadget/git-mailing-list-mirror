Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 04:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKUEDL convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 20 Nov 2022 23:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUEDI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 23:03:08 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6021013D3B
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 20:03:06 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d192so10259719pfd.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 20:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0X9UTv6kDZhsaJcpHVxtLHK2j/lwCSgeLgml9YHNzc=;
        b=YQsDsoO9na5dYBIISoEH5bITJXSPOA6oLR5xpDoN+NxRiJntta+vbBVCu52Y32dpRO
         15zir82rvuGotfWgiRrY66cWhY2QRy8Jkr+8uraajwEaz5KDqmbEBbAdcd1DiXDbNExX
         1k/+W1LDXoe0Hqa+kxdCfFzhNhM+TBkwPGA6Otx8t2JMgXDEqKdn0+RgheNtIA+DtdQR
         aLPc3ii1ajVtKj8LjLGBnkhz2tCiwwXuHqIU/118lpWkrJPk6gzocsdkSHybx/gDwsnS
         Sjh8yFLRbrTXSpBTATh5t+8v1xftsY5zH6cv7do+zcvCuCO3P1wIORAirXgU3sU7A6aY
         zMtw==
X-Gm-Message-State: ANoB5pkLvtcwE/juyMk/Q9wF1zRKU78CwZbTpqTzuoJhiceQPVQO66+N
        nSm6+bH7Gz003XQ+gEJFRhOM9V7WRHlJfQ3QVVE=
X-Google-Smtp-Source: AA0mqf5w1XNmkvtTcrgrpiDTV0xYaTIRV0v8ml1aAkn98n8yCgZ9shh+hzq6o1lGvVxy/14g03VV2QRkZTzsP8C5HsA=
X-Received: by 2002:a05:6a00:b84:b0:563:4643:db33 with SMTP id
 g4-20020a056a000b8400b005634643db33mr302753pfj.22.1669003385777; Sun, 20 Nov
 2022 20:03:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr> <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
In-Reply-To: <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 20 Nov 2022 23:02:54 -0500
Message-ID: <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 6, 2022 at 7:27 PM Jeff King <peff@peff.net> wrote:
> I did some timings the other night, and I found something quite curious
> with the thread stuff.
>
> I was quite surprised that it made things slower! It's nice that we're
> only calling it once per script instead of once per test, but it seems
> the startup overhead of the script is really high.
>
> And since in this mode we're only feeding it one script at a time, I
> tried reverting the "chainlint.pl: validate test scripts in parallel"
> commit. And indeed, now things are much faster:
>
>   Benchmark 1: make
>     Time (mean ± σ):     61.544 s ±  3.364 s    [User: 556.486 s, System: 384.001 s]
>     Range (min … max):   57.660 s … 63.490 s    3 runs
>
> And you can see the same thing just running chainlint by itself:
>
>   $ time perl chainlint.pl /dev/null
>   real  0m0.069s
>   user  0m0.042s
>   sys   0m0.020s
>
>   $ git revert HEAD^{/validate.test.scripts.in.parallel}
>   $ time perl chainlint.pl /dev/null
>   real  0m0.014s
>   user  0m0.010s
>   sys   0m0.004s
>
> I didn't track down the source of the slowness. Maybe it's loading extra
> modules, or maybe it's opening /proc/cpuinfo, or maybe it's the thread
> setup. But it's a surprising slowdown.

It is surprising, and unfortunate. Ditching "ithreads" would probably
be a good idea. (more on that below)

> Now of course your intent is to do a single repo-wide invocation. And
> that is indeed a bit faster. Here it is without the parallel code:
>
>   Benchmark 1: make
>     Time (mean ± σ):     61.727 s ±  2.140 s    [User: 507.712 s, System: 377.753 s]
>     Range (min … max):   59.259 s … 63.074 s    3 runs
>
> The wall-clock time didn't improve much, but the CPU time did. Restoring
> the parallel code does improve the wall-clock time a bit, but at the
> cost of some extra CPU:
>
>   Benchmark 1: make
>     Time (mean ± σ):     59.029 s ±  2.851 s    [User: 515.690 s, System: 380.369 s]
>     Range (min … max):   55.736 s … 60.693 s    3 runs
>
> which makes sense. If I do a with/without of just "make test-chainlint",
> the parallelism is buying a few seconds of wall-clock:
>
>   Benchmark 1: make test-chainlint
>     Time (mean ± σ):     900.1 ms ± 102.9 ms    [User: 12049.8 ms, System: 79.7 ms]
>     Range (min … max):   704.2 ms … 994.4 ms    10 runs
>
>   Benchmark 1: make test-chainlint
>     Time (mean ± σ):      3.778 s ±  0.042 s    [User: 3.756 s, System: 0.023 s]
>     Range (min … max):    3.706 s …  3.833 s    10 runs
>
> I'm not sure what it all means. For Linux, I think I'd be just as happy
> with a single non-parallelized test-chainlint run for each file. But
> maybe on Windows the startup overhead is worse? OTOH, the whole test run
> is so much worse there. One process per script is not going to be that
> much in relative terms either way.

Somehow Windows manages to be unbelievably slow no matter what. I
mentioned elsewhere (after you sent this) that I tested on a five or
six year old 8-core dual-boot machine. Booted to Linux, running a
single chainlint.pl invocation using all 8 cores to check all scripts
in the project took under 1 second walltime. The same machine booted
to Windows using all 8 cores took just under two minutes(!) walltime
for the single Perl invocation to check all scripts in the project.

So, at this point, I have no hope for making linting fast on Windows;
it seems to be a lost cause.

> And if we did cache the results and avoid extra invocations via "make",
> then we'd want all the parallelism to move to there anyway.
>
> Maybe that gives you more food for thought about whether perl's "use
> threads" is worth having.

I'm not especially happy about the significant overhead of "ithreads";
on my (old) machine, although it does improve perceived time
significantly, it eats up quite a bit of additional user-time. As
such, I would not be unhappy to see "ithreads" go away, especially
since fast linting on Windows seems unattainable (at least with Perl).

Overall, I think Ævar's plan to parallelize linting via "make" is
probably the way to go.
