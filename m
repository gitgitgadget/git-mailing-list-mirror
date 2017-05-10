Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E992018D
	for <e@80x24.org>; Wed, 10 May 2017 04:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdEJE7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 00:59:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:48607 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbdEJE7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 00:59:17 -0400
Received: (qmail 16447 invoked by uid 109); 10 May 2017 04:59:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 04:59:17 +0000
Received: (qmail 32232 invoked by uid 111); 10 May 2017 04:59:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 00:59:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 May 2017 00:59:15 -0400
Date:   Wed, 10 May 2017 00:59:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged
 warnings
Message-ID: <20170510045914.adtb5qmnc53z4vdq@sigill.intra.peff.net>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
 <CACBZZX4=QePHqDFnxvTSJ4siNv6TVzUvhCpA91aY8APZTpGEfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4=QePHqDFnxvTSJ4siNv6TVzUvhCpA91aY8APZTpGEfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2017 at 03:22:23PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Is there any way with this to both supply CFLAGS & DEVELOPER=1 on the
> command-line, to get my custom -O<whatever> & these -W flags? I.e.:
> 
> $ make DEVELOPER=1 V=1
> [...] -g -O2 -Wall -Werror -Wdeclaration-after-statement
> -Wno-format-zero-length -Wold-style-definition -Woverflow
> -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -I. [...]
> $ make DEVELOPER=1 CFLAGS="-g -O0 -Wall" V=1
> [...] -g -O0 -Wall -I. [...]
> 
> I thought the second case would prepend my "-g -O0 -Wall" but then be
> followed by the various -W developer flags, but it isn't, am I just
> doing something stupid, or is there no way to combine these two?

The problem is that when you give "make" a variable on the command line,
it overrides all of the modifications. So if you were to set that CFLAGS
in your config.mak, I think everything would work as you expect.

I actually do this in my config.mak:

  O = 0
  CFLAGS += -g -O$(O)

which lets me override the optimization level as a one-off on the
command-line:

  make O=2

without disturbing the rest of the CFLAGS. I also do this:

  CFLAGS += $(EXTRA_CFLAGS)

as a catch-all, so that I can do:

  make EXTRA_CFLAGS=-Wone-off-warning-that-I-am-testing

Perhaps those are things the main Makefile should support. I dunno. You
could see the full depths of my depravity at:

  https://github.com/peff/git/blame/meta/config/config.mak

(I linked to the blame view because there are a lot of WTF bits in there
that are explained by the commit messages).

-Peff
