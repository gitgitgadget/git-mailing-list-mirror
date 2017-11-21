Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6F12036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdKUVPw (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:15:52 -0500
Received: from siwi.pair.com ([209.68.5.199]:38448 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdKUVPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:15:45 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2BEC9844F1;
        Tue, 21 Nov 2017 16:15:45 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BFE2D844D5;
        Tue, 21 Nov 2017 16:15:44 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
Subject: [PATCH v5 07/14] fetch-pack: test support excluding large blobs
Date:   Tue, 21 Nov 2017 21:15:21 +0000
Message-Id: <20171121211528.21891-8-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121211528.21891-1-git@jeffhostetler.com>
References: <20171121211528.21891-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Created tests to verify fetch-pack and upload-pack support
for excluding large blobs using --filter=blob:limit=<n>
parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5500-fetch-pack.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 80a1a32..c57916b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -755,4 +755,31 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success 'filtering by size' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_config -C server uploadpack.allowfilter 1 &&
+
+	test_create_repo client &&
+	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
+
+	# Ensure that object is not inadvertently fetched
+	test_must_fail git -C client cat-file -e $(git hash-object server/one.t)
+'
+
+test_expect_success 'filtering by size has no effect if support for it is not advertised' '
+	rm -rf server client &&
+	test_create_repo server &&
+	test_commit -C server one &&
+
+	test_create_repo client &&
+	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD 2> err &&
+
+	# Ensure that object is fetched
+	git -C client cat-file -e $(git hash-object server/one.t) &&
+
+	test_i18ngrep "filtering not recognized by server" err
+'
+
 test_done
-- 
2.9.3

