Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C99611F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbfIER74 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:59:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:40756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727143AbfIER7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:59:55 -0400
Received: (qmail 1362 invoked by uid 109); 5 Sep 2019 17:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 17:59:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29654 invoked by uid 111); 5 Sep 2019 18:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 14:01:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 13:59:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
Message-ID: <20190905175954.GB23663@sigill.intra.peff.net>
References: <20190826214737.164132-1-jonathantanmy@google.com>
 <20190905070153.GE21450@sigill.intra.peff.net>
 <xmqqpnker7ij.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnker7ij.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 10:13:24AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I wonder if it would make sense to keep a cache of these "cut
> > points" in the partial clone. That's potentially smaller than the
> > complete set of objects (especially for tree-based partial cloning), and
> > it seems clear we're willing to store it in memory anyway.
> 
> That sounds in line with how "shallow" gives us cut points in the
> history, but then would we end up listing a handful of cut-point
> objects for each and every commit in the history?  That still may be
> a lot cheaper than computing the same set of cut-point objects every
> time, though.

I think it would be one set of cut points for the whole pack. There
would potentially be a lot of overlap between commits (e.g., if you omit
blob X, then every commit after it was added, even if it doesn't touch
it, mentions X in its tree).

It would also make sense to omit objects from the list that are actually
in the pack (because we can trivially already know they're promisor
objects by finding them in the pack's .idx).

Which means that in the case of blob filters, the set of cut points is
identical to the set of omitted objects (because blobs can't reference
other objects). For a sparse-path filter that omits a whole tree like
"!/foo", we'd end up with a list of all of the oids in history that were
ever at the "foo" entry, but nothing below that.

-Peff
