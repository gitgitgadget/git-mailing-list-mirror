Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D93C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA5520719
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 22:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgI3WzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:55:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:46084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731870AbgI3Wym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 18:54:42 -0400
Received: (qmail 27003 invoked by uid 109); 30 Sep 2020 22:54:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 22:54:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1294 invoked by uid 111); 30 Sep 2020 22:54:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 18:54:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 18:54:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] combine-diff: handle --find-object in multitree code path
Message-ID: <20200930225441.GD1908000@coredump.intra.peff.net>
References: <20200930115240.GA1899467@coredump.intra.peff.net>
 <xmqqmu16gbqk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmu16gbqk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 03:07:15PM -0700, Junio C Hamano wrote:

> > +test_expect_success 'do not detect merge that does not touch blob' '
> > +	git checkout -B merge interesting &&
> > +	git merge -m "untouched blob" base &&
> > +	git diff-tree --format=%s --find-object=$blob -c --name-status HEAD >actual &&
> 
> You learn new things every day ;-)
> 
> I've always thought that for --find-object to do a good job, you'd
> need "--full-history" and perhaps "-m".  Especially, I didn't expect
> "-c" or "--cc" to make a difference.

You don't need --full-history, since there's no history simplification
going on here. And "-m" isn't very helpful with --find-object. It's
going to find every merge that crosses a boundary where the object was
introduced, since it will be introduced in the diff against the _other_
parent. E.g., in:

  A -- B
   \    \
    C -- M

If B introduces object X, then:

  git log --find-object=X -m M

is going to see the diff of C to M as introducing X. But M didn't do
anything interesting there; it just picked it up from the branch with B.

My concrete use case here, btw, is reporting to users which commit
introduced a blob (and at which path). It mostly works if you ignore
merges, but misses out on any evil merges which introduce the object.
Adding "-c" fixes that (but before this patch is slow and misses the
case where the merge removes the object).

-Peff
