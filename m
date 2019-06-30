Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CBA1F461
	for <e@80x24.org>; Sun, 30 Jun 2019 22:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfF3Wjx (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 18:39:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:55518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727131AbfF3Wjx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 18:39:53 -0400
Received: (qmail 24222 invoked by uid 109); 30 Jun 2019 22:39:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jun 2019 22:39:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32718 invoked by uid 111); 30 Jun 2019 22:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Jun 2019 18:40:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jun 2019 18:39:51 -0400
Date:   Sun, 30 Jun 2019 18:39:51 -0400
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
Message-ID: <20190630223951.GB21696@sigill.intra.peff.net>
References: <20190630051816.8814-1-eantoranz@gmail.com>
 <20190630065358.GB31264@sigill.intra.peff.net>
 <CAOc6etYMzOpEDs1GpLChAEhp2SbZcKjO82S=qm4P-t6SkUEWcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOc6etYMzOpEDs1GpLChAEhp2SbZcKjO82S=qm4P-t6SkUEWcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 09:09:31AM -0600, Edmundo Carmona Antoranz wrote:

> >   git merge --squash feature
> >
> > I get the same merge that rebuash is doing (with R6 as the merge base,
> > so we see F5 and R7 conflicting with each other). And then when I finish
> > it with "git commit", the result is a linear strand with M3 at the tip
> > (and its commit message is even auto-populated with information from the
> > squashed commits).
> 
> From the point of view of the revisions that you produce in the end,
> it's the same thing, but you are not rebasing/squashing your feature
> branch, you are moving your upstream branch to where you want the
> squashed/rebased branch to be. So, in fact you would need more steps,
> something like (starting from your feature branch being checked out):

Ah, OK, that's what I was missing. I agree that "merge --squash" isn't
quite what you want, then. It's sort of a "reverse squash": do the
merge, but use the _other_ side as the parent of the new squash commit.

I wonder if it might be easier to implement as an option to git-merge.
I noticed when I hit a conflict with rebuash that it emphatically told
me not to use "git commit" once I had resolved everything. If this were
just a special case of a merge, that might be a bit more seamless
(though I imagine it might still require teaching git-commit about the
feature, since it generally wants to mark HEAD as the parent).

> I think it makes more sense in terms of development flow of feature
> branches, if you know in the end you will give up a squashed branch:

Yeah, I agree it is a separate operation that by itself makes sense. I
do wonder a little why you'd care about squashing on the branch. If
you're eventually going to squash the whole thing anyway, you don't care
about a messy history. So you can just continue to back-merge from
master into the feature branch and build on top.

But perhaps the squashed version is easier to work with for further
modifications? I'm not sure how, though. Certainly in your example
rewriting changes in F1 with "rebase --interactive" would be a pain. But
I think the end-state of the tree after your rebuash is identical to
what you'd get by just merging from master. So in either case, just
building new work on top should be the same.

> But, as you said, it's not like it's not possible to do it (with a
> little more effort) with available tools like merge --squash

Yeah, but I agree with you that just because it is possible to do
something does not mean that it is not a good idea to make the workflow
easier or safer.

I'm still not quite sure of the greater workflow where having the
rebuash-ed commit on the feature branch is more useful than just having
a merge from master.

-Peff
