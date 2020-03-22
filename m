Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62647C43333
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBFD20753
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 06:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgCVGEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:04:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:46808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725881AbgCVGEg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 02:04:36 -0400
Received: (qmail 23736 invoked by uid 109); 22 Mar 2020 06:04:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 06:04:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29819 invoked by uid 111); 22 Mar 2020 06:14:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 02:14:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 02:04:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference
 when merging
Message-ID: <20200322060434.GC578498@coredump.intra.peff.net>
References: <cover.1584762087.git.me@ttaylorr.com>
 <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
 <20200321050025.GA1438317@coredump.intra.peff.net>
 <20200321061141.GA30636@syl.local>
 <20200321070333.GB1441446@coredump.intra.peff.net>
 <xmqqfte1a6ew.fsf@gitster.c.googlers.com>
 <a0de34e3-3f60-1838-dbaf-2ee3dddc7c89@gmail.com>
 <20200322002005.GA48038@syl.local>
 <1cb561fc-5bce-28f0-e5e1-886f590fba92@gmail.com>
 <20200322054916.GB578498@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322054916.GB578498@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 01:49:16AM -0400, Jeff King wrote:

> [1] I'm actually not quite sure about correctness here. It should be
>     fine to generate a graph file without any given commit; readers will
>     just have to load that commit the old-fashioned way. But at this
>     phase of "commit-graph write", I think we'll already have done the
>     close_reachable() check. What does it mean to throw away a commit at
>     this stage? If we're the parent of another commit, then it will have
>     trouble referring to us by a uint32_t. Will the actual writing phase
>     barf, or will we generate an invalid graph file?

It doesn't seem great. If I instrument Git like this to simulate an
object temporarily "missing" (if it were really missing the whole repo
would be corrupt; we're trying to see what would happen if a race causes
us to momentarily not see it):

diff --git a/commit-graph.c b/commit-graph.c
index 3da52847e4..71419c2532 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1596,6 +1596,19 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	}
 }
 
+static int pretend_commit_is_missing(const struct object_id *oid)
+{
+	static int initialized;
+	static struct object_id missing;
+	if (!initialized) {
+		const char *x = getenv("PRETEND_COMMIT_IS_MISSING");
+		if (x)
+			get_oid_hex(x, &missing);
+		initialized = 1;
+	}
+	return oideq(&missing, oid);
+}
+
 static void merge_commit_graph(struct write_commit_graph_context *ctx,
 			       struct commit_graph *g)
 {
@@ -1612,6 +1625,11 @@ static void merge_commit_graph(struct write_commit_graph_context *ctx,
 
 		load_oid_from_graph(g, i + offset, &oid);
 
+		if (pretend_commit_is_missing(&oid)) {
+			warning("pretending %s is missing", oid_to_hex(&oid));
+			continue;
+		}
+
 		/* only add commits if they still exist in the repo */
 		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
 

and then I make a fully-graphed repo like this:

  git init repo
  cd repo
  for i in $(seq 10); do
    git commit --allow-empty -m $i
  done
  git commit-graph write --input=reachable --split=no-merge

if we pretend a parent is missing, I get a BUG():

  $ git rev-parse HEAD |
    PRETEND_COMMIT_IS_MISSING=$(git rev-parse HEAD^) \
    git commit-graph write --stdin-commits --split=merge-all
  warning: pretending 35e6e15c738cf2bfbe495957b2a941c2efe86dd9 is missing
  BUG: commit-graph.c:879: missing parent 35e6e15c738cf2bfbe495957b2a941c2efe86dd9 for commit d4141fb57a9bbe26b247f23c790d63d078977833
  Aborted

So it seems like just skipping here (either with the new patch or
without) isn't really a good strategy.

-Peff
