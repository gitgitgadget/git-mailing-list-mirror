Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07EC1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbeGMUgA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:36:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:58930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731379AbeGMUgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:36:00 -0400
Received: (qmail 2177 invoked by uid 109); 13 Jul 2018 20:19:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 20:19:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7012 invoked by uid 111); 13 Jul 2018 20:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 16:19:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 16:19:49 -0400
Date:   Fri, 13 Jul 2018 16:19:49 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
Message-ID: <20180713201949.GA17670@sigill.intra.peff.net>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
 <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
 <20180713184732.GC968742@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713184732.GC968742@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 06:47:32PM +0000, brian m. carlson wrote:

> > >> git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
> > > ... path to git repository/xdiff !!!
> > >
> > > This seems like incorrect behaviour to me since it's a weird
> > > inconsistency (even with other rebase contexts) & the documentation
> > > says "Show the absolute path of the top-level directory." with no
> > > caveats.
> > 
> > Does it reproduce with older rebase (say from v2.10 days), too?
> 
> It appears to work correctly on the CentOS SCL Git 2.9.3.  We print the
> top level of the repository there.

Bisecting is tricky, because there are actually three distinct
behaviors.

The command above prints the correct top-level until 18633e1a22 (rebase
-i: use the rebase--helper builtin, 2017-02-09). After that, rev-parse
prints "Not a git repository".

That goes on until 09d7b6c6fa (sequencer: pass absolute GIT_DIR to exec
commands, 2017-10-31).

None of which is too surprising. The root of the bug is in the
conversion to rebase--helper, I think, when presumably we started
setting GIT_DIR at all (but I didn't dig further). Then 09d7b6c6fa fixed
_one_ fallout of that, which was relative paths, but didn't help the
subdirectory case.

Just reading over this thread, I suspect the simplest fix is to pass
GIT_DIR and GIT_WORK_TREE together, which is almost always the right
thing to do.

-Peff
