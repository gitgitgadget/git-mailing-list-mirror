Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1456520248
	for <e@80x24.org>; Tue, 26 Mar 2019 22:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfCZWUz (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 18:20:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:37278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729506AbfCZWUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 18:20:54 -0400
Received: (qmail 24168 invoked by uid 109); 26 Mar 2019 22:20:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Mar 2019 22:20:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24075 invoked by uid 111); 26 Mar 2019 22:21:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Mar 2019 18:21:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2019 18:20:52 -0400
Date:   Tue, 26 Mar 2019 18:20:52 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m
 1' is specified
Message-ID: <20190326222052.GD1445@sigill.intra.peff.net>
References: <87efh0pdln.fsf@javad.com>
 <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
 <8736nj2jcl.fsf@javad.com>
 <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
 <87h8bra1z6.fsf@javad.com>
 <20190326163204.GC29627@sigill.intra.peff.net>
 <CABPp-BF7cd2+4jr=zGVP8x_QLdFbyOoGRWUgMtgiGDCdqZdjFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF7cd2+4jr=zGVP8x_QLdFbyOoGRWUgMtgiGDCdqZdjFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 03:07:42PM -0700, Elijah Newren wrote:

> On Tue, Mar 26, 2019 at 9:35 AM Jeff King <peff@peff.net> wrote:
> >
> > On Mon, Mar 25, 2019 at 09:43:09AM +0300, Sergey Organov wrote:
> >
> > > How about changing "git show -p M" to output "diff -p M^ M" rather than
> > > "diff-tree --cc M" for merge commits? It's really surprising specifying
> > > -p has no visible effect.
> >
> > That's because "-p" is already the default, and the format selection is
> > orthogonal to the handling of merge commits. Providing "-m" would
> > actually override the "--cc" default (though "--first-parent -m" is
> > likely to be less noisy, per this discussion).
> >
> > As far as defaults go, I dunno. The idea is that "--cc" would give you a
> > nice summary of what the merge _itself_ had to touch. I think that's
> > valuable, too. If we were starting from scratch, I think there could be
> > a discussion about whether one default is better than the other. But at
> > this point I have a hard time finding one so much obviously better than
> > the other to merit changing the behavior.
> 
> Indeed, some of us would view a first parent diff default for merges
> as problematic.  However, I'd like to point out (or remind) that these
> two options aren't the only ways you could view a merge.  Thomas
> Rast's --remerge-diff[1] is another (even if not yet part of git.git).
> Gerrit uses something similar-ish for its default way of showing a
> merge.

Heh, I almost mentioned remerge-diff, but since it's not actually part
of Git, I didn't want to get into a tangent. But since you mention it,
yes, I actually find it quite a useful way of looking at the diff,
especially when I want to see what the person resolving the conflicts
actually _did_. The --cc combined diff is too eager to throw away hunks
that resolved purely to one side (which _most_ of the time is what you
want, but when you're hunting a possible error in the merge, it's quite
confusing).

How close is merge-recursive.c to actually doing a pure in-memory merge?

I seem to recall that was a (the?) sticking point for the original
remerge-diff.

-Peff
