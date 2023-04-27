Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A459C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbjD0IO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242966AbjD0IOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:14:25 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB68549E7
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:14:07 -0700 (PDT)
Received: (qmail 20674 invoked by uid 109); 27 Apr 2023 08:14:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:14:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17249 invoked by uid 111); 27 Apr 2023 08:14:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:14:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:14:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 1/4] t4212: avoid putting git on left-hand side of pipe
Message-ID: <20230427081406.GA1477912@coredump.intra.peff.net>
References: <20230427081330.GA1461786@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427081330.GA1461786@coredump.intra.peff.net>
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
2.40.1.663.g410c33770c.dirty

