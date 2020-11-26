Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C951C56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF86207BC
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgKZAsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:48:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:43200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgKZAsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:48:55 -0500
Received: (qmail 12360 invoked by uid 109); 26 Nov 2020 00:48:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 00:48:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12317 invoked by uid 111); 26 Nov 2020 00:48:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 19:48:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 19:48:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 0/2] midx: prevent against racily disappearing packs
Message-ID: <X777dl3pqioME7uM@coredump.intra.peff.net>
References: <cover.1606324509.git.me@ttaylorr.com>
 <xmqqblfldts4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblfldts4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 01:13:31PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Here are a couple of patches that Peff and I wrote after noticing a
> > problem where racily disappearing .idx files can cause a segfault. While
> > investigating, we fixed a related issue which is described and fixed in
> > the second patch.
> 
> In the cover letter it won't affect the end result, but when talking
> about "race", it always is a good idea to explicitly mention both
> sides of the race.  It is clear what one side is in the above
> (i.e. somebody who removes .idx file that is still in use), but it
> is not so clear who gets hit and segfaults.
> 
> I am guessing that the other party is the user of .pack file(s)
> bypassing the corresponding .idx file(s) because the necessary data
> is mostly in .midx?

Yeah, the race reproduction in the second commit message can actually
reproduce the segfault as well (it depends on the exact timing which
error you get). So the segfault is in the reader, who is not checking
the result of find_revindex_entry().

Arguably every call there should be checking for NULL, but in practice
I think it would always be a bug:

  - we were somehow unable to open the index in order to generate the
    revindex (which is what happened here). But I think we are better
    off making sure that we can always do so, which is what this series
    does.

  - the caller asked about an object at a position beyond the number of
    objects in the packfile. This is a bug in the caller.

So we could perhaps BUG() in find_revindex_entry() instead of returning
NULL. A quick segfault accomplishes mostly the same thing, though the
BUG() could distinguish the two cases more clearly.

-Peff
