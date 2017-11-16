Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F786202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 18:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966628AbdKPSSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 13:18:00 -0500
Received: from siwi.pair.com ([209.68.5.199]:46715 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966660AbdKPSRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 13:17:41 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 630B18453C;
        Thu, 16 Nov 2017 13:17:41 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E48B984557;
        Thu, 16 Nov 2017 13:17:40 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 11/15] t5500: add fetch-pack tests for partial clone
Date:   Thu, 16 Nov 2017 18:17:19 +0000
Message-Id: <20171116181723.62033-12-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5500-fetch-pack.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index c57916b..23702b5 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -782,4 +782,40 @@ test_expect_success 'filtering by size has no effect if support for it is not ad
 	test_i18ngrep "filtering not recognized by server" err
 '
 
+fetch_blob_max_bytes () {
+		      SERVER="$1"
+		      URL="$2"
+
+	rm -rf "$SERVER" client &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" one &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+
+	git clone "$URL" client &&
+	test_config -C client extensions.partialclone origin &&
+
+	test_commit -C "$SERVER" two &&
+
+	git -C client fetch --filter=blob:limit=0 origin HEAD:somewhere &&
+
+	# Ensure that commit is fetched, but blob is not
+	test_config -C client extensions.partialclone "arbitrary string" &&
+	git -C client cat-file -e $(git -C "$SERVER" rev-parse two) &&
+	test_must_fail git -C client cat-file -e $(git hash-object "$SERVER/two.t")
+}
+
+test_expect_success 'fetch with filtering' '
+		     fetch_blob_max_bytes server server
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetch with filtering and HTTP' '
+		     fetch_blob_max_bytes "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
+'
+
+stop_httpd
+
+
 test_done
-- 
2.9.3

