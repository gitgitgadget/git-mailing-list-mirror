Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5594920988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757095AbcJQJgM (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:36:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:58313 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755048AbcJQJgL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:36:11 -0400
Received: (qmail 17965 invoked by uid 109); 17 Oct 2016 09:36:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 09:36:10 +0000
Received: (qmail 28886 invoked by uid 111); 17 Oct 2016 09:36:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Oct 2016 05:36:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Oct 2016 05:36:09 -0400
Date:   Mon, 17 Oct 2016 05:36:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
Message-ID: <20161017093608.qfevdonb336mglgx@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610171025470.197091@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610171025470.197091@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[tl;dr: the version in your repo is fine, and there's a trivial fix
 below if we want to silence the warning in the meantime]

On Mon, Oct 17, 2016 at 10:37:52AM +0200, Johannes Schindelin wrote:

> > I'm not sure I agree. IIRC, Assigning values outside the range of an enum has
> > always been fishy according to the standard, and a compiler really is
> > allowed to allocate a single bit for storage for this enum.
> 
> Really? I did see my share of code that completely violated this freedom,
> by assuming that it was really okay to cast a -1 to an enum and then test
> for that value later, when -1 was not a legal enum value.

I poked around a bit, and it seems we're both half-wrong. C99 says:

  6.7.2.2 Enumeration specifiers
  [...]
  The expression that defines the value of an enumeration constant shall
  be an integer constant expression that has a value representable as an
  int.
  [...]
  Each enumerated type shall be compatible with char, a signed integer
  type, or an unsigned integer type. The choice of type is
  implementation-defined, but shall be capable of representing the
  values of all the members of the enumeration.

My reading is that it can't be a single-bit bitfield as I claimed, but
it also isn't necessarily interchangeable with an int. But you get at
least a "char", and you can use all of those integer values even if they
aren't explicitly part of the set. And I'd assume that goes for values
even beyond the largest tag as long as you don't need more bits, so
that:

  enum { A = 1, B = 2, C = 4 } x = A | B | C;

is OK (though I didn't see anything particularly about that in the
standard).

Assigning "-1" works in the same way that normal "unsigned x = -1" works
(and is defined by the standard), though of course it may unexpectedly
conflict with an actual enum value if the compiler chooses a smaller
type (e.g., it may literally be 255 in many cases).

Anyway. Enough language lawyering. It seems like clang is being overly
strict in its interpretation of the standard (it should be giving us at
least a char's worth of values). But it matters less what the standard
says and more what real compilers do, and we have to deal with clang's
behavior.

> In any case, the fact that even one compiler used to build Git *may*
> violate that standard, and that we therefore need such safety guards as
> the one under discussion, still makes me think that this warning, while
> certainly well-intentioned, is poison for cross-platform projects.

Oh, I agree that the warning is annoying, and the code should not go
away. We just need to figure out how to silence clang.

> > I'm happy to test the TODO_NOOP version against clang (and prepare a
> > patch on top if it still complains), but that doesn't seem to have
> > Junio's tree at all yet.
> 
> Junio chose to pick up only one patch series out of the rebase--helper
> thicket at a time, it seems. I did send out at least one revision per
> patch series prior to integrating them into Git for Windows v2.10.0,
> though. Plus, I kept updating the `interactive-rebase` branch in my
> repository on GitHub (https://github.com/dscho/git).

Thanks, I was able to test that branch. It looks like clang is happy
with it because you compare against the max value. Unlike the
ARRAY_SIZE() check, this does mean if somebody modifies the enum without
touching the array, we might go out of bounds. But things would be
severely broken enough from the mismatch that I don't think it's worth
worrying about too much (and I see you have a nice comment warning
people about this).

If the rest of your interactive-rebase branch is coming soon, I think we
can probably ignore it for now. Otherwise something like:

diff --git a/sequencer.c b/sequencer.c
index d662c6b..1fdc35e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -620,7 +620,8 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 
 enum todo_command {
 	TODO_PICK = 0,
-	TODO_REVERT
+	TODO_REVERT,
+	TODO_MAX
 };
 

is probably the simplest portable fix.

As a more clever change, I wondered if switching the enum values from
(0,1) to (1,2) would silence the warning, and indeed it does. Which I
assume is because using bit-flags, we could now represent "1|2", or "3",
which is larger than the array (well, obviously "2" is, but we'd need to
subtract 1 when indexing the array). I don't think that's a good route,
though, because it loses the 0-indexing, the benefits of
zero-initialization, etc. I was mostly just poking at how clang
perceives the enum values.

> P.S.: I cannot wait for the day when somebody with an artistic touch
> provides .css for the public-inbox.org site so it stops threatening
> causing eye cancer to me.

Heh. I gently hinted something similar to Eric in the past, but I think
he actually likes how it looks. He has invited others to mirror
public-inbox and make their own interface, though. I just lack the
"artistic touch" you mentioned.

-Peff
