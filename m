Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B4D207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034385AbcIZReR (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:34:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030261AbcIZReQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:34:16 -0400
Received: (qmail 5970 invoked by uid 109); 26 Sep 2016 17:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 17:34:15 +0000
Received: (qmail 6656 invoked by uid 111); 26 Sep 2016 17:34:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 13:34:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 13:34:13 -0400
Date:   Mon, 26 Sep 2016 13:34:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
Message-ID: <20160926173413.prp3wevf6kkksy7c@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
 <xmqqwphytvp3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwphytvp3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 10:30:48AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We also restrict the list to those that match any
> > disambiguation hint. E.g.:
> >
> >   $ git rev-parse b2e1:foo
> >   error: short SHA1 b2e1 is ambiguous
> >   hint: The candidates are:
> >   hint:   b2e1196 tag v2.8.0-rc1
> >   hint:   b2e11d1 tree
> >   hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
> >   fatal: Invalid object name 'b2e1'.
> >
> > does not bother reporting the blobs, because they cannot
> > work as a treeish.
> 
> That's a nice touch, and it even comes free--how wonderful.
> 
> It somehow felt strange to have an expensive (compared to no-op,
> anyway) loop whose only externally visible effect is to call
> advise(), but there does not appear to be a way to even disable this
> advise() output, so it probably is OK, I guess.

Right, advise() always has an effect. But that reminds me.  I wasn't
sure if we should attach an advice.* config to this. If we do, then the
right place to put the conditional is right after the error() call in
get_short_sha1().

Since it's attached to an error path, I'm guessing nobody will be too
upset about it, so my inclination was to wait and let somebody add the
conditional advice code if they're bothered.

-Peff
