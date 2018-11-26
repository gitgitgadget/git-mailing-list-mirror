Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EB41F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 18:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeK0FIQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 00:08:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:51270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725723AbeK0FIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 00:08:16 -0500
Received: (qmail 13160 invoked by uid 109); 26 Nov 2018 18:13:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Nov 2018 18:13:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14414 invoked by uid 111); 26 Nov 2018 18:12:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Nov 2018 13:12:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Nov 2018 13:13:20 -0500
Date:   Mon, 26 Nov 2018 13:13:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
Message-ID: <20181126181320.GA32492@sigill.intra.peff.net>
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
 <87muq2zoy9.fsf@evledraar.gmail.com>
 <20181122175259.GC22123@sigill.intra.peff.net>
 <87efbd0xix.fsf@evledraar.gmail.com>
 <20181124120950.GB19257@sigill.intra.peff.net>
 <xmqqpnut29uq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnut29uq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 25, 2018 at 11:02:05AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do also think in the long run we should be fixing the "unreachable
> > always become loose" issues.
> 
> I think I've seen an idea of collecting them into a garbage pack
> floated for at least a few times here.  What are the downsides?  We
> no longer will know when these unreachable ones were last accessed
> individually so we need to come up with a different policy around
> their expiration?  As the common traits among objects in such a
> garbage pack (iow the way we discover the objects that need to be
> placed in there) does not involve path information and we lose the
> ability to compress them well?

Yes, the main issue is handling the expiration/mtime.

We may lose some input to the delta heuristics, but:

  - the current alternative is non-delta loose objects (so just shoving
    those in a pack is no worse for disk space, and probably better
    because of less inode/file overhead)

  - if they were already packed we can often just retain the existing
    deltas (and we get this basically for free with the existing code)

  - we could still walk unreachable bits of the graph, starting at
    dangling commits, to find the path information (we do this to some
    degree already to avoid dropping objects depended on by "unreachable
    but recent" objects, but I don't know how systematic we are about
    making sure to hit walk down from root trees first)

The most thorough discussion I know of in this direction is the one
around:

  https://public-inbox.org/git/20170610080626.sjujpmgkli4muh7h@sigill.intra.peff.net/

-Peff
