Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0001F453
	for <e@80x24.org>; Tue, 18 Sep 2018 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeISEx6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 00:53:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725779AbeISEx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 00:53:58 -0400
Received: (qmail 26505 invoked by uid 109); 18 Sep 2018 23:19:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 23:19:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12408 invoked by uid 111); 18 Sep 2018 23:19:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 19:19:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 19:19:03 -0400
Date:   Tue, 18 Sep 2018 19:19:03 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged
 content
Message-ID: <20180918231903.GA30695@sigill.intra.peff.net>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <20180917181511.GA3894@sigill.intra.peff.net>
 <CA+P7+xqzN5M6VgQqCNAAsmwYRmnoSVsAvdES7aK2fKf9P-f4fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqzN5M6VgQqCNAAsmwYRmnoSVsAvdES7aK2fKf9P-f4fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 12:36:06PM -0700, Jacob Keller wrote:

> > I like that, too. It's a little more costly just because it may involve
> > object-db writes, but I think in most cases it would be fine. I almost
> > always "git stash" away discarded changes these days instead of "git
> > reset --hard", because it effectively provides this kind of log.
> 
> Obviously we do eventually turn the index into a tree, which is used
> by the commit. Would it be possible to simply somehow store these
> trees, and have commands which blow the tree away simply instead, save
> it? I'm not sure how costly that is.

For an up-to-date index with the cache-tree extension, this should be
pretty cheap.  Even for a partially-staged index, where we already have
the blob in the object database, it should just incur the tree
computation (and parts you didn't touch would hopefully have an
up-to-date cache-tree).

Where it gets expensive is when you are throwing away working-tree
changes, and you have to re-hash those objects. Conceptually that's not
much worse than just calling `git add`, but there are corner cases
(e.g., imagine you keep a 1GB clone of another project in an ignored
directory, and then `git clean -dx` wants to `git add` all of it).

-Peff
