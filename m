Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90175201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdBXTCp (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:02:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:33490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbdBXTCn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:02:43 -0500
Received: (qmail 4443 invoked by uid 109); 24 Feb 2017 18:56:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 18:56:02 +0000
Received: (qmail 22107 invoked by uid 111); 24 Feb 2017 18:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 13:56:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 13:56:00 -0500
Date:   Fri, 24 Feb 2017 13:56:00 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Subject: Re: git email From: parsing (was Re: [GIT PULL] Staging/IIO driver
 patches for 4.11-rc1)
Message-ID: <20170224185600.ftfts6y2au3tvzge@sigill.intra.peff.net>
References: <20170222145613.GA17333@kroah.com>
 <CA+55aFy1JpXmo_PpC7f0zZa0YAP6rz+bztJ+fpDUoWgCz0_FMw@mail.gmail.com>
 <20170223060444.GA26196@kroah.com>
 <20170223061702.bzzgrntotppvwdw6@sigill.intra.peff.net>
 <CAMuHMdX+xGUD+K16VCE=ywRgN1Zd4MzSr=NJ=2xz+8e_ixyGKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX+xGUD+K16VCE=ywRgN1Zd4MzSr=NJ=2xz+8e_ixyGKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 12:03:45PM +0100, Geert Uytterhoeven wrote:

> > The problem isn't on the applying end, but rather on the generating end.
> > The From header in the attached mbox is:
> >
> >   From: =?us-ascii?B?PT9VVEYtOD9xP1NpbW9uPTIwU2FuZHN0cj1DMz1CNm0/PQ==?= <simon@nikanor.nu>
> 
> Slightly related, once in a while I get funny emails through
> git-commits-head@vger.kernel.org, where the subject is completely screwed up:
> 
>     Subject: \x64\x72\x6D\x2F\x74\x69\x6E\x79\x64\x72\x6D\x3A
> \x6D\x69\x70\x69\x2D\x64\x62\x69\x3A \x53\x69\x6C\x65\x6E\x63\x65\x3A
> ‘\x63\x6D\x64’ \x6D\x61\x79 \x62\x65

Sorry, I don't have a clue on that one.

If you have UTF-8 or other non-ASCII characters in your subject,
format-patch will correctly do the rfc2047 encoding (and it should
always use QP). And that would kick in here because of the UTF-8 quotes.

But that weird "\x" encoding is not in any mail standard I know of (and
certainly Git would never do it).

The odd thing is that the quotes themselves _aren't_ encoded. Just
everything else.

One other feature is that subject line is long enough (especially
QP-encoded) that it spans two lines:

  $ git format-patch --stdout -1 b401f34314d | grep -A1 ^Subject
  Subject: [PATCH] =?UTF-8?q?drm/tinydrm:=20mipi-dbi:=20Silence:=20=E2=80=98?=
   =?UTF-8?q?cmd=E2=80=99=20may=20be=20used=20uninitialized?=

It's possible that something along the way is mis-handling subjects with
line-continuation (though why it would escape those characters, I don't
know).

> and some of the mail headers end up in the body as well:
> 
>     =?UTF-8?Q?\x75\x73\x65\x64_\x75\x6E\x69\x6E\x69\x74\x69\x61\x6C\x69\x7A\x65\x64?=

That might be related to the whitespace continuation (the first line
after the break is the second line of the subject).

-Peff
