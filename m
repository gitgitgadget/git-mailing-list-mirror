Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71132018D
	for <e@80x24.org>; Wed, 10 May 2017 01:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbdEJBZ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 21:25:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:48538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdEJBZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 21:25:56 -0400
Received: (qmail 2537 invoked by uid 109); 10 May 2017 01:25:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 01:25:52 +0000
Received: (qmail 31226 invoked by uid 111); 10 May 2017 01:26:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 21:26:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 21:25:50 -0400
Date:   Tue, 9 May 2017 21:25:50 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] :(attr) pathspecs can die("BUG") in the tree-walker
Message-ID: <20170510012550.3qs3ra2c7ehbnixs@sigill.intra.peff.net>
References: <20170509222432.3dxt7osjt2zjtaiw@sigill.intra.peff.net>
 <20170509225219.GB106700@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170509225219.GB106700@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 03:52:19PM -0700, Brandon Williams wrote:

> >   $ git log HEAD -- ':(attr:-diff)'
> >   fatal: BUG:tree-walk.c:947: unsupported magic 40
> > 
> > Whoops. This is presumably ls-tree is protected, but I think we are
> > missing a GUARD_PATHSPEC call somewhere.
> > 
> > This isn't a huge deal, as the correct behavior is probably to die like
> > ls-tree does, but we probably shouldn't be hitting BUG assertions as a
> > general rule.
> 
> The die("BUG: ..."); is from a GAURD_PATHSPEC call.  What really needs
> to happen is to update the magic_mask passed into the parse_pathspec
> call which initializes the pathspec object.  Its this magic_mask which
> catches unsupported magic and prints a better message.

Ah, right, I always get the pathspec safety bits mixed up. I think the
parse_pathspec() call in setup_revisions is a bit permissive:

  parse_pathspec(&revs->prune_data, 0, 0,
		 revs->prefix, prune_data.path);

You _shouldn't_ need to audit all the callers when you add new pathspec
magic. The callers should be masking out the bits that they know they
support, but this one isn't.  It looks like there are a number of such
permissive calls, though. I guess it was an attempt to not have to list
them manually at each call site (but then we suffer from the exact
problem I ran into).

> I guess this means I (or someone else :D) should audit all the
> parse_pathspec calls and ensure that 'attr' magic is turned off until we
> won't run into these GAURD_PATHSPEC die's.

Of course it would be nicer still if the 'attr' magic actually worked
via the tree-walking code. :)

-Peff
