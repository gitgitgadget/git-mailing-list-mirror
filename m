Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AEC21F42B
	for <e@80x24.org>; Mon, 17 Sep 2018 18:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeIRACL (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:02:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:51172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbeIRACL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:02:11 -0400
Received: (qmail 15739 invoked by uid 109); 17 Sep 2018 18:33:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Sep 2018 18:33:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14918 invoked by uid 111); 17 Sep 2018 18:33:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Sep 2018 14:33:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2018 14:33:37 -0400
Date:   Mon, 17 Sep 2018 14:33:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] gc: exit with status 128 on failure
Message-ID: <20180917183336.GA4630@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065416.GC177907@aiede.svl.corp.google.com>
 <20180717195946.GC26218@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717195946.GC26218@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 03:59:47PM -0400, Jeff King wrote:

> On Mon, Jul 16, 2018 at 11:54:16PM -0700, Jonathan Nieder wrote:
> 
> > A value of -1 returned from cmd_gc gets propagated to exit(),
> > resulting in an exit status of 255.  Use die instead for a clearer
> > error message and a controlled exit.
> 
> This feels a little funny because we know we're going to turn some of
> these back in the next patch. That said, I'm OK with it, since this
> version is already written.

There's discussion elsewhere[1] of applying just up to patch 2.

Do we still want to convert these cases to die() as their end-state?
Another alternative would be to just convert a "-1" return to 128 or
similar at the level of cmd_gc(), which avoids the 255 weirdness.

Doing so also keeps the error messages the same as (as "error" and not
"fatal"). I'm not sure which we prefer.

It also makes the code more flexible and lib-ifiable (since the caller
can decide how to handle the errors). That probably doesn't matter much
since this is all static-local to builtin/gc.c, though I suppose in
theory we could eventually do parts of "gc --auto" without spawning a
separate process.

-Peff

[1] https://public-inbox.org/git/20180917182210.GB3894@sigill.intra.peff.net/
