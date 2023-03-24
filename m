Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E081C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCXWYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjCXWYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:24:32 -0400
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 15:24:15 PDT
Received: from mailproxy04.manitu.net (mailproxy04.manitu.net [217.11.48.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E0C65E
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:24:14 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a43:1600:85b4:ca9:f8ec:9ddf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy04.manitu.net (Postfix) with ESMTPSA id 3086E80861;
        Fri, 24 Mar 2023 23:17:22 +0100 (CET)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] t3070: make chain lint tester happy
Date:   Fri, 24 Mar 2023 23:17:11 +0100
Message-Id: <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
X-Mailer: git-send-email 2.40.0.355.gd681773fb6
In-Reply-To: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1f2e05f0b7 ("wildmatch: fix exponential behavior", 2023-03-20)
introduced a new test with a background process. Backgrounding
necessarily gives a result of 0, so that a seemingly broken && chain is
not really broken.

Adjust t3070 slightly so that our chain list test recognizes the
construct for what it is and does not raise a false positive.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t3070-wildmatch.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index b91a7cb712..4dd42df38c 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -432,10 +432,12 @@ match 0 1 0 1 'z' '[Z-y]'
 match 1 1 1 1 'Z' '[Z-y]'
 
 test_expect_success 'matching does not exhibit exponential behavior' '
-	test-tool wildmatch wildmatch \
-		aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
-		"*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
-	pid=$! &&
+	{
+		test-tool wildmatch wildmatch \
+			aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
+			"*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
+		pid=$!
+	} &&
 	sleep 2 &&
 	! kill $!
 '
-- 
2.40.0.355.gd681773fb6

