Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44FC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 06:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6822A611C4
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 06:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhKEGj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 02:39:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:53664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhKEGj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 02:39:28 -0400
Received: (qmail 10674 invoked by uid 109); 5 Nov 2021 06:36:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 06:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14785 invoked by uid 111); 5 Nov 2021 06:36:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 02:36:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 02:36:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh <nksingh85@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYTQ//+8OnsR60k1@coredump.intra.peff.net>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
 <xmqqk0hn1unp.fsf@gitster.g>
 <20211104223600.GA4069@neerajsi-x1.localdomain>
 <xmqqfssbz8ft.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfssbz8ft.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 06:40:22PM -0700, Junio C Hamano wrote:

> Neeraj Singh <nksingh85@gmail.com> writes:
> 
> > Is there some reason we shouldn't die if writing the ref fails? We are
> > already accustomed to dying if fsyncing a packfile or the index fails.
> 
> If we look at the surrounding code and the callers of the function,
> this caller of fsync() is about to signal a failure to its callers
> by returning an error().  The callers are prepared to see an error
> and cope with it.
> 
> Introducing die() to such a library-ish part of the code deep in the
> callchain is not exactly a good change, especially when it is
> obvious how we can avoid it.

And here's a good concrete example that relies on it: when receive-pack
is taking in a push, if the ref fails it should report that via the
protocol back to the client, rather than just hanging up the connection.
That leaves the client less confused, and gives it the opportunity to
attempt and report status on other ref updates.

-Peff
