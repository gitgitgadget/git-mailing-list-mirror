Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A4C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 13:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbdFONZf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 09:25:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:40650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdFONZe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 09:25:34 -0400
Received: (qmail 27883 invoked by uid 109); 15 Jun 2017 13:25:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 13:25:33 +0000
Received: (qmail 23111 invoked by uid 111); 15 Jun 2017 13:25:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jun 2017 09:25:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jun 2017 09:25:32 -0400
Date:   Thu, 15 Jun 2017 09:25:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Message-ID: <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 01:33:34PM +0200, René Scharfe wrote:

> > The difference is that in the "before" case, we actually opened each
> > directory and ran getdents(). But after gc, the directories are gone
> > totally and open() fails. We also have to do a linear walk through the
> > objects in each directory, since the contents are sorted.
> 
> Do you mean "unsorted"?

Er yeah, sorry, I meant to say "aren't".

> > I'm not really sure how, though, short of caching the directory
> > contents. That opens up questions of whether and when to invalidate the
> > cache. If the cache were _just_ about short hashes, it might be OK to
> > just assume that it remains valid through the length of the program (so
> > worst case, a simultaneous write might mean that we generate a sha1
> > which just became ambiguous, but that's generally going to be racy
> > anyway).
> > 
> > The other downside of course is that we'd spend RAM on it. We could
> > bound the size of the cache, I suppose.
> 
> You mean like an in-memory pack index for loose objects?  In order to
> avoid the readdir call in sha1_name.c::find_short_object_filename()?
> We'd only need to keep the hashes of found objects.  An oid_array
> would be quite compact.

Yes, that's what I was thinking of.

> Non-racy writes inside a process should not be ignored (write, read
> later) -- e.g. checkout does something like that.

Ideally, yes. Though thinking on this more, it's racy even today,
because we rely on the in-memory packed_git list. We usually re-check the
directory only when we look for an object and it's missing. So any new
packs which have been added while the process runs will be missed when
doing short-sha1 lookups (and actually, find_short_packed_object does
not even seem to do the usual retry-on-miss).

A normal process like "checkout" isn't writing new packs, but a
simultaneous repack could be migrating its new objects to a pack behind
its back. (It also _can_ write packs, but only for large blobs).

Given that we are talking about finding "unique" abbreviations here, and
that those abbreviations can become invalidated immediately anyway as
more objects are added (even by the same process), I'm not sure we need
to strive for absolute accuracy.

> Can we trust object directory time stamps for cache invalidation?

I think it would work on POSIX-ish systems, since loose object changes
always involve new files, not modifications of existing ones. I don't
know if there are systems that don't update directory mtimes even for
newly added files.

That would still be a stat() per request. I'd be curious how the timing
compares to the opendir/readdir that happens now.

-Peff
