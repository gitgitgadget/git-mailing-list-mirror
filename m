Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842121F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfIFR2x (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:28:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:42258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731974AbfIFR2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:28:53 -0400
Received: (qmail 21212 invoked by uid 109); 6 Sep 2019 17:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:28:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5227 invoked by uid 111); 6 Sep 2019 17:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:30:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:28:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
Message-ID: <20190906172851.GC23181@sigill.intra.peff.net>
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
 <20190906061919.GA5122@sigill.intra.peff.net>
 <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 09:57:29AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is sort-of attributable to my 834876630b (get_commit_tree(): return
> > NULL for broken tree, 2019-04-09). Before then it was a BUG(). However,
> > that state was relatively short-lived. Before 7b8a21dba1 (commit-graph:
> > lazy-load trees for commits, 2018-04-06), we'd have similarly returned
> > NULL (and anyway, BUG() is clearly wrong since it's a data error).
> >
> > None of which argues against your patches, but it's kind of sad that the
> > issue is present in so many code paths. I wonder if we could be handling
> > this in a more central way, but I don't see how short of dying.
> 
> Well, either we explicitly die in here, or let the caller segfault.
> Is there even a single caller that is prepared to react to NULL?
> [...]
> So, after fixing the above, we may safely be able to die inside
> get_commit_tree() instead of returning NULL.

I think the one alternative is catching this more reliably during the
parse phase. And then callers have the option of handling the error
_then_, without forcing every downstream user of the struct to
re-validate it.

We _could_ add the die() there to catch any stragglers. But that does
make it harder for somebody to try to examine the error situation, or
gracefully return an error up the stack. Maybe that use case really
doesn't have any value. I dunno. This case did BUG() until recently, and
we did run into it in the real world. But the problem wasn't that the
operation didn't succeed, but rather the BUG(). I don't know of any code
path where the caller doesn't simply die().

>     Answer. There is a single hit inside fsck.c that wants to report
>     an error without killing ourselves in fsck_commit_buffer().  I
>     however doubt its use of get_commit_tree() is correct in the
>     first place.  The function is about validating the commit object
>     payload manually, without trusting the result of parse_commit(),
>     and it does read the object name of the tree object; the call to
>     get_commit_tree() used for reporting the error there should
>     probably become has_object() on the tree_oid.

I actually think that check should be removed entirely. That function is
about checking the syntactic validity of the object itself, not about
connectivity (which is handled separately). We already check that we
have a valid "tree" pointer earlier in the function.

The current get_commit_tree() check is doing essentially nothing.
parse_commit() would have parsed the same thing we already checked, and
the lookup_tree() call it uses to fill in the pointer is not reliable
(it would only fail if we happened to have seen the same oid already as
a non-tree in the same process).

The history is interesting here. In the early days fsck-cache actually
did parse the commit object itself. Then ff5ebe39b0 ([PATCH] Port
fsck-cache to use parsing functions, 2005-04-18) converted it to use
parse_commit(). Then de2eb7f694 (git-fsck-cache.c: check commit objects
more carefully, 2005-07-27) went back to parsing it ourselves, but left
the struct checks in place.

We also look at commit->parents, but seemingly only to compare them to
grafts (and that's weird itself, because grafts aren't a property of the
object at all, and it seems like at best this is just verifying that we
correctly loaded the grafts).

> By the way, I think get_commit_tree() and parse_commit() in fsck
> should always use the value obtained from the underlying object and
> bypass any caches like commit graph---if they pay attention to the
> caches, they should be fixed.  Secondary caches like commit graph
> should of course be validated against what are recorded in the
> underlying object, but that should be done separately.

Agreed. Probably fsck should just be disabling the commit graph for the
whole process (it looks like there's an env variable for this, but no
internal global, which is what fsck would want).

-Peff
