Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1DEC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3253C20B80
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD1U7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:42980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726284AbgD1U7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 16:59:14 -0400
Received: (qmail 23718 invoked by uid 109); 28 Apr 2020 20:59:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 20:59:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7071 invoked by uid 111); 28 Apr 2020 21:10:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 17:10:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 16:59:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, mhagger@alum.mit.edu
Subject: Re: [PATCH v2 3/4] commit-graph.c: write non-split graphs as
 read-only
Message-ID: <20200428205913.GC4000@coredump.intra.peff.net>
References: <cover.1587422630.git.me@ttaylorr.com>
 <cover.1588004647.git.me@ttaylorr.com>
 <86cf29ce9c1e6dc1fc881458c18850c2893b092a.1588004647.git.me@ttaylorr.com>
 <xmqqr1w85vtq.fsf@gitster.c.googlers.com>
 <20200427235935.GA14984@syl.local>
 <20200428033438.GA2369457@coredump.intra.peff.net>
 <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk11z4ksl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 09:50:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we're just doing this for a single test, perhaps it would be better
> > to set the umask in that test (perhaps even in a subshell to avoid
> > touching other tests). I guess that's a little awkward here because the
> > write and the mode-check happen in separate snippets.
> 
> Yes, and we cannot afford to place the writing side under POSIXPERM
> prerequisite.

Do we need POSIXPERM just to call umask?

We call it unconditionally in t1304, for example. I could certainly
believe it doesn't do anything useful or predictable on other systems,
but it would not surprise me if it is a silent noop. It might return
non-zero, though (the call in t1304 is not inside a test snippet).

> Among various approaches on plate, my preference is to use "umask
> 022" around the place where we prepare the $TRASH_DIRECTORY and do
> so only when POSIXPERM is there in the test-lib.sh.  I do not know
> if we should do so before or after creating the $TRASH_DIRECTORY;
> my gut feeling is that in the ideal world, we should be able to
> 
>  - create trash directory
> 
>  - use the directory to automatically figure out POSIXPERM
> 
>  - if POSIXPERM is set, use umask 022 and chmod og=rx the trash
>    directory

I don't think we do any actual filesystem tests for POSIXPERM. It's
purely based on "uname -s", and we could check it much earlier. So
unless actually probing the filesystem is worth doing, we could just
punt on that part easily.

That said, I think this does get complicated when interacting with
t1304, for example, which explicitly creates an 077 umask for the trash
directory.

This is looking like a much deeper rabbit hole than it's worth going
down. I think the pragmatic thing is to just stick a "umask 022" near
the new test (or possibly "test_might_fail umask 022" inside the
commit-graph writing test).

-Peff
