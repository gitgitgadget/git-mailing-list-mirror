Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441491FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 17:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755031AbdBNR0G (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 12:26:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:55124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755012AbdBNR0E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 12:26:04 -0500
Received: (qmail 6309 invoked by uid 109); 14 Feb 2017 17:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 17:26:04 +0000
Received: (qmail 4477 invoked by uid 111); 14 Feb 2017 17:26:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 12:26:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 12:26:01 -0500
Date:   Tue, 14 Feb 2017 12:26:01 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] show-branch: drop head_len variable
Message-ID: <20170214172601.3bt64h35i65vz4sj@sigill.intra.peff.net>
References: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We copy the result of resolving HEAD into a buffer and keep
track of its length.  But we never actually use the length
for anything besides the copy. Let's stop passing it around.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/show-branch.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 974f3403a..e4c488b8c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -470,7 +470,7 @@ static void snarf_refs(int head, int remotes)
 	}
 }
 
-static int rev_is_head(char *head, int headlen, char *name,
+static int rev_is_head(char *head, char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
 	if ((!head[0]) ||
@@ -622,7 +622,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
 	char head[128];
 	const char *head_p;
-	int head_len;
 	struct object_id head_oid;
 	int merge_base = 0;
 	int independent = 0;
@@ -790,11 +789,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	head_p = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 				    head_oid.hash, NULL);
 	if (head_p) {
-		head_len = strlen(head_p);
+		size_t head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
 	}
 	else {
-		head_len = 0;
 		head[0] = 0;
 	}
 
@@ -805,7 +803,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			 * HEAD points at.
 			 */
 			if (rev_is_head(head,
-					head_len,
 					ref_name[i],
 					head_oid.hash, NULL))
 				has_head++;
@@ -866,7 +863,6 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		for (i = 0; i < num_rev; i++) {
 			int j;
 			int is_head = rev_is_head(head,
-						  head_len,
 						  ref_name[i],
 						  head_oid.hash,
 						  rev[i]->object.oid.hash);
-- 
2.12.0.rc1.479.g59880b11e

