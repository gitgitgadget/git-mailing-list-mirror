Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81F220357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbdGJNYp (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:24:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:35390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753864AbdGJNYp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:24:45 -0400
Received: (qmail 17817 invoked by uid 109); 10 Jul 2017 13:24:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:24:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5048 invoked by uid 111); 10 Jul 2017 13:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:24:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:24:42 -0400
Date:   Mon, 10 Jul 2017 09:24:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] Makefile: add helper for compiling with -fsanitize
Message-ID: <20170710132442.epsox4rawxlyvrw3@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You can already build and test with ASan by doing:

  make CFLAGS=-fsanitize=address test

but there are a few slight annoyances:

  1. It's a little long to type.

  2. It override your CFLAGS completely. You'd probably
     still want -O2, for instance.

  3. It's a good idea to also turn off "recovery", which
     lets the program keep running after a problem is
     detected (with the intention of finding as many bugs as
     possible in a given run). Since Git's test suite should
     generally run without triggering any problems, it's
     better to abort immediately and fail the test when we
     do find an issue.

With this patch, all of that happens automatically when you
run:

  make SANITIZE=address test

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 9c9c42f8f..59f6bdcd7 100644
--- a/Makefile
+++ b/Makefile
@@ -1012,6 +1012,10 @@ ifdef DEVELOPER
 CFLAGS += $(DEVELOPER_CFLAGS)
 endif
 
+ifdef SANITIZE
+BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
+endif
+
 ifndef sysconfdir
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
-- 
2.13.2.1071.gcd8104b61

