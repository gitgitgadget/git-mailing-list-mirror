Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADA11F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfBHSDX (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:03:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:37762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727343AbfBHSDX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:03:23 -0500
Received: (qmail 9612 invoked by uid 109); 8 Feb 2019 18:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Feb 2019 18:03:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25882 invoked by uid 111); 8 Feb 2019 18:03:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Feb 2019 13:03:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2019 13:03:21 -0500
Date:   Fri, 8 Feb 2019 13:03:21 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190208180321.GB27673@sigill.intra.peff.net>
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
 <20190208165052.GC23461@sigill.intra.peff.net>
 <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 12:49:59PM -0500, Randall S. Becker wrote:

> > We did discuss this at the time of the patch, but it seems we already use
> > /dev/zero in a bunch of places:
> > 
> >   https://public-inbox.org/git/xmqqbm57rkg5.fsf@gitster-ct.c.googlers.com/
> > 
> > Were you just skipping the other tests before?
> 
> I did not catch the implications of the review at the time - my bad. We were not intentionally skipping the tests. It looks like some are automatically skipped. t4153 automatically skips (missing TTY), and t5562 fails also but for a different reason (hang - we don't have apache2 to serve up http content).
> 
> Would you object to something like this:
> 
> if [ ! -e /dev/zero ]; then
> 	# use shred or some other mechanism (still trying to figure out a solution)
> else
> 	# existing dd
> fi

That's fine, as long as it's wrapped up in a function in order to keep
the tests readable.

Though I suspect we may be able to just find a solution that works
everywhere, without having two different implementations. If we know we
need $count bytes for dd, we could probably just generate a file with
that many NULs in it.

Other cases don't seem to actually care that they're getting NULs, and
are just redirecting stdin from /dev/zero to get an infinite amount of
input. They could probably use "yes" for that.

-Peff
