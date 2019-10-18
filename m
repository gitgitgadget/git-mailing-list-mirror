Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3AA1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfJRFKN (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:10:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:51802 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727606AbfJRFKL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:10:11 -0400
Received: (qmail 9317 invoked by uid 109); 18 Oct 2019 04:43:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:43:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14040 invoked by uid 111); 18 Oct 2019 04:46:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:46:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:43:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/23] parse_commit_buffer(): treat lookup_tree() failure as
 parse error
Message-ID: <20191018044328.GB17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If parsing a commit yields a valid tree oid, but we've seen that same
oid as a non-tree in the same process, the resulting commit struct will
end up with a NULL tree pointer, but not otherwise report a parsing
failure.

That's perhaps convenient for callers which want to operate on even
partially corrupt commits (e.g., by still looking at the parents). But
it leaves a potential trap for most callers, who now have to manually
check for a NULL tree. Most do not, and it's likely that there are
possible segfaults lurking. I say "possible" because there are many
candidates, and I don't think it's worth following through on
reproducing them when we can just fix them all in one spot. And
certainly we _have_ seen real-world cases, such as the one fixed by
806278dead (commit-graph.c: handle corrupt/missing trees, 2019-09-05).

Note that we can't quite drop the check in the caller added by that
commit yet, as there's some subtlety with repeated parsings (which will
be addressed in a future commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 6467c9e175..810419a168 100644
--- a/commit.c
+++ b/commit.c
@@ -401,6 +401,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	struct commit_graft *graft;
 	const int tree_entry_len = the_hash_algo->hexsz + 5;
 	const int parent_entry_len = the_hash_algo->hexsz + 7;
+	struct tree *tree;
 
 	if (item->object.parsed)
 		return 0;
@@ -412,7 +413,12 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	set_commit_tree(item, lookup_tree(r, &parent));
+	tree = lookup_tree(r, &parent);
+	if (!tree)
+		return error("bad tree pointer %s in commit %s",
+			     oid_to_hex(&parent),
+			     oid_to_hex(&item->object.oid));
+	set_commit_tree(item, tree);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-- 
2.23.0.1228.gee29b05929

