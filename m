Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D698E1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 19:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeJFCrR (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 22:47:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:43706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728061AbeJFCrR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 22:47:17 -0400
Received: (qmail 25939 invoked by uid 109); 5 Oct 2018 19:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 19:47:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15479 invoked by uid 111); 5 Oct 2018 19:46:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 15:46:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 15:47:03 -0400
Date:   Fri, 5 Oct 2018 15:47:03 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone"
 due to commit graph
Message-ID: <20181005194703.GA19735@sigill.intra.peff.net>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <87in2hgzin.fsf@evledraar.gmail.com>
 <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
 <87ftxkh7bf.fsf@evledraar.gmail.com>
 <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
 <20181005192154.GD17482@sigill.intra.peff.net>
 <934fa00e-f6df-c333-4968-3e9acffab22d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <934fa00e-f6df-c333-4968-3e9acffab22d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 03:41:40PM -0400, Derrick Stolee wrote:

> > So can we really just take (total_objects - commit_graph_objects) and
> > compare it to some threshold?
> 
> The commit-graph only stores the number of _commits_, not total objects.

Oh, right, of course. That does throw a monkey wrench in that line of
thought. ;)

There's unfortunately not a fast way of doing that. One option would be
to keep a counter of "ungraphed commit objects", and have callers update
it. Anybody admitting a pack via index-pack or unpack-objects can easily
get this information. Commands like fast-import can do likewise, and
"git commit" obviously increments it by one.

I'm not excited about adding a new global on-disk data structure (and
the accompanying lock).

-Peff
