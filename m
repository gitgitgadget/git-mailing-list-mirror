Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B871F404
	for <e@80x24.org>; Sat,  3 Mar 2018 05:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbeCCFPT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 00:15:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:45294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750892AbeCCFPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 00:15:18 -0500
Received: (qmail 5499 invoked by uid 109); 3 Mar 2018 05:15:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 05:15:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3124 invoked by uid 111); 3 Mar 2018 05:16:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 00:16:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 00:15:16 -0500
Date:   Sat, 3 Mar 2018 00:15:16 -0500
From:   Jeff King <peff@peff.net>
To:     csilvers <csilvers@cs.stanford.edu>
Cc:     avarab@gmail.com, jrnieder@gmail.com, drizzd@aon.at,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/4] Speed up git tag --contains
Message-ID: <20180303051516.GE27689@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706064012.GA927@sigill.intra.peff.net>
 <E1ea4Ui-0005qJ-3s@theory.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1ea4Ui-0005qJ-3s@theory.stanford.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 10:56:00AM -0800, csilvers wrote:

> > This is a resubmission of Jeff King's patch series to speed up git tag
> > --contains with some changes. It's been cooking for a while as:
> 
> Replying to this 6-year-old thread:
> 
> Is there any chance this could be resurrected?  We are using
> phabricator, which uses `git branch --contains` as part of its
> workflow.  Our repo has ~1000 branches on it, and the contains
> operation is eating up all our CPU (and time).  It would be very
> helpful to us to make this faster!
> 
> (The original thread is at
> https://public-inbox.org/git/E1OU82h-0001xY-3b@closure.thunk.org/

Sorry, this got thrown on my "to respond" pile and languished.

There are actually three things that make "git branch --contains" slow.

First, if you're filtering 1000 branches, we'll run 1000 merge-base
traversals, which may walk over the same commits multiple times.

These days "tag --contains" uses a different algorithm that can look at
all heads in a single traversal. But the downside is that it's
depth-first, so it tends to walk down to the roots. That's generally OK
for tags, since you often have ancient tags that mean getting close to
the roots anyway.

But for branches, they're more likely to be recent, and you can get away
without going very deep into the history.

So it's a tradeoff. There's no run-time switch to flip between them, but
a patch like this:

diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed058..4d674e86d5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -404,6 +404,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	memset(&array, 0, sizeof(array));
 
+	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
 
 	if (filter->verbose)

drops my run of "git branch -a --contains HEAD~100" from 8.6s to
0.4s on a repo with ~1800 branches. That sounds good, but on a repo with
a smaller number of branches, we may actually end up slower (because we
dig further down in history, and don't benefit from the multiple-branch
speedup).

I tried to do a "best of both" algorithm in:

 https://public-inbox.org/git/20140625233429.GA20457@sigill.intra.peff.net/

which finds arbitrary numbers of merge bases in a single traversal.  It
did seem to work, but I felt uneasy about some of the corner cases.
I've been meaning to revisit it, but obviously have never gotten around
to it.

The second slow thing is that during the traversal we load each commit
object from disk. The solution there is to keep the parent information
in a faster cache. I had a few proposals over the years, but I won't
even bother to dig them up, because there's quite recent and promising
work in this area from Derrick Stolee:

  https://public-inbox.org/git/1519698787-190494-1-git-send-email-dstolee@microsoft.com/

And finally, the thing that the patches you linked are referencing is
about using commit timestamps as a proxy for generation numbers. And
Stolee's patches actually leave room for real, trustable generation
numbers.

Once we have the serialized commit graph and generation numbers, think
the final step would just be to teach the "tag --contains" algorithm to
stop walking down unproductive lines of history. And in fact, I think we
can forget about the best-of-both multi-tip merge-base idea entirely.
Because if you can use the generation numbers to avoid going too deep,
then a depth-first approach is fine. And we'd just want to flip
git-branch over to using that algorithm by default.

-Peff
