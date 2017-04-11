Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54131FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbdDKKYV (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:24:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:59757 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbdDKKXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:23:38 -0400
Received: (qmail 22856 invoked by uid 109); 11 Apr 2017 10:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:23:36 +0000
Received: (qmail 482 invoked by uid 111); 11 Apr 2017 10:23:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:23:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:23:33 -0400
Date:   Tue, 11 Apr 2017 06:23:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 05/12] log: add exhaustive tests for pattern style
 options & config
Message-ID: <20170411102333.itfca2aofu5l23bc@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170408132506.5415-6-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 01:24:59PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Add exhaustive tests for how the different grep.patternType options &
> the corresponding command-line options affect git-log.
> 
> Before this change it was possible to patch revision.c so that the
> --basic-regexp option was synonymous with --extended-regexp, and
> --perl-regexp wasn't recognized at all, and still have 100% of the
> test suite pass.

I thought we _did_ have good coerage here, but I think it is only for
grep (via t7810). It makes sense to cover this for "log", too.

> The patterns being passed to fixed/basic/extended/PCRE are carefully
> crafted to return the wrong thing if the grep engine were to pick any
> other matching method than the one it's told to use.

This can be tricky since POSIX allows implementations to add arbitrary
extensions for otherwise invalid syntax.

See my recent 7675c7bd0 (t7810: avoid assumption about invalid regex
syntax, 2017-01-11). In particular:

> +		if test_have_prereq LIBPCRE
> +		then
> +			git -c grep.patternType=perl log --pretty=tformat:%s \
> +				--grep="\((?=1)" >actual.perl
> +		fi &&

I'd have to double-check POSIX, but I suspect that it may allow (?=1) to
work in an ERE (since it's otherwise bogus to have "?" without a prior
element to match).

-Peff
