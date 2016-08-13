Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375B520193
	for <e@80x24.org>; Sat, 13 Aug 2016 08:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbcHMI7K (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 04:59:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:54677 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751418AbcHMI7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 04:59:08 -0400
Received: (qmail 1388 invoked by uid 109); 13 Aug 2016 08:59:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 08:59:07 +0000
Received: (qmail 27428 invoked by uid 111); 13 Aug 2016 08:59:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 04:59:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 04:59:05 -0400
Date:	Sat, 13 Aug 2016 04:59:05 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
Message-ID: <20160813085904.lykoihh4v2lf4yuj@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
 <e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4232cba-aae8-8426-c730-7914bb750363@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 01:25:05AM +0200, Michael Haggerty wrote:

> > These two flags are mutually exclusive in the xdiff code, so we should
> > probably handle that here.
> > 
> > TBH, I do not care that much what:
> > 
> >   [diff]
> >   compactionHeuristic = true
> >   indentHeuristic = true
> > 
> > does. But right now:
> > 
> >   git config diff.compactionHeuristic true
> >   git show --indent-heuristic
> > 
> > still prefers the compaction heuristic, which I think is objectively
> > wrong.
> 
> I wasn't worrying about that yet, given that these two features are both
> still experimental. I also have a strong inkling that at most one of
> them needs to be made permanent. I propose that I repair the semantics
> in the simplest way possible for now while we decide on the long-term
> plan, which might conceivably be:
> 
> * keep both options permanently
> * keep only one option permanently
> * choose one heuristic and use it always (i.e., make it part of the new
> standard one-and-only diff algorithm)
> * discard both heuristics (I hope not!)
> 
> After we've decided on that, *then* let's decide on a suitable UI and
> implement it before we declare either feature non-experimental.

Is there a case where the compaction heuristic produces a better result
than this indent heuristic? AFAICT, you have not found one, and I'd be
surprised if there is one, because this _seems_ like a superset
generally. I suppose there is always the possibility that the empirical
knobs behave badly in some particular case that the compaction heuristic
just happens to get right, but it should be quite rare.

So assuming everything I just said isn't complete bollocks, I think we
can move to a future where nobody uses the compaction heuristic. And
there are three ways to deal with that:

  1. The knob and feature stay. It might be useful for somebody who
     wants to experiment in the future.

  2. The knob and feature go away completely. It was an experiment, but
     now we have something more useful.

  3. The feature goes away, but the knob stays as noop, or maybe as an
     alias for the indent heuristic, just because we did ship a version
     that accepts "--compaction-heuristic", and maybe somebody somewhere
     put it in a script?

I think I'd be in favor of (2). It doesn't seem likely enough for people
to experiment with to merit a run-time knob; they can always patch and
build if they want to do so. And (3) just seems like a pain for
something that was only shipped in one version and was kind of
experimental, and was unlikely to end up in scripts (much more likely is
that people set the config, but that's easier to ignore). But it does
violate our usual backwards-compatibility rules.

So if we assume that indent is useful and compaction goes away, the only
questions are "does indent it become the default" and "if so, does it
still get a knob". I'd say "yes" to both. Making the new behavior the
default was what we planned to do with compaction until we saw that it
regressed some cases. But as a new feature, it's nice for users to be
able to easily disable it to see if it's causing a problem (or to see
what a big improvement it is!).

I think we could get by with just a command-line option for that
purpose, rather than a config option; that saves a lot of effort in
having porcelains manually propagate the config option when they call a
plumbing diff-tree.

I guess the only users that leaves out are ones who really want stable
backwards-compatible diff. I guess "patch --stable" is one such user
(but that one we could handle internally). But let's say you had a code
review system that attached comments to lines of a diff. You might want
to disable the feature entirely to avoid invalidating old comments.

-Peff
