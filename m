Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E5E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbjJCU0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjJCU0e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:26:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF31EA6
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:26:31 -0700 (PDT)
Received: (qmail 14853 invoked by uid 109); 3 Oct 2023 20:26:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:26:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14908 invoked by uid 111); 3 Oct 2023 20:26:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:26:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:26:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/10] commit-reach: free temporary list in
 get_octopus_merge_bases()
Message-ID: <20231003202630.GB7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We loop over the set of commits to merge, and for each one compute the
merge base against the existing set of merge base candidates we've
found. Then we replace the candidate set with a simple assignment of the
list head, leaking the old list. We should free it first before
assignment.

This makes t5521 leak-free, so mark it as such.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-reach.c          | 1 +
 t/t5521-pull-options.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 4b7c233fd4..a868a575ea 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -173,6 +173,7 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 			for (k = bases; k; k = k->next)
 				end = k;
 		}
+		free_commit_list(ret);
 		ret = new_commits;
 	}
 	return ret;
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 264de29c35..079b2f2536 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -5,6 +5,7 @@ test_description='pull options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.42.0.810.gbc538a0ee6

