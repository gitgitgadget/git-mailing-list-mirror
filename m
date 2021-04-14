Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89AC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9659F61131
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhDNFOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:14:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:51990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhDNFOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 01:14:37 -0400
Received: (qmail 3210 invoked by uid 109); 14 Apr 2021 05:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Apr 2021 05:14:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4116 invoked by uid 111); 14 Apr 2021 05:14:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Apr 2021 01:14:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Apr 2021 01:14:14 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <YHZ6JvLBNpZVOqiX@coredump.intra.peff.net>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
 <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
 <20210413180552.GI2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210413180552.GI2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 08:05:52PM +0200, SZEDER Gábor wrote:

> >   [but now ask it to exclude promisor objects, and it's much slower;
> >   this is because is_promisor_object() opens up each tree in the pack in
> >   order to see which "promised" objects it mentions]
> 
> I don't understand this: 'git rev-list --count --all' only counts
> commit objects, so why should it open any trees at all?

Because the promisor code is a bit over-eager. There's actually one
small error in what I wrote above. In that particular rev-list, we're
not calling is_promisor_object() at all, because we'll already have
excluded all the promisor objects by marking them UNINTERESTING and
SEEN.

So:

  - in is_promisor_object(), we load the _whole_ list of promisor
    objects, which requires opening trees to find out about referenced
    blobs. In theory it could know that we only care about commits, but
    it's not connected to a particular traversal, so it gets the whole
    list.

  - mark_uninteresting() is the code where we pre-mark the objects from
    the promisor pack as UNINTERESTING, and that was loading all of the
    trees in this case. And it could know that we are not looking at
    --objects, so there's no need to touch trees. But after my patches,
    we do not load the contents of _any_ objects at all in that
    function. We could avoid even creating "struct object" for
    non-commits there, too, but that would imply looking up the type of
    each object (so more CPU, though it would save us some memory when
    we only care about commits). I suspect in practice that most callers
    would generally pass --objects anyway, though (e.g., your original
    pack-objects that started this thread certainly cares about
    non-commits).

> > +	/*
> > +	 * yikes, do we really need to parse here? maybe
> 
> Heh, a "yikes" here and a "yuck" in your previous patch...  This issue
> was worth reporting :)

Yeah. I think the client side of a lot of this partial-clone / promisor
stuff is not very mature. It's waiting on people to start using it and
finding all of these rough edges.

-Peff
