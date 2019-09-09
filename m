Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C0C1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 22:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfIIWVD (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 18:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:44734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726406AbfIIWVD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 18:21:03 -0400
Received: (qmail 23855 invoked by uid 109); 9 Sep 2019 22:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 22:21:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14218 invoked by uid 111); 9 Sep 2019 22:22:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 18:22:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 18:21:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH v2] cache-tree: do not lazy-fetch merge tree
Message-ID: <20190909222101.GB31319@sigill.intra.peff.net>
References: <20190903194247.217964-1-jonathantanmy@google.com>
 <20190909190130.146613-1-jonathantanmy@google.com>
 <xmqqsgp5i6s1.fsf@gitster-ct.c.googlers.com>
 <xmqqef0pi3im.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqef0pi3im.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 02:05:53PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Isn't that what is going on?  I thought I dug up the original that
> > introduced the has_object_file() call to this codepath to make sure
> > we understand why we make the check (and I expected the person who
> > is proposing this change to do the same and record the finding in
> > the proposed log message).
> >
> > I am running out of time today, and will revisit later this week
> > (I'll be down for at least two days starting tomorrow, by the way).
> 
> Here is what I came up with.
> 
>     The cache-tree datastructure is used to speed up the comparison
>     between the HEAD and the index, and when the index is updated by
>     a cherry-pick (for example), a tree object that would represent
>     the paths in the index in a directory is constructed in-core, to
>     see if such a tree object exists already in the object store.
> 
>     When the lazy-fetch mechanism was introduced, we converted this
>     "does the tree exist?" check into an "if it does not, and if we
>     lazily cloned, see if the remote has it" call by mistake.  Since
>     the whole point of this check is to repair the cache-tree by
>     recording an already existing tree object opportunistically, we
>     shouldn't even try to fetch one from the remote.
> 
>     Pass the OBJECT_INFO_SKIP_FETCH_OBJECT flag to make sure we only
>     check for existence in the local object store without triggering the
>     lazy fetch mechanism.

As a third-party observer, that explanation makes sense to me.

I wondered also if this means we should be using OBJECT_INFO_QUICK.
I.e., do we expect to see a "miss" here often, forcing us to re-scan the
packed directory?

Reading dd0c34c46b (cache-tree: protect against "git prune".,
2006-04-24), I think the answer is "no".

-Peff
