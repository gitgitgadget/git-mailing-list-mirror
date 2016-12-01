Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991391FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 05:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755006AbcLAFQo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 00:16:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:49579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753254AbcLAFQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 00:16:43 -0500
Received: (qmail 19707 invoked by uid 109); 1 Dec 2016 05:16:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 05:16:43 +0000
Received: (qmail 29348 invoked by uid 111); 1 Dec 2016 05:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 00:17:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 00:16:41 -0500
Date:   Thu, 1 Dec 2016 00:16:41 -0500
From:   Jeff King <peff@peff.net>
To:     Steven Noonan <steven@uplinklabs.net>
Cc:     git@vger.kernel.org
Subject: Re: 'git repack' and repack.writeBitmaps=true with kept packs
Message-ID: <20161201051640.gsavaexw55mwycza@sigill.intra.peff.net>
References: <CAKbGBLjZ2WLVRM9f=by337xLhPgKCy10T8ra6Qz7OWA=QF-5yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKbGBLjZ2WLVRM9f=by337xLhPgKCy10T8ra6Qz7OWA=QF-5yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 04:15:33PM -0800, Steven Noonan wrote:

> It seems like it's behaving as though I've provided
> --pack-kept-objects. In order to ensure the .bitmap is created, it
> repacks everything, including everything in existing .pack files (not
> respecting .keep). But then it's not deleting the old .pack file
> (oddly, respecting .keep).

Right, that's exactly what's happening.

The bitmaps require a completely reachable set inside the pack, so if
you omit some objects that are in .keep packs, we cannot generate the
bitmap. So we have to either disable bitmaps, or pack the kept objects.
By default, we do the latter (and I'll explain why in a minute).

We can't delete the .keep packfiles because we don't know for sure that
we've included all of their contents in the new pack (not to mention
that somebody asked to keep them, and we don't know why; we should
respect that).

> What I'd expect it to do here is ignore the 'repack.writeBitmaps =
> true' value if there's a .keep that needs to be respected. Is this not
> a correct assumption?

In practice, I think that ends up worse. The .keep files are used by
receive-pack as lockfiles for incoming pushes. So imagine you kick off a
full repack just as somebody is pushing, and repack sees the temporary
.keep file. Your options are:

  1. Disable bitmaps, leaving the repository with no bitmaps at all
     until the next repack (because you're deleting the old bitmaps
     along with the old, non-kept pack).

  2. Duplicate the newly pushed objects in the pack (if they're even
     reachable; you're also racing to see the ref updates). Now you have
     bitmaps, but you're wasting a bit of space to store the racy push
     twice (and it goes away next time you repack).

If you're running a Git server which depends on bitmaps for good
performance, then (2) is much better. And that's the default.

If you want to override it, you can pass --no-pack-kept-objects, or set
repack.packKeptObjects to false.

I think the documentation for --pack-kept-objects could be a bit more
clear for this case. It doesn't mention the default value, nor that what
you really want with "-b" is probably "--no-pack-kept-objects".

-Peff
