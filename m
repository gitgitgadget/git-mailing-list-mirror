Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA12720ABE
	for <e@80x24.org>; Sat, 21 Jan 2017 01:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbdAUBIi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 20:08:38 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:54124 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbdAUBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 20:08:36 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id D8A3255BDF0; Sat, 21 Jan 2017 01:08:32 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v2 2/4] show-ref: Allow -d to work with --verify
Date:   Sat, 21 Jan 2017 01:08:19 +0000
Message-Id: <20170121010821.25046-3-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121010821.25046-1-git@thecybershadow.net>
References: <20170121010821.25046-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the same output machinery when --verify is absent or present,
which allows tag dereferencing (-d) to work with --verify. This is
useful when the user wishes to avoid the costly iteration of refs.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c  | 3 +--
 t/t1403-show-ref.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 945a483e3..bcdc1a95e 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -205,8 +205,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			if ((starts_with(*pattern, "refs/") ||
 			     (show_head && !strcmp(*pattern, "HEAD"))) &&
 			    !read_ref(*pattern, oid.hash)) {
-				if (!quiet)
-					show_one(*pattern, &oid);
+				show_ref(*pattern, &oid, 0, NULL);
 			}
 			else if (!quiet)
 				die("'%s' - not a valid ref", *pattern);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 2fb5dc879..5c540e67f 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -97,6 +97,9 @@ test_expect_success 'show-ref -d' '
 	git show-ref -d refs/tags/A refs/tags/C >actual &&
 	test_cmp expect actual &&
 
+	git show-ref --verify -d refs/tags/A refs/tags/C >actual &&
+	test_cmp expect actual &&
+
 	echo $(git rev-parse refs/heads/master) refs/heads/master >expect &&
 	git show-ref -d master >actual &&
 	test_cmp expect actual &&
@@ -116,6 +119,12 @@ test_expect_success 'show-ref -d' '
 	test_cmp expect actual &&
 
 	test_must_fail git show-ref -d --verify heads/master >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -d A C >actual &&
+	test_cmp expect actual &&
+
+	test_must_fail git show-ref --verify -d tags/A tags/C >actual &&
 	test_cmp expect actual
 
 '
-- 
2.11.0

