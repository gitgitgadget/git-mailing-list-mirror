Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C115CE8FDB4
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbjJCUbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjJCUbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:31:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B5B4
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:31:32 -0700 (PDT)
Received: (qmail 14904 invoked by uid 109); 3 Oct 2023 20:31:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:31:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14982 invoked by uid 111); 3 Oct 2023 20:31:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:31:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:31:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/10] commit-graph: clear oidset after finishing write
Message-ID: <20231003203130.GJ7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In graph_write() we store commits in an oidset, but never clean it up,
leaking the contents. We should clear it in the cleanup section.

The oidset comes from 6830c36077 (commit-graph.h: replace 'commit_hex'
with 'commits', 2020-04-13), but it was just replacing a string_list
that was also leaked. Curiously, we fixed the leak of some adjacent
variables in commit fa8953cb40 (builtin/commit-graph.c: extract
'read_one_commit()', 2020-05-18), but the oidset wasn't included for
some reason.

In combination with the preceding commits, this lets us mark t5324 as
leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit-graph.c        | 1 +
 t/t5324-split-commit-graph.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c88389df24..c527a8369e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -311,6 +311,7 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 	FREE_AND_NULL(options);
 	string_list_clear(&pack_indexes, 0);
 	strbuf_release(&buf);
+	oidset_clear(&commits);
 	return result;
 }
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 36c4141e67..52e8a3e619 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='split commit graph'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
-- 
2.42.0.810.gbc538a0ee6
