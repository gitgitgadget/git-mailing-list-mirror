Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1482DECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 23:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIFX1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 19:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIFX1C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 19:27:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1380A9410C
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 16:27:00 -0700 (PDT)
Received: (qmail 19970 invoked by uid 109); 6 Sep 2022 23:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Sep 2022 23:27:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6824 invoked by uid 111); 6 Sep 2022 23:27:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Sep 2022 19:27:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Sep 2022 19:26:59 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Message-ID: <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
 <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 06, 2022 at 06:52:26PM -0400, Eric Sunshine wrote:

> On Tue, Sep 6, 2022 at 6:35 PM Eric Wong <e@80x24.org> wrote:
> > Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com> wrote:
> > > +unless ($Config{useithreads} && eval {
> > > +     require threads; threads->import();
> >
> > Fwiw, the threads(3perl) manpage has this since 2014:
> >
> >        The use of interpreter-based threads in perl is officially discouraged.
> 
> Thanks for pointing this out. I did see that, but as no better
> alternative was offered, and since I did want this to work on Windows,
> I went with it.

I did some timings the other night, and I found something quite curious
with the thread stuff.

Here's a hyperfine run of "make" in the t/ directory before any of your
patches. It uses "prove" to do parallelism under the hood:

  Benchmark 1: make
    Time (mean ± σ):     68.895 s ±  0.840 s    [User: 620.914 s, System: 428.498 s]
    Range (min … max):   67.943 s … 69.531 s    3 runs

So that gives us a baseline. Now the first thing I wondered is how bad
it would be to just run chainlint.pl once per script. So I applied up to
that patch:

  Benchmark 1: make
    Time (mean ± σ):     71.289 s ±  1.302 s    [User: 673.300 s, System: 417.912 s]
    Range (min … max):   69.788 s … 72.120 s    3 runs

I was quite surprised that it made things slower! It's nice that we're
only calling it once per script instead of once per test, but it seems
the startup overhead of the script is really high.

And since in this mode we're only feeding it one script at a time, I
tried reverting the "chainlint.pl: validate test scripts in parallel"
commit. And indeed, now things are much faster:

  Benchmark 1: make
    Time (mean ± σ):     61.544 s ±  3.364 s    [User: 556.486 s, System: 384.001 s]
    Range (min … max):   57.660 s … 63.490 s    3 runs

And you can see the same thing just running chainlint by itself:

  $ time perl chainlint.pl /dev/null
  real	0m0.069s
  user	0m0.042s
  sys	0m0.020s

  $ git revert HEAD^{/validate.test.scripts.in.parallel}
  $ time perl chainlint.pl /dev/null
  real	0m0.014s
  user	0m0.010s
  sys	0m0.004s

I didn't track down the source of the slowness. Maybe it's loading extra
modules, or maybe it's opening /proc/cpuinfo, or maybe it's the thread
setup. But it's a surprising slowdown.

Now of course your intent is to do a single repo-wide invocation. And
that is indeed a bit faster. Here it is without the parallel code:

  Benchmark 1: make
    Time (mean ± σ):     61.727 s ±  2.140 s    [User: 507.712 s, System: 377.753 s]
    Range (min … max):   59.259 s … 63.074 s    3 runs

The wall-clock time didn't improve much, but the CPU time did. Restoring
the parallel code does improve the wall-clock time a bit, but at the
cost of some extra CPU:

  Benchmark 1: make
    Time (mean ± σ):     59.029 s ±  2.851 s    [User: 515.690 s, System: 380.369 s]
    Range (min … max):   55.736 s … 60.693 s    3 runs

which makes sense. If I do a with/without of just "make test-chainlint",
the parallelism is buying a few seconds of wall-clock:

  Benchmark 1: make test-chainlint
    Time (mean ± σ):     900.1 ms ± 102.9 ms    [User: 12049.8 ms, System: 79.7 ms]
    Range (min … max):   704.2 ms … 994.4 ms    10 runs

  Benchmark 1: make test-chainlint
    Time (mean ± σ):      3.778 s ±  0.042 s    [User: 3.756 s, System: 0.023 s]
    Range (min … max):    3.706 s …  3.833 s    10 runs

I'm not sure what it all means. For Linux, I think I'd be just as happy
with a single non-parallelized test-chainlint run for each file. But
maybe on Windows the startup overhead is worse? OTOH, the whole test run
is so much worse there. One process per script is not going to be that
much in relative terms either way.

And if we did cache the results and avoid extra invocations via "make",
then we'd want all the parallelism to move to there anyway.

Maybe that gives you more food for thought about whether perl's "use
threads" is worth having.

-Peff
