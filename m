Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A79B202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755729AbdCLMYX (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 08:24:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42803 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755697AbdCLMYW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 08:24:22 -0400
Received: (qmail 28999 invoked by uid 109); 12 Mar 2017 12:24:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 12:24:20 +0000
Received: (qmail 12270 invoked by uid 111); 12 Mar 2017 12:24:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 08:24:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 08:24:18 -0400
Date:   Sun, 12 Mar 2017 08:24:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     James Melvin <jmelvin@codeaurora.org>, git@vger.kernel.org,
        nasserg@codeaurora.org, mfick@codeaurora.org, sbeller@google.com
Subject: Re: [PATCH v2] repack: Add option to preserve and prune old pack
 files
Message-ID: <20170312122418.e544nrmqniycqouc@sigill.intra.peff.net>
References: <20170310220020.2666-1-jmelvin@codeaurora.org>
 <xmqqmvcswvdc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvcswvdc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 03:43:43PM -0800, Junio C Hamano wrote:

> James Melvin <jmelvin@codeaurora.org> writes:
> 
> > The new --preserve-and-prune option renames old pack files
> > instead of deleting them after repacking and prunes previously
> > preserved pack files.
> >
> > This option is designed to prevent stale file handle exceptions
> > during git operations which can happen on users of NFS repos when
> > repacking is done on them. The strategy is to preserve old pack files
> > around until the next repack with the hopes that they will become
> > unreferenced by then and not cause any exceptions to running processes
> > when they are finally deleted (pruned).
> 
> This certainly is simpler than the previous one, but if you run
> 
> 	git repack --preserve-and-prune 
> 	sleep for N minutes
> 	git repack --preserve-and-prune 
> 
> the second "repack" will drop the obsoleted packs that were
> preserved by the first one no matter how short the value of N is,
> no?
> 
> I suspect that users would be more comfortable with something based
> on expiration timestamp that gives them a guaranteed grace period,
> e.g. "--preserve-expire=8.hours", like how we expire reflog entries
> and loose objects.
> 
> Perhaps builtin/prune.c can be a source of inspiration?

I have been a bit slow to read this series, but FWIW I had the exact
same thought while reading up to this point. There should be an
expiration, and that expiration time corresponds roughly to "how long do
you expect a long-running git operation to last".

You'd probably want "--preserve-expire" as an option to repack, and then
a "gc.preservePackExpire" option so that "git gc" triggers it reliably.

I can think of one downside of a time-based solution, though: if you run
multiple gc's during the time period, you may end up using a lot of disk
space (one repo's worth per gc). But that's a fundamental tension in the
problem space; the whole point is to waste disk to keep helping old
processes. But you may want a knob that lets you slide between those two
things. For instance, if you kept a sliding window of N sets of
preserved packs, and ejected from one end of the window (regardless of
time), while inserting into the other end. James' existing patch is that
same strategy with a hardcoded window of "1".

The other variable you can manipulate is whether to gc in the first
place. E.g., don't gc if there are N preserved sets (or sets consuming
more than N bytes, or whatever). You could do that check outside of git
entirely (or in an auto-gc hook, if you're using it).

Note that something like a sliding window gets complicated pretty
quickly. I'm not really proposing it as a direction; I'm just trying to
think of ways the time-based system could go wrong. IMHO it would
probably be fine to just ignore the problem and assume that repacking
doesn't happen often enough for it to come up in practice.

-Peff
