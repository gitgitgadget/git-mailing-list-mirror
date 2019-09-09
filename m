Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F0D1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405371AbfIIREF (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:04:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:44310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727295AbfIIREF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:04:05 -0400
Received: (qmail 20449 invoked by uid 109); 9 Sep 2019 17:04:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 17:04:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10508 invoked by uid 111); 9 Sep 2019 17:05:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 13:05:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 13:04:04 -0400
From:   Jeff King <peff@peff.net>
To:     Douglas Graham <douglas.graham@ericsson.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: O_NONBLOCK: should I blame git or ssh?
Message-ID: <20190909170403.GB30399@sigill.intra.peff.net>
References: <BN8PR15MB302515278334F3BD7B63D519F0B50@BN8PR15MB3025.namprd15.prod.outlook.com>
 <20190908102839.GC15641@sigill.intra.peff.net>
 <BN8PR15MB302520248BB1AD49B28C3AB3F0B40@BN8PR15MB3025.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN8PR15MB302520248BB1AD49B28C3AB3F0B40@BN8PR15MB3025.namprd15.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 02:18:15PM +0000, Douglas Graham wrote:

> When I collected that strace output, I had stdout redirected to a pipe to my
> workaround program, but I did not redirect stderr.  So ssh made stdout non-blocking,
> but since stderr was still connected to my terminal, it didn't touch that. But when
> this build is run under Jenkins, both stdout and stderr are connected to a pipe that
> Jenkins creates to collect output from the build. I assume that when git runs ssh, it
> does not redirect ssh's stderr to its own pipe, it only redirects stdout. So I think
> ssh will be messing with both pipes when this build is run under Jenkins.

OK, that makes sense.

> Now that I have a fairly good understanding of what's happening, I think I can work
> around this occasional error by redirecting git's stderr to a file or something like
> that, but it's taken us a long time to figure this out, so I wonder if a more permanent
> fix shouldn't be implement, so others don't run into the same problem.  A google for
> "make: write error" indicates that we're not the first to have this problem with
> parallel builds, although in the other cases I've found, a specific version of the
> Linux kernel was being blamed.  Maybe that was a different problem.
> 
> I guess git could workaround this by redirecting stderr, but the real problem is probably
> with ssh, although it's not clear to me what it should do differently. It does some
> somehow backwards to me that that it only makes a descriptor non-blocking if it doesn't
> refer to a TTY, but it does the same thing in at least three different places so I guess
> that's  not a mistake.

Where would git redirect the stderr to? We definitely want to make sure
it goes to our original stderr, since it can have useful content for the
user to see. We could make a new pipe and then pump the output back to
our original stderr. But besides being complex, that fools the
downstream programs about whether stderr is a tty (I don't know whether
ssh cares, but certainly git itself uses that to decide on some elements
of the output, mostly progress meters).

So I think it would make more sense to talk to ssh folks about why this
momentary O_NONBLOCK setting happens, and if it can be avoided.

-Peff
