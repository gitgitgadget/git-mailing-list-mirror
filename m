Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712CC20986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbcJDRyx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:54:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:52209 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbcJDRyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:54:52 -0400
Received: (qmail 6533 invoked by uid 109); 4 Oct 2016 17:54:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:54:51 +0000
Received: (qmail 7800 invoked by uid 111); 4 Oct 2016 17:55:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:55:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 13:54:49 -0400
Date:   Tue, 4 Oct 2016 13:54:49 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] push: change submodule default to check
Message-ID: <20161004175449.gn5cw6wcbvloqkzj@sigill.intra.peff.net>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
 <20161004164036.6584-1-sbeller@google.com>
 <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
 <CAGZ79kaKOjqLBsNVSmudzLUCkOJf_CsFGE8OZZHsTmuXCfiVeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaKOjqLBsNVSmudzLUCkOJf_CsFGE8OZZHsTmuXCfiVeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 10:48:51AM -0700, Stefan Beller wrote:

> > This does seem like a reasonable heuristic. I wonder if you want to
> > confirm that we actually have a worktree (and are in it) before looking
> > at file_exists(). It's unlikely that looking at ".gitmodules" in a bare
> > repo would trigger in practice, but it does not hurt to be careful.
> 
> In a bare repo we'd rather want to check for an entry of .gitmodules in HEAD ?

Yeah, I think that is the closest equivalent.

> I considered it a non issue, as I don't think many people push from
> bare repositories.

I'd also agree, and I have no problem if there simply _isn't_ an auto
heuristic for bare repos. Mostly I just thought blindly calling
file_exists() was ugly (especially after all the recent "whoops, we look
at .git/config in the wrong directory" fixes I've been doing lately).

> Here is another thought:
> .gitmodules may not exist (either in working dir or in HEADs git
> tree), so maybe the
> "correct" heuristic is to check for directories in $GIT_DIR/modules/
> That is "more correct", because it is inconceivable to change the submodule
> pointers without having the submodules checked out. (Who would do that? Why?)

Actually, I like that a bit better. It would not cover the case where
you have not actually checked out any of the submodules (or at least not
called "submodule init", I guess?). But arguably that is a sign that the
auto-recurse behavior should not be kicking in anyway.

Bearing in mind that I am not too familiar with what's normal in the
submodule world, and so might be spouting nonsense. :)

-Peff
