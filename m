Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C671F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbfAOTMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:12:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:37246 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729921AbfAOTMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:12:37 -0500
Received: (qmail 24068 invoked by uid 109); 15 Jan 2019 19:12:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Jan 2019 19:12:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12419 invoked by uid 111); 15 Jan 2019 19:12:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 15 Jan 2019 14:12:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jan 2019 14:12:35 -0500
Date:   Tue, 15 Jan 2019 14:12:35 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] getenv() timing fixes
Message-ID: <20190115191235.GB4886@sigill.intra.peff.net>
References: <20190111221414.GA31335@sigill.intra.peff.net>
 <87va2u3yeu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va2u3yeu.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 12, 2019 at 12:31:21PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > So anyway. Here are a handful of what seem like pretty low-hanging
> > fruit. Beyond the first one, I'm not sure if they're triggerable, but
> > they're easy to fix. There are 100+ grep matches that I _didn't_ audit,
> > so this is by no means a complete fix. I was mostly trying to get a
> > sense of how painful these fixes would be.
> 
> I wonder, and not as "you should do this" feedback on this series, just
> on future development, whether we shouldn't just make our own getenv()
> wrapper for the majority of the GIT_* variables. The semantics would be
> fetch value X, and if it's ever requested again return the value we
> found the first time.

Yeah, that thought certainly crossed my mind while looking into this.
But as you noted below, you do sometimes have to worry about
invalidating that cache. The most general solution is that you'd hook
setenv(), too. At which point you've basically just constructed a shadow
environment that has less-crappy semantics than what POSIX guarantees. ;)

Another option is to just have a getenv_safe() that always returns an
allocated string. That's less efficient in some cases, but probably not
meaningfully so (you probably shouldn't be calling getenv() in a tight
loop anyway). It does mean dealing with memory ownership, though, which
is awkward in some cases (e.g., see git_editor).

Mostly I'm worried about making a system that's opaque or easy for
people to get wrong (e.g., if our getenv() wrapper quietly caches things
but setenv() does not invalidate that cache, that's a recipe for
confusion).

> Maybe such an API would just loop over "environ" on startup, looking for
> any GIT_* variables, i.e. called from the setup.c code.

I think whatever we do could just lazy-load. There's no particular
initialization we have to do at the beginning of the program.

-Peff
