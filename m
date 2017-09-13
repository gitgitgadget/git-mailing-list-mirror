Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD2F20286
	for <e@80x24.org>; Wed, 13 Sep 2017 18:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdIMS6x (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:58:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751920AbdIMS6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:58:51 -0400
Received: (qmail 29706 invoked by uid 109); 13 Sep 2017 18:58:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 18:58:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18615 invoked by uid 111); 13 Sep 2017 18:59:25 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:59:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 14:58:48 -0400
Date:   Wed, 13 Sep 2017 14:58:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] config: avoid "write_in_full(fd, buf, len) < len"
 pattern
Message-ID: <20170913185848.5ht44spbakzkrsu6@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171104.yu7ags4aq2zdwz6r@sigill.intra.peff.net>
 <20170913181515.p7u2ouine3ysblqc@sigill.intra.peff.net>
 <20170913182431.GE27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913182431.GE27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 11:24:31AM -0700, Jonathan Nieder wrote:

> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, and thank you for questioning the ptrdiff_t bits that didn't
make sense. I _thought_ they felt like nonsense, but couldn't quite
puzzle it out.

> Compilers' signed/unsigned comparison warning can be noisy, but I'm
> starting to feel it's worth the suppression noise to turn it on when
> DEVELOPER=1 anyway.  What do you think?  Is there a way to turn it on
> selectively for certain functions on the LHS (like read() and write()
> style functions)?

Obviously we couldn't turn them on for -Werror at this point. Let me see
how bad "-Wsign-compare -Wno-error=sign-compare" is.

  $ make 2>&1 | grep -c warning:
  1391

Ouch. I'm afraid that's probably not going to be very helpful. Even if I
were introducing a new problem, I'm not likely to see it amidst the mass
of existing complaints.

AFAIK there's no way to turn it on for specific functions, but I'm far
from a gcc-warning guru. Even if you could, though, the error may be far
from the function (e.g., if we store the result in an ssize_t and then
compare that with a size_t).

Interestingly in the write_in_full() case the code was actually
unreachable! But I don't think the compiler is smart enough to know
that, because it would have to realize that write_in_full() can only
return either -1 or the original value (and not a positive value in
between). Coverity _might_ be smart enough, but figuring that out does
take some loop analysis (including the assumption that write() never
returns more bytes than we asked it to write).

-Peff
