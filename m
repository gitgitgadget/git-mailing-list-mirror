Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ECBD1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfFTKVF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:21:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:45702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726234AbfFTKVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:21:05 -0400
Received: (qmail 18474 invoked by uid 109); 20 Jun 2019 10:21:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 10:21:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14464 invoked by uid 111); 20 Jun 2019 10:21:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 06:21:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 06:21:03 -0400
Date:   Thu, 20 Jun 2019 06:21:03 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: only run 'gc' once when fetching multiple remotes
Message-ID: <20190620102103.GA15212@sigill.intra.peff.net>
References: <20190619094630.32557-1-pclouds@gmail.com>
 <20190619185934.GC28145@sigill.intra.peff.net>
 <CACsJy8A5K4hNKy1LupQJ8is4AgTAyzfW+qhMYkcBmS_kvnE23Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8A5K4hNKy1LupQJ8is4AgTAyzfW+qhMYkcBmS_kvnE23Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 05:11:03PM +0700, Duy Nguyen wrote:

> > Another option would be to just pass "-c gc.auto=0" to the child
> > processes to inhibit auto-gc. But maybe it makes sense to have a nicer
> > interface (after all, somebody else could be doing the same "let's do a
> > bunch of fetches in a row" without using the multi-fetch code).
> 
> Nah to me -c is much nicer (and flexible too). The only thing I'm not
> sure about is whether a user could override it. If fetch.c adds -c
> gc.auto=0 automatically, and the user wants auto gc back, will "git -c
> gc.auto=non-zero fetch --multiple" still work?
> 
> I haven't checked git_config_push_parameter() carefully, but I have an
> impression that the parameter order there is "wrong", at least in this
> case.

It depends what you're trying to get it to do.

I'd expect that command to turn on auto-gc for just the outer fetch
(i.e., overriding any on-disk disabling of auto-gc), but keep it off for
the child fetches. And I think that is how it would behave: the outer
fetch only sees the config you provided. The inner ones see
"gc.auto=non-zero gc.auto=0-zero" because git_config_push_parameter()
appends. And they accept the latter under last-one-wins rules.

If you expect to be able to re-enable auto-gc in the child fetches, then
I don't think there would be a way to do that.

> > Though there I kind of wonder if this would apply to other scripted
> > uses, too. E.g., if I'm doing a bunch of commits, I might want to
> > inhibit auto-gc and then run it myself at the end. Should we support
> > "GIT_AUTO_GC=0" in the environment (and a matching "git --no-auto-gc
> > ..." option that could be used here)?
> 
> export GIT_CONFIG=gc.auto=0 ?

Almost. The parser for GIT_CONFIG_PARAMETERS is very picky about seeing
single quotes around each item, which makes it a little unfriendly to
use manually. Plus there may be existing values if your script was
invoked as "git -c whatever my-script".

It's probably not that big a deal for a script to just use "git -c
gc.auto" to inhibit auto-gc for each command that needs it.

-Peff
