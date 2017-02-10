Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C763A1FD6A
	for <e@80x24.org>; Fri, 10 Feb 2017 00:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbdBJAgy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 19:36:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:52687 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752014AbdBJAgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 19:36:53 -0500
Received: (qmail 15621 invoked by uid 109); 10 Feb 2017 00:36:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 00:36:35 +0000
Received: (qmail 13884 invoked by uid 111); 10 Feb 2017 00:36:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 19:36:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Feb 2017 19:36:32 -0500
Date:   Thu, 9 Feb 2017 19:36:32 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH] gc: ignore old gc.log files
Message-ID: <20170210003632.7ghlgfulwdsntlag@sigill.intra.peff.net>
References: <20170209020222.23642-1-dturner@twosigma.com>
 <20170209032325.bspll66ux6n2pj4n@sigill.intra.peff.net>
 <1637154470724DABAC99AF6199707A4B@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1637154470724DABAC99AF6199707A4B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 09, 2017 at 11:57:12PM -0000, Philip Oakley wrote:

> > > +gc.maxLogAge::
> > > + If the file gc.log exists, then `git gc --auto` won't run
> > > + unless that file is more than maxLogAge seconds old.  Default
> > > + is 86400, one day.
> 
> Is there a reason why one day is chosen? If maintenance staff are available
> 24/7 then a shorter time would be appropriate, but if it's a 5 day work week
> then they may want longer. Is there a particular case it targets?

I'm pretty sure the one-day time limit isn't scientific. It's just a
number we've been throwing around.

I'm not sure what maintenance staff matters, though. It basically needs
long enough that we're not doing _too_ many fruitless gc's, because it
wastes resources. But you'd prefer to not go too long without a gc for a
repository that needs it.

The root cause of the error could be any number of issues. But for the
case that David cares about most, you basically want to keep trying
until the too-many-objects condition goes away. That's usually on a
2-week timer. So trying once per day to see if the 2-week timer feels
about right.

That's certainly not science, but hopefully it at least frames the
general ballpark.

One possible option would be to auto-scale it with the pruneExpire time.
I don't know if people actually tweak that value or not.

-Peff
