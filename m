Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3F21F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 09:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCRJ0c (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 05:26:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:33164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751934AbeCRJ0c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 05:26:32 -0400
Received: (qmail 3083 invoked by uid 109); 18 Mar 2018 09:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 18 Mar 2018 09:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10580 invoked by uid 111); 18 Mar 2018 09:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 18 Mar 2018 05:27:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Mar 2018 05:26:30 -0400
Date:   Sun, 18 Mar 2018 05:26:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in
 DEVELOPER=1
Message-ID: <20180318092629.GB29208@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net>
 <20180318081834.16081-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180318081834.16081-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 09:18:34AM +0100, Nguyễn Thái Ngọc Duy wrote:

> The set of extra warnings we enable when DEVELOPER has to be
> conservative because we can't assume any compiler version the
> developer may use. Detect the compiler version so we know when it's
> safe to enable -Wextra and maybe more.

Hrm, I was planning to expand my patch into a series. In particular, in
my experiments some of those warnings do not need to be disabled under
-Wextra (I tested going back to gcc 5 and clang 4.0).

I think it's worth splitting up the boilerplate changes from the
decisions on individual warnings, because I suspect we'll need to revise
the latter going forward.

I also noticed that all of those options seem to go back at least to
gcc-5. It makes me wonder how much we even need this version-detecting
framework. There are one or two "clang vs gcc" things I've found, but I
haven't found a case where old versions of gcc don't support a
particular option.

IOW, could we get away with just adding these to the DEVELOPER knob and
assuming that people who use it have a reasonably modern gcc or clang
setup? That's more or less what the existing knobs do.

But I didn't follow whether there was any earlier discussion on specific
problems.

>  -dumpversion does not work correctly for clang. So I use "-v" instead
>  which seems to produce the same output for both gcc and clang (with a
>  minor difference in freebsd where it says "FreeBSD clang" instead of
>  just "clang"). Not sure if it helps your "cc on debian" case though

Heh. At first I was confused, as it seems to work for me:

  $ clang-4.0 -dumpversion
  4.2.1

But then I tried this:

  $ clang-5.0 -dumpversion
  4.2.1

Whoops. It returns the same value up through clang 7.

-Peff
