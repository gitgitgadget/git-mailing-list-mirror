Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50111FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbdBNR1t (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 12:27:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:55134 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754878AbdBNR1s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 12:27:48 -0500
Received: (qmail 6465 invoked by uid 109); 14 Feb 2017 17:27:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 17:27:48 +0000
Received: (qmail 4518 invoked by uid 111); 14 Feb 2017 17:27:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 12:27:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 12:27:45 -0500
Date:   Tue, 14 Feb 2017 12:27:45 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] show-branch: store resolved head in heap buffer
Message-ID: <20170214172745.4tnnu6kv7xru54vy@sigill.intra.peff.net>
References: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We resolve HEAD and copy the result to a fixed-size buffer
with memcpy, never checking that it actually fits. This bug
dates back to 8098a178b (Add git-symbolic-ref, 2005-09-30).
Before that we used readlink(), which took a maximum buffer
size.

We can fix this by using resolve_refdup(), which duplicates
the buffer on the heap. That also lets us just check
for a NULL pointer to see if we have resolved HEAD, and
drop the extra head_p variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e4c488b8c..404c4d09a 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -473,8 +473,7 @@ static void snarf_refs(int head, int remotes)
 static int rev_is_head(char *head, char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
-	if ((!head[0]) ||
-	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
+	if (!head || (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
 	if (starts_with(head, "refs/heads/"))
 		head += 11;
@@ -620,8 +619,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int all_heads = 0, all_remotes = 0;
 	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
-	char head[128];
-	const char *head_p;
+	char *head;
 	struct object_id head_oid;
 	int merge_base = 0;
 	int independent = 0;
@@ -786,17 +784,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			snarf_refs(all_heads, all_remotes);
 	}
 
-	head_p = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-				    head_oid.hash, NULL);
-	if (head_p) {
-		size_t head_len = strlen(head_p);
-		memcpy(head, head_p, head_len + 1);
-	}
-	else {
-		head[0] = 0;
-	}
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING,
+			      head_oid.hash, NULL);
 
-	if (with_current_branch && head_p) {
+	if (with_current_branch && head) {
 		int has_head = 0;
 		for (i = 0; !has_head && i < ref_name_cnt; i++) {
 			/* We are only interested in adding the branch
-- 
2.12.0.rc1.479.g59880b11e

