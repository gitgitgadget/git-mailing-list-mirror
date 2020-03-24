Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D67C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E86720719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCXGMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:12:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49078 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727426AbgCXGMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:12:00 -0400
Received: (qmail 15180 invoked by uid 109); 24 Mar 2020 06:12:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 06:12:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21254 invoked by uid 111); 24 Mar 2020 06:21:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 02:21:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Mar 2020 02:11:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200324061159.GC610977@coredump.intra.peff.net>
References: <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
 <20200322060434.GC578498@coredump.intra.peff.net>
 <20200322154749.GB53402@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322154749.GB53402@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 09:47:49AM -0600, Taylor Blau wrote:

> > > [1] I'm actually not quite sure about correctness here. It should be
> > >     fine to generate a graph file without any given commit; readers will
> > >     just have to load that commit the old-fashioned way. But at this
> > >     phase of "commit-graph write", I think we'll already have done the
> > >     close_reachable() check. What does it mean to throw away a commit at
> > >     this stage? If we're the parent of another commit, then it will have
> > >     trouble referring to us by a uint32_t. Will the actual writing phase
> > >     barf, or will we generate an invalid graph file?
> >
> > It doesn't seem great. If I instrument Git like this to simulate an
> > object temporarily "missing" (if it were really missing the whole repo
> > would be corrupt; we're trying to see what would happen if a race causes
> > us to momentarily not see it):
> 
> This is definitely a problem on either side of this patch, which is
> demonstrated by the fact that you applied your changes without my patch
> on top (and that my patch isn't changing anything substantial in this
> area like removing the 'continue' statement).
> 
> Should we address this before moving on with my patch? I think that we
> *could*, but I'd rather go forward with what we have for now, since it's
> only improving the situation, and not introducing a new bug.

I do agree it's a problem before your patch. But I think your patch may
make it a lot more common, if only because it means we'd _actually_ be
dropping entries for objects that went away, instead of accidentally
keeping them due to re-using the graph result. So it probably is worth
trying to deal with it now, or at least thinking hard about it.

The trouble is that I'm not sure what _should_ happen. Aborting the
whole commit-graph generation seems overboard (and would be annoying for
cases where whole swaths of history became unreachable and went away;
presumably we'd be dropping _all_ of those objects, and the write phase
would be just fine). I have a feeling the correct solution is to do this
merging pass earlier, before we check close_reachable(). Or if not a
true merging pass, at least a pass to check which existing entries are
still valid. But I don't know how painful that reordering would be.

-Peff
