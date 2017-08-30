Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA3020285
	for <e@80x24.org>; Wed, 30 Aug 2017 19:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdH3To4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 15:44:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:53528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750895AbdH3Toz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 15:44:55 -0400
Received: (qmail 19564 invoked by uid 109); 30 Aug 2017 19:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 19:44:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22950 invoked by uid 111); 30 Aug 2017 19:45:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Aug 2017 15:45:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Aug 2017 15:44:48 -0400
Date:   Wed, 30 Aug 2017 15:44:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/39] pack: make packed_git_mru global a value instead
 of a pointer
Message-ID: <20170830194448.u653vadhgzmkru3y@sigill.intra.peff.net>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
 <20170830064827.GB153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170830064827.GB153983@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 11:48:27PM -0700, Jonathan Nieder wrote:

> The MRU cache that keeps track of recently used packs is represented
> using two global variables:
> 
> 	struct mru packed_git_mru_storage;
> 	struct mru *packed_git_mru = &packed_git_mru_storage;
> 
> Callers never assign to the packed_git_mru pointer, though, so we can
> simplify by eliminating it and using &packed_git_mru_storage (renamed
> to &packed_git_mru) directly.  This variable is only used by the
> packfile subsystem, making this a relatively uninvasive change (and
> any new unadapted callers would trigger a compile error).
> 
> Noticed while moving these globals to the object_store struct.

Sounds reasonable. I think I had originally wanted to hide the
implementation and make the MRU more opaque, hence exposing only the
pointer. But since I ended up just letting people directly walk over the
struct pointers to do iteration, it needs to expose the struct internals
anyway, and this layer of indirection isn't useful.

> ---
>  builtin/pack-objects.c |  4 ++--
>  cache.h                |  4 ++--
>  packfile.c             | 12 +++++-------
>  3 files changed, 9 insertions(+), 11 deletions(-)

The patch looks good to me.

As an aside, the mru code could probably be simplified a bit by reusing
the list implementation from list.h (both were added around the same
time, and it wasn't worth creating a dependency then, but I think list.h
is useful and here to stay at this point).

It's definitely not critical to put that into this already-large series,
though.  Maybe we can use Junio's #leftoverbits tag. :)

-Peff
