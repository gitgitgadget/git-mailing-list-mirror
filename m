Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C241F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbeGPWPA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:15:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:48656 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728290AbeGPWO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:14:59 -0400
Received: (qmail 17655 invoked by uid 109); 16 Jul 2018 21:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:45:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16144 invoked by uid 111); 16 Jul 2018 21:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:45:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:45:39 -0400
Date:   Mon, 16 Jul 2018 17:45:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716214539.GL25189@sigill.intra.peff.net>
References: <20180716175103.GB18636@sigill.intra.peff.net>
 <20180716182207.GA11513@aiede.svl.corp.google.com>
 <20180716185255.GC22298@sigill.intra.peff.net>
 <20180716190949.GB11513@aiede.svl.corp.google.com>
 <20180716194136.GA25189@sigill.intra.peff.net>
 <20180716195431.GD11513@aiede.svl.corp.google.com>
 <20180716202915.GC25189@sigill.intra.peff.net>
 <20180716203753.GE11513@aiede.svl.corp.google.com>
 <20180716210938.GF25189@sigill.intra.peff.net>
 <20180716214003.GH11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716214003.GH11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 02:40:03PM -0700, Jonathan Nieder wrote:

> > The key thing is that the presence of the warning/log still suppress
> > the actual gc for the gc.logExpiry period.
> 
> Ah, now I think I see the source of the misunderstanding.
> 
> When I initially read the docs, I also assumed that
> 
> 	If the file gc.log exists, then git gc --auto won’t run unless
> 	that file is more than gc.logExpiry old.
> 
> meant "git gc --auto" would be skipped (and thus silently succeed) when
> the file is less than gc.logExpiry old.  But that assumption was wrong:
> it errors out!

Right. That's the mysterious "-1" error code, and I agree that part is
confusing.

> This makes scripting difficult, since arbitrary commands that
> incidentally run "git gc --auto" will fail in this state, until gc.log
> expires (but at that point they'll fail again anyway).

I don't think any command should report failure of its _own_ operation
if "gc --auto" failed. And grepping around the source code shows that we
typically ignore it.

> For comparison, in non-daemon mode, there is nothing enforcing the
> kind of ratelimiting you are talking about.  It is an accident of
> history.  If we want this kind of ratelimiting, I'd rather we build it
> deliberately instead of relying on this accident.

What I was trying to say earlier is that we _did_ build this
rate-limiting, and I think it is a bug that the non-daemon case does not
rate-limit (but nobody noticed, because the default is daemonizing).

So the fix is not "rip out the rate-limiting in daemon mode", but rather
"extend it to the non-daemon case".

-Peff
