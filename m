Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9911F42E
	for <e@80x24.org>; Sun,  6 May 2018 06:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeEFGfr (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 02:35:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750824AbeEFGfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 02:35:46 -0400
Received: (qmail 5868 invoked by uid 109); 6 May 2018 06:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 06 May 2018 06:35:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15498 invoked by uid 111); 6 May 2018 06:35:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 06 May 2018 02:35:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2018 02:35:44 -0400
Date:   Sun, 6 May 2018 02:35:44 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/18] color: provide inverted colors, too
Message-ID: <20180506063543.GA3418@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182922.GD17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 12:03:50AM +0200, Johannes Schindelin wrote:

> > There's a "reverse" attribute (which we already parse and support) that
> > can do this without having to repeat the colors. AFAIK it's well
> > supported everywhere, but I could be wrong.
> 
> How would I use that here, though? I need to get the thing via
> diff_get_color_opt() which takes a parameter of type `enum color_diff`.
> There is no way I can specify `reverse` here, can I?

My thinking was that the code would know that coloring the initial "+"
should combine color.diff.new, along with a new tbdiff-specific config
option. So the C equivalent of something like this:

  new=$(git config --get-color color.diff.new green)
  tbdiff=$(git config --get-color color.tbdiff.new reverse)
  reset=$(git config --get-color color.diff.reset reset)

  echo "${new}${tbdiff}+${reset}${new}+actual diff content${reset}"

Then if you set color.diff.new to blue, you'll get a reverse-blue "+"
without having to configure anything else.

You can still override the tbdiff coloring with a totally unrelated
color, since it comes after ${new} (so you could set it to purple or
something if you wanted, though obviously a background or attribute from
${new} can still leak through if you have one set). The only downside in
such a case is that the color sequence is slightly longer ("green, no
blue!").

You could also have tbdiff.new and tbdiff.old to allow setting them
independently (but they'd both default to "reverse").

> > I wonder if that would make configuring this slightly more pleasant,
> > since it saves the user having to define "oldinv" whenever they change
> > "old".
> 
> I am all for making the configuration more pleasant. So I hope I can make
> use of the `reverse` thing here, without having to introduce a new enum
> value.

I think the new enum (and matching config) has some value in case people
want to override it.  But if you don't want to, diff_get_color() is
really just checking want_color() as a convenience. You could do that,
too:

  const char *reverse = want_color(opt->use_color) ? GIT_COLOR_REVERSE : "";

You'd have to introduce GIT_COLOR_REVERSE. I don't think we have a
constant for it yet, but it's \x[7m.

-Peff
