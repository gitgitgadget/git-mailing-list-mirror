Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1FEC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712E560F4C
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhINRYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:24:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:47212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230111AbhINRYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:24:48 -0400
Received: (qmail 24631 invoked by uid 109); 14 Sep 2021 17:23:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 17:23:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25663 invoked by uid 111); 14 Sep 2021 17:23:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 13:23:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 13:23:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUDakl7dcJpfve0T@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:06AM -0400, Jeff King wrote:

> The limit here is fairly arbitrary, and probably much higher than anyone
> would need in practice. It might be worth limiting it further, if only
> because we check it linearly (so with "m" local refs and "n" patterns,
> we do "m * n" string comparisons). But if we care about optimizing this,
> an even better solution may be a more advanced data structure anyway.

The limit I picked is 65536, because it seemed round and high. But note
that somebody can put up to almost-64k in a single ref-prefix line,
which means ultimately you can allocate 4GB. I do wonder if dropping
this to something like 1024 might be reasonable.

In practice I'd expect it to be a handful in most cases (refs/heads/*,
refs/tags/*, HEAD). But if you do something like:

  git fetch $remote 1 2 3 4 5 6 7 ...

then we'll prefix-expand those names with the usual lookup rules into
refs/1, refs/heads/1, refs/2, refs/heads/2, and so on.

At some point it becomes silly and works counter to the purpose of the
optimization (you send more prefix constraints than the actual ref
advertisement, not to mention that client bandwidth may not be
symmetric). I'm not sure what we want to declare as a reasonable limit.

And this is just about protecting the server; probably it makes sense
for the client to realize it's going to send a ridiculous number of
prefixes and just skip the feature entirely (since that's what actually
saves the bandwidth).

-Peff
