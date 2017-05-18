Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6321201A7
	for <e@80x24.org>; Thu, 18 May 2017 01:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbdERBPW (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 21:15:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:53969 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754080AbdERBPV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 21:15:21 -0400
Received: (qmail 20082 invoked by uid 109); 18 May 2017 01:15:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 01:15:21 +0000
Received: (qmail 13533 invoked by uid 111); 18 May 2017 01:15:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 21:15:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 21:15:18 -0400
Date:   Wed, 17 May 2017 21:15:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 17/23] get_packed_ref_cache(): assume "packed-refs" won't
 change while locked
Message-ID: <20170518011517.xklxkbmkkx6cppdf@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <eedc8f85c8237515bc66584649b1e3f3d547049c.1495014840.git.mhagger@alum.mit.edu>
 <CAGZ79kb65sv8g6XUQMcGTkZ0ubpY2LYpj7g2wv15knXuv7oKhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb65sv8g6XUQMcGTkZ0ubpY2LYpj7g2wv15knXuv7oKhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 10:57:34AM -0700, Stefan Beller wrote:

> On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > If we've got the "packed-refs" file locked, then it can't change;
> > there's no need to keep calling `stat_validity_check()` on it.
> 
> This change will work in a world where all Git implementations
> obey a lock. If there is at least one implementation that doesn't
> care about the existence of lock files we may introduce a race
> here.
> 
> I am not sure if it is worth to be extra careful in the common case
> though. But I could imagine some people using a git repo on an
> NFS concurrently with different implementations and one of them
> is an old / careless lock-ignoring implementation.
> 
> My opinion is not strong enough that I'd veto such a patch
> just food for thought.

You're so unbelievably screwed if somebody is not respecting the lock
that I don't think it's worth considering.

This change just drops the stat_validity_check(), so you may fail to
realize that somebody racily (without holding the lock!) changed the
packed refs, and may omit a ref from your traversal if it moved from
loose to packed. That _can_ have lasting corruption effects if your
operation is something like "git prune" that is computing full
reachability.

But even without this change, somebody writing the packed-refs file
without lock is likely to hose over simultaneous writes and lose ref
updates (or even lose refs entirely). So anybody who doesn't respect the
locks is broken, period, and needs to be fixed.

-Peff
