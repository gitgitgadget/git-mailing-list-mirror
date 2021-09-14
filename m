Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2CC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D10610A2
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 05:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbhINF2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 01:28:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:46782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239411AbhINF2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 01:28:48 -0400
Received: (qmail 22804 invoked by uid 109); 14 Sep 2021 05:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 05:27:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19110 invoked by uid 111); 14 Sep 2021 05:27:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 01:27:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 01:27:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YUAyw+qVkKBEZtLx@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <xmqqa6khi9ph.fsf@gitster.g>
 <YT/3BuDa7KfUN/38@nand.local>
 <xmqqpmtbc3o3.fsf@gitster.g>
 <YUAvBso+UsBTYizb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUAvBso+UsBTYizb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 01:11:34AM -0400, Taylor Blau wrote:

> Some experiments to back that up: I instrumented the existing p5326 by
> replacing anything like "pack-objects ... --stdout >/dev/null" with
> "pack-objects ... --stdout >pack.tmp" and then added test_size's to
> measure the size of each pack.
> 
> On the tip of this branch, the results are:
> 
> 		Test                              origin/tb/multi-pack-bitmaps   HEAD
> 		----------------------------------------------------------------------------
> 		5326.5: simulated clone size                 3.3G                 3.3G +0.0%
> 		5326.7: simulated fetch size                10.5M                10.5M -0.2%
> 		5326.21: clone (partial bitmap)              3.3G                 3.3G +0.0%

I wouldn't expect a change in the clone size. We're already including
all the objects from the single pack, so we won't even look for new
deltas.

In my run, I did see a small improvement in the fetch size (though my
size both before and after was larger than yours). This is going to
depend on the exact set of deltas we have (which in turn depends on how
your repo happens to have been packed before the script even starts) and
which ones the client actually wants (which may depend on the exact tip
of your repo).

Presumably you also saw a decrease in the user CPU time of 5326.6 here.
If not, you may have forgotten the extra patch to create the pack
bitmap.

-Peff
