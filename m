Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55AE2018E
	for <e@80x24.org>; Mon, 11 Jul 2016 05:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbcGKFCK (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 01:02:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:42692 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750863AbcGKFCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 01:02:09 -0400
Received: (qmail 13329 invoked by uid 102); 11 Jul 2016 05:02:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:02:09 -0400
Received: (qmail 28926 invoked by uid 107); 11 Jul 2016 05:02:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jul 2016 01:02:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jul 2016 01:02:02 -0400
Date:	Mon, 11 Jul 2016 01:02:02 -0400
From:	Jeff King <peff@peff.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: add format specifiers: %gr, %gt, %gI, gi
Message-ID: <20160711050201.GA18031@sigill.intra.peff.net>
References: <20160710055402.32684-1-tytso@mit.edu>
 <20160710061644.GA19640@sigill.intra.peff.net>
 <20160710142622.GE26097@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710142622.GE26097@thunk.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 10:26:22AM -0400, Theodore Ts'o wrote:

> On Sun, Jul 10, 2016 at 02:16:45AM -0400, Jeff King wrote:
> > I wonder if a better approach would be:
> > 
> >   1. In the short term, add specific designators for the fields you'd
> >      want. One for HEAD@{n} that is unaffected by date, as %gd is (or
> >      even one for the branch-name and one for "n"). And one for the
> >      reflog date, by itself, in whatever format --date= asked for.
> > 
> >      That would let you do your format above, though it does not let you
> >      show the reflog date in multiple formats.
> 
> Hrm, maybe.  I didn't realize that %gd and %gD displayed something
> very different if --date is specified.  Is this documented?  I looked
> everywhere, and the closest I could find is a mention in the
> description of -g that if you specify commit@{now}, the output will
> use commit@{timestamp} notation --- but that's different from
> --date=xxx, and it doesn't actually specify which pretty-printer
> format string this affects, although I suppose that's not that hard to
> infer.

I couldn't find anything beyond the bit that you mentioned. So no
explanation of "--date", and no mention that  "%gd" is affected by the
usual "-g" output rules. I have two patches to improve that.

> One other thing I'll note in passing is that the --date notation
> doesn't support Unix timestamps.  So you can't actually do the
> equivalent of %gt as proposed in this patch.

We have "--date=raw", but that's not _quite_ the same, as it includes
the timezone. I think we should have "--date=unix" for this case. Patch
to follow.

> I'm not sure what designators we'd use for a HEAD@{n} that is
> uneffected by date, and as far as which arbitrary two-letter code for
> "reflog date in the default date format", we can't use %gd (ala %ad or
> %cd), since it's already spoken for.  %gr, %gt, etc., at least have
> the advantage that they are somewhat orthogonal to %ar/%at, %cr/%ct,
> etc.

Yeah, I'd have hoped for %gd, as well. One thing I think we should move
towards in the long run is giving more readable names to our
placeholders for git-log, the way for-each-ref and cat-file do (but
keeping the existing ones for compatibility and as a shorthand).

So ideally the answer in the long run is:

  %(reflog-ref)@{%(reflog-index)}

or possibly:

  %(reflog:index)

for the whole thing. Or something like that. I haven't thought that hard
about the exact syntax.

But anyway, I don't necessarily expect you to dig into that much larger
topic.

> So I definitely understand the concern about the PP format string
> being somewhat creaky, and obscure.  It's not entirely clearly to me
> that adding the new designators actually doesn't add more bloat or
> non-orthogonality.  I suppose we could add %gb for branch name, and
> %gU for the HEAD@{n} nUm --- since %gn and %gN are already spoken for
> --- and then use %gt for the reflog date in the default date format.
> So that only adds three new two-letter formats, instead of the four in
> my patch.
> 
> (BTW, I really only care about %gt and %gr --- so if the concern is
> bloat, we could just add those two specifiers.  I just added %gi and
> %gI because it wasn't hard, and I thought orthoganlity was better
> where it was possible.)

To me it's less about the number, and more the issue that:

  1. It's half-implemented. Why can we do format X, but not format Y
     (for that matter, why can you do %ct, but there is no --date format
     that matches it?). That sort of non-orthogonality ends up
     frustrating for users and makes git look creaky and poorly thought
     out.

  2. Every shorthand we pick, especially for things that aren't commonly
     used, eats up the namespace. If I were designing from scratch, I'd
     say the reflog selector shouldn't be %gd; that should be reserved
     for symmetry with %ad and %cd.

     I think your patch is not really an offender here, though; if
     anything it's helping symmetry.

> One possibility is %{authordate:format:%s} --- but it suffers from two
> drawbacks:

Yeah, I agree that's pretty horrid. We should have "Unix timestamp" as a
first-class format.

> One other long-term thought.  Maybe past a certain point, we should
> just make it easy to get the data from git-log into a perl or pythons
> script, where it becomes possible to do conditionals, more flexible
> padding rules, etc.  So some kind of --format=yaml or --format=json
> sort of thing.  Some interesting ideas of how we could do this can be
> found here:

I do like that idea, though I think that's a somewhat orthogonal
concept, just because this kind of pretty-format stuff is used in two
ways. One, to easily get it into another script which will do something
clever with it. And two, to make nicer formats for everyday use for
things like "git log", "git branch -v", and so on.

The two needs only intersect when your plan is to get it into a perl
script which will do the nice formatting. :)

So I think --format=json is a great idea for getting it into a separate
script, but it doesn't help people much who just want to customize their
git-log output. As an aside, there was talk and some patches long ago
about having a json-format for a lot of different commands. E.g., not
just "git log", but "git status --porcelain", etc.  I like the general
idea; line-oriented is convenient with the usual shell tools, but the
quoting is sometimes a nightmare (and I think the "status --porcelain"
output is even context-sensitive, which is horrible to parse). If you're
interested, I think this is the probably the most relevant thread:

  http://thread.gmane.org/gmane.comp.version-control.git/144642

For pretty formats themselves (and possibly other script-ish bits, like
commit selection), I had experimental patches at one point to embed a
lua interpreter:

  http://thread.gmane.org/gmane.comp.version-control.git/206335

Again, I don't expect you to pick up and run with either of those idea
(but I'd love it if you did!). Just adding to the discussion. :)

> ... although I doubt whether git would ever want to do the equivalent of:
> 
> gcloud compute images list  --format='table[box,title=Images](name:sort=1,family)'
> 
> which will print something like this:

That's neat, though I think I'd really prefer just making it easy to get
the data out of git in a structured way, and then applying some cool
json-formatting script to it. Surely "turn this json into a table" is a
thing that could be solved once for everybody (I don't work with it
enough to know, but maybe "jq" can do that already).


But let's get back to reality for a moment. Here are some patches that
address the issues you brought up above.

  [1/5]: doc/rev-list-options: clarify "commit@{Nth}" for "-g" option
  [2/5]: doc/rev-list-options: explain "-g" output formats
  [3/5]: doc/pretty-formats: describe index/time formats for %gd
  [4/5]: date: document and test "raw-local" mode
  [5/5]: date: add "unix" format

The next step is either:

  - add specific reflog-time-formats, as your patch does

  - add a generic reflog-date placeholder, so you can do:

      git log --date=unix --format='%gT'

    or whatever. That still doesn't give you multiple date types in a
    single invocation, though. It's probably not much code to do so, but
    designing the syntax and supporting existing placeholders would be
    some work.

I'm on the fence, so I'll let you decide how you want to proceed. I can
live with "%gr" and "%gt", as they are at least symmetric with their
author/committer counterparts.

-Peff
