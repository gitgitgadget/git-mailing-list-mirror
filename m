Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8731CE8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbjJCUbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjJCUbP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:31:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A1AD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:31:12 -0700 (PDT)
Received: (qmail 14891 invoked by uid 109); 3 Oct 2023 20:31:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:31:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14971 invoked by uid 111); 3 Oct 2023 20:31:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:31:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/10] commit-graph: free write-context base_graph_name
 during cleanup
Message-ID: <20231003203111.GI7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6c622f9f0b (commit-graph: write commit-graph chains, 2019-06-18)
added a base_graph_name string to the write_commit_graph_context struct.
But the end-of-function cleanup forgot to free it, causing a leak.

This (presumably in combination with the preceding leak-fixes) lets us
mark t5328 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c                     | 1 +
 t/t5328-commit-graph-64bit-time.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 744b7eb1a3..e4d09da090 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2518,6 +2518,7 @@ int write_commit_graph(struct object_directory *odb,
 
 cleanup:
 	free(ctx->graph_name);
+	free(ctx->base_graph_name);
 	free(ctx->commits.list);
 	oid_array_clear(&ctx->oids);
 	clear_topo_level_slab(&topo_levels);
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index e9c521c061..ca476e80a0 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='commit graph with 64-bit timestamps'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
-- 
2.42.0.810.gbc538a0ee6

