Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEB2208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751382AbdIENEN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751160AbdIENEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:12 -0400
Received: (qmail 2061 invoked by uid 109); 5 Sep 2017 13:04:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12757 invoked by uid 111); 5 Sep 2017 13:04:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:04:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:10 -0400
Date:   Tue, 5 Sep 2017 09:04:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/10] add: free leaked pathspec after add_files_to_cache()
Message-ID: <20170905130410.3sexuoc7a42yc2t7@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After run_diff_files, we throw away the rev_info struct,
including the pathspec that we copied into it, leaking the
memory. this is probably not a big deal in practice. We
usually only run this once per process, and the leak is
proportional to the pathspec list we're already holding in
memory.

But it's still a leak, and it pollutes leak-checker output,
making it harder to find important leaks.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/add.c b/builtin/add.c
index c20548e4f5..ef625e3fb8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -119,6 +119,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	clear_pathspec(&rev.prune_data);
 	return !!data.add_errors;
 }
 
-- 
2.14.1.721.gc5bc1565f1

