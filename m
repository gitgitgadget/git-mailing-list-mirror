Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6823820A25
	for <e@80x24.org>; Fri, 15 Sep 2017 00:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdIOAkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 20:40:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:39382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751673AbdIOAkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 20:40:41 -0400
Received: (qmail 16877 invoked by uid 109); 15 Sep 2017 00:40:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 00:40:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1461 invoked by uid 111); 15 Sep 2017 00:41:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 20:41:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 20:40:39 -0400
Date:   Thu, 14 Sep 2017 20:40:39 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/7] get-tar-commit-id: check write_in_full() return
 against 0
Message-ID: <20170915004039.sxluh3cv7p6tltqa@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
 <20170913210927.GJ27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913210927.GJ27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 02:09:27PM -0700, Jonathan Nieder wrote:

> > We ask to write 41 bytes and make sure that the return value
> > is at least 41. This is the same "dangerous" pattern that
> > was fixed in the prior commit (wherein a negative return
> > value is promoted to unsigned), though it is not dangerous
> > here because our "41" is a constant, not an unsigned
> > variable.
> >
> > But we should convert it anyway to avoid modeling a
> > dangerous construct.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> >  builtin/get-tar-commit-id.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> I kind of disagree with calling this dangerous (and I think that is
> what you alluded to above by putting it in quotes), but I like the
> postimage more than the preimage.

Right, this instance is fine, but the pattern of using "<" is not. If
you swapped out "41" for:

  size_t len = 41;

then it would be a bug. Which I think would surprise most people.

> The variable 'n' could be eliminated to simplify this further.  I
> realize that would go against the spirit of this patch, but (1) it's
> on-topic for the patch, since it is another ssize_t vs constant
> comparison and (2) as mentioned elsewhere in this thread, it's a very
> common idiom with read_in_full.  If we want to eliminate it then we
> could introduce a separate helper to distinguish between
> read_this_much_i_mean_it and read_this_much_or_to_eof.

Yes, I noticed that, too, after you brought up read_in_full() as a
potential source of problems. But I would rather deal with
read_in_full() separately on top. Can you do it as a separate patch on
top (possibly with other read_in_full() cleanups, though I think this is
the only "<" case that exists).

-Peff
