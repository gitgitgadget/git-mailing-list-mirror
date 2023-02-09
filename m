Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D2C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 13:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBINMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 08:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBINMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 08:12:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8E37576
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 05:12:37 -0800 (PST)
Received: (qmail 634 invoked by uid 109); 9 Feb 2023 13:12:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Feb 2023 13:12:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12868 invoked by uid 111); 9 Feb 2023 13:12:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Feb 2023 08:12:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Feb 2023 08:12:36 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham <mjcheetham@outlook.com>
Cc:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 11/12] http: read HTTP WWW-Authenticate response
 headers
Message-ID: <Y+TxRDatM9Iirwwu@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <5f5e46038cf526714f3c5b89ffef2b895b503242.1674252531.git.gitgitgadget@gmail.com>
 <Y9JWnQeEV0weV4yu@coredump.intra.peff.net>
 <DB9PR03MB983150E73B1C963C628CBE75C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR03MB983150E73B1C963C628CBE75C0DA9@DB9PR03MB9831.eurprd03.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2023 at 11:25:49AM -0800, Matthew John Cheetham wrote:

> > I guess I would have expected some level of abstraction here between the
> > credential subsystem and the http subsystem, where the latter is parsing
> > and then sticking opaque data into the credential to ferry to the
> > helpers.
> > 
> > But it probably isn't that big a deal either way. Even though there are
> > non-http credentials, it's not too unreasonable for the credential
> > system to be aware of http specifically.
> 
> I had considered possibly introducing an opaque property-bag style of
> 'protocol-specific properties' that, for example, http.c would add the
> WWW-Authenticate headers to as something like `http.wwwauth[]`.
> Other protocols (like smtp:// or cert://) could add their own properties
> if they needed or wanted to also.
> 
> Thoughts?

At the protocol level, I don't see much point. wwwauth sufficiently
implies "http", and any helper is free to ignore or respect keys as
appropriate to what it can handle. A flat namespace is fine.

Here I was more talking about the internal implementation. Mostly it was
just funky that this internal http state flag was stuck into the
credential struct. I think it could be removed with some minor pain, but
it's probably not too big a deal (the pain at all is only because we are
having to bring this state across multiple curl callbacks).

So let's go with it for now.

-Peff
