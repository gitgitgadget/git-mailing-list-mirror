Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A08C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB452074B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437385AbgE1XE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:04:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728629AbgE1XE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:04:57 -0400
Received: (qmail 32483 invoked by uid 109); 28 May 2020 23:04:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 May 2020 23:04:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19222 invoked by uid 111); 28 May 2020 23:04:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 19:04:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 19:04:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Steven Willis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Steven Willis <onlynone@gmail.com>
Subject: Re: [PATCH] doc: ls-tree paths do not support wildcards
Message-ID: <20200528230454.GA1267915@coredump.intra.peff.net>
References: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
 <20200528215107.GA1265681@coredump.intra.peff.net>
 <xmqqy2pb1z0x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2pb1z0x.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 03:21:34PM -0700, Junio C Hamano wrote:

> >   1. Deprecate the current behavior in the documentation and release
> >      notes, encouraging people who want literal matching to use
> >      --literal-pathspecs or the ":(literal)" magic. AFAICT we've
> >      supported these since at least 2013 for this command, so it should
> >      be safe to use unconditionally.
> >
> >   2. Add a new option, "--use-pathspecs" or similar, that switches the
> >      matching code to use match_pathspec(). That lets people use the new
> >      feature immediately if they want to.
> >
> >   3. When --use-pathspecs is not in use, warn to stderr about any
> >      wildcard characters in the input. That reinforces the deprecation
> >      notice in (1) and is likely to get more people's attention.
> 
> Hmph, if we are serious about deprecation and migration, I would
> image that in stage #1, we should do this check already.  When
> "--literal-pathspecs" is NOT in use, if a pathspec would change its
> meaning if not taken literally (e.g. has glob letters, begins with
> :-magic introducer, etc.), we warn and do so from the very beginning
> of the migration process.

Yeah, sorry, I meant these three steps to all happen at once.

Technically we don't need step (2) in there for the deprecation, but I
think it lets people adjust to the new world order as their solution to
avoid the warning (though I guess literal-pathspecs would also prevent
the warning; we wouldn't be looking for "*" in the input so much as
checking whether the parsed pathspec contains a wildcard).

> >   4. After several releases, flip the default to --use-pathspecs,
> >      leaving --no-use-pathspecs as an escape hatch for people who still
> >      haven't switched their scripts.
> 
> Wouldn't --literal-pathspecs be the accepted escape hatch that will
> always be accepted, even after --use-pathspecs becomes a no-op?

Hmm, I guess so. That wouldn't restore the behavior as it is _now_, but
the current behavior is sort of pointless. It treats pathspec magic as
special, but not globs. I doubt anybody actually wants that; they'd
either want pathspecs or literal paths.

-Peff
