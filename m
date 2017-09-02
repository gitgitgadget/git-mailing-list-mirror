Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58BE8208CD
	for <e@80x24.org>; Sat,  2 Sep 2017 08:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbdIBIoy (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 04:44:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:55680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751603AbdIBIox (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 04:44:53 -0400
Received: (qmail 28820 invoked by uid 109); 2 Sep 2017 08:44:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 08:44:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9315 invoked by uid 111); 2 Sep 2017 08:45:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 04:45:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Sep 2017 04:44:51 -0400
Date:   Sat, 2 Sep 2017 04:44:51 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Brandon Williams <bmwill@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170902084451.h5pmbtolqcl2j3w4@sigill.intra.peff.net>
References: <B1E291F2-86FF-4982-A092-92FAED65385C@gmail.com>
 <20170829185341.s3xlsx4uym7lcluc@sigill.intra.peff.net>
 <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <20170830055539.xpgxeu3flmxs55av@sigill.intra.peff.net>
 <8e09e4e1-984c-78d1-7b87-0bafe5346621@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e09e4e1-984c-78d1-7b87-0bafe5346621@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 09:07:53AM +0200, Michael Haggerty wrote:

> > So it's probably safer to just let tempfile.c handle the whole lifetime,
> > and have it put all live tempfiles on the heap, and free them when
> > they're deactivated. That means our creation signature becomes more
> > like:
> > 
> >   struct tempfile *create_tempfile(const char *path);
> > 
> > and delete_tempfile() actually calls free() on it (though we'd probably
> > want to skip the free() from a signal handler for the usual reasons).
> 
> I agree that the latter would be a nice, and relatively safe, design. It
> would involve some fairly intrusive changes to client code, though.
>
> I think it would be possible to implement the new API while leaving the
> old one intact, to avoid having to rewrite all clients at once, and
> potentially to allow clients to avoid a malloc if they already have a
> convenient place to embed a `struct tempfile` (except that now they'd be
> able to free it when done). For example, `create_tempfile(tempfile,
> path)` and its friends could accept NULL as the first argument, in which
> case it would malloc a `struct tempfile` itself, and mark it as being
> owned by the tempfile module. Such objects would be freed when
> deactivated. But if the caller passes in a non-NULL `tempfile` argument,
> the old behavior would be retained.

There are actually very few callers of create_tempfile (I count two).
Everybody just uses lock_file(). So I think we could get away with just
modifying the internals of the lock struct to hold a pointer, and then
teaching commit_lock_file() et al to reset it to NULL after performing
an operation that frees the tempfile. We could even modify
rename_tempfile() and friends to take a pointer-to-pointer and NULL it
itself. That would make it harder to get wrong.

In the long term I don't think there's a huge value to being able to
place a "struct tempfile" inside another struct, as opposed to holding a
pointer. It saves a malloc, but at the cost of opening up confusion
about lifetimes.

-Peff
