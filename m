Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7B51F404
	for <e@80x24.org>; Thu,  5 Apr 2018 19:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeDETb1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 15:31:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:54948 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751573AbeDETb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 15:31:26 -0400
Received: (qmail 3489 invoked by uid 109); 5 Apr 2018 19:31:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 19:31:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18664 invoked by uid 111); 5 Apr 2018 19:32:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 15:32:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 15:31:24 -0400
Date:   Thu, 5 Apr 2018 15:31:24 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [RFC PATCH 4/7] dir: Directories should be checked for matching
 pathspecs too
Message-ID: <20180405193124.GA24643@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com>
 <20180405173446.32372-5-newren@gmail.com>
 <20180405185805.GA21164@sigill.intra.peff.net>
 <CABPp-BEnFiEnao0NqU3GerYkpxO9fJadQLHo6_PZ-hXLZfbbdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEnFiEnao0NqU3GerYkpxO9fJadQLHo6_PZ-hXLZfbbdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 12:15:59PM -0700, Elijah Newren wrote:

> On Thu, Apr 5, 2018 at 11:58 AM, Jeff King <peff@peff.net> wrote:
> 
> > It sounds like correct_untracked_entries() is doing the wrong thing, and
> > it should be aware of the pathspec-matching when culling entries. In
> > other words, my understanding was that read_directory() does not
> > necessarily promise to cull fully (which is what led to cf424f5fd in the
> > first place), and callers are forced to apply their own pathspecs.
> >
> > The distinction is academic for this particular bug, but it makes me
> > wonder if there are other cases where "clean" needs to be more careful
> > with what comes out of dir.c.
> 
> Interesting, I read things very differently.  Looking back at commit
> 6b1db43109ab ("clean: teach clean -d to preserve ignored paths",
> 2017-05-23), which introduced correct_untracked_entries(), I thought
> that correct_untracked_entries() wasn't there to correct pathspec
> issues with fill_directory(), but instead to special case the handling
> of files which are both untracked and ignored.  Did I mis-read or were
> there other commits that changed the semantics?
> 
> Also, it would just seem odd to me that fill_directory() requires
> pathspecs, and it uses those pathspecs, but it doesn't guarantee that
> the files it returns matches them.  That seems like an API ripe for
> mis-use, especially since I don't see any comment in the code about
> such an assumption.  Is that really the expectation?

To be honest, I don't know. Most of dir.c predates me, and I've tried to
avoid looking at it too hard. But I had a vague recollection of it being
"best effort", and this bit from cf424f5fd89b reinforces that:

  However, read_directory does not actually check against our pathspec.
  It uses a simplified version that may turn up false positives. As a
  result, we need to check that any hits match our pathspec.

So I don't know that correct_untracked_entries() is there to fix the
pathspec handling. But I think that anybody who looks at the output of
fill_directory() does need to be aware that they may get more entries
than they expected, and has to apply the pathspecs themselves. And
that's what that extra dir_path_match() call in cmd_clean() is
there for (it used to be match_pathspec before some renaming).

I agree it's an error-prone interface. I don't know all the conditions
under which dir.c might return extra entries, but it seems like it might
be sane for it to do a final pathspec-matching pass so that callers
don't have to. That would mean that correct_untracked_entries() sees the
correctly culled list, and the extra check in cmd_clean() could be
dropped.

Ideally, of course, we'd fix those individual cases, since that would be
more efficient. And your patch may be the right first step in that
direction. But since we don't know what all of them are, it seems ripe
for regressions.

-Peff
