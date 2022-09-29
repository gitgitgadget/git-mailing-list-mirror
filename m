Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865CCC433F5
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 11:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiI2L1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiI2L1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 07:27:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB6B14D4BA
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 04:27:16 -0700 (PDT)
Received: (qmail 10981 invoked by uid 109); 29 Sep 2022 11:27:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Sep 2022 11:27:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9624 invoked by uid 111); 29 Sep 2022 11:27:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Sep 2022 07:27:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Sep 2022 07:27:14 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/3] read-cache: read on-disk entries in byte order
Message-ID: <YzWBEoRkCmbUkIs8@coredump.intra.peff.net>
References: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
 <YzPLuizoOlDuPu4G@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzPLuizoOlDuPu4G@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2022 at 12:21:15AM -0400, Jeff King wrote:

> The downside is that we're copying the data an extra time. It's not very
> much data, and it's all fixed size, so the compiler should be able to do
> a reasonable job of optimizing here. But I didn't time the potential
> impact.

I timed this using "test-tool read-cache". It's kind of an artificial
benchmark, but it does isolate the code we're touching here. The results
are...not good. Here's the time to read the index of linux.git 1000
times, before and after this reordering patch:

  Benchmark 1: ./test-tool.old read-cache 1000
    Time (mean ± σ):      2.870 s ±  0.073 s    [User: 2.555 s, System: 0.315 s]
    Range (min … max):    2.789 s …  3.001 s    10 runs
  
  Benchmark 2: ./test-tool.new read-cache 1000
    Time (mean ± σ):      3.180 s ±  0.080 s    [User: 2.849 s, System: 0.331 s]
    Range (min … max):    3.092 s …  3.297 s    10 runs
  
  Summary
    './test-tool.old read-cache 1000' ran
      1.11 ± 0.04 times faster than './test-tool.new read-cache 1000'

I think that's probably the nail in the coffin for my proposed approach.
To be fair, it's only .3ms extra for a normal program which reads the
index once. That's not that big in absolute numbers. But there are
larger index files in the wild. And the improvement in simplicity and
readability is simply not that great.

-Peff
