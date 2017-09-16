Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817CB20281
	for <e@80x24.org>; Sat, 16 Sep 2017 06:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbdIPGCQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 02:02:16 -0400
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:57859
        "EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbdIPGCP (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 Sep 2017 02:02:15 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Sep 2017 02:02:15 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id t63YdElFpa1gVt63cdDG0j; Fri, 15 Sep 2017 22:54:26 -0700
From:   Max Kirillov <max@max630.net>
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [PATCH] describe: fix matching to actually match all patterns
Date:   Sat, 16 Sep 2017 08:53:44 +0300
Message-Id: <20170916055344.31866-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
X-CMAE-Envelope: MS4wfItPVt4WMNSid4lZeU7HuLwHcl7q40RWckVtDt8nzd/A08CUPppEM6xouMIixTiiH5aYLB8v1Y0oZ35rKEhzBywXr9zjVTQ8JnZgrVFYG+VtfrqCJkd8
 tenECrjwAYZmT+iqLK27JcKxoydGNPAtQ1qKynGK+SeO/zLr8h9ALZ6tHzkMPW8HqkeF+5Fh+UFanG8K5yBXPlqn/q/zIzqnzj1ZpKIlOGTT4SnrH0mKUQPc
 zEwmS0NllSw/i3I9IxnIEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git describe --match` with multiple patterns matches only first pattern.
If it fails, next patterns are not tried.

Fix it, add test cases and update existing test which has wrong
expectation.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/describe.c  | 9 ++++++---
 t/t6120-describe.sh | 6 +++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 89ea1cdd60..94ff2fba0b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -155,18 +155,21 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	 * pattern.
 	 */
 	if (patterns.nr) {
+		int found = 0;
 		struct string_list_item *item;
 
 		if (!is_tag)
 			return 0;
 
 		for_each_string_list_item(item, &patterns) {
-			if (!wildmatch(item->string, path + 10, 0))
+			if (!wildmatch(item->string, path + 10, 0)) {
+				found = 1;
 				break;
+			}
+		}
 
-			/* If we get here, no pattern matched. */
+		if (!found)
 			return 0;
-		}
 	}
 
 	/* Is it annotated? */
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index aa74eb8f0d..25110ea55d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -182,10 +182,14 @@ check_describe "test2-lightweight-*" --tags --match="test2-*"
 
 check_describe "test2-lightweight-*" --long --tags --match="test2-*" HEAD^
 
-check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="test2-*" HEAD^
+check_describe "test2-lightweight-*" --long --tags --match="test1-*" --match="test2-*" HEAD^
 
 check_describe "test2-lightweight-*" --long --tags --match="test1-*" --no-match --match="test2-*" HEAD^
 
+check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="test3-*" HEAD
+
+check_describe "test1-lightweight-*" --long --tags --match="test3-*" --match="test1-*" HEAD
+
 test_expect_success 'name-rev with exact tags' '
 	echo A >expect &&
 	tag_object=$(git rev-parse refs/tags/A) &&
-- 
2.11.0.1122.gc3fec58.dirty

