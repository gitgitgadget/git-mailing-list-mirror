Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE9720A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdAWSBJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:01:09 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:50622 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdAWSBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:01:07 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id 3B26B55FC57; Mon, 23 Jan 2017 18:01:05 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v3 3/5] show-ref: Move --quiet handling into show_one
Date:   Mon, 23 Jan 2017 18:00:57 +0000
Message-Id: <20170123180059.4288-4-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123180059.4288-1-git@thecybershadow.net>
References: <20170123180059.4288-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do the same with --quiet as was done with -d, to remove the need to
perform this check at show_one's call site from the --verify branch.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index a72a626b1..ab8e0dc41 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -22,6 +22,9 @@ static void show_one(const char *refname, const struct object_id *oid)
 	const char *hex;
 	struct object_id peeled;
 
+	if (quiet)
+		return;
+
 	hex = find_unique_abbrev(oid->hash, abbrev);
 	if (hash_only)
 		printf("%s\n", hex);
@@ -82,9 +85,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
 
-	if (quiet)
-		return 0;
-
 	show_one(refname, oid);
 
 	return 0;
@@ -205,8 +205,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 
 			if ((starts_with(*pattern, "refs/") || !strcmp(*pattern, "HEAD")) &&
 			    !read_ref(*pattern, oid.hash)) {
-				if (!quiet)
-					show_one(*pattern, &oid);
+				show_one(*pattern, &oid);
 			}
 			else if (!quiet)
 				die("'%s' - not a valid ref", *pattern);
-- 
2.11.0

