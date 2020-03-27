Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599BFC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2622320705
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgC0Imu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:42:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726275AbgC0Imu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 04:42:50 -0400
Received: (qmail 9906 invoked by uid 109); 27 Mar 2020 08:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 08:42:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23194 invoked by uid 111); 27 Mar 2020 08:52:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 04:52:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 04:42:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200327084248.GA607390@coredump.intra.peff.net>
References: <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
 <20200322060434.GC578498@coredump.intra.peff.net>
 <20200322154749.GB53402@syl.local>
 <20200324061159.GC610977@coredump.intra.peff.net>
 <20200324230826.GA42939@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324230826.GA42939@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 05:08:26PM -0600, Taylor Blau wrote:

> > The trouble is that I'm not sure what _should_ happen. Aborting the
> > whole commit-graph generation seems overboard (and would be annoying for
> > cases where whole swaths of history became unreachable and went away;
> > presumably we'd be dropping _all_ of those objects, and the write phase
> > would be just fine). I have a feeling the correct solution is to do this
> > merging pass earlier, before we check close_reachable(). Or if not a
> > true merging pass, at least a pass to check which existing entries are
> > still valid. But I don't know how painful that reordering would be.
> 
> Maybe, but I'm not sure that moving 'close_reachable' up would
> necessarily solve all of our problems. Or, at least, that it wouldn't
> create a set of new problems :).
> 
> Let's say that you have (1) some connected component of your history
> that is written to a commit-graph, where (2) part of that cluster has
> been dropped (e.g., due to corruption, a rogue 'git gc', etc), and (3)
> you're writing a new graph with '--input=graphed'.
> 
> What is 'close_reachable' supposed to do? If some of the now-missing
> commits are in the reachability closure of the commits that still exist
> in the repository, then we're back to where we started. We *could* have
> 'close_reachable' take all missing commits and drop their ancestors and
> descendants, but this creates quite the headache for 'close_reachable',
> which now needs to keep track of such things.

Yeah, I think my suggestion was dumb. I was thinking that
close_reachable() might somehow fix things up, but all it ever does with
the current code is _add_ commits to the graph. And we would want the
opposite: removing ones which can no longer be present, because their
ancestors are gone. That would be possible, but would be quite a pain
(you'd have to walk an inversion of the parent DAG).

> I'm hopeful that this isn't so common in practice, but I'm also not
> entirely sure one way or another. I can plan to deploy this patch to
> GitHub's servers for a ~month and see if we experience it. If it turns
> out to be common, I'll assume that others have this problem, too, in
> which case we can go back and think more about it.

It _shouldn't_ be too common, because it implies that we have commit X
but not its ancestor X^. And the pruning and repacking code tries to
avoid throwing away X^ in such a case. It could still happen due to a
race, though.

So yeah, I think we should mostly ignore it. It's not a new problem with
your series (and the only reason it is more common with your series is
that the old code was actually incorrectly handling some cases). It
might be worth turning the "missing parent" BUG() into a die(), since we
know it's reachable. But that's largely academic, since in either case
commit-graph is going to barf and fail to write.

As a follow-up to this part for anyone else following the discussion:

> I can plan to deploy this patch to GitHub's servers for a ~month and
> see if we experience it.

...I don't think we'll actually generate good data here. We're probably
going to end up doing our "big maintenance" commit-graph roll-ups by
just feeding --reachable as input, and dropping all of the existing
graphs.

-Peff
