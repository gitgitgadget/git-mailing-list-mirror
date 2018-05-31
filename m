Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E971F42D
	for <e@80x24.org>; Thu, 31 May 2018 05:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbeEaFvD (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 01:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751037AbeEaFvC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 01:51:02 -0400
Received: (qmail 12907 invoked by uid 109); 31 May 2018 05:51:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 May 2018 05:51:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9421 invoked by uid 111); 31 May 2018 05:51:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 May 2018 01:51:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2018 01:51:00 -0400
Date:   Thu, 31 May 2018 01:51:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180531055100.GC17344@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <ae75f388-edbc-8f00-e98c-825027a58c1c@gmail.com>
 <20180529211523.GA7964@sigill.intra.peff.net>
 <xmqqzi0hety4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi0hety4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 11:52:19AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Right, what I meant by "gentler" is that we continue to perform the same
> > behavior as the old version, alongside the warning. It's arguable here
> > because running "git branch -l" has _always_ been wrong. It's just wrong
> > in a way that happens to do what the user wants. ;)
> > ...
> >> Anyways, if you think it mustn't turn into an error now and only in the
> >> next stage, a suggestion follows in another thread.
> >
> > I don't think "mustn't", but I have a slight preference for what I
> > posted, as I think it is a little friendlier during the transition (at
> > the risk of somebody missing the warning, but then step 2 turns it into
> > a hard error anyway, so they'll certainly find out then).
> 
> Well, we could keep treating '-l' given in contexts where we have
> silently ignored the option and did "list" instead as before during
> the transition, until the very end where it becomes an explicit
> "list" command, no?  Then there is no need to even warn against '-l'
> that is ignored because we are listing in the earliest step.  The
> only usage that requires a warning then becomes '-l' used for its
> original meaning to create a reflog, right?  That sounds gentler to
> me.

So I think you're proposing:

  - step 0: warn about "-l" when it actually gets used, and otherwise
    continue ignoring

  - step 1: turn "-l" into "--list"

  - step 2: there is no step 2

I can't think of any reason that would work, and it lets us reclaim it
for "--list" sooner. I guess "when it gets used" is maybe not the right
criterion. We'd warn on:

  git branch -l foo

But we wouldn't on:

  git branch -d -l foo

That's clearly nonsense, but we're probably better off complaining. So I
guess the right rule is to warn when we are not in list-mode, and
otherwise quietly accept it.

That does mean that anybody who misses the deprecation warning may be
surprised when "branch -l foo" starts listing instead of creating a
branch with a reflog (whereas in the current 3-step plan, we have a
period in the middle where that's a hard error). That may be OK, though,
and is a natural consequence of getting to the end step sooner (even
with a 3-step plan, anybody who skips the versions in the middle _could_
be surprised).

-Peff
