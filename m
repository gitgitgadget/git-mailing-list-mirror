Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB44C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED586100A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhEUJcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:32:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:33154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236548AbhEUJcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:32:25 -0400
Received: (qmail 2827 invoked by uid 109); 21 May 2021 09:31:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 09:31:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7784 invoked by uid 111); 21 May 2021 09:31:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 05:31:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 05:30:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 0/8] Speed up connectivity checks via quarantine dir
Message-ID: <YKd90xMgfOcuJfpI@coredump.intra.peff.net>
References: <cover.1621451532.git.ps@pks.im>
 <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
 <xmqqr1i1t6zl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1i1t6zl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 06:45:02AM +0900, Junio C Hamano wrote:

> >   2. This tightening is actually important if we want to avoid letting
> >      people _intentionally_ introduce the unreachable-but-incomplete
> >      scenario. Without it, an easy denial-of-service corruption against
> >      a repository you can push to is:
> >
> >        - push an update to change a ref from X to Y. Include all objects
> > 	 necessary for X..Y, but _also_ include a tree T which points to
> > 	 a missing blob B. This will be accepted by the current rules
> > 	 (but not by your patch).
> >
> >        - push an update to change the ref from Y to C, where C is a
> > 	 commit whose root tree is T. Your patch allows this (because we
> > 	 already have T in the repository). But the resulting repository
> > 	 is corrupt (the ref now points to an incomplete object graph).
> 
> Hmph, the last step of that attack would not work with our current
> check; is this the same new hole the series brings in as you
> explained earlier for a case where a newly pushed tree/commit starts
> to reference a left-over dangling tree already in the repository
> whose content blobs are missing?

Right. The current state is immune to this attack; the rule is "refs
must be complete, but nothing else has to be". The state after Patrick's
series is (I think) likewise immune; the rule is "all objects must be
complete".

I'm not sure if that was intentional, or a lucky save because the series
tries to optimize both parts (both which objects we decide to check, as
well as which we consider we "already have"). But it's quite subtle. :)

> > If we wanted to keep the existing rule (requiring that any objects that
> > sender didn't provide are actually reachable from the current refs),
> > then we'd want to be able to check reachability quickly. And there I'd
> > probably turn to reachability bitmaps.
> 
> True.  As we are not "performance is king---a code that corrupts
> repositories as quickly as possible is an improvement" kind of
> project, we should keep the existing "an object can become part of
> DAG referred by ref tips only when the objects it refers to all
> exist in the object store, because we want to keep the invariant: an
> object that is reachable from a ref is guaranteed to have everything
> reachable from it in the object store" rule, and find a way to make
> it fast to enforce that rule somehow.

That's my feeling, too. A rule of "you are not allowed to introduce
objects which directly reference a missing object" would be likewise
correct, if consistently enforced. But it makes me nervous to switch
from one to the other, especially in just one place.

And I guess in that sense, this series isn't immune as I said earlier.
It looks like a push from a shallow clone would use the old "reachable
from refs" check even after this series.

-Peff
