Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A392C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjC1Rvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC1Rvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:51:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D5DD524
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:41 -0700 (PDT)
Received: (qmail 1146 invoked by uid 109); 28 Mar 2023 17:51:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 17:51:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32727 invoked by uid 111); 28 Mar 2023 17:51:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 13:51:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 13:51:39 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Gniazdowski <sgniazdowski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: A nice, beauty progress metter for Git Clone + a feature request
Message-ID: <20230328175139.GA18558@coredump.intra.peff.net>
References: <CAKc7PVD_65vB5+meeO3xcu4ASbqr85LBGUO8Ntb7SvbO+NNHmQ@mail.gmail.com>
 <CAKc7PVA14_mjZeuED1Ee0Mu5YoCSrR4FNNhSEKFHmnKnc-gESQ@mail.gmail.com>
 <ZBIIKqAIF+aF8vvx@coredump.intra.peff.net>
 <CAKc7PVDZ4Ra7s-pyFms1-sGqjYD9b407G1u0A0hHTkQRa-MPkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKc7PVDZ4Ra7s-pyFms1-sGqjYD9b407G1u0A0hHTkQRa-MPkQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 10:59:56AM +0000, Sebastian Gniazdowski wrote:

> On Wed, 15 Mar 2023 at 18:02, Jeff King <peff@peff.net> wrote:
> > Now, none of that is _strictly_ necessary. We could just dump the same
> > human-readable progress to the progress command that we dump to stderr
> > now, and it could scrape it for things that look like progress, and pass
> > everything else through. But then, you can already do that with:
> >
> >   git clone --progress ... 2>&1 | my-progress-scraper
> >
> > (and it looks like the asciinema you showed is probably just a
> > syntactically nicer version of that with support from the shell?).
> 
> Yes, that's what the asciinema does  – it pipes git clone --progress
> to a script, and that's pretty much it. That's why I thought about a
> core.pipe option, that would hold the my-progress-scrapper command.
> That's a very easy change, could it be added to git source code?

For the reasons I gave earlier, it has to scrape all of stderr, and not
just progress output. I'm still skeptical that this buys a lot over just
redirecting stderr entirely via the shell, but it's at least
conceptually simple (it's basically the same as a pager for stderr).

The implementation might have some tricky bits to think about, though,
since we have an extra process to handle. For real pagers, we take some
care to terminate them on close. Maybe we wouldn't need the same here,
though (since the filter isn't interactive, and we don't want Git to
wait on exiting until it's done).

So I dunno. It might only be a few lines. It just feels like a weird
feature to add.

-Peff
