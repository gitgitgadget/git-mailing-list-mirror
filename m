Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE436C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812F7206E3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgKDTQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:16:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:47710 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgKDTQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 14:16:01 -0500
Received: (qmail 10879 invoked by uid 109); 4 Nov 2020 19:16:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 19:16:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13811 invoked by uid 111); 4 Nov 2020 19:16:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 14:16:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 14:15:59 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Postler <johannes.postler@txture.io>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] format-patch: support --output option
Message-ID: <20201104191559.GA3053889@coredump.intra.peff.net>
References: <20201104132428.GA2491189@coredump.intra.peff.net>
 <20201104132907.GC3030146@coredump.intra.peff.net>
 <CAPig+cQ7t1by2X0xwddyo40sQdb9BPBKmERpqKR6oMD82kUwgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ7t1by2X0xwddyo40sQdb9BPBKmERpqKR6oMD82kUwgg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 12:27:30PM -0500, Eric Sunshine wrote:

> > diff --git a/builtin/log.c b/builtin/log.c
> > @@ -1942,11 +1942,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > +       } else if (rev.diffopt.close_file) {
> > +               /*
> > +                * The diff code parsed --output; it has already opened the
> > +                * file, but but we must instruct it not to close after each
> > +                * diff.
> > +                */
> > +               rev.diffopt.close_file = 0;
> >         } else {
> 
> The commit message's justification for supporting --output seems
> reasonable. However, my knee-jerk reaction to the implementation was
> that it feels overly magical and a bit too hacky. I can see the logic
> in it but it also leaves a bad taste when the implementation has to
> "undo" a side-effect of some other piece of code, which makes it feel
> unplanned and fragile. The question which popped into my mind
> immediately was "why not handle --output explicitly via
> builtin_format_patch_options[] along with other first-class options?".
> This review comment may or may not be actionable; it's just expressing
> surprise and a bit of nose-wrinkling I experienced.

I agree it's a bit magical. I didn't really consider writing a new
"--output" option for format-patch, because I came at it from the angle
of "let's unbreak the existing diff --output option". Which isn't
necessarily a defense, but just an explanation.

FWIW, that unsetting of rev.diffopt.close_file is exactly how git-log
does it. So while I agree it's a bit ugly, this is the intended way for
--output to be used across multiple diffs, and with log_tree_commit().
I'd prefer to go this way for now, and if somebody wants to make it less
ugly, they can clean up all of the callers in one go.

Amusingly, 6ea57703f6 (log: prepare log/log-tree to reuse the
diffopt.close_file attribute, 2016-06-22) which introduced this code
foresaw the format-patch bug here.

-Peff
