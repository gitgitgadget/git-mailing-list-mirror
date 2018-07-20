Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004DF1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbeGTUVd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:21:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:54476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733198AbeGTUVd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:21:33 -0400
Received: (qmail 2356 invoked by uid 109); 20 Jul 2018 19:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 19:31:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31405 invoked by uid 111); 20 Jul 2018 19:31:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 15:31:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 15:31:50 -0400
Date:   Fri, 20 Jul 2018 15:31:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
Message-ID: <20180720193150.GC26403@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
 <20180716173636.GA18636@sigill.intra.peff.net>
 <xmqqh8kxrfrf.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1807191840490.71@tvgsbejvaqbjf.bet>
 <xmqq7elrdk8x.fsf@gitster-ct.c.googlers.com>
 <xmqqeffycl00.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeffycl00.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 02:30:23AM -0700, Junio C Hamano wrote:

> > The entries in shallow file says that history behind them may not
> > exist in the repository due to its shallowness but history after
> > them are supposed to be traversable (otherwise we have a repository
> > corruption).  It is true that an entry that itself no longer exists
> > in this repository should not be in shallow file, as the presence of
> > that entry breaks that promise the file is making---that commit
> > ought to exist and it is safe to traverse down to it, so keeping the
> > entry in the file is absolutely a wrong thing to do.
> >
> > But that does not automatically mean that just simply removing it
> > makes the resulting repository good, does it?  Wouldn't the solution
> > for that corruption be to set a new entry to stop history traversal
> > before reaching that (now-missing) commit?
> 
> The above is overly pessimistic and worried about an impossible
> situation, I would think.  The reason why a commit that used to be
> in the shallow file is being pruned during a "repack" is because it
> has become unreachable.  By definition, no future history traversal
> that wants to enumerate reachable commits needs to be stopped from
> finding that commits that are older than this commit being pruned
> are missing by having this in the shallow list.  If there is a ref
> or a reflog entry from which such a problematic traversal starts at,
> we wouldn't be pruing this commit in the first place, because the
> commit has not become unreachable yet.
> 
> So a repository does not become corrupt by pruning the commit *and*
> removing it from the shallow file at the same time.

Right. I think a lot of this is rethinking how shallow pruning works,
too, which is not something Dscho is trying to change. The simplest
argument (which I think Dscho has made elsewhere, too) is: this is
necessary in the current shallow code when dropping objects. We do it
therefore from prune, but miss the case when git-repack is run itself
outside of git-gc.

I do still think the gc/prune architecture is a bit muddled, but at this
point in the discussion I feel OK saying that people running "git repack
-ad" would not be upset to have their shallows pruned.

But the patch is still not OK as-is because prune_shallow() requires the
SEEN flag on each reachable object struct, which we have not set in the
repack process (hence the failing test I posted earlier).  So we need a
solution for that, which may impact ideas about how the call works.
E.g., some possible solutions are:

 - teach pack-objects to optionally trigger the shallow prune based on
   its internal walk

 - have repack use the just-completed pack as a hint about reachability

 - introduce a mechanism to trigger the shallow prune based on a
   commit-only reachability check, and run that from repack (or from gc
   and document that it must be run if you are using repack as a manual
   gc replacement)

I'm not advocating any particular solution there, but just showing that
there's an array of them (and probably more that I didn't mention).

-Peff
