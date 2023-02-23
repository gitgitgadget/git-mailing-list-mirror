Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873EFC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 11:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjBWLF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 06:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBWLF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 06:05:57 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC453EC7
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 03:05:56 -0800 (PST)
Received: (qmail 25065 invoked by uid 109); 23 Feb 2023 11:05:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Feb 2023 11:05:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20272 invoked by uid 111); 23 Feb 2023 11:05:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Feb 2023 06:05:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Feb 2023 06:05:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/16] t/lib-httpd: respect $HTTPD_PROTO in expect_askpass()
Message-ID: <Y/dIk5Zex6Sq2p8h@coredump.intra.peff.net>
References: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/dEYYWKy/o96vBG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the HTTP tests are run with LIB_HTTPD_SSL in the environment, then
we access the test server as https://. This causes expect_askpass to
complain, because it tries to blindly match "http://" in the prompt
shown to the user. We can adjust this to use $HTTPD_PROTO, which is set
during the setup phase.

Note that this is enough for t5551 and t5559 to pass when run with
https, but there are similar problems in other scripts that will need to
be fixed before the whole suite can run with LIB_HTTPD_SSL.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5d2d56c445..8f59e9dff8 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -283,11 +283,11 @@ expect_askpass() {
 		none)
 			;;
 		pass)
-			echo "askpass: Password for 'http://$2@$dest': "
+			echo "askpass: Password for '$HTTPD_PROTO://$2@$dest': "
 			;;
 		both)
-			echo "askpass: Username for 'http://$dest': "
-			echo "askpass: Password for 'http://$2@$dest': "
+			echo "askpass: Username for '$HTTPD_PROTO://$dest': "
+			echo "askpass: Password for '$HTTPD_PROTO://$2@$dest': "
 			;;
 		*)
 			false
-- 
2.39.2.981.g6157336f25

