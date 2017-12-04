Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE1120954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdLDRa1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:30:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:47624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751754AbdLDRa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:30:26 -0500
Received: (qmail 1111 invoked by uid 109); 4 Dec 2017 17:30:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 17:30:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24935 invoked by uid 111); 4 Dec 2017 17:30:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 12:30:46 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 12:30:24 -0500
Date:   Mon, 4 Dec 2017 12:30:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171204173024.GE13332@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 02, 2017 at 09:15:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I tried to think of ways this "show a message and then delete it" could
> > go wrong. It should work OK with editors that just do curses-like
> > things, taking over the terminal and then restoring it at the end.
> > ...
> 
> I think that it is not worth to special-case "dumb" terminals like
> this round of the patches do.  If it so much disturbs reviewers that
> "\e[K" may not work everywhere, we can do without the "then delete
> it" part.  It was merely trying to be extra nice, and the more
> important part of the "feature" is to be noticeable, and I do think
> that not showing anything on "dumb", only because the message cannot
> be retracted, is putting the cart before the horse.  
> 
> Since especially now people are hiding this behind an advise.*
> thing, I think it is OK to show a message and waste a line, even.

Yeah, I was tempted to suggest just dropping this terminal magic
completely. But it probably _does_ work and is helpful in the majority
of cases (i.e., where people have in-terminal editors). I dunno.

I am a little wary of hiding behind "but you can disable it with a
config option", because that's still a thing that users have to actually
do to get the previous behavior. And I expect to get some "ugh, git is
too chatty and annoying" backlash once this is in a released version.

But maybe that is just being paranoid. It's not like we don't have a lot
of other advice flags. I really could go either way on this whole thing
(but I'll be setting the advice flag myself ;) ).

> > An even worse case (and yes, this is really reaching) is:
> >
> >   $ GIT_EDITOR='echo one; printf "two\\r"; vim' git commit
> >   hint: Waiting for your editor input...one
> >   Aborting commit due to empty commit message.
> >
> > There we ate the "two" line.
> 
> Yes, I would have to agree that this one is reaching, as there isn't
> any valid reason other than "the editor then wanted to do \e[K
> later" for it to end its last line with CR.  So our eating that line
> is not a problem.

Yeah, this was just me trying to come up with all possible implications.
I agree it's probably not worth worrying about.

-Peff
