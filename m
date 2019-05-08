Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45AA1F45F
	for <e@80x24.org>; Wed,  8 May 2019 23:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfEHXEW (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 19:04:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:52576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727041AbfEHXEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 19:04:22 -0400
Received: (qmail 5297 invoked by uid 109); 8 May 2019 23:04:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 May 2019 23:04:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29014 invoked by uid 111); 8 May 2019 23:04:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 May 2019 19:04:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 May 2019 19:04:20 -0400
Date:   Wed, 8 May 2019 19:04:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as unsigned
Message-ID: <20190508230420.GC19990@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <pull.145.v2.git.gitgitgadget@gmail.com>
 <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com>
 <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
 <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 01:45:25PM +0200, Johannes Schindelin wrote:

> Hi René,
> 
> On Thu, 2 May 2019, René Scharfe wrote:
> 
> > Am 27.04.19 um 01:27 schrieb Johannes Schindelin via GitGitGadget:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > They really are unsigned, and we are using e.g. BLOCKSIZE as `size_t`
> > > parameter to pass to `write_or_die()`.
> >
> > True, but the compiler converts that value correctly to size_t without
> > complaint already, doesn't it?  What am I missing?
> 
> Are you talking about a specific compiler? It sure sounds as if you did.
> 
> I really do not want to fall into the "you can build Git with *any*
> compiler, as long as that compiler happens to be GCC, oh, and as long it
> is version X" trap.

I don't this this has anything to do with gcc. The point is that we
already have this line:

  write_or_die(fd, buf, BLOCKSIZE);

which does not cast and nobody has complained, even though the signed
constant is implicitly converted to a size_t. So adding another line
like:

  gzwrite(gzip, block, BLOCKSIZE);

would in theory be treated the same (gzwrite takes an "unsigned").

The conversion from signed to unsigned is well defined in ANSI C, and
I'd expect a compiler to either complain about neither or both (and the
latter probably with warnings like -Wconversion cranked up).

But of course if you have data otherwise, we can revise that. Was the
cast added out of caution, or to squelch a compiler warning?

-Peff
