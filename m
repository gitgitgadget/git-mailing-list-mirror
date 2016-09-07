Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAABC1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 19:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757174AbcIGTqQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 15:46:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:39570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753974AbcIGTpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 15:45:46 -0400
Received: (qmail 20757 invoked by uid 109); 7 Sep 2016 19:45:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 19:45:45 +0000
Received: (qmail 7156 invoked by uid 111); 7 Sep 2016 19:45:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 15:45:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 15:45:42 -0400
Date:   Wed, 7 Sep 2016 15:45:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] pack-objects: walk tag chains for --include-tag
Message-ID: <20160907194542.rubdx37mwnho6lrr@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
 <20160905215226.m6vv2tk5pe2qt4ui@sigill.intra.peff.net>
 <20160905215939.hriu6ev3m332qhp6@sigill.intra.peff.net>
 <xmqqzinjlf47.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzinjlf47.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 11:49:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As explained further in the commit message, "fetch" is robust to this,
> > because it does a real connectivity check and follow-on fetch before
> > writing anything it thinks it got via include-tag. So perhaps one could
> > argue that pack-objects is correct; include-tag is best-effort, and it
> > is the client's job to make sure it has everything it needs. And that
> > would mean the bug is in git-clone, which should be doing the
> > connectivity check and follow-on fetch.
> 
> I think that is probably a more technically correct interpretation
> of the history.
> 
> I think upgrading "best-effort" to "guarantee" like you did is a
> right approach nevertheless.  I think the "best-effort" we initially
> did was merely us being lazy.

Yeah, after sleeping on it, the conclusion I came to was that it does
not _hurt_ to have include-tag be a bit more careful.

I also wondered about the corner case I noted in the commit message.  If
you have a tag chain of A->B->C, and you already have "C" (a commit),
but are fetching "B" (a tag), then include-tag does not notice "A".

That's OK for git-fetch. It will collect "A" during its backfill phase
(not because of "B" at all, but because it knows that "A" eventually
peels to "C", which it already has). "git-clone" does not have a
backfill, of course. But neither can it "already have" a commit. So
either we get "C" as part of the clone (in which case include-tag will
include "A"), or it does not (in which case we cannot be getting "B"
either, because "C" is reachable from it).

And of course that's only when single-branch is in use. Normally
git-clone just grabs all the tags blindly. :)

So I think everything Just Works after my patch, though we do still rely
on fetch backfill to pick up some obscure cases.

-Peff
