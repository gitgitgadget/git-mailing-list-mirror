Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE7F1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 17:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFNR5C (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 13:57:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:55418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726389AbfFNR5C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 13:57:02 -0400
Received: (qmail 18216 invoked by uid 109); 14 Jun 2019 17:57:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jun 2019 17:57:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29023 invoked by uid 111); 14 Jun 2019 17:57:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Jun 2019 13:57:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2019 13:57:00 -0400
Date:   Fri, 14 Jun 2019 13:57:00 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH v1 0/4] compat/obstack: update from upstream
Message-ID: <20190614175700.GA313@sigill.intra.peff.net>
References: <20190614095308.GG31952@szeder.dev>
 <20190614100059.13540-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190614100059.13540-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 12:00:55PM +0200, SZEDER Gábor wrote:

> Update 'compat/obstack.{c,h}' from upstream, because they already use
> 'size_t' instead of 'long' in places that might eventually end up as
> an argument to malloc(), which might solve build errors with GCC 8 on
> Windows.
> 
> The first patch just imports from upstream and doesn't modify anything
> at all, and, consequently, it can't be compiled because of a screenful
> or two of errors.  This is bad for future bisects, of course.
> 
> OTOH, adding all the necessary build fixes right away makes review
> harder...

One thing about your approach that makes it hard to review is that the
first commit obliterates all of our local changes, and then you have to
re-apply them individually. Looking at "git log" there aren't very many
in this case, so it's pretty easy to be sure you got them all (in some
cases this can be particularly nasty if the changes were themselves part
of conflict resolution, and so you have to pick them out of a merge).

I think a flow that better matches "what really happened" is to do more
of a vendor-branch approach: have a line of history that represents the
upstream changes (each one obliterating the last), and then periodically
merge that into our fork.

That can even retain bisectability as long as the commits along the
vendor branch don't actually try to build the code. Unfortunately our
initial import does try to build, so I think it already wrecks
bisectability, but we can undo that now. So e.g.,:

  # start at e831171d67 (Add obstack.[ch] from EGLIBC 2.10, 2011-08-21)
  git checkout -b upstream-obstack e831171d67

  # undo build changes to restore bisection; ideally this would have
  # been done back then, but it's too late now
  sed -i /obstack/d Makefile
  git commit -am 'strip out obstack building'

  # but of course in our merged version we want that back, so let's
  # do a noop merge to represent that.
  git checkout master ;# or whatever feature branch you're working on
  git merge -s ours upstream-obstack

  # and now with a sane vendor branch established, we can proceed to do
  # a real update there
  git checkout upstream-obstack
  cp /path/to/obstack.[ch] compat/
  git commit -am 'update obstack'

  # and now we are free to merge that in, getting a real 3-way merge
  # between our changes and what happened upstream.
  git checkout master
  git merge upstream-obstack

Now, if you try this you may find that the conflicts are pretty horrid.
And the result may end up way less readable than your cherry-picks (and
harder to resolve in the first place). I claim only that:

  1. This represents in the history graph more clearly the actual
     sequence of events.

  2. Its saves you from digging up the set of changes that have been
     applied since our last upstream import.

So in this case the way you did it may well be the best way. But I offer
it as an alternative. :)

-Peff
