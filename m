Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD8C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D5B20665
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLVJcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:32:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:52244 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725899AbfLVJcR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:32:17 -0500
Received: (qmail 12666 invoked by uid 109); 22 Dec 2019 09:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Dec 2019 09:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26908 invoked by uid 111); 22 Dec 2019 09:37:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Dec 2019 04:37:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Dec 2019 04:32:16 -0500
From:   Jeff King <peff@peff.net>
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit-graph: free large diffs, too
Message-ID: <20191222093216.GB3460818@coredump.intra.peff.net>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191222093036.GA3449072@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a diff we compute for --changed-path has more than 512 entries, we
don't bother generating a bloom filter for it. But since we don't
iterate over diff_queued_diff, we also don't free the filepairs and
filespecs from the diff before clearing the queue. Let's make sure we do
so.

This drops the peak heap usage of "commit-graph write --changed-paths"
on linux.git from ~8GB to ~4GB.

Signed-off-by: Jeff King <peff@peff.net>
---
 bloom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bloom.c b/bloom.c
index 0c7505d3d6..d1d3796e11 100644
--- a/bloom.c
+++ b/bloom.c
@@ -226,6 +226,8 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
 
 		hashmap_free_entries(&pathmap, struct pathmap_hash_entry, entry);
 	} else {
+		for (i = 0; i < diff_queued_diff.nr; i++)
+			diff_free_filepair(diff_queued_diff.queue[i]);
 		filter->data = NULL;
 		filter->len = 0;
 	}
-- 
2.24.1.1152.gda0b849012

