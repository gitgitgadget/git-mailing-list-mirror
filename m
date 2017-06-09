Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FE2E1FAEB
	for <e@80x24.org>; Fri,  9 Jun 2017 05:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdFIF16 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 01:27:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:36940 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbdFIF15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 01:27:57 -0400
Received: (qmail 648 invoked by uid 109); 9 Jun 2017 05:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 05:27:57 +0000
Received: (qmail 18756 invoked by uid 111); 9 Jun 2017 05:27:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 01:27:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jun 2017 01:27:55 -0400
Date:   Fri, 9 Jun 2017 01:27:55 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "There are too many unreachable loose objects" - why don't we
 run 'git prune' automatically?
Message-ID: <20170609052755.dsuqd4gizi2opoya@sigill.intra.peff.net>
References: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9C2F2EA2-0C59-4EA2-8C8E-10228FB82D90@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 02:45:48PM +0200, Lars Schneider wrote:

> I recently ran into "There are too many unreachable loose objects; run 
> 'git prune' to remove them." after a "Auto packing the repository in 
> background for optimum performance." message.
> 
> This was introduced with a087cc9 "git-gc --auto: protect ourselves from 
> accumulated cruft" but I don't understand the commit message really.
> 
> Why don't we call 'git prune' automatically? I though Git would prune
> unreachable objects after 90 days by default anyways. Is the warning 
> about unreachable objects that are not yet 90 days old?

We _do_ call "git prune", but we do so with whatever configured
expiration time is (by default 2 weeks; the 90-day expiration is for
reflogs).

The problem is that auto-gc kicked in because there were a bunch of
loose objects, but after repacking and running "git prune" there were
still enough loose objects to trigger auto-gc. Which means every command
you run will do an auto-gc that never actually helps.

So you have two options:

  1. Wait until those objects expire (which may be up to 2 weeks,
     depending on how recent they are), at which point your auto-gc will
     finally delete them.

  2. Run "git prune". Without an argument it prunes everything now,
     with no expiration period.

I agree the existing message isn't great. There should probably be a big
advise() block explaining what's going on (and that expert users can
disable).

-Peff
