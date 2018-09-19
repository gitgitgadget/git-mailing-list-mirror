Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9D71F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbeISVz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:55:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:53236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731332AbeISVz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 17:55:26 -0400
Received: (qmail 2493 invoked by uid 109); 19 Sep 2018 16:16:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Sep 2018 16:16:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19109 invoked by uid 111); 19 Sep 2018 16:16:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Sep 2018 12:16:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2018 12:16:47 -0400
Date:   Wed, 19 Sep 2018 12:16:47 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged
 content
Message-ID: <20180919161647.GA9432@sigill.intra.peff.net>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <20180917181511.GA3894@sigill.intra.peff.net>
 <CA+P7+xqzN5M6VgQqCNAAsmwYRmnoSVsAvdES7aK2fKf9P-f4fg@mail.gmail.com>
 <20180918231903.GA30695@sigill.intra.peff.net>
 <CACsJy8A3QCYY6QeJQYkbCKYh=7Q7pj=rer_OQHLGoAMqTNomNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8A3QCYY6QeJQYkbCKYh=7Q7pj=rer_OQHLGoAMqTNomNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 06:12:23PM +0200, Duy Nguyen wrote:

> On Wed, Sep 19, 2018 at 1:19 AM Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Sep 18, 2018 at 12:36:06PM -0700, Jacob Keller wrote:
> >
> > > > I like that, too. It's a little more costly just because it may involve
> > > > object-db writes, but I think in most cases it would be fine. I almost
> > > > always "git stash" away discarded changes these days instead of "git
> > > > reset --hard", because it effectively provides this kind of log.
> > >
> > > Obviously we do eventually turn the index into a tree, which is used
> > > by the commit. Would it be possible to simply somehow store these
> > > trees, and have commands which blow the tree away simply instead, save
> > > it? I'm not sure how costly that is.
> >
> > For an up-to-date index with the cache-tree extension, this should be
> > pretty cheap.  Even for a partially-staged index, where we already have
> > the blob in the object database, it should just incur the tree
> > computation (and parts you didn't touch would hopefully have an
> > up-to-date cache-tree).
> 
> Just FYI. I wanted to get at least pruning support in place before
> posting another RFC. But right now I'm going without cache-tree.
> Whenever a file is updated, the _blob_ hashes are recorded in the
> index log (one line per update, same as reflog format) and the
> description part of the line is the updated path.
> 
> This is simpler to do, and we can still reconstruct a tree/commit in
> memory if we need to (but not whole tree snapshots; but I don't think
> that would be very useful). But maybe cache-tree approach is better.
> We will see.

Oh, interesting. Sort of a hybrid approach. :) That makes sense, and I
don't see any reason it wouldn't work.

-Peff
