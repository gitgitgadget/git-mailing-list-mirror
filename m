Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38172C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 16:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiGAQ10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiGAQ1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 12:27:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233241307
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 09:27:21 -0700 (PDT)
Received: (qmail 8640 invoked by uid 109); 1 Jul 2022 16:27:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 16:27:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26877 invoked by uid 111); 1 Jul 2022 16:27:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 12:27:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 12:27:17 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/5] Avoid spawning gzip in git archive
Message-ID: <Yr8gZT6dbCpzaR9n@coredump.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
 <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet>
 <0aa5c101-06bf-325c-efbc-6b4ef38616c5@web.de>
 <ps52p06s-01nr-4ss2-r802-6nsp5nqq5199@tzk.qr>
 <038r075o-5s5r-9sop-5o02-8s84428o0r54@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <038r075o-5s5r-9sop-5o02-8s84428o0r54@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2022 at 06:05:59PM +0200, Johannes Schindelin wrote:

> Stolee pointed out to me that objects inside pack files are also
> zlib-compressed, and that measuring the speed of `git rev-list --objects
> --all --count` might therefore be a better test.

That will spend quite a lot of time doing hash-lookups for each tree
entry. A better raw zlib test might be:

  git cat-file --batch --batch-all-objects --unordered >/dev/null

which will just dump each object, and should mostly be zlib and delta
reconstruction (the --unordered is important to hit the deltas in the
right order).

> And this is where things get a little messy: in the context of Git for
> Windows, my local measurements indicate that zlib is better, with ~41
> seconds using zlib vs ~52 seconds using zlib-ng (but the latter has a
> rather large variance).

That is a surprising slow-down between the two. I'd expect the command
above to show even more pronounced results, though, as it's spending
less time doing non-zlib things. But it's still just inflating (as
opposed to git-archive, which is both inflating and deflating).

-Peff
