Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB1A1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeAWAZQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:25:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:53956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751060AbeAWAZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:25:15 -0500
Received: (qmail 12506 invoked by uid 109); 23 Jan 2018 00:25:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:25:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12819 invoked by uid 111); 23 Jan 2018 00:25:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 19:25:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:25:13 -0500
Date:   Mon, 22 Jan 2018 19:25:13 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180123002513.GE26357@sigill.intra.peff.net>
References: <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com>
 <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
 <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
 <20180120221445.GA4451@thunk.org>
 <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
 <871siihqvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871siihqvw.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 04:09:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Yes, a "cruft pack" that holds unreachable object has been discussed
> > a few times recently on list, and I do agree that it is a desirable
> > thing to have in the longer run.
> >
> > What's tricky is to devise a way to allow us to salvage objects that
> > are placed in a cruft pack because they are accessed recently,
> > proving themselves to be no longer crufts.  It could be that a good
> > way to resurrect them is to explode them to loose form when they are
> > accessed out of a cruft pack.  We need to worry about interactions
> > with read-only users if we go that route, but with the current
> > "explode unreachable to loose, touch their mtime when they are
> > accessed" scheme ends up ignoring accesses from read-only users that
> > cannot update mtime, so it might not be too bad.
> 
> Wouldn't it also make gc pruning more expensive? Now you can repack
> regularly and loose objects will be left out of the pack, and then just
> rm'd, whereas now it would entail creating new packs (unless the whole
> pack was objects meant for removal).
> 
> Probably still worth it, but something to keep in mind.

That's a good point. I think it would be OK in practice, though, since
normal operations don't tend to create a huge number of unreachable
loose objects (at least compared to the _reachable_ loose objects, which
we're already dealing with). We tend to get unbalanced explosions of
loose objects only because a huge chunk of packed history expired.

It is something to keep in mind when implementing the scheme, though.
Luckily we already have the right behavior implemented via
--pack-loose-unreachable (which is used for "repack -k" currently), so I
think it would just be a matter of passing the right flags from
git-repack.

-Peff
