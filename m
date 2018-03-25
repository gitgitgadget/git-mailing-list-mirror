Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CD41F404
	for <e@80x24.org>; Sun, 25 Mar 2018 04:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeCYEdj (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 00:33:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:41976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750771AbeCYEdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 00:33:39 -0400
Received: (qmail 27442 invoked by uid 109); 25 Mar 2018 04:33:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Mar 2018 04:33:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11191 invoked by uid 111); 25 Mar 2018 04:34:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 25 Mar 2018 00:34:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Mar 2018 00:33:37 -0400
Date:   Sun, 25 Mar 2018 00:33:37 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
Message-ID: <20180325043337.GA32465@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
 <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 12:28:30AM -0400, Eric Sunshine wrote:

> On Sun, Mar 25, 2018 at 12:10 AM, Jeff King <peff@peff.net> wrote:
> > Alternatively, we could at least detect the situation that confused you:
> >
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > @@ -676,6 +676,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
> > +       if (list && reflog)
> > +               die(_("--reflog in list mode does not make sense"));
> > +
> >
> > That doesn't help somebody mistakenly doing "git branch -l foo", but
> > more likely they'd do "git branch -l jk/*" if they were trying to list
> > branches (and then "branch" would barf with "that's not a valid branch
> > name", though that may still leave them quite confused).
> 
> Assuming that existing clients of "-l" (if there are any) only invoke
> "git branch -l <name>" to create a new branch, then it would be
> possible to interpret "-l" as --list when <name> is an existing
> branch. That is, the "-l" in "git branch -l" and "git branch -l
> <existing-branch>..." is recognized as --list, and (for backward
> compatibility only) the "-l" in "git branch -l <new-branch>" is still
> recognized as --create-reflog.
> 
> This idea falls flat, however, if there are clients out there which
> actually depend upon "git branch -l <existing-branch>" failing.

I agree that might work most of the time as a sort of "do what I mean",
but I'd prefer to avoid those kinds of magic rules if we can. They're
very hard to explain to the user, and can be quite baffling when they go
wrong.

IMHO we should do one of:

  1. Nothing. ;)

  2. Complain about "-l" in list mode to help educate users about the
     current craziness.

  3. Drop "-l" (probably with a deprecation period); it seems unlikely
     to me that anybody uses it for branch creation, and this would at
     least reduce the confusion (then it would just be "so why don't we
     have -l" instead of "why is -l not what I expect").

  4. Repurpose "-l" as a shortcut for --list (also after a deprecation
     period). This is slightly more dangerous in that it may confuse
     people using multiple versions of Git that cross the deprecation
     line. But that's kind of what the deprecation period is for...

-Peff
