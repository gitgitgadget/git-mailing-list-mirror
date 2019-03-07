Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30E720248
	for <e@80x24.org>; Thu,  7 Mar 2019 19:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCGTlt (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 14:41:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:43022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726207AbfCGTlt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 14:41:49 -0500
Received: (qmail 6228 invoked by uid 109); 7 Mar 2019 19:41:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 19:41:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26984 invoked by uid 111); 7 Mar 2019 19:42:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 14:42:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 14:41:47 -0500
Date:   Thu, 7 Mar 2019 14:41:47 -0500
From:   Jeff King <peff@peff.net>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190307194146.GA2453@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
 <20190304204007.GA32691@sigill.intra.peff.net>
 <20190305191519.GA12791@sigill.intra.peff.net>
 <1551902320.1727.1.camel@libero.it>
 <20190306200356.GB23315@sigill.intra.peff.net>
 <1551905579.1727.8.camel@libero.it>
 <20190306215752.GC32630@sigill.intra.peff.net>
 <1551985495.1606.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551985495.1606.1.camel@libero.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc git@vger; let's keep this on the list; I'm not sure there's a lot
 to be learned from fiddling with this old version, but if we're going
 to do it, let's at least record our attempts for posterity]

On Thu, Mar 07, 2019 at 08:04:55PM +0100, Fabio Aiuto wrote:

> I made a directory "trial" and inside it I ran init-db (that's the
> grand-father of git init) inside that directory. Then I created a file 
> this way:
> 
> echo 'helloooo!' >file.txt
> 
> then then executed update-cache file.txt (thinking that's the ancestor
> of git add), but that doesn't work and it returns with a segmentation
> fault, due to the nullity of the header. But in this first commit how
> do I add a file in the cache? What's the right way to build up a
> repository from scratch with commit e83c5163316f?

Hmm. I tried that, too, and got a segfault. Then I tried it again a few
minutes later, and it worked.

One thing that seems to provoke it consistently is having a zero-length
index file (because that causes mmap to return NULL, and the code does
not check for that case). Try this:

  # This works.
  init-db
  echo content >file
  update-cache file

  # This segfaults
  >.dircache/index
  update-cache file

  # And this works again
  rm .dircache/index
  update-cache file

I'm not sure why it would ever fail without that explicit empty-file
write. Perhaps there's some code path that writes out an empty index
file, and we inadvertently triggered it.

If you're going to play with such an antique commit, you have to expect
that things won't necessarily work, and be ready to poke around in the
debugger.

-Peff
