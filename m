Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DB01F42E
	for <e@80x24.org>; Mon,  7 May 2018 07:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeEGHk1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 03:40:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:58450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750913AbeEGHk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 03:40:26 -0400
Received: (qmail 30187 invoked by uid 109); 7 May 2018 07:40:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 07:40:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24382 invoked by uid 111); 7 May 2018 07:40:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 03:40:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 03:40:24 -0400
Date:   Mon, 7 May 2018 03:40:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/18] color: provide inverted colors, too
Message-ID: <20180507074024.GB31170@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182922.GD17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet>
 <20180506063543.GA3418@sigill.intra.peff.net>
 <20180506064104.GB3418@sigill.intra.peff.net>
 <xmqqvac0qmbq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvac0qmbq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 07, 2018 at 10:35:53AM +0900, Junio C Hamano wrote:

> > So really, I guess all I am arguing for is having GIT_COLOR_INV (or
> > REVERSE) as a constant, and then teaching the code to combine it with
> > the existing "new" color. It's perfectly OK to have:
> >
> >   \x1b[7m\x1b[36m
> >
> > instead of:
> >
> >   \x1b[7;36m
> >
> > It's two extra bytes, but I doubt anybody cares.
> 
> I do not think two extra bytes will be missed, but it was not
> immediately obvious to me how much flexibility or simplicity weu are
> gaining by combining values from multiple configuration variables.

My goal was just to let you set color.diff.new to something besides
green without having to also manually set color.tbdiff.new (or whatever
it's called) to match.

> With a "letters on a new line is painted with ${new}, in addition,
> the leading plus is further annotated with ${tbdiffNew}" (similarly
> to "old") scheme, the user can take advantage of the fact that there
> is no ${reset} between ${new} and ${tbdiffNew} and set tbdiffNew and
> tbdiffOld to a same value (that does not change the color but
> changes some other aspect of the appearance, like "reverse" or
> "underline").  Since only pre-designed combination can be used (your
> example works only because you chose to allow combination by
> annotating the leading "+" with ${new}${tbdiffNew}), we'd need to
> (1) establish a convention to paint things with similar meanings in
> the same color, modifyable by individual command (e.g. you could say
> anything new is by default green with "color.new=green", and then
> "color.frotz.new=blink" "color.status.new=" "color.diff.new=blue"
> would make frotz, status and diff subcommands to show new things in
> blinking green, normal green, and blue), and (2) push the codebase
> to adopt such color combination as a preferred design pattern if we
> want the resulting system to be useful.

Right, this is basically making that "new" piggy-backing explicit, but
only for this one case.

> I guess you are getting simpler configuration, which is a big plus,
> but to make a truly useful combining convention, we'd need to
> rethink and find a way to transition existing configurations to the
> new world, which may not be feasible.

Yes, one could probably develop a whole theming system for Git. We've
resisted it so far. :)

-Peff
