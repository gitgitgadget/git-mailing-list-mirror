Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595F420C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdFLVKZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:10:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:38463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdFLVKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:10:24 -0400
Received: (qmail 1051 invoked by uid 109); 12 Jun 2017 21:10:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:10:24 +0000
Received: (qmail 16251 invoked by uid 111); 12 Jun 2017 21:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:10:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:10:22 -0400
Date:   Mon, 12 Jun 2017 17:10:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
Message-ID: <20170612211022.k7t2ywngrdcrkehn@sigill.intra.peff.net>
References: <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de>
 <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de>
 <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
 <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net>
 <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 09:02:32PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I think the main problem is that the mapping isn't just "JST->+0900".
> > It's a set of rules that depend on the specific time being converted. So
> > it's true that at some time t, +0900 may mean JST or KST or whatever.
> > But at a different time, those time zones will map to a different
> > offset.
> 
> To the extent that it doesn't map correctly (e.g. due to summer time)
> that's already a bug/understood limitation in the fuzzy TZ parser in
> date.c, isn't it (dating back to Linus's "In my world, it's always
> summer" comment in 89967023da).

To be honest, I find that whole timezone_names[] array pretty gross. It
gets basic stuff wrong like:

  $ t/helper/test-date parse '2017-02-01 00:00:00 PST8PDT'
  2017-02-01 00:00:00 PST8PDT -> 2017-02-01 00:00:00 -0700

That should be -0800 because it's winter (though the bigger problem is
that our parser is too stupid and just sees "PDT" at the end and guesses
it's summer).

I suspect nobody has complained because we generally encourage real
"-0800" names when specifying zones. Which is really just punting the
problem to whoever is generating the timestamp, but it works in
practice. And we use real localtime() for handling things in the current
zone, which is usually what's responsible for generating any such time.
So just using the local zone, both of these are right (notice the zone
difference in the summer):

  $ TZ=PST8PDT t/helper/test-date parse '2017-02-01 00:00:00'
  2017-02-01 00:00:00 -> 2017-02-01 00:00:00 -0800

  $ TZ=PST8PDT t/helper/test-date parse '2017-06-01 00:00:00'
  2017-06-01 00:00:00 -> 2017-06-01 00:00:00 -0700

It would be nice to fix that. In theory strptime is the solution, but
comments in date.c indicate that it doesn't work well (and I can well
believe that). Presumably there is some not-terrible date library out
there that really can parse/format in arbitrary time-zones (perl's
DateTime is pleasant to use, for example). But I don't know of a C
library offhand (and unless we can ship it with the source, I'd guess
that the extra dependency isn't worth it).

> I think everyone in this thread disagrees with what I think makes
> sense for %Z, and I'm not going to argue the point, I just thought I'd
> chime in because it seemed to me that the discussion had missed the
> mapping we had in the timezone_names variable.

I did actually forget we had it, though I don't think it changes my
opinion.

> But FWIW and just to (I think fairly) summarize, here's where we differ.
> 
> You (and others) think that unless we can actually show the user's
> time zone as it appeared on their machine %Z shouldn't show anything
> at all, since it would be confusing. Fair enough.
> 
> I only ever use the time offset info to quickly make a mental note of
> "oh +0200, this guy's in Europe", or "oh -0400 America East". Having
> any info at all for %Z would allow me to easily replace that already
> buggy mapping that exists in my head right now with something that's
> at least a bit more accurate, e.g. I remember that +0900 is Japan, but
> I can't now offhand recall what timezones India is at.

I can't either. But nor could I tell you which timezone abbreviations
they use. ;)

>     Author: Jeff King <peff@peff.net>
>     Date:   Fri May 19 08:59:34 2017 -0400 (New York, Havana, Santiago etc.)

But I don't live in any of those places. :)

I see your point, though. I wouldn't want that on, but I wouldn't have
an objection to turning that into a configurable feature. But I'm not
sure we would just want it plumbed through to %Z. It seems like you'd
potentially want it on for any dates that show the numeric zone.

The biggest headache would be managing the reverse-mapping to cities. It
would be nice if there were some way to access the system zone database,
but I doubt there's a portable way to do so. And besides, it would
probably come up with way too many options (e.g., even just in the US
-0500 encompasses not just what we normally think of as Eastern Time,
but lots of little localities who do or do not handle DST; we obviously
wouldn't want to mention them, but I don't know how we'd limit the tz
database entries to only "you know, the important ones").

-Peff
