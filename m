Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13305C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8C62071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYS1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:27:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:40316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYS1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:27:47 -0400
Received: (qmail 1795 invoked by uid 109); 25 Aug 2020 18:27:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 18:27:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30959 invoked by uid 111); 25 Aug 2020 18:27:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 14:27:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 14:27:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825182745.GA1417288@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
 <20200825172214.GC1414394@coredump.intra.peff.net>
 <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7sq1u0a.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 11:05:09AM -0700, Junio C Hamano wrote:

> Subject: [RFC] pack-redundant: gauge the usage before proposing its removal
> 
> The subcommand is unusably slow and the reason why nobody reports it
> as a performance bug is suspected to be the absense of users.  Let's
> disable the normal use of command by making it error out with a big
> message that asks the user to tell us that they still care about the
> command, with an escape hatch to override it with a command line
> option.

I like this direction. And I'm tempted to say it's OK to go straight
here given how generally useless the command is. But it feels like a big
jump for the initial change. While we give the user an easy escape
hatch, it might still break their scripts.

A more gentle transition would I guess be:

  1. Mention deprecation in release notes (hah, as if anybody reads
     them).

  2. Issue a warning but continue to behave as normal. That might break
     scripts that care a lot about stderr, but otherwise is harmless. No
     clue if anybody would actually see the message or not.

  3. Flip warning to error, as your patch does.

  4. Removal.

I'd guess we could do 1+2 in one release, then 3 a release or two later,
and then finally 4. I dunno. That's more tedious and I'll be surprised
if we get any bites, but maybe we ought to do it out of principle.

-Peff
