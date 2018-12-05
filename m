Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691B4211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeLEEqr (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:46:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:59324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725909AbeLEEqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:46:47 -0500
Received: (qmail 30207 invoked by uid 109); 5 Dec 2018 04:46:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 04:46:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27908 invoked by uid 111); 5 Dec 2018 04:46:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 23:46:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 23:46:45 -0500
Date:   Tue, 4 Dec 2018 23:46:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181205044645.GA12284@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112145442.GH7400@sigill.intra.peff.net>
 <87ftw62sld.fsf@evledraar.gmail.com>
 <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com>
 <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
 <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 10:45:13PM +0100, René Scharfe wrote:

> > The comment in the context there is warning callers to remember to load
> > the cache first. Now that we have individual caches, might it make sense
> > to change the interface a bit, and make these members private. I.e.,
> > something like:
> > 
> >   struct oid_array *odb_loose_cache(struct object_directory *odb,
> >                                     int subdir_nr) 
> >   {
> > 	if (!loose_objects_subdir_seen[subdir_nr])
> > 		odb_load_loose_cache(odb, subdir_nr); /* or just inline it here */
> > 
> > 	return &odb->loose_objects_cache[subdir_nr];
> >   }
> 
> Sure.  And it should take an object_id pointer instead of a subdir_nr --
> less duplication, nicer interface (patch below).

I had considered that initially, but it's a little less flexible if a
caller doesn't actually have an oid. Though both of the proposed callers
do, so it's probably OK to worry about that if and when it ever comes up
(the most plausible thing in my mind is doing some abbrev-like analysis
without looking to abbreviate a _particular_ oid).

> It would be nice if it could return a const pointer to discourage
> messing up the cache, but that's not compatible with oid_array_lookup().

Yeah.

> And quick_has_loose() should be converted to object_id as well -- adding
> a function that takes a SHA-1 is a regression. :D

I actually wrote it that way initially, but doing the hashcpy() in the
caller is a bit more awkward. My thought was to punt on that until the
rest of the surrounding code starts handling oids.

> ---
>  object-store.h |  8 ++++----
>  sha1-file.c    | 19 ++++++++-----------
>  sha1-name.c    |  4 +---
>  3 files changed, 13 insertions(+), 18 deletions(-)

This patch looks sane. How do you want to handle it? I'd assumed your
earlier one would be for applying on top, but this one doesn't have a
commit message. Did you want me to squash down the individual hunks?

-Peff
