Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52ED202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbdJSVIP (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:08:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58308 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752629AbdJSVIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:08:15 -0400
Received: (qmail 4488 invoked by uid 109); 19 Oct 2017 21:08:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 21:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12533 invoked by uid 111); 19 Oct 2017 21:08:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 17:08:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 17:08:13 -0400
Date:   Thu, 19 Oct 2017 17:08:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 3/3] test-lib: make "-x" work with "--verbose-log"
Message-ID: <20171019210812.lje3o64v4qdnzcuc@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "-x" tracing option implies "--verbose". This is a
problem when running under a TAP harness like "prove", where
we need to use "--verbose-log" instead. Instead, let's
handle this the same way we do for --valgrind, including the
recent fix from 88c6e9d31c (test-lib: --valgrind should not
override --verbose-log, 2017-09-05). Namely, let's enable
--verbose only when we there isn't a more specific verbosity
option indicated.

Note that we also have to tweak `want_trace` to turn it on
(we re-check $verbose in each test because that's how we
handle --verbose-only, but --verbose-log is always on for
all tests).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3399fc3c88..14fac6d6f2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,6 @@ do
 		shift ;;
 	-x)
 		trace=t
-		verbose=t
 		shift ;;
 	--verbose-log)
 		verbose_log=t
@@ -282,6 +281,11 @@ then
 	test -z "$verbose_log" && verbose=t
 fi
 
+if test -n "$trace" && test -z "$verbose_log"
+then
+	verbose=t
+fi
+
 if test -n "$color"
 then
 	# Save the color control sequences now rather than run tput
@@ -585,7 +589,9 @@ maybe_setup_valgrind () {
 }
 
 want_trace () {
-	test "$trace" = t && test "$verbose" = t
+	test "$trace" = t && {
+		test "$verbose" = t || test "$verbose_log" = t
+	}
 }
 
 # This is a separate function because some tests use
-- 
2.15.0.rc1.560.g5f0609e481
