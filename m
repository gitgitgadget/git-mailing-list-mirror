Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235DA208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 08:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbdHTITk (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 04:19:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:43880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752687AbdHTITj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 04:19:39 -0400
Received: (qmail 22656 invoked by uid 109); 20 Aug 2017 08:19:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 08:19:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12656 invoked by uid 111); 20 Aug 2017 08:20:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 04:20:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 04:19:37 -0400
Date:   Sun, 20 Aug 2017 04:19:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
Message-ID: <20170820081936.i2e2rdvxl5wmpepd@sigill.intra.peff.net>
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
 <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
 <20170817090308.yh3jnztgfmkwtqpr@sigill.intra.peff.net>
 <20170817091503.vsd4lncogphy5gxx@sigill.intra.peff.net>
 <xmqq60dmgftg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60dmgftg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 12:22:19PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Of course this is a pretty ridiculous input in the first place. In
> > theory it _could_ be figured out, but overlapping hunks like this are
> > always going to cause problems (in this case, context from the second
> > hunk became a removal, and the second hunk no longer applies).
> 
> To be honest, I do not think it could be figured out by "git apply",
> but "git add -p" _should_ be able to.  I've said already this
> earlier in the discussion:
> 
>   https://public-inbox.org/git/7vab5cn7wr.fsf@alter.siamese.dyndns.org/
> 
> "add -p" knows how the hunk _before_ it gave the user to edit looked
> like, and it knows how the hunk after the user edited looks like, so
> it may have enough information to figure it out.  But the "(e)dit"
> feature was done in a way to discard that information and forced an
> impossible "guess what the correct shape of the patch would be, out
> of this broken patch input" with --recount and --allow-overlap.
> 
> If we want to make "add -p/(e)dit" work in the corner cases and make
> it trustworthy, "apply" is a wrong tree to back at.  A major part of
> the effort to fix would go to "add -p", not to "apply".

In theory "add -p" could give all the information it has to git-apply in
some form, and it could figure it out. That may sound crazy, but I just
wonder if it makes things easier because git-apply already knows quite a
lot about how to parse and interpret diffs. Whereas "add -p" is largely
stupid and just parroting back lines.

But I certainly wouldn't make such a decision until figuring out the
actual algorithm, which should then make it obvious where is the best
place to implement it. :)

So just thinking about this particular situation. We have two hunks
after the split:

  @@ -1, +1,3 @@
  +a
  +b
   x

and

  @@ -1, +3,2 @@
   x
  +c

The root of the issue, I think, is that the hunk header for the second
one is bogus. It claims to start at the beginning, but of course if the
other hunk is applied first, it doesn't. The right header in that case
would be (assuming we do not copy the extra context):

  @@ -3, +3,2 @@
   x
  +c

One point of interest is that without an (e)dit, we get this case right,
despite the bogus hunk header. I'm not quite sure why that is. After the
failing edit we would end up with:

  @@ -1, +1,3 @@
  +b
   x

  @@ -1, +3,2 @@
   x
  +c

Clearly the count in the first one is now wrong, but we fix that with
--recount. But it seems to me that the second hunk is equally wrong as
it would be in the non-edit case. I guess in addition to the "-1" being
a "-2", the "+3" should now also be a "+2". But I didn't think that
would impact us finding the preimage side.

So that's one question I'm puzzled by: why does it work without an edit,
but fail with one.

My second question is how "add -p" could generate the corrected hunk
headers.

In the non-edit case, we know that our second hunk's leading context
must always match the first hunk's trailing context (since that's how we
do a split). So we'd know that the preimage "-pos" field of the second
hunk header should be offset by the net sum of the added/changed lines
for any previous split hunks.

In the original case we had net two added lines in the first hunk. So if
it's selected, that's how our "-1" becomes "-3". And after the edit, we
should be able to apply the same, I think? We have a single added line,
so it becomes "-2". That doesn't require knowing what was in the hunk
before the user edited at all. We just need to know which other hunks
it's split from, so we know which overlapping hunks we need to take into
account when recomputing.

"add -p" certainly has that information. I _think_ git-apply also has
that information if it bothers to find out. Right now --allow-overlap is
just "do not complain of overlap". But it could actively recount the
offsets when it detects overlap.

I'm assuming here that the edit process isn't changing the hunk headers,
introducing new hunks, etc. I feel like all bets are off, then.

-Peff
