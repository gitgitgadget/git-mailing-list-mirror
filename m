Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED3D20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdAWSBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:01:10 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:50624 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdAWSBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:01:09 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id 2B2AC55FC53; Mon, 23 Jan 2017 18:01:05 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v3 1/5] show-ref: Accept HEAD with --verify
Date:   Mon, 23 Jan 2017 18:00:55 +0000
Message-Id: <20170123180059.4288-2-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123180059.4288-1-git@thecybershadow.net>
References: <20170123180059.4288-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, when --verify was specified, show-ref would use a separate
code path which did not handle HEAD and treated it as an invalid
ref. Thus, "git show-ref --verify HEAD" (where "--verify" is used
because the user is not interested in seeing refs/remotes/origin/HEAD)
did not work as expected.

Instead of insisting that the input begins with "refs/", allow "HEAD"
as well in the codepath that handles "--verify", so that all valid
full refnames including HEAD are passed to the same output machinery.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c  |  2 +-
 t/t1403-show-ref.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6d4e66900..0e53e3da4 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -202,7 +202,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		while (*pattern) {
 			struct object_id oid;
 
-			if (starts_with(*pattern, "refs/") &&
+			if ((starts_with(*pattern, "refs/") || !strcmp(*pattern, "HEAD")) &&
 			    !read_ref(*pattern, oid.hash)) {
 				if (!quiet)
 					show_one(*pattern, &oid);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 7e10bcfe3..5932beada 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -164,4 +164,15 @@ test_expect_success 'show-ref --heads, --tags, --head, pattern' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show-ref --verify HEAD' '
+	echo $(git rev-parse HEAD) HEAD >expect &&
+	git show-ref --verify HEAD >actual &&
+	test_cmp expect actual &&
+
+	>expect &&
+
+	git show-ref --verify -q HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0

