Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6800B20281
	for <e@80x24.org>; Tue, 19 Sep 2017 05:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750952AbdISFPI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 01:15:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:42972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750713AbdISFPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 01:15:07 -0400
Received: (qmail 3215 invoked by uid 109); 19 Sep 2017 05:15:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 05:15:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32055 invoked by uid 111); 19 Sep 2017 05:15:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 01:15:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 01:15:05 -0400
Date:   Tue, 19 Sep 2017 01:15:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] read_info_alternates: warn on non-trivial errors
Message-ID: <20170919051505.qdfycovqlcqa6n5c@sigill.intra.peff.net>
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
 <20170918155519.llmetd2ylebzokrl@sigill.intra.peff.net>
 <20170919024623.GD175206@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919024623.GD175206@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 18, 2017 at 07:46:24PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > When we fail to open $GIT_DIR/info/alternates, we silently
> > assume there are no alternates. This is the right thing to
> > do for ENOENT, but not for other errors.
> >
> > A hard error is probably overkill here. If we fail to read
> > an alternates file then either we'll complete our operation
> > anyway, or we'll fail to find some needed object. Either
> > way, a warning is good idea. And we already have a helper
> > function to handle this pattern; let's just call
> > warn_on_fopen_error().
> 
> I think I prefer a hard error.  What kind of cases are you imagining
> where it would be better to warn?
> 
> E.g. for EIO, erroring out so that the user can try again seems better
> than hoping that the application will be able to cope with the more
> subtle error that comes from discovering some objects are missing.
> 
> For EACCES, I can see how it makes sense to warn and move on, but no
> other errors like that are occuring to me.
> 
> Thoughts?

Yes, EACCES is exactly the example that came to mind.  But most
importantly, we don't know at this point whether the alternate is even
relevant to the current operation. So calling die() here would make some
cases fail that would otherwise succeed. That's usually not a big deal,
but we've had cases where being lazy about dying helps people use git
itself to help repair the case.

Admittedly most of those chicken-and-egg problems are centered around
git-config (e.g., using "git config --edit" to repair broken config), so
it's perhaps less important here. But it seems like a reasonable
principle to follow in general.

If there's a compelling reason to die hard, I'd reconsider it. But I
can't really think of one (if we were _writing_ a new alternates file
and encountered a read error of the old data we're copying, then I think
it would be very important to bail before claiming a successful write.
But that's not what's happening here).

-Peff
