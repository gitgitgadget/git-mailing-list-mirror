Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82100208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbdIEND5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:03:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:57286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750805AbdIEND4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:03:56 -0400
Received: (qmail 2017 invoked by uid 109); 5 Sep 2017 13:03:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:03:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12725 invoked by uid 111); 5 Sep 2017 13:04:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:04:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:03:54 -0400
Date:   Tue, 5 Sep 2017 09:03:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/10] test-lib: --valgrind should not override --verbose-log
Message-ID: <20170905130354.ydaasossmjlaps22@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --verbose test option cannot be used with test harnesses
like "prove". Instead, you must use --verbose-log.

Since the --valgrind option implies --verbose, that means
that it cannot be used with prove. I.e., this does not work:

  prove t0000-basic.sh :: --valgrind

You'd think it could be fixed by doing:

  prove t0000-basic.sh :: --valgrind --verbose-log

but that doesn't work either, because the implied --verbose
takes precedence over --verbose-log. If the user has given
us a specific option, we should prefer that.

Signed-off-by: Jeff King <peff@peff.net>
---
I ended up not using valgrind for most of my tests, but this did bite me
early on when I tried to run "make GIT_TEST_OPTS=--valgrind prove".

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5fbd8d4a90..62461a6e35 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -274,7 +274,7 @@ then
 	test -z "$verbose" && verbose_only="$valgrind_only"
 elif test -n "$valgrind"
 then
-	verbose=t
+	test -z "$verbose_log" && verbose=t
 fi
 
 if test -n "$color"
-- 
2.14.1.721.gc5bc1565f1

