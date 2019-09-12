Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22631F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfILWeC (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:34:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:48662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726694AbfILWeB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:34:01 -0400
Received: (qmail 17624 invoked by uid 109); 12 Sep 2019 22:34:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 22:34:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12748 invoked by uid 111); 12 Sep 2019 22:36:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 18:36:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 18:34:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] list-objects: don't queue root trees unless
 revs->tree_objects is set
Message-ID: <20190912223400.GA2580@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912001846.GA31370@sigill.intra.peff.net>
 <20190912011137.GA23412@sigill.intra.peff.net>
 <xmqqd0g5h2xm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0g5h2xm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 09:52:53AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I was surprised we ever called repo_get_commit_tree() at all, since
> >> we're literally just traversing commits here. It looks like
> >> list-objects.c is very happy to queue pending trees for each commit,
> >> even if we're just going to throw them away when we get to
> >> process_tree()! I wonder if could be checking revs->tree_objects here
> >> and saving ourselves some work.
> >
> > Indeed, this seems to help quite a bit in the commit-graph case. I think
> > it's worth doing (and is independent of the other patch).
> 
> Yeah, I agree this is very much worth doing and is orthogonal to the
> other one.
> 
> Thanks for spotting it.  I wonder if it was broken like this forever
> since the beginning X-<.

Not quite since the beginning; it comes from 8d2dfc49b1
(process_{tree,blob}: show objects without buffering, 2009-04-10). I
suspect nobody noticed because the cost for the normal case is really
just shuffling some pointers around. It's only because it actively works
against the commit-graph optimizations that it's so expensive there.

I was surprised (and pleased) by how much such a simple thing helped.

-Peff
