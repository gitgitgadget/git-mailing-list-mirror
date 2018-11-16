Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17631F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeKPSzu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 13:55:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:41806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727413AbeKPSzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 13:55:50 -0500
Received: (qmail 29019 invoked by uid 109); 16 Nov 2018 08:44:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 08:44:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24885 invoked by uid 111); 16 Nov 2018 08:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 03:43:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 03:44:27 -0500
Date:   Fri, 16 Nov 2018 03:44:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] remote-curl smart-http discovery cleanup
Message-ID: <20181116084427.GA31493@sigill.intra.peff.net>
References: <9a89e54e79593f6455b52e01d802695362f4ec21.1542062657.git.steadmon@google.com>
 <20181113142624.GA17128@sigill.intra.peff.net>
 <20181113222540.GE126896@google.com>
 <20181114004915.GA5059@sigill.intra.peff.net>
 <20181114070052.GA19904@sigill.intra.peff.net>
 <20181115215152.GK126896@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115215152.GK126896@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 01:51:52PM -0800, Josh Steadmon wrote:

> > This patch tightens both of those (I also made a few stylistic tweaks,
> > and added the ERR condition to show where it would go). I dunno. Part of
> > me sees this as a nice cleanup, but maybe it is better to just leave it
> > alone. A lot of these behaviors are just how it happens to work now, and
> > not part of the spec, but we don't know what might be relying on them.
> 
> At least according to the protocol-v2 and http-protocol docs, the
> stricter behavior seems correct:
> 
> For the first point above, dumb servers should never use an
> "application/x-git-*" content type (http-protocol.txt line 163-167).
> 
> For the second point, the docs require v2 servers to use
> "application/x-git-*" content types. protocol-v2.txt lines 63-65 state
> that v2 clients should make a smart http request, while
> http-protocol.txt lines 247-252 state that a smart server's response
> type must be "application/x-git-*".

Thanks for digging into the spec. I agree that it's pretty clear that
the appropriate content-type is expected.

> Of course we don't know if other implementations follow the spec, but
> ISTM that this patch at least doesn't contradict how we've promised the
> protocols should work.

These seem like pretty unlikely ways for a buggy server to behave, so I
think it's a reasonable risk. I also checked GitHub's implementation
(which recently learned to speak v2) and made sure that it works. :)
I didn't check JGit, but given the provenance, I assume it's fine.

Amusingly, this does break the test you just added, because it tries to
issue an ERR after claiming "text/html" (and after my patch, we
correctly fall back to dumb-http).

> If no one has any objections, I'll include the diff below in v2. Thanks
> for the help Jeff!

I think it makes sense to do the refactoring first as a separate step.
And of course it needs a commit message. So how about this series (your
original is rebased on top)?

  [1/3]: remote-curl: refactor smart-http discovery
  [2/3]: remote-curl: tighten "version 2" check for smart-http
  [3/3]: remote-curl: die on server-side errors

 remote-curl.c                   | 96 +++++++++++++++++++++------------
 t/lib-httpd.sh                  |  1 +
 t/lib-httpd/apache.conf         |  4 ++
 t/lib-httpd/error-smart-http.sh |  3 ++
 t/t5551-http-fetch-smart.sh     |  5 ++
 5 files changed, 75 insertions(+), 34 deletions(-)
 create mode 100644 t/lib-httpd/error-smart-http.sh

-Peff
