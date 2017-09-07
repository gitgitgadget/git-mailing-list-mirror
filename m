Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04872082D
	for <e@80x24.org>; Thu,  7 Sep 2017 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbdIGJAW (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 05:00:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753826AbdIGJAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 05:00:21 -0400
Received: (qmail 10558 invoked by uid 109); 7 Sep 2017 09:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 09:00:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29646 invoked by uid 111); 7 Sep 2017 09:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 05:00:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 05:00:18 -0400
Date:   Thu, 7 Sep 2017 05:00:18 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170907090018.t6ogu2vufdfhz3n6@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
 <CAN0heSpYZT7cm=XNpfgcsGFa9FOR6SdaF=vXJ+M7NNaA6Mnb3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpYZT7cm=XNpfgcsGFa9FOR6SdaF=vXJ+M7NNaA6Mnb3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 06, 2017 at 07:16:00PM +0200, Martin Ågren wrote:

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index b3b04f5dd3..de775d906c 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1819,5 +1819,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >                 print_summary(prefix, &oid, !current_head);
> >
> >         strbuf_release(&err);
> > +       UNLEAK(sb);
> >         return 0;
> >  }
> 
> These are both strbufs, so this ends up being a bit inconsistent. What
> would be the ideal end state for these two and all other such
> structures? My guess is "always UNLEAK", as opposed to carefully judging
> whether foo_release() would/could add any significant overhead.
> 
> In other words, it would be ok/wanted with changes such as "let's UNLEAK
> bar, because ..., and while at it, convert the existing foo_release to
> UNLEAK for consistency" (or per policy, for smaller binary, whatever).
> Or "if it ain't broken, don't fix it"? Did you think about this, or was
> it more a random choice?

To be honest, I didn't really think that deeply about it. I had a hammer
in my hand, and LSAN kept showing me nails to pound.

I agree that these two strbufs should probably be treated the same.

In general, I think I prefer using UNLEAK() because it's hard to get it
wrong (i.e., you don't have to care about double-frees or uninitialized
pointers). For strbufs, though, that's less of an issue because they are
always maintained in a consistent state.

As an aside, I'm pretty sure that "err" can never have been allocated
here, and this release is always a noop. It's filled in only when we get
an error from the ref update, which also causes us to die(). But in
general I'd prefer the code that causes readers to think the least
(i.e., just calling free or UNLEAK here rather than forcing the reader
to figure out whether it's possible to leak).

-Peff
