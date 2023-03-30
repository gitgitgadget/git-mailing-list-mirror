Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A3C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 22:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjC3WJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjC3WJI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 18:09:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86914EF80
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 15:08:47 -0700 (PDT)
Received: (qmail 32034 invoked by uid 109); 30 Mar 2023 22:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 Mar 2023 22:08:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22227 invoked by uid 111); 30 Mar 2023 22:08:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Mar 2023 18:08:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Mar 2023 18:08:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 0/4] some chainlint fixes and performance improvements
Message-ID: <20230330220823.GA130426@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328210814.GA1754178@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328210814.GA1754178@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 05:08:15PM -0400, Jeff King wrote:

> BTW, I noticed something really funky when timing t3070 for this series.
> 
>   $ time ./t3070-wildmatch.sh
>   [a bunch of output]
>   real	0m4.750s
>   user	0m3.665s
>   sys	0m0.955s
> 
>   $ time ./t3070-wildmatch.sh >/dev/null
>   real	0m18.664s
>   user	0m9.185s
>   sys	0m9.495s
> 
> Er, what? It gets way slower when redirected to /dev/null. I can't
> figure out why.

In case anyone is curious (and I know you were all on the edge of your
seats), I figured this out. The issue is that with the "powersave" CPU
governor in place, we never ratchet up the CPU frequency. Perhaps
because no process is pegging the CPU, but we just have tons of small
processes that quickly exit (which seems like a blind spot in the
governor, but at least makes some sense).

When the output is going to the terminal, then the terminal is consuming
CPU, and the frequency scales up. So it's faster when we show the
output, even though we're doing more work, because the CPU clock is
faster. Switching to the "performance" governor makes the problem go
away.

I cared for this series, of course, because I wanted to run t3070 under
hyperfine, which behaves like the /dev/null case (unless you pass
--show-output, which mangles the screen, and is why the hyperfine output
I showed earlier was so terse). So with the performance governor in
place, here's the hyperfine output for the whole series (this is on the
5-patch v2):

  $ hyperfine -P parent 0 5 -s 'git checkout jk/chainlint-fixes~{parent}' \
      -n 't3070 on jk/chainlint-fixes~{parent}' ./t3070-wildmatch.sh

  Benchmark 1: t3070 on jk/chainlint-fixes~0
    Time (mean ± σ):      3.677 s ±  0.047 s    [User: 2.893 s, System: 0.677 s]
    Range (min … max):    3.606 s …  3.725 s    10 runs
  
  Benchmark 2: t3070 on jk/chainlint-fixes~1
    Time (mean ± σ):      3.720 s ±  0.013 s    [User: 2.941 s, System: 0.676 s]
    Range (min … max):    3.698 s …  3.738 s    10 runs
  
  Benchmark 3: t3070 on jk/chainlint-fixes~2
    Time (mean ± σ):      4.224 s ±  0.019 s    [User: 3.291 s, System: 0.850 s]
    Range (min … max):    4.191 s …  4.254 s    10 runs
  
  Benchmark 4: t3070 on jk/chainlint-fixes~3
    Time (mean ± σ):      4.227 s ±  0.018 s    [User: 3.293 s, System: 0.856 s]
    Range (min … max):    4.198 s …  4.252 s    10 runs
  
  Benchmark 5: t3070 on jk/chainlint-fixes~4
    Time (mean ± σ):      4.604 s ±  0.014 s    [User: 3.599 s, System: 0.887 s]
    Range (min … max):    4.583 s …  4.629 s    10 runs
  
  Benchmark 6: t3070 on jk/chainlint-fixes~5
    Time (mean ± σ):      4.603 s ±  0.010 s    [User: 3.578 s, System: 0.904 s]
    Range (min … max):    4.583 s …  4.617 s    10 runs
  
  Summary
    't3070 on jk/chainlint-fixes~0' ran
      1.01 ± 0.01 times faster than 't3070 on jk/chainlint-fixes~1'
      1.15 ± 0.02 times faster than 't3070 on jk/chainlint-fixes~2'
      1.15 ± 0.02 times faster than 't3070 on jk/chainlint-fixes~3'
      1.25 ± 0.02 times faster than 't3070 on jk/chainlint-fixes~5'
      1.25 ± 0.02 times faster than 't3070 on jk/chainlint-fixes~4'

Which is what we'd expect. We got about 1.25x faster, in two jumps at ~3
and ~1, which were the patches removing subshells (marking commits by
their parent number is rather confusing; I think it might be worth
making a small hyperfine wrapper that feeds the commit summary to "-n").

So no effect on the series (good), but I didn't want to leave the
mystery unsolved on the list. :)

-Peff
