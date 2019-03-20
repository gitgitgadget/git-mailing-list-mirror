Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E240120248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCTINi (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:13:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:57398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727528AbfCTINi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:13:38 -0400
Received: (qmail 19581 invoked by uid 109); 20 Mar 2019 08:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:13:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6251 invoked by uid 111); 20 Mar 2019 08:14:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:14:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:13:36 -0400
Date:   Wed, 20 Mar 2019 04:13:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/13] revision: drop some unused "revs" parameters
Message-ID: <20190320081336.GA10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several internal helpers that take a rev_info struct but don't
actually look at it. While one could argue that all helpers in
revision.c should take a rev_info struct for consistency, dropping the
unused parameter makes it clear that they don't actually depend on any
other rev options.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index eb8e51bc63..695021d6fc 100644
--- a/revision.c
+++ b/revision.c
@@ -1894,7 +1894,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	return 0;
 }
 
-static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
+static void read_pathspec_from_stdin(struct strbuf *sb,
 				     struct argv_array *prune)
 {
 	while (strbuf_getline(sb, stdin) != EOF)
@@ -1928,7 +1928,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
-		read_pathspec_from_stdin(revs, &sb, prune);
+		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -2748,7 +2748,7 @@ static struct merge_simplify_state *locate_simplify_state(struct rev_info *revs,
 	return st;
 }
 
-static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
+static int mark_redundant_parents(struct commit *commit)
 {
 	struct commit_list *h = reduce_heads(commit->parents);
 	int i = 0, marked = 0;
@@ -2784,7 +2784,7 @@ static int mark_redundant_parents(struct rev_info *revs, struct commit *commit)
 	return marked;
 }
 
-static int mark_treesame_root_parents(struct rev_info *revs, struct commit *commit)
+static int mark_treesame_root_parents(struct commit *commit)
 {
 	struct commit_list *p;
 	int marked = 0;
@@ -2976,8 +2976,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
 	 * Detect and simplify both cases.
 	 */
 	if (1 < cnt) {
-		int marked = mark_redundant_parents(revs, commit);
-		marked += mark_treesame_root_parents(revs, commit);
+		int marked = mark_redundant_parents(commit);
+		marked += mark_treesame_root_parents(commit);
 		if (marked)
 			marked -= leave_one_treesame_to_parent(revs, commit);
 		if (marked)
-- 
2.21.0.701.g4401309e11

