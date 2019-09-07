Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034F91F461
	for <e@80x24.org>; Sat,  7 Sep 2019 04:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394288AbfIGEvD (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 00:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394279AbfIGEvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 00:51:02 -0400
Received: (qmail 27991 invoked by uid 109); 7 Sep 2019 04:51:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Sep 2019 04:51:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9462 invoked by uid 111); 7 Sep 2019 04:52:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Sep 2019 00:52:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Sep 2019 00:51:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
Message-ID: <20190907045101.GD24463@sigill.intra.peff.net>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <xmqqef0xtd3p.fsf@gitster-ct.c.googlers.com>
 <d550ac23-cb65-b547-d9dc-1428ee2e9420@gmail.com>
 <xmqqlfv1m72p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfv1m72p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 02:46:22PM -0700, Junio C Hamano wrote:

> > You're right that we could isolate the new write to the refs we
> > just received. We could use the more cumbersome write_commit_graph()
> > method with a list of commit oids as starting points. I'm happy to
> > make that change if we see a lot of value there.
> 
> Well, that is not the kind of information reuse I am talking about.
> 
> I was wondering if "index-pack" has enough information in-core after
> it receives and processes the incoming pack data, scanned each and
> every object in it, in order to write out the commit graph _without_
> having to do a lot of duplicate computation and enumeration of the
> objects done in the current commit-graph.c::write_commit_graph(), so
> that it can learn a "--write-commit-graph" option that performs much
> better than running "git fetch && git commit-graph write".
> 
> Perhaps that would require too much refactoring of both index-pack
> and commit-graph code and infeasible in short to medium term and
> that is why I said "for longer term, it feels a bit unfortunate".

I think the basic metadata should be easy. We have each commit expanded
in memory at some point, so parsing it and filing away its parents,
trees, etc isn't too hard.

Generation numbers are a little trickier, though, because they imply an
actual topological traversal. It might actually be easier to couple this
with the connectivity check we do after index-pack finishes (though I've
often wondered if we could drop that check in favor of making index-pack
smarter about finding the boundaries).

-Peff
