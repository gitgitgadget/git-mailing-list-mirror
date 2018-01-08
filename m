Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE811F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755346AbeAHKUg (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 05:20:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:37120 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754573AbeAHKUc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 05:20:32 -0500
Received: (qmail 11122 invoked by uid 109); 8 Jan 2018 10:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 08 Jan 2018 10:20:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27075 invoked by uid 111); 8 Jan 2018 10:21:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Jan 2018 05:21:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jan 2018 05:20:29 -0500
Date:   Mon, 8 Jan 2018 05:20:29 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, jrnieder@gmail.com
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
Message-ID: <20180108102029.GA21232@sigill.intra.peff.net>
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
 <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 07, 2018 at 07:08:54PM -0500, Derrick Stolee wrote:

> > (Not a critique of this, just a (stupid) question)
> > 
> > What's the practical use-case for this feature? Since it doesn't help
> > with --abbrev=40 the speedup is all in the part that ensures we don't
> > show an ambiguous SHA-1.
> 
> The point of including the --abbrev=40 is to point out that object lookups
> do not get slower with the MIDX feature. Using these "git log" options is a
> good way to balance object lookups and abbreviations with object parsing and
> diff machinery. And while the public data shape I shared did not show a
> difference, our private testing of the Windows repository did show a
> valuable improvement when isolating to object lookups and ignoring
> abbreviation calculations.

Just to make sure I'm parsing this correctly: normal lookups do get faster
when you have a single index, given the right setup?

I'm curious what that setup looked like. Is it just tons and tons of
packs? Is it ones where the packs do not follow the mru patterns very
well?

I think it's worth thinking a bit about, because...

> > If something cares about both throughput and e.g. is saving the
> > abbreviated SHA-1s isn't it better off picking some arbitrary size
> > (e.g. --abbrev=20), after all the default abbreviation is going to show
> > something as small as possible, which may soon become ambigous after the
> > next commit.
> 
> Unfortunately, with the way the abbreviation algorithms work, using
> --abbrev=20 will have similar performance problems because you still need to
> inspect all packfiles to ensure there isn't a collision in the first 20 hex
> characters.

...if what we primarily care about speeding up is abbreviations, is it
crazy to consider disabling the disambiguation step entirely?

The results of find_unique_abbrev are already a bit of a probability
game. They're guaranteed at the moment of generation, but as more
objects are added, ambiguities may be introduced. Likewise, what's
unambiguous for you may not be for somebody else you're communicating
with, if they have their own clone.

Since we now scale the default abbreviation with the size of the repo,
that gives us a bounded and pretty reasonable probability that we won't
hit a collision at all[1].

I.e., what if we did something like this:

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..04c661ba85 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -600,6 +600,15 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
+	/*
+	 * A default length of 10 implies a repository big enough that it's
+	 * getting expensive to double check the ambiguity of each object,
+	 * and the chance that any particular object of interest has a
+	 * collision is low.
+	 */
+	if (len >= 10)
+		return len;
+
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;

If I repack my linux.git with "--max-pack-size=64m", I get 67 packs. The
patch above drops "git log --oneline --raw" on the resulting repo from
~150s to ~30s.

With a single pack, it goes from ~33s ~29s. Less impressive, but there's
still some benefit.

There may be other reasons to want MIDX or something like it, but I just
wonder if we can do this much simpler thing to cover the abbreviation
case. I guess the question is whether somebody is going to be annoyed in
the off chance that they hit a collision.

-Peff

[1] I'd have to check the numbers, but IIRC we've set the scaling so
    that the chance of having a _single_ collision in the repository is
    less than 50%, and rounding to the conservative side (since each hex
    char gives us 4 bits). And indeed, "git log --oneline --raw" on
    linux.git does not seem to have any collisions at its default of 12
    characters, at least in my clone.

    We could also consider switching core.disambiguate to "commit",
    which makes even a collision less likely to annoy the user.
