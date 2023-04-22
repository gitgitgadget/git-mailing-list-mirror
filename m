Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D15EC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDVNmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDVNms (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 09:42:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160901BC3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 06:42:46 -0700 (PDT)
Received: (qmail 13282 invoked by uid 109); 22 Apr 2023 13:42:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 13:42:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28907 invoked by uid 111); 22 Apr 2023 13:42:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 09:42:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 09:42:45 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 1/3] t4212: avoid putting git on left-hand side of pipe
Message-ID: <20230422134245.GA3942326@coredump.intra.peff.net>
References: <20230422134150.GA3516940@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230422134150.GA3516940@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We wouldn't expect cat-file to fail here, but it's good practice to
avoid putting git on the upstream of a pipe, as we otherwise ignore its
exit code.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4212-log-corrupt.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index e89e1f54b6..8b5433ea74 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -8,8 +8,9 @@ TEST_PASSES_SANITIZE_LEAK=true
 test_expect_success 'setup' '
 	test_commit foo &&
 
-	git cat-file commit HEAD |
-	sed "/^author /s/>/>-<>/" >broken_email.commit &&
+	git cat-file commit HEAD >ok.commit &&
+	sed "/^author /s/>/>-<>/" <ok.commit >broken_email.commit &&
+
 	git hash-object --literally -w -t commit broken_email.commit >broken_email.hash &&
 	git update-ref refs/heads/broken_email $(cat broken_email.hash)
 '
-- 
2.40.0.653.g15ca972062

