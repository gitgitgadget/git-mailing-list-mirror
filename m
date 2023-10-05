Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7D6E92FC0
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJEVaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJEVaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:30:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBE795
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:30:15 -0700 (PDT)
Received: (qmail 27261 invoked by uid 109); 5 Oct 2023 21:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 21:30:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29452 invoked by uid 111); 5 Oct 2023 21:30:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 17:30:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 17:30:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] revision: clear decoration structs during
 release_revisions()
Message-ID: <20231005213014.GB986467@coredump.intra.peff.net>
References: <20231005212802.GA982892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005212802.GA982892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The point of release_revisions() is to free memory associated with the
rev_info struct, but we have several "struct decoration" members that
are left untouched. Since the previous commit introduced a function to
do that, we can just call it.

We do have to provide some specialized callbacks to map the void
pointers onto real ones (the alternative would be casting the existing
function pointers; this generally works because "void *" is usually
interchangeable with a struct pointer, but it is technically forbidden
by the standard).

Since the line-log code does not expose the type it stores in the
decoration (nor of course the function to free it), I put this behind a
generic line_log_free() entry point. It's possible we may need to add
more line-log specific bits anyway (running t4211 shows a number of
other leaks in the line-log code).

While this doubtless cleans up many leaks triggered by the test suite,
the only script which becomes leak-free is t4217, as it does very little
beyond a simple traversal (its existing leak was from the use of
--children, which is now fixed).

Signed-off-by: Jeff King <peff@peff.net>
---
 line-log.c           | 10 ++++++++++
 line-log.h           |  2 ++
 revision.c           |  9 +++++++++
 t/t4217-log-limit.sh |  1 +
 4 files changed, 22 insertions(+)

diff --git a/line-log.c b/line-log.c
index 790ab73212..24a1ecb677 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1327,3 +1327,13 @@ int line_log_filter(struct rev_info *rev)
 
 	return 0;
 }
+
+static void free_void_line_log_data(void *data)
+{
+	free_line_log_data(data);
+}
+
+void line_log_free(struct rev_info *rev)
+{
+	clear_decoration(&rev->line_log_data, free_void_line_log_data);
+}
diff --git a/line-log.h b/line-log.h
index adff361b1b..4291da8d79 100644
--- a/line-log.h
+++ b/line-log.h
@@ -60,4 +60,6 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev,
 
 int line_log_print(struct rev_info *rev, struct commit *commit);
 
+void line_log_free(struct rev_info *rev);
+
 #endif /* LINE_LOG_H */
diff --git a/revision.c b/revision.c
index e789834dd1..219dc76716 100644
--- a/revision.c
+++ b/revision.c
@@ -3083,6 +3083,11 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
 static void release_revisions_topo_walk_info(struct topo_walk_info *info);
 
+static void free_void_commit_list(void *list)
+{
+	free_commit_list(list);
+}
+
 void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
@@ -3100,6 +3105,10 @@ void release_revisions(struct rev_info *revs)
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 	release_revisions_topo_walk_info(revs->topo_walk_info);
+	clear_decoration(&revs->children, free_void_commit_list);
+	clear_decoration(&revs->merge_simplification, free);
+	clear_decoration(&revs->treesame, free);
+	line_log_free(revs);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
index 6e01e2629c..613f0710e9 100755
--- a/t/t4217-log-limit.sh
+++ b/t/t4217-log-limit.sh
@@ -2,6 +2,7 @@
 
 test_description='git log with filter options limiting the output'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup test' '
-- 
2.42.0.836.g4b88bf80c5

