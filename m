Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3291F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfAXMOa (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:14:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:47054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726105AbfAXMO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:14:29 -0500
Received: (qmail 25004 invoked by uid 109); 24 Jan 2019 12:14:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:14:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27757 invoked by uid 111); 24 Jan 2019 12:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:14:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:14:28 -0500
Date:   Thu, 24 Jan 2019 07:14:28 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joey Hess <id@joeyh.name>, git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124121427.GB4949@sigill.intra.peff.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124003948.GS423984@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124003948.GS423984@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 12:39:49AM +0000, brian m. carlson wrote:

> > [pid  6573] mmap(NULL, 11811164160, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> > 
> > Why status needs to mmap a large file that is not modified
> > and that is configured to pass through smudge/clean, I don't know.
> 
> I believe that currently, Git stores the smudge/clean output in memory
> until it writes it out. When using the persistent filter process, it's
> possible for the process to choose to abort the operation, so we store
> the data in memory until we get the status.

For the clean step, that should be OK, since that filter output is tiny
(but see my other message for a silly heuristic and an easy fix). And
that should be all that "git status" needs. But...

> Theoretically, it should be possible for us to write this to a temporary
> file, and if necessary, rename into place, although I'm not sure how
> well that will work on Windows. File modes may also be tricky here.
> Patches are of course welcome.

I didn't experiment with the smudge side, but I think it uses the same
apply_filter() code. Which means that yes, it would try to store the
11GB in memory before writing it out. And I agree writing it out to a
file and moving it directly into place is the sanest option there. If
that doesn't work, spooling to a tempfile and then streaming it into
place would also work.

-Peff
