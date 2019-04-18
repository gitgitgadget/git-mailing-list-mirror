Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0D120248
	for <e@80x24.org>; Thu, 18 Apr 2019 18:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfDRSmK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 14:42:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389757AbfDRSmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 14:42:10 -0400
Received: (qmail 2974 invoked by uid 109); 18 Apr 2019 18:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Apr 2019 18:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3250 invoked by uid 111); 18 Apr 2019 18:42:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Apr 2019 14:42:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2019 14:42:05 -0400
Date:   Thu, 18 Apr 2019 14:42:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        rappazzo@gmail.com
Subject: Re: [PATCH] worktree: update is_bare heuristics
Message-ID: <20190418184205.GA12260@sigill.intra.peff.net>
References: <CACsJy8BygpTQg5=8+2KkFCpaJBEkKx+ocVZoa0yRBAQvnkXVSw@mail.gmail.com>
 <20190418183000.78138-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418183000.78138-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 18, 2019 at 11:30:00AM -0700, Jonathan Tan wrote:

> > >         strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
> > > -       is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
> > > -       if (is_bare)
> > > +       if (!strbuf_strip_suffix(&worktree_path, "/.git"))
> > >                 strbuf_strip_suffix(&worktree_path, "/.");
> > 
> > We can just call these two calls unconditionally, right? No harm done
> > if we don't strip.
> 
> We can, and no harm done. But this if/then pattern is also repeated in
> other parts of the file (e.g. get_linked_worktree()) so I'll leave it in
> for consistency. (Also, for what it's worth, it's slightly faster if
> only one strip is done.)

I also think your version expresses the intent more clearly. We expect
to see one or the other, but not "foo/./.git". And so (just as the code
prior to your patch) we would not convert that to "foo".

I am not sure of exactly what the "/." is trying to accomplish, so maybe
that double-strip _would_ be desirable, but if so it is definitely
worthy of its own commit explaining why that is so.

Interestingly, the case in get_linked_worktree() makes a lot more sense
because it has added "." as an absolute path itself, and is just
cleaning up the results of its strbuf_add_absolute_path()[1]. Which
makes me wonder if the "/." stripping in get_main_worktree() is actually
cargo-culted and simply unnecessary.

-Peff

[1] It seems like it would be simpler to just use strbuf_getcwd() for
    this, but maybe I am missing something.
