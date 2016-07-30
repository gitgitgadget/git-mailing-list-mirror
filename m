Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9561F855
	for <e@80x24.org>; Sat, 30 Jul 2016 02:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbcG3Clk (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 22:41:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:51511 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbcG3Clk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 22:41:40 -0400
Received: (qmail 28810 invoked by uid 102); 30 Jul 2016 02:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 22:41:40 -0400
Received: (qmail 8458 invoked by uid 107); 30 Jul 2016 02:42:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 22:42:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 22:41:36 -0400
Date:	Fri, 29 Jul 2016 22:41:36 -0400
From:	Jeff King <peff@peff.net>
To:	Paul Tan <pyokagan@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 10:11:56AM +0800, Paul Tan wrote:

> > diff --git a/commit.c b/commit.c
> > index 71a360d..7ddbffe 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -1548,6 +1548,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
> >         }
> >
> >         /* Person/date information */
> > +       reset_ident_date();
> >         if (!author)
> >                 author = git_author_info(IDENT_STRICT);
> >         strbuf_addf(&buffer, "author %s\n", author);
> 
> But since builtin/commit.c constructs its author ident string before
> calling the editor and then commit_tree_extended(), this would cause
> the resulting commits to have committer timestamps which differ from
> their author timestamps.

Hrm, yeah. I assumed it would only pass in the author string for things
like "-c" or "--amend". But it looks like it unconditionally passes in
the author.  And it would be slightly difficult to have it pass NULL,
because it may actually have _part_ of an author (e.g., "--author" will
come up with name and email but not the date), so it has to sometimes
combine those bits with things like ident_default_date() itself.

I guess one option would be to commit_tree_extended() to take the
broken-down author bits and call fmt_ident() itself. That's what all of
the callers are doing (that, or just passing NULL). It would make the
interface a bit clunkier, but I think the end result would be more
flexible.

I suppose that would be tricky for git-commit, because in addition to
passing the result of fmt_ident() to commit_tree_extended(), it wants to
take the pieces and put them in the environment for hooks to see. And if
the data is available only inside commit_tree_extended(), we don't have
it for the hooks.

> So maybe we would have to put reset_ident_date() at the end of the
> function instead, at least after git_committer_info() is called.

Yes, although "reset and end" still feels a bit weird to me.

I'd almost prefer to just have long-running programs insert resets at
strategic points.

-Peff
