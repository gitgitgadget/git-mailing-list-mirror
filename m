Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF9C1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 10:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbeG1MUA (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 08:20:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:34060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728736AbeG1MUA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 08:20:00 -0400
Received: (qmail 13520 invoked by uid 109); 28 Jul 2018 10:53:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Jul 2018 10:53:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2488 invoked by uid 111); 28 Jul 2018 10:53:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 28 Jul 2018 06:53:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2018 06:53:51 -0400
Date:   Sat, 28 Jul 2018 06:53:51 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>, peff <peff@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
Message-ID: <20180728105351.GA13283@sigill.intra.peff.net>
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
 <20180727233606.179965-1-sbeller@google.com>
 <xmqqlg9wjhq7.fsf@gitster-ct.c.googlers.com>
 <CAGZ79ka2yRv5+EaBoHx_TWdM1Qgt9F7YZiW=X35MyOehfcdQBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka2yRv5+EaBoHx_TWdM1Qgt9F7YZiW=X35MyOehfcdQBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 08:52:59PM -0700, Stefan Beller wrote:

> > > +     for key in "v.a.r" "V.A.r" "v.A.r" "V.a.r"
> > > +     do
> > > +             cp testConfig testConfig_actual &&
> > > +             git config -f testConfig_actual v.a.r value2 &&
> > > +             test_cmp testConfig_expect testConfig_actual
> > > +     done
> > > +'
> >
> > I think you meant to use "$key" when setting the variable to value2.
> >
> > When the test_cmp fails with "v.a.r" but later succeeds and most
> > importantly succeeds with "V.a.r" (i.e. the last one), wouldn't the
> > whole thing suceed?  I think the common trick people use is to end
> > the last one with "|| return 1" in a loop inside test_expect_success.
> 
> Hah, of course this patch is not as easy.
> 
> The problem is in git_parse_source (config.c, line 755) when we call
> get_base_var it normalizes both styles, (and lower cases the dot style).
> 
> So in case of dot style, the strncasecmp is correct, but for the new
> extended style we need to strncmp.
> 
> So this is correct for extended but not any more for the former dot style.

Hmm, it looks like this has always been broken. Before your patch (but
after v2.18.0), running "git config v.A.r value2" writes:

  [V.A]
  r = value1
  r = value2

which is obviously broken (we decided it was the right section, but
didn't match the variables, leading to a weird duplicate). After your
patch we write:

  [V.A]
  r = value1
  [v "A"]
  r = value2

I.e., we do not consider them the same value at all. But that's actually
what happened before v2.18, too. I think you could almost justify that
behavior as "The section.subsection syntax is deprecated, so we match it
case-insensitively on reading but not on writing; since we never write
such sections ourselves, you are on your own for modifying such entries
if you choose to write them manually".

I dunno. Maybe that is too harsh. But this syntax has been deprecated
for 7 years, and nobody has noticed the bug until now (when _still_
nobody wants to use it, but rather we're poking at it as "gee, I wonder
if this even works").

> I wonder if we want to either (a) add another CONFIG_EVENT_SECTION
> that indicates the difference between the two, or have a flag in 'cf' that
> tells us what kind of section style we have, such that we can check
> appropriately for the case.

I'd think that the parse_event_data could carry type-specific
information. But...

> Or we could encode it in the 'cf->var' value to distinguish the old
> and new style.

Even if we fix the section-matching here, I suspect that would just
trigger a separate bug later when we match the full key (so we might add
to the correct section, but we would not correctly replace an existing
key). To fix that, the information does need to be carried for the whole
lifetime of cf->var, not just during the header event.

-Peff
