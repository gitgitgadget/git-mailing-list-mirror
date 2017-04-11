Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92321FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbdDKKxA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:53:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:59858 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754142AbdDKKve (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:51:34 -0400
Received: (qmail 25851 invoked by uid 109); 11 Apr 2017 10:51:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:51:33 +0000
Received: (qmail 1098 invoked by uid 111); 11 Apr 2017 10:51:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:51:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:51:31 -0400
Date:   Tue, 11 Apr 2017 06:51:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 05/12] log: add exhaustive tests for pattern style
 options & config
Message-ID: <20170411105130.2ezvvm4kl5wdav3x@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-6-avarab@gmail.com>
 <20170411102333.itfca2aofu5l23bc@sigill.intra.peff.net>
 <CACBZZX5jGGUToK83e2iugpbSBDpATi7J0BWg9=UY=YC4ZixT+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5jGGUToK83e2iugpbSBDpATi7J0BWg9=UY=YC4ZixT+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:32:57PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > This can be tricky since POSIX allows implementations to add arbitrary
> > extensions for otherwise invalid syntax.
> 
> For POSIX basic v.s. extended I'm relying on (|) not being
> metacharacters in basic but metachars needing quoting in extended. I
> very much doubt any regex implementation doesn't conform to that, but
> maybe some crazy implementation does...

Yeah, I think BRE vs ERE (vs fixed) is fine, because POSIX specifies the
differences. It's really PCRE, because ERE implementations have a
surprising amount of flexibility according to the standard (basically
anything invalid is listed as "undefined" and implementations are
allowed to do what they please).

> >> +             if test_have_prereq LIBPCRE
> >> +             then
> >> +                     git -c grep.patternType=perl log --pretty=tformat:%s \
> >> +                             --grep="\((?=1)" >actual.perl
> >> +             fi &&
> >
> > I'd have to double-check POSIX, but I suspect that it may allow (?=1) to
> > work in an ERE (since it's otherwise bogus to have "?" without a prior
> > element to match).
> 
> Distinguishing PCRE from the rest is much easier, I'll add some more
> obscure PCRE feature to that which definitely doesn't exist in any
> POSIX rx library, e.g. (*COMMIT) or something.

I think (*) would be "undefined" by POSIX, and thus allowed for
extensions (though in practice it's probably fine). The "[\d]" trick was
the simplest one I could find that is reliably defined to be different
between ERE and PCRE.

-Peff
