Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C7820248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbfCASo7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:44:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:34766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727418AbfCASo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:44:59 -0500
Received: (qmail 20586 invoked by uid 109); 1 Mar 2019 18:44:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 18:44:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32646 invoked by uid 111); 1 Mar 2019 18:45:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 13:45:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 13:44:57 -0500
Date:   Fri, 1 Mar 2019 13:44:57 -0500
From:   Jeff King <peff@peff.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] name-rev: improve name_rev() memory usage
Message-ID: <20190301184457.GE30847@sigill.intra.peff.net>
References: <20190301175024.17337-1-alban.gruin@gmail.com>
 <20190301175024.17337-2-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301175024.17337-2-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 06:50:21PM +0100, Alban Gruin wrote:

> name_rev() is a recursive function.  For each commit, it allocates the
> name of its parents, and call itself.  A parent may not use a name for
> multiple reasons, but in any case, the name will not be released.  On a
> repository with a lot of branches, tags, remotes, and commits, it can
> use more than 2GB of RAM.

I don't know name-rev that well, so I didn't look super carefully at
your patch. But if it's recursive in history, that's almost certainly
going to be a problem for some histories on some platforms. We've had to
de-recursify several other algorithms (e.g., "tag --contains") because
of stack space issues.

Which isn't to say what you're doing here might not be separately
useful, but just know that in the long run that's probably where we'd
need to take this.

-Peff
