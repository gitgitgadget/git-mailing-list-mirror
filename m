Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BB920ABE
	for <e@80x24.org>; Sat, 21 Jan 2017 01:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbdAUBIj (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 20:08:39 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:54130 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdAUBIh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 20:08:37 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id DEFCF55BDF2; Sat, 21 Jan 2017 01:08:32 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v2 3/4] show-ref: Optimize show_ref a bit
Date:   Sat, 21 Jan 2017 01:08:20 +0000
Message-Id: <20170121010821.25046-4-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170121010821.25046-1-git@thecybershadow.net>
References: <20170121010821.25046-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The inner `if (verify)' check was not being used before the preceding
commit, as show_ref was never being called from a code path where
verify was non-zero.

Adding a `!verify' check to the outer if skips an unnecessary string
comparison when verify is non-zero, and show_ref is already called
with a reference exactly matching pattern.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index bcdc1a95e..3cf344d47 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -43,7 +43,7 @@ static int show_ref(const char *refname, const struct object_id *oid,
 		if (!match)
 			return 0;
 	}
-	if (pattern) {
+	if (pattern && !verify) {
 		int reflen = strlen(refname);
 		const char **p = pattern, *m;
 		while ((m = *p++) != NULL) {
@@ -54,9 +54,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
 				continue;
 			if (len == reflen)
 				goto match;
-			/* "--verify" requires an exact match */
-			if (verify)
-				continue;
 			if (refname[reflen - len - 1] == '/')
 				goto match;
 		}
-- 
2.11.0

