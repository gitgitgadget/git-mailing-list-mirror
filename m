Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDAC41F404
	for <e@80x24.org>; Fri,  6 Apr 2018 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDFRxv (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 13:53:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:56070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751278AbeDFRxv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 13:53:51 -0400
Received: (qmail 21223 invoked by uid 109); 6 Apr 2018 17:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 17:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27566 invoked by uid 111); 6 Apr 2018 17:54:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 13:54:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 13:53:49 -0400
Date:   Fri, 6 Apr 2018 13:53:49 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [RFC PATCH 2/7] dir.c: fix off-by-one error in
 match_pathspec_item
Message-ID: <20180406175349.GB32228@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com>
 <20180405173446.32372-3-newren@gmail.com>
 <20180405174925.GA19974@sigill.intra.peff.net>
 <CABPp-BERWUPCPq-9fVW1LNocqkrfsoF4BPj3gJd9+En43vEkTQ@mail.gmail.com>
 <20180405190446.GB21164@sigill.intra.peff.net>
 <CABPp-BF0GaYMubkckqwRSo_2J_JNtd+xOtSUOLUZH3xhE0rRHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF0GaYMubkckqwRSo_2J_JNtd+xOtSUOLUZH3xhE0rRHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 01:06:30PM -0700, Elijah Newren wrote:

> > There are other similar trailing-slash matches in that function, but I'm
> > not sure of all the cases in which they're used. I don't know if any of
> > those would need similar treatment (sorry for being vague; I expect I'd
> > need a few hours to dig into how the pathspec code actually works, and I
> > don't have that today).
> 
> If it'd only take you a few hours, then you're a lot faster than me.
> It took me a while to start wrapping my head around it.

OK, I was being overly optimistic. :)

> The other trailing-slash matches in the function are all correct,
> according to the testsuite.  (I'm not sure I like the
> DO_MATCH_DIRECTORY stuff, but it is encoded in tests and backward
> compatibility is important.)  In particular, changing the earlier code
> to have the same offset trick would make it claim that e.g. either
> "a/b" or "a/b/" as names match unconditionally against "a/b/c" as a
> pathspec.  We need it to be conditional: we only want that to be
> considered a match when checking whether we want to recurse into the
> directory for other matches, not when checking whether the directory
> itself matches the pathspec.  Thus, it should be behind a separate
> flag, in a subsequent check, which is what this series does (namely
> with DO_MATCH_LEADING_PATHSPEC).

OK, that makes some sense to me.

> To be more precise, here is how a matrix of pathnames and pathspecs
> would be treated by match_pathspec_item(), where I am abbreviating
> names like MATCH_RECURSIVELY_LEADING_PATHSPEC to LEADING):
> 
>                                Pathspecs
>                 |    a/b    |    a/b/    |   a/b/c
>           ------+-----------+------------+-----------
>           a/b   |  EXACT    | RECURSIVE  |  LEADING[3]
>   Names   a/b/  |  EXACT[1] |  EXACT     |  LEADING[2]
>           a/b/c | RECURSIVE | RECURSIVE  |  EXACT
> 
> [1] Only if DO_MATCH_DIRECTORY is passed.  Otherwise,
>     this is NOT a match at all.
> [2] Only if DO_MATCH_LEADING_PATHSPEC is passed,
>     after applying this series.  Otherwise, not a match
>     at all.
> [3] Without the fix in this thread that you highlighted,
>     and assuming we apply patch 7, this would actually
>     mistakenly return RECURSIVE.
> 
> 
> Now for a separate question: How much of the above would you like
> added to the commit message...or even as a comment in the code to make
> it clearer to other folks trying to make sense of it?

That table seems quite illuminating to me. It's hard to pick out all the
special-cases from the code, or what they're _supposed_ to be doing. I
think it makes sense as a code comment.

-Peff

PS I'm going to be on a 3-week vacation starting tomorrow, so apologies
   in advance for ignoring any follow-ups.
