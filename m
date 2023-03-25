Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8275EC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 06:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjCYGak (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 02:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCYGai (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 02:30:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88503158A6
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 23:30:37 -0700 (PDT)
Received: (qmail 11291 invoked by uid 109); 25 Mar 2023 06:30:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Mar 2023 06:30:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10462 invoked by uid 111); 25 Mar 2023 06:30:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Mar 2023 02:30:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Mar 2023 02:30:35 -0400
From:   Jeff King <peff@peff.net>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <20230325063035.GA562387@coredump.intra.peff.net>
References: <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
 <ZB3z3e5G3Lrv9g3Y@ugly>
 <20230324191302.GB536967@coredump.intra.peff.net>
 <ZB4A7+LMY+NSaPYE@ugly>
 <20230324204504.GB549549@coredump.intra.peff.net>
 <ZB4e/yE+25W66z6S@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZB4e/yE+25W66z6S@ugly>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 11:06:55PM +0100, Oswald Buddenhagen wrote:

> > Ah, that is your problem. When "replace" refs are in use, the data
> > stored in the commit-graph can't reliably be used. [...]
> > 
> why isn't the commit-graph built with the replaces applied (and tagged by a
> hash of the used replaces, so we know when to ignore it)?

I think a similar idea has come up before, but we decided to do the
simplest safe thing (disabling optimizations) to start with. And then
somebody who really cared about making optimizations work with commit
graphs could come along and do so later. Nobody has yet; you could be
that someone. ;)

> at minimum, i'd expect a warning giving a reason when the graph is ignored.

That might be reasonable. The commit graph is an optimization, so we'd
never produce a wrong answer by ignoring it. And since the fallback was
the status quo before the optimizations were implemented, it didn't seem
like that big a deal. But these days the performance many of us expect
is with those optimizations, so perhaps the tables have turned.

I do think there might be some complications, though. I think we may
build commit graphs by default these days during "gc" and even
incrementally after "fetch". If we warned when the graphs are disabled,
it basically means that every command in a repo with replace refs would
issue the warning.

> > I'd still be curious to see the
> > difference between "just commit graphs" and "commit graphs plus the
> > patch I showed earlier". I think it should make things faster, but if
> > it's only a few milliseconds on average, it's not that urgent to pursue.
> > 
> if there is a speed difference at all, it gets drowned out by the noise.

OK, thanks for testing. I do think that looking into a true single
traversal might make sense, but I don't think we've seen a case yet
where it's a substantial speedup.

-Peff
