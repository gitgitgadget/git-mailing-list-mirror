Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965D820A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdLERDy (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:03:54 -0500
Received: from siwi.pair.com ([209.68.5.199]:46261 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753146AbdLERDM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:03:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 81AA9844E2;
        Tue,  5 Dec 2017 12:03:12 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 08B80844DE;
        Tue,  5 Dec 2017 12:03:11 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 04/14] fetch-pack: test support excluding large blobs
Date:   Tue,  5 Dec 2017 17:02:44 +0000
Message-Id: <20171205170254.65293-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205170254.65293-1-git@jeffhostetler.com>
References: <20171205170254.65293-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Created tests to verify fetch-pack and upload-pack support
for excluding large blobs using --filter=blobs:limit=<n>
parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5500-fetch-pack.sh | 27 +++++++++++++++++++++++++++
 upload-pack.c         | 13 +++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

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
diff --git a/upload-pack.c b/upload-pack.c
index e6d38b9..15b6605 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -139,10 +139,15 @@ static void create_pack_file(void)
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
 	if (filter_options.filter_spec) {
-		struct strbuf buf = STRBUF_INIT;
-		sq_quote_buf(&buf, filter_options.filter_spec);
-		argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
-		strbuf_release(&buf);
+		if (pack_objects.use_shell) {
+			struct strbuf buf = STRBUF_INIT;
+			sq_quote_buf(&buf, filter_options.filter_spec);
+			argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
+			strbuf_release(&buf);
+		} else {
+			argv_array_pushf(&pack_objects.args, "--filter=%s",
+					 filter_options.filter_spec);
+		}
 	}
 
 	pack_objects.in = -1;
-- 
2.9.3

