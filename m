Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BAFC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E5619E3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhCXTT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:19:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237843AbhCXTTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:19:45 -0400
Received: (qmail 14552 invoked by uid 109); 24 Mar 2021 19:19:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 19:19:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21033 invoked by uid 111); 24 Mar 2021 19:19:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 15:19:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 15:19:44 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 2/4] Makefile/coccicheck: speed up and fix bug with
 duplicate hunks
Message-ID: <YFuQ0K7o2Yy/RoWs@coredump.intra.peff.net>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <3bca3239cb84488a1638f2bb269392f47f78c6da.1616414951.git.avarab@gmail.com>
 <365dd12a-b96e-8daf-ba34-bc7d40f39634@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <365dd12a-b96e-8daf-ba34-bc7d40f39634@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 07:05:06PM +0100, René Scharfe. wrote:

> > This change speeds up the runtime of "make -j8 coccicheck" from ~1m50s
> > to ~1m20s for me. See [2] for more timings.
> 
> Without this patch, /usr/bin/time -l reports:
> 
>        95.08 real       598.29 user        32.62 sys
>            103727104  maximum resident set size
> 
> With --include-headers-for-types, I get this:
> 
>        76.37 real       483.83 user        26.77 sys
>             97107968  maximum resident set size
> 
> This is similar to your numbers.  And adding that option to the demo
> script in your [1] gives consistent results for all xargs -n values,
> so that option alone fixes the subtle bug you refer to above, right?
> 
> However, with the second part of this patch also applied (adding %.h
> to FOUND_C_SOURCES), I get this:
> 
>        90.38 real       558.38 user        38.32 sys
>            100073472  maximum resident set size
> 
> Is this still necessary?

If I understand what the spatch options are doing (and I'm not at all
sure that I do), then with --include-headers-for-types, aren't we
avoiding looking for transformations in the included files?

In which case not adding *.h to the list of files we pass means that
we'd fail to find instances in the header files that need to be
mentioned in the output.

-Peff
