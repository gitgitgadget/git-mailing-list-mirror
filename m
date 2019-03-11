Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D2C20248
	for <e@80x24.org>; Mon, 11 Mar 2019 03:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCKD30 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 23:29:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:45366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727109AbfCKD30 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 23:29:26 -0400
Received: (qmail 19227 invoked by uid 109); 11 Mar 2019 03:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 03:29:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19717 invoked by uid 111); 11 Mar 2019 03:29:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 10 Mar 2019 23:29:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Mar 2019 23:29:24 -0400
Date:   Sun, 10 Mar 2019 23:29:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: One failed self test on Fedora 29
Message-ID: <20190311032923.GA7087@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 09, 2019 at 07:34:15AM -0500, Jeffrey Walton wrote:

> > It would probably help to know what commit you're building.
> > The verbose test output would also be useful, e.g.:
> 
> I built with CFLAGS += -fsanitize=undefined. It looks like the
> misaligned accesses generate UBsan findings, which is causing
> t0021-conversion to fail.

You probably should use SANITIZE=undefined instead. The Makefile has
some smarts to tweak build parameters based on your sanitize flag (e.g.,
defining NO_UNALIGNED_LOADS).

That said, I do not think sha1dc works with UBsan at this point at all.
I usually do error-checking builds with:

  make SANITIZE=address,undefined BLK_SHA1=Yes

What puzzles me is not that t0021 failed, but that everything else
_didn't_. Almost every script fails for me when Git is built with UBSan
and sha1dc.

It would be nice to make sha1dc respect NO_UNALIGNED_LOADS. But barring
that, we should probably default to BLK_SHA1 when we see
SANITIZE=undefined.

-Peff
