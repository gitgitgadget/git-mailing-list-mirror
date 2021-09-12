Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE18C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2567360F51
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhILWCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:02:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:45668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235898AbhILWCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:02:14 -0400
Received: (qmail 16994 invoked by uid 109); 12 Sep 2021 22:00:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 22:00:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2644 invoked by uid 111); 12 Sep 2021 22:00:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 18:00:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 18:00:58 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] strvec: use size_t to store nr and alloc
Message-ID: <YT54mskEIir2gXc2@coredump.intra.peff.net>
References: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
 <87o88z82pc.fsf@evledraar.gmail.com>
 <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 11:48:38PM +0100, Philip Oakley wrote:

> I'm particularly interested in the int -> size_t change problem as part
> of the wider 4GB limitations for the LLP64 systems [0] such as the
> RaspPi, git-lfs (on windows [1]), and Git-for-Windows[2]. It is a big
> problem.

Note that a lot of the Windows LLP64 problems are really a separate
issue. They come from a misuse of "unsigned long" as "gee, this should
be big enough for anything". Most of that is due to its use for object
sizes, which of course infected a whole bunch of other code.

Which isn't to say it's not important. But my main goal here was making
sure we use size_t for growth allocations to avoid integer overflow
leading to under-allocation (and thus heap overflow).

-Peff
