Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7665C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA2F64FD4
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 08:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCEIr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:47:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:53240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCEIqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 03:46:55 -0500
Received: (qmail 32250 invoked by uid 109); 5 Mar 2021 08:46:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Mar 2021 08:46:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18323 invoked by uid 111); 5 Mar 2021 08:46:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Mar 2021 03:46:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Mar 2021 03:46:54 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: rev-list --use-bitmap-index
Message-ID: <YEHv/tlTWv72BDJ2@coredump.intra.peff.net>
References: <CAGyf7-EXQJ2rWFqvt++Gi2=ZSCBonNtS1JSBkW4k+ORrQiyizQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-EXQJ2rWFqvt++Gi2=ZSCBonNtS1JSBkW4k+ORrQiyizQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 05, 2021 at 12:18:15AM -0800, Bryan Turner wrote:

> The documentation for --use-bitmap-index notes that if used with
> --objects trees and blobs they won't have their paths printed, but it
> appears to change a whole lot more than that. In my testing, it
> appears to mean --date-order, --format. --parents, and maybe more are
> effectively ignored.

Yes, quite a few options won't work with bitmaps. The order you get is
not a traversal order at all, but mostly just the order of objects
within the pack (and then with any extra traversal we had to do tacked
onto the end!). Likewise something like "--boundary", as that implies
that we actually walked the graph. We probably _could_ support --format
and --parents, but don't.

Probably the documentation should be strengthened to say that
--use-bitmap-index implies thinking about the resulting objects as a set
result, rather than a traversal. Or maybe that's getting too into the
weeds.

> It appears this changed in 2.26.0. The release notes for that version
> include this blurb, which seems like it might be relevant, but I'm not
> sure:

It has always been the case that those options wouldn't work with
bitmaps. But v2.26 did let us use bitmaps in more cases.

The blurb you mentioned is a bit of a red herring; it only applies when
--filter is used. The interesting commit for your example below is
4eb707ebd6 (rev-list: allow commit-only bitmap traversals, 2020-02-14).

The "--use-bitmap-index" option is really "if you can use bitmaps to
speed things up, do so". So prior to v2.26 it was simply being ignored
in your example (and you got no speedup benefit from specifying it).

That "use it if you can" behavior should probably likewise be
documented. Callers need to be prepared to receive either result (and
hence asking for stuff like --boundary does not make any sense at all).

> Is this expected? If so, perhaps the --use-bitmap-index documentation
> should be updated to indicate that it has unexpected interactions with
> a whole lot more than just --objects? Or perhaps I'm doing something
> wrong/unexpected here? What sorts of traversals are --use-bitmap-index
> expected to be used for?

The interesting traversals IMHO are:

  - with --objects, quickly getting the result set (but without paths,
    and without any ordering)

  - with --count (with or without --objects), because we avoid quite a
    bit of work by counting bits rather than walking the graph

  - with the new --disk-usage, which likewise avoids a bunch of work

Asking about just commits via bitmaps isn't that big a speed improvement
these days, because commit graphs make the cost to actually traverse
each commit way cheaper (see the numbers in the commit I mentioned
above).

So the behavior you're seeing is expected, but probably not all that
useful (and you should likely just drop --use-bitmap-index).

-Peff
