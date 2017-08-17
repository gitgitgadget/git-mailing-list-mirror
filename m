Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA311F667
	for <e@80x24.org>; Thu, 17 Aug 2017 05:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdHQFzT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 01:55:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:41360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750926AbdHQFzT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 01:55:19 -0400
Received: (qmail 27110 invoked by uid 109); 17 Aug 2017 05:55:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 05:55:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24776 invoked by uid 111); 17 Aug 2017 05:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 01:55:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 01:55:16 -0400
Date:   Thu, 17 Aug 2017 01:55:16 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in
 read_graft_line
Message-ID: <20170817055516.4zz3ucvx4mgr6qus@sigill.intra.peff.net>
References: <cover.1502796628.git.patryk.obara@gmail.com>
 <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
 <CAGZ79kaCtbuDEUJqJ+nVUW78ksLMyHZ2xhnbunUqzjkGRuYg+A@mail.gmail.com>
 <CAJfL8+QreNvRqVZ0t1Sw=+o4nFK6WuvuOWix_C0MNFik6Cc+rA@mail.gmail.com>
 <20170816225901.dbpzvsie2zgetunu@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170816225901.dbpzvsie2zgetunu@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 16, 2017 at 10:59:02PM +0000, brian m. carlson wrote:

> On Wed, Aug 16, 2017 at 02:24:27PM +0200, Patryk Obara wrote:
> > On Tue, Aug 15, 2017 at 7:02 PM, Stefan Beller <sbeller@google.com> wrote:
> > >>         const int entry_size = GIT_SHA1_HEXSZ + 1;
> > >
> > > outside the scope of this patch:
> > > Is GIT_SHA1_HEXSZ or GIT_MAX_HEXSZ the right call here?
> > 
> > I think neither one. In my opinion, this code should not be so closely
> > coupled to hash parsing code - it should be tasked with parsing
> > whitespace separated list of commit ids without relying on specific
> > commit id length or format.
> 
> What I had intended, although maybe I have not explained this well, was
> that we would have one binary that set up hash functionality as part of
> early setup.  GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ would turn into
> something like current_hash->rawsz and current_hash->hexsz at that
> point.  The reason I introduced the GIT_MAX constants was to allocate
> memory suitable for whatever hash we picked.
> 
> However, this is only what I had considered for design, and others might
> have different views going forward.  I have, however, based my patches
> on that assumption, and responded to others' comments with those
> statements.

What you wrote here matches my understanding of the general plan. IOW,
we'd expect to "waste" 12 bytes when dealing with a 160-bit sha1 in a
Git binary that's aware of 256-bit hashes. But that seems like a small
price to pay to be able to continue using automatic allocations, versus
rewriting each site to call xmalloc(current_hash->rawsz).

I'd expect most of the GIT_MAX constants to eventually go away in favor
of "struct object_id", but that will still be using the same "big enough
to hold any hash" size under the hood.

> I agree that ideally we should make as much of the code as possible
> ignorant of the hash size, because that will generally result in more
> robust, less brittle code.  I've noticed in this series the use of
> parse_oid_hex, and I agree that's one tool we can use to accomplish that
> goal.

Agreed. Most code should be dealing with the abstract concept of a hash
and shouldn't have to care about the size. I really like parse_oid_hex()
for that reason (and I think parsing is the main place we've found that
needs to care).

-Peff
