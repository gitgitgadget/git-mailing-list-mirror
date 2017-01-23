Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEDC20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbdAWSBI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:01:08 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:50620 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdAWSBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:01:07 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id 3264255FC55; Mon, 23 Jan 2017 18:01:05 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v3 2/5] show-ref: Allow -d to work with --verify
Date:   Mon, 23 Jan 2017 18:00:56 +0000
Message-Id: <20170123180059.4288-3-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123180059.4288-1-git@thecybershadow.net>
References: <20170123180059.4288-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move handling of -d into show_one, so that it takes effect when
--verify is present as well as when it is absent. This is useful when
the user wishes to avoid the costly iteration of refs.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c  | 23 ++++++++++++-----------
 t/t1403-show-ref.sh |  9 +++++++++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 0e53e3da4..a72a626b1 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -19,19 +19,27 @@ static const char *exclude_existing_arg;
 
 static void show_one(const char *refname, const struct object_id *oid)
 {
-	const char *hex = find_unique_abbrev(oid->hash, abbrev);
+	const char *hex;
+	struct object_id peeled;
+
+	hex = find_unique_abbrev(oid->hash, abbrev);
 	if (hash_only)
 		printf("%s\n", hex);
 	else
 		printf("%s %s\n", hex, refname);
+
+	if (!deref_tags)
+		return;
+
+	if (!peel_ref(refname, peeled.hash)) {
+		hex = find_unique_abbrev(peeled.hash, abbrev);
+		printf("%s %s^{}\n", hex, refname);
+	}
 }
 
 static int show_ref(const char *refname, const struct object_id *oid,
 		    int flag, void *cbdata)
 {
-	const char *hex;
-	struct object_id peeled;
-
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
 
@@ -79,13 +87,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
 
 	show_one(refname, oid);
 
-	if (!deref_tags)
-		return 0;
-
-	if (!peel_ref(refname, peeled.hash)) {
-		hex = find_unique_abbrev(peeled.hash, abbrev);
-		printf("%s %s^{}\n", hex, refname);
-	}
 	return 0;
 }
 
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 5932beada..c6872bd96 100755
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

