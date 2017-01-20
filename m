Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A54D20756
	for <e@80x24.org>; Fri, 20 Jan 2017 16:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbdATQMt (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 11:12:49 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:37516 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbdATQMs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 11:12:48 -0500
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jan 2017 11:12:48 EST
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id B96C655B51A; Fri, 20 Jan 2017 16:04:04 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH] show-ref: Allow --head to work with --verify
Date:   Fri, 20 Jan 2017 15:50:15 +0000
Message-Id: <20170120155015.4360-1-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, when --verify was specified, --head was being ignored, and
"show-ref --verify --head HEAD" would always print "fatal: 'HEAD' -
not a valid ref". As such, when using show-ref to look up any
ref (including HEAD) precisely by name, one would have to special-case
looking up the HEAD ref.

This patch adds --head support to show-ref's --verify logic, by
explicitly checking if the "HEAD" ref is specified when --head is
present.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c  | 2 ++
 t/t1403-show-ref.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6d4e66900..ee5078604 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -207,6 +207,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 				if (!quiet)
 					show_one(*pattern, &oid);
 			}
+			else if (show_head && !strcmp(*pattern, "HEAD"))
+				head_ref(show_ref, NULL);
 			else if (!quiet)
 				die("'%s' - not a valid ref", *pattern);
 			else
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 7e10bcfe3..de64ebfb7 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -164,4 +164,12 @@ test_expect_success 'show-ref --heads, --tags, --head, pattern' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show-ref --verify --head' '
+	{
+		echo $(git rev-parse HEAD) HEAD
+	} >expect &&
+	git show-ref --verify --head HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0

