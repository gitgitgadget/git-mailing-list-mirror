Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978C0C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7359F20733
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLVJcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:32:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:52260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725899AbfLVJcX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:32:23 -0500
Received: (qmail 12691 invoked by uid 109); 22 Dec 2019 09:32:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Dec 2019 09:32:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26931 invoked by uid 111); 22 Dec 2019 09:37:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Dec 2019 04:37:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Dec 2019 04:32:22 -0500
From:   Jeff King <peff@peff.net>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] commit-graph: stop using full rev_info for diffs
Message-ID: <20191222093222.GC3460818@coredump.intra.peff.net>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191222093036.GA3449072@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we perform a diff to get the set of changed paths for a commit,
we initialize a full "struct rev_info" with setup_revisions(). But the
only part of it we use is the diff_options struct. Besides being overly
complex, this also leaks memory, as we use the fake argv to
setup_revisions() create a pending array which is never cleared.

Let's just use diff_options directly. This reduces the peak heap usage
of "git commit-graph write --changed-paths" on linux.git from ~4GB to
~1.2GB.

Signed-off-by: Jeff King <peff@peff.net>
---
 bloom.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/bloom.c b/bloom.c
index d1d3796e11..ea77631cc2 100644
--- a/bloom.c
+++ b/bloom.c
@@ -154,8 +154,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	struct bloom_filter *filter;
 	struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 	int i;
-	struct rev_info revs;
-	const char *revs_argv[] = {NULL, "HEAD", NULL};
+	struct diff_options diffopt;
 
 	filter = bloom_filter_slab_at(&bloom_filters, c);
 
@@ -170,16 +169,15 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 	if (filter->data || !compute_if_null)
 			return filter;
 
-	init_revisions(&revs, NULL);
-	revs.diffopt.flags.recursive = 1;
-
-	setup_revisions(2, revs_argv, &revs, NULL);
+	repo_diff_setup(r, &diffopt);
+	diffopt.flags.recursive = 1;
+	diff_setup_done(&diffopt);
 
 	if (c->parents)
-		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &revs.diffopt);
+		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
 	else
-		diff_tree_oid(NULL, &c->object.oid, "", &revs.diffopt);
-	diffcore_std(&revs.diffopt);
+		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
+	diffcore_std(&diffopt);
 
 	if (diff_queued_diff.nr <= 512) {
 		struct hashmap pathmap;
-- 
2.24.1.1152.gda0b849012
