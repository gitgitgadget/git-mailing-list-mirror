Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD43D1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758059AbcH3Qhz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 12:37:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:35492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1757715AbcH3Qhz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 12:37:55 -0400
Received: (qmail 21724 invoked by uid 109); 30 Aug 2016 16:37:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 16:37:53 +0000
Received: (qmail 31066 invoked by uid 111); 30 Aug 2016 16:37:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 12:37:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 12:37:49 -0400
Date:   Tue, 30 Aug 2016 12:37:49 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
Message-ID: <20160830163749.it4nedannqzqeh5c@sigill.intra.peff.net>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-11-larsxschneider@gmail.com>
 <xmqq7fazcvsk.fsf@gitster.mtv.corp.google.com>
 <F976C223-0CF3-43FB-ABF2-FFE7C600138E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F976C223-0CF3-43FB-ABF2-FFE7C600138E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 30, 2016 at 01:41:59PM +0200, Lars Schneider wrote:

> >> +	git checkout -- test test.t test.i &&
> >> +
> >> +	mkdir generated-test-data &&
> >> +	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
> >> +	do
> >> +		RANDOM_STRING="$(test-genrandom end $i | tr -dc "A-Za-z0-9" )"
> >> +		ROT_RANDOM_STRING="$(echo $RANDOM_STRING | ./rot13.sh )"
> > 
> > In earlier iteration of loop with lower $i, what guarantees that
> > some bytes survive "tr -dc"?
> 
> Nothing really, good catch! The seed "end" produces as first character always a 
> "S" which would survive "tr -dc". However, that is clunky. I will always set "1"
> as first character in $RANDOM_STRING to mitigate the problem.

It seems odd that you would generate a larger set of random bytes and
then throw most of them away (about 1 in 5, on average). So you don't
actually know how long your inputs are, and you're wasting time
generating bytes which are discarded.

The goal looks like it is just to clean up the string to only-ASCII
characters. Perhaps converting to to base64 or hex would be conceptually
simpler? Like:

  test-genrandom ... |
  perl -pe 's/./hex(ord($&))/sge'

> > I do not quite get the point of this complexity.  You are using
> > exactly the same seed "end" every time, so in the first round you
> > have 1M of SP, letter '1', letter 'S' (from the genrandom), then
> > in the second round you have 1M of SP, letter '1', letter 'S' and
> > letter 'p' (the last two from the genrandom), and go on.  Is it
> > significant for the purpose of your test that the cruft inserted
> > between the repetition of 1M of SP gets longer by one byte but they
> > all share the same prefix (e.g. "1S", "1Sp", "1SpZ", "1SpZT",
> > ... are what you insert between a large run of spaces)?
> 
> The pktline packets have a constant size. If the cruft between 1M of SP 
> has a constant size as well then the generated packets for the test data
> would repeat themselves. That's why I increased the length after every 1M
> of SP.
> 
> However, I realized that this test complexity is not necessary. I'll
> simplify it in the next round.

I was also confused by this, and wondered if other patterns (perhaps
using a single longer genrandom) might be applicable. Simplification (or
explanation in comments about what properties the content _needs_ to
have) would be welcome. :)

-Peff
