Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B71C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3156126A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhKEJHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:07:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:53736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhKEJHG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 05:07:06 -0400
Received: (qmail 11227 invoked by uid 109); 5 Nov 2021 09:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 09:04:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15954 invoked by uid 111); 5 Nov 2021 09:04:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 05:04:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 05:04:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYTzmWzAaqvGFu/v@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
 <xmqqk0hn1unp.fsf@gitster.g>
 <20211104223600.GA4069@neerajsi-x1.localdomain>
 <211105.865yt7hu7x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211105.865yt7hu7x.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 05, 2021 at 09:35:24AM +0100, Ævar Arnfjörð Bjarmason wrote:

> So if we're in the middle of a transaction and have created and written
> the lockfile we might only notice that the disk has is full when we do
> the fsync().
> 
> In that case we'll (or should, I didn't check just now) unroll the ref
> transaction, and delete the *.lock files we created, which presumably
> will succeed in that scenario.
> 
> So calling die() at this level is the difference between leaving the
> repo in an inconsistent state due to a disk error, and something like
> "git fetch --atomic" gracefully failing.

We should rollback the lockfiles even if we call die(), via the atexit()
handler. Ditto if we receive a fatal signal.

(But I completely agree that if we have the opportunity to just pass the
error up the stack, we should do so).

-Peff
