Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FF41F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393069AbfFMQ6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:58:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:54004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729911AbfFMQ6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:58:12 -0400
Received: (qmail 3193 invoked by uid 109); 13 Jun 2019 16:58:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 16:58:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19953 invoked by uid 111); 13 Jun 2019 16:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 12:58:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 12:58:09 -0400
Date:   Thu, 13 Jun 2019 12:58:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
Message-ID: <20190613165809.GA13031@sigill.intra.peff.net>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <cover.1560277373.git.matvore@google.com>
 <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
 <nycvar.QRO.7.76.6.1906122118380.789@QRFXGBC-DHN364S.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1906122118380.789@QRFXGBC-DHN364S.ybpnyqbznva>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 09:51:33PM +0200, Johannes Schindelin wrote:

> > +	head -n 1 actual >first &&
> > +	# The first line should be enclosed by full-width parenthesis.
> > +	grep "（.*）" first &&
> 
> I wonder whether it is a good idea to pretend that we can pass arbitrary
> byte sequences to `grep`, independent of the current locale. On Windows,
> this does not hold true, for example.
> 
> It would probably make more sense to store a support file in t/t3207/,
> much like it is done in t3900.
> 
> And once you do that, you can simply `test_cmp t3207/first first`. No
> need to `grep` for `master` in addition:

I was just writing a similar response in another part of the thread, and
found this. :)

In addition to grep portability problems, IMHO the source with the raw
UTF-8 characters is harder to read. Even if your editor and terminal
support UTF-8, people without the right fonts will just get a bunch of
empty boxes. And when debugging, you often care about the raw bytes
anyway (e.g., when there are multiple representations of the same
glyph).

Adding a support file is fine, but for small cases like this, it may be
easier to do:

  printf '\357\274\210...' >expect

but note that this _must_ be octal, not hex, as many versions of printf
only handle the former.

-Peff
