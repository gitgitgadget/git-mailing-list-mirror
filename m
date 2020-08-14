Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F7C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B4820791
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgHNQOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:14:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:59258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgHNQOy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 12:14:54 -0400
Received: (qmail 1037 invoked by uid 109); 14 Aug 2020 16:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 16:14:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26895 invoked by uid 111); 14 Aug 2020 16:14:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 12:14:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 12:14:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/6] checkout: fix leak of non-existent branch names
Message-ID: <20200814161453.GB595698@coredump.intra.peff.net>
References: <20200814161328.GA153929@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814161328.GA153929@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We unconditionally write a branch name into a newly allocated buffer in
new_branch_info->path, via setup_branch_path(). We then check to see if
the branch exists; if not, we set that field to NULL, leaking the
memory. We should take care to free() it when doing so.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2837195491..bba64108af 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1120,8 +1120,10 @@ static void setup_new_branch_info_and_source_tree(
 	if (!check_refname_format(new_branch_info->path, 0) &&
 	    !read_ref(new_branch_info->path, &branch_rev))
 		oidcpy(rev, &branch_rev);
-	else
+	else {
+		free((char *)new_branch_info->path);
 		new_branch_info->path = NULL; /* not an existing branch */
+	}
 
 	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
 	if (!new_branch_info->commit) {
-- 
2.28.0.596.g9c08d63829

