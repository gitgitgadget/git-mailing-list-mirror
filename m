Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D087A20357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbdGJNYx (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:24:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:35400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753864AbdGJNYx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:24:53 -0400
Received: (qmail 17828 invoked by uid 109); 10 Jul 2017 13:24:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:24:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5069 invoked by uid 111); 10 Jul 2017 13:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:25:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:24:50 -0400
Date:   Mon, 10 Jul 2017 09:24:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] Makefile: disable unaligned loads with UBSan
Message-ID: <20170710132450.yxojk5cybejy7und@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The undefined behavior sanitizer complains about unaligned
loads, even if they're OK for a particular platform in
practice. It's possible that they _are_ a problem, of
course, but since it's a known tradeoff the UBSan errors are
just noise.

Let's quiet it automatically by building with
NO_UNALIGNED_LOADS when SANITIZE=undefined is in use.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index cc03b3c95..3c341b2a6 100644
--- a/Makefile
+++ b/Makefile
@@ -1015,6 +1015,9 @@ endif
 ifdef SANITIZE
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
 BASIC_CFLAGS += -fno-omit-frame-pointer
+ifeq ($(SANITIZE),undefined)
+BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
+endif
 endif
 
 ifndef sysconfdir
-- 
2.13.2.1071.gcd8104b61
