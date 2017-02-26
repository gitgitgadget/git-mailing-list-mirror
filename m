Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C5B201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 05:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdBZF0z (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 00:26:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:34293 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbdBZF0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 00:26:54 -0500
Received: (qmail 8642 invoked by uid 109); 26 Feb 2017 05:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 05:18:37 +0000
Received: (qmail 25079 invoked by uid 111); 26 Feb 2017 05:18:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 00:18:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Feb 2017 00:18:34 -0500
Date:   Sun, 26 Feb 2017 00:18:34 -0500
From:   Jeff King <peff@peff.net>
To:     Jason Cooper <git@lakedaemon.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170226051834.i37mlqv5wxwz3254@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
 <20170226011359.GI11350@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170226011359.GI11350@io.lakedaemon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 01:13:59AM +0000, Jason Cooper wrote:

> On Fri, Feb 24, 2017 at 10:10:01PM -0800, Junio C Hamano wrote:
> > I was thinking we would need mixed mode support for smoother
> > transition, but it now seems to me that the approach to stratify the
> > history into old and new is workable.
> 
> As someone looking to deploy (and having previously deployed) git in
> unconventional roles, I'd like to add one caveat.  The flag day in the
> history is great, but I'd like to be able to confirm the integrity of
> the old history.
> 
> "Counter-hashing" the blobs is easy enough, but the trees, commits and
> tags would need to have, iiuc, some sort of cross-reference.  As in my
> previous example, "git tag -v v3.16" also checks the counter hash to
> further verify the integrity of the history (yes, it *really* needs to
> check all of the old hashes, but I'd like to make sure I can do step one
> first).
> 
> Would there be opposition to counter-hashing the old commits at the flag
> day?

I don't think a counter-hash needs to be embedded into the git objects
themselves. If the "modern" repo format stores everything primarily as
sha-256, say, it will probably need to maintain a (local) mapping table
of sha1/sha256 equivalence. That table can be generated at any time from
the object data (though I suspect we'll keep it up to date as objects
enter the repository).

At the flag day[1], you can make a signed tag with the "correct" mapping
in the tag body (so part of the actual GPG signed data, not referenced
by sha1). Then later you can compare that mapping to the object content
in the repo (or to the local copy of the mapping based on that data).

-Peff

[1] You don't even need to wait until the flag day. You can do it now.
    This is conceptually similar to the git-evtag tool, though it just
    signs the blob contents of the tag's current tree state. Signing the
    whole mapping lets you verify the entirety of history, but of course
    that mapping is quite big: 20 + 32 bytes per object for
    sha1/sha-256, which is ~250MB for the kernel. So you'd probably not
    want to do it more than once.
