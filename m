Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD65202FC
	for <e@80x24.org>; Thu, 19 Oct 2017 21:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdJSVOi (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:14:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751325AbdJSVOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:14:38 -0400
Received: (qmail 4765 invoked by uid 109); 19 Oct 2017 21:14:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:14:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12628 invoked by uid 111); 19 Oct 2017 21:14:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:14:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:14:36 -0400
Date:   Thu, 19 Oct 2017 17:14:36 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH 3/5] t4015: test the output of "diff --color-moved -b"
Message-ID: <20171019211435.jatotd34knltutco@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net>
 <20171019202630.plnm6g4x3cuggxoj@sigill.intra.peff.net>
 <CAGZ79kaszx26d8D0UrEj948Fam5b41hQWXcpC0V-5Rrom6M15w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaszx26d8D0UrEj948Fam5b41hQWXcpC0V-5Rrom6M15w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 02:03:54PM -0700, Stefan Beller wrote:

> > +
> > +       git diff HEAD --no-renames --color-moved --color |
> > +               grep -v "index" |
> > +               test_decode_color >actual &&
> 
> The -v index grep makes it future proof (for a new hash)!
> I like that. What I do not like is the pipe at the end of
> git-diff as we certainly want to inspect the return code
> (or for a segfault ;)

I can claim neither credit nor failure here. These lines are copied
straight from your existing test. :)

> > +       git diff HEAD --no-renames -b --color-moved --color |
> > +               grep -v "index" |
> > +               test_decode_color >actual &&
> 
> Do we need (or rather want) to give --color additionally,
> instead of having --color-moved imply it? I guess this is
> extra carefulness from the "color always" series?

I do think --color-moved probably ought to imply --color (or at least
--color=auto). But AFAIK it doesn't do so now, so we need --color (and
if it implied "auto", we'd have to overcome that anyway).

But again, this comes straight from the existing test.

> > -test_expect_success 'move detection with whitespace changes' '
> > -       test_when_finished "git reset --hard" &&
> > -       test_seq 10 >test &&
> > -       git add test &&
> > -       sed s/3/42/ <test >test.tmp &&
> > -       mv test.tmp test &&
> > -       git -c diff.colormoved diff --ignore-space-change -- test
> > -'
> 
> Ok, this is covered above in testing for the unchanged lines (1-5)

Yes, though I think it's actually the _changed_ lines which do it (the
problem was in next_byte(), so any diff with "--color-moved -b", whether
it had moves or not, would infinite loop as long as it had lines without
whitespace at the end).

-Peff
