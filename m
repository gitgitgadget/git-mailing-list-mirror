Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C95C20C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753444AbdLHKrV (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:47:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:51980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753260AbdLHKrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 05:47:20 -0500
Received: (qmail 1774 invoked by uid 109); 8 Dec 2017 10:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 10:47:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30963 invoked by uid 111); 8 Dec 2017 10:47:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 05:47:40 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 05:47:17 -0500
Date:   Fri, 8 Dec 2017 05:47:17 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 3/4] test-lib: make "-x" work with "--verbose-log"
Message-ID: <20171208104717.GC4939@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171208104647.GA4016@sigill.intra.peff.net>
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
--verbose only when we know there isn't a more specific
verbosity option indicated.

Note that we also have to tweak `want_trace` to turn it on
(previously we just lumped $verbose_log in with $verbose,
but now we don't necessarily auto-set the latter).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7914453a3b..b8dd5e79ac 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -264,7 +264,6 @@ do
 		shift ;;
 	-x)
 		trace=t
-		verbose=t
 		shift ;;
 	--verbose-log)
 		verbose_log=t
@@ -283,6 +282,11 @@ then
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
@@ -586,7 +590,9 @@ maybe_setup_valgrind () {
 }
 
 want_trace () {
-	test "$trace" = t && test "$verbose" = t
+	test "$trace" = t && {
+		test "$verbose" = t || test "$verbose_log" = t
+	}
 }
 
 # This is a separate function because some tests use
-- 
2.15.1.659.g8bd2eae3ea

