Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A5020705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbcIEV7m (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:59:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:38500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932466AbcIEV7m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:59:42 -0400
Received: (qmail 8488 invoked by uid 109); 5 Sep 2016 21:59:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 21:59:42 +0000
Received: (qmail 22474 invoked by uid 111); 5 Sep 2016 21:59:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 17:59:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 17:59:39 -0400
Date:   Mon, 5 Sep 2016 17:59:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] pack-objects: walk tag chains for --include-tag
Message-ID: <20160905215939.hriu6ev3m332qhp6@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
 <20160905215226.m6vv2tk5pe2qt4ui@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905215226.m6vv2tk5pe2qt4ui@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 05:52:26PM -0400, Jeff King wrote:

> When pack-objects is given --include-tag, it peels each tag
> ref down to a non-tag object, and if that non-tag object is
> going to be packed, we include the tag, too. But what
> happens if we have a chain of tags (e.g., tag "A" points to
> tag "B", which points to commit "C")?
> 
> We'll peel down to "C" and realize that we want to include
> tag "A", but we do not ever consider tag "B", leading to a
> broken pack (assuming "B" was not otherwise selected).
> Instead, we have to walk the whole chain, adding any tags we
> find to the pack.

So technically one might argue that this pack isn't "broken", in that it
_is_ a valid pack. It's just that it doesn't contain what the user was
asking for.

As explained further in the commit message, "fetch" is robust to this,
because it does a real connectivity check and follow-on fetch before
writing anything it thinks it got via include-tag. So perhaps one could
argue that pack-objects is correct; include-tag is best-effort, and it
is the client's job to make sure it has everything it needs. And that
would mean the bug is in git-clone, which should be doing the
connectivity check and follow-on fetch.

I dunno. This seems like the most elegant place to fix it, though it
does mean that pack-objects will go to some slight extra work when
auto-packing a tag (it has to parse the tag to find out whether it's a
chain). I'm doubt it matters much in practice.

-Peff
