Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C369C433FE
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A4F60FE3
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhKJUsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 15:48:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:57114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232195AbhKJUsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 15:48:04 -0500
Received: (qmail 30676 invoked by uid 109); 10 Nov 2021 20:45:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 20:45:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20395 invoked by uid 111); 10 Nov 2021 20:45:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 15:45:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 15:45:11 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/3] refs: sync loose refs to disk before committing
 them
Message-ID: <YYwvVy6AWDjkWazn@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1636544377.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 12:40:50PM +0100, Patrick Steinhardt wrote:

> Please note that I didn't yet add any performance numbers or tests.
> Performance tests didn't show any conclusive results on my machine given
> that I couldn't observe any noticeable impact at all, and I didn't write
> tests yet given that I first wanted to get some feedback on this series.
> If we agree that this is the correct way to go forward I'll of course
> put in some more time to add them.

Here's a mild adjustment of the quick test I showed earlier in [1]. It
uses your version for all cases, but swaps between the three config
options, and it uses --atomic to put everything into a single
transaction:

  $ hyperfine -L v false,true,batch -p ./setup 'git -C dst.git config core.fsyncreffiles {v}; git.compile push --atomic dst.git refs/heads/*'
  Benchmark 1: git -C dst.git config core.fsyncreffiles false; git.compile push --atomic dst.git refs/heads/*
    Time (mean ± σ):      10.5 ms ±   0.2 ms    [User: 7.8 ms, System: 3.9 ms]
    Range (min … max):    10.1 ms …  11.0 ms    108 runs
   
  Benchmark 2: git -C dst.git config core.fsyncreffiles true; git.compile push --atomic dst.git refs/heads/*
    Time (mean ± σ):     402.5 ms ±   6.2 ms    [User: 13.9 ms, System: 10.7 ms]
    Range (min … max):   387.3 ms … 408.9 ms    10 runs
   
  Benchmark 3: git -C dst.git config core.fsyncreffiles batch; git.compile push --atomic dst.git refs/heads/*
    Time (mean ± σ):      21.4 ms ±   0.6 ms    [User: 8.0 ms, System: 5.2 ms]
    Range (min … max):    20.7 ms …  24.9 ms    99 runs
   
  Summary
    'git -C dst.git config core.fsyncreffiles false; git.compile push --atomic dst.git refs/heads/*' ran
      2.05 ± 0.07 times faster than 'git -C dst.git config core.fsyncreffiles batch; git.compile push --atomic dst.git refs/heads/*'
     38.51 ± 1.06 times faster than 'git -C dst.git config core.fsyncreffiles true; git.compile push --atomic dst.git refs/heads/*'

So yes, the "batch" case is much improved. It's still more expensive
than skipping the fsync entirely, but it's within reason. The trick,
though is the --atomic. If I drop that flag, then "batch" takes as long
as "true". And of course that's the default.

I wonder if that means we'd want an extra mode: do the WRITEOUT_ONLY
flush, but _don't_ do a HARDWARE_FLUSH for each transaction. That
doesn't give you durability, but it (in theory) solves the out-of-order
journal problem without paying any performance cost.

I say "in theory" because I'm just assuming that the WRITEOUT thing
works as advertised. I don't have an easy way to test the outcome on a
power failure at the right moment here.

-Peff

[1] https://lore.kernel.org/git/YYTaiIlEKxHRVdCy@coredump.intra.peff.net/
