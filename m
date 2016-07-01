Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D61520FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 07:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbcGAHBi (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 03:01:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:38794 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752025AbcGAHBh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 03:01:37 -0400
Received: (qmail 26282 invoked by uid 102); 1 Jul 2016 06:54:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:54:57 -0400
Received: (qmail 14064 invoked by uid 107); 1 Jul 2016 06:55:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:55:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:54:52 -0400
Date:	Fri, 1 Jul 2016 02:54:52 -0400
From:	Jeff King <peff@peff.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160701065452.GE5358@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <5774F4C7.805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5774F4C7.805@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 12:30:31PM +0200, Jakub Narębski wrote:

> > This is one of the open questions. My older patches turned them off when
> > replacements and grafts are in effect.
> 
> Well, if you store the cache of generation numbers in the packfile, or in
> the index of the packfile, or in the bitmap file, or in separate bitmap-like
> file, generating them on repack, then of course any grafts or replacements
> invalidate them... though for low level commands (like object counting)
> replacements are transparent -- or rather they are (and can be) treated as
> any other ref for reachability analysis.
> 
> Well, if there are no grafts, you could still use them for doing
> "git --no-replace-objects log ...", isn't it?

Yes, replace refs don't invalidate the concept of a cache. It just
means that you invalidate the invariants of the cache for a specific
view, so you need a cache which matches that view.

It has been several years, but I remember at one point having patches
that summarized the graft/replace state as a single hash, and only used
the cache if it matched that state. So you could actually keep a cache
for some set of replace-refs that you have, as well as a cache for the
case that you've turned them off, etc.

I don't think that level of complexity is really worth it, though.

> >>> I have patches that generate and store the numbers at pack time, similar
> >>> to the way we do the reachability bitmaps.
> 
> Ah, so those cached generation numbers are generated and stored at pack
> time. Where you store them: is it a separate file? Bitmap file? Packfile?

There were a few iterations of the concept over the years, but the
pack-time one uses a separate file with the same name prefix as a pack
(similar to the way bitmaps are stored). The big advantage there is that
we can piggy-back on the pack .idx to avoid having to write each sha1
again (20 bytes per commit, whereas the actual data we're caching is
only 4 bytes).

> > At GitHub we are using them for --contains analysis, along with mass
> > ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
> > plan is to send patches upstream, but they need some cleanup first.
> 
> That would be nice to have, please.
> 
> Er, is mass ahead/behind something that can be plugged into Git
> (e.g. for "git branch -v -v"), or is it something GitHub-specific?

We have a custom command, "git ahead-behind", where you can specify
arbitrary pairs of commits on stdin. But it's all backed by a function
which, yes, could be plugged into "branch -v -v". It caches any bitmaps
it needs, so if you are doing 100 ahead/behind comparisons against
"master", for example, it only has to find the bitmap for "master" once
(remember that we sometimes have to traverse to complete a bitmap when
a branch has been updated since the last repack).

-Peff
