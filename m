Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA86BC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0EF20714
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 08:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgC0ICM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:02:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726027AbgC0ICM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 04:02:12 -0400
Received: (qmail 9367 invoked by uid 109); 27 Mar 2020 08:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Mar 2020 08:02:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22990 invoked by uid 111); 27 Mar 2020 08:12:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Mar 2020 04:12:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Mar 2020 04:02:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] upload-pack: handle unexpected v2 delim packets
Message-ID: <20200327080210.GA604725@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We saw an upload-pack segfault in the wild today at GitHub. It's caused
by a client sending bogus v2 protocol lines (a "delim" packet instead of
a "flush"). So the client is broken and our only option is to break the
network connection, but we shouldn't segfault while doing so. :)

I don't think the broken client was Git. It didn't send an "agent"
capability at all, which makes me suspect it was somebody generating the
request manually (nor was there anything interesting in the transport
layer agent; it was just an openssh client).

The fix was simple enough, and is in the second patch. The first one is
just a small cleanup / refactor in preparation.

  [1/2]: test-lib-functions: make packetize() more efficient
  [2/2]: upload-pack: handle unexpected delim packets

 ls-refs.c                              |  5 +++-
 t/t5562-http-backend-content-length.sh | 19 +++++++++------
 t/t5704-protocol-violations.sh         | 33 ++++++++++++++++++++++++++
 t/test-lib-functions.sh                | 23 ++++++++++++------
 upload-pack.c                          |  5 +++-
 5 files changed, 69 insertions(+), 16 deletions(-)
 create mode 100755 t/t5704-protocol-violations.sh

-Peff
