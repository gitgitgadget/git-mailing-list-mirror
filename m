Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4036FC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 19:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA07422227
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 19:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgJHTxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 15:53:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:54390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbgJHTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 15:53:10 -0400
Received: (qmail 31351 invoked by uid 109); 8 Oct 2020 19:53:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 19:53:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27921 invoked by uid 111); 8 Oct 2020 19:53:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 15:53:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 15:53:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID
 pattern
Message-ID: <20201008195309.GA2841047@coredump.intra.peff.net>
References: <cover.1602139448.git.liu.denton@gmail.com>
 <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
 <20201008161345.GD2823778@coredump.intra.peff.net>
 <xmqqwo00woz5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo00woz5.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 11:29:34AM -0700, Junio C Hamano wrote:

> >   Side note: It's a shame that there is no way to convince rev-list not
> >   to print the "commit ..." header, which is really what we're avoiding
> >   here. We probably should have suppressed it with user-formats when
> >   they were introduced, but it's too late to make that change. I wonder
> >   if it would be worth adding a command-line option, though. I've often
> >   had to hack around this when parsing rev-list output (and sometimes
> >   even resort to using git-log if it's a one-off).
> 
> Or make "git log" without frills as fast as rev-list, perhaps?
> 
> What extra things do we do that makes "log" inherently slower than
> "rev-list"?

It's not the speed of log that is a problem, but just that I usually try
to use plumbing when scripting. So I often reach for rev-list first.

I do think for just listing commit hashes that log is slower, though.
One reason is that when there's a commit-graph, it's not as good at
avoiding reading the commit objects. E.g.:

  $ time git rev-list HEAD >/dev/null
  real	0m0.031s
  user	0m0.027s
  sys	0m0.004s

  $ time git -c core.commitgraph=false rev-list HEAD >/dev/null
  real	0m0.362s
  user	0m0.345s
  sys	0m0.016s

  $ time git log --format=%H HEAD >/dev/null
  real	0m0.371s
  user	0m0.355s
  sys	0m0.016s

So running "git log" takes about the same time as rev-list if we disable
the commit-graph. Which makes sense. The pretty-print code is aggressive
about loading the object contents, even if we end up not needing it
(because really, everything _except_ userformat does need it, and even
userformat usually needs it).

I think it would be nice to make the formatting code smarter about
reporting exactly which parts it needs.

> I do not mind a new option (e.g. --no-header) to "rev-list", though.

I took a brief look at this earlier today and it was more awkward than I
expected. The "commit <oid>" header might also have other stuff attached
to it (revision marks, parents, and who even knew we had a "--timestamp"
option?). It's not clear where those things should go if we suppress the
header (for oneline, they just get stuck in front of the oneline; would
that be OK for userformats, too?).

-Peff
