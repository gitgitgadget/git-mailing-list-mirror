Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ECCB20281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964871AbdKBUVQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:26465 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964858AbdKBUVO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C51AB845A8;
        Thu,  2 Nov 2017 16:21:13 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6D7A9845A5;
        Thu,  2 Nov 2017 16:21:12 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 5/9] fsck: support promisor objects as CLI argument
Date:   Thu,  2 Nov 2017 20:20:48 +0000
Message-Id: <20171102202052.58762-6-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102202052.58762-1-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fsck to not treat missing promisor objects provided on the CLI as
an error when extensions.partialcloneremote is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsck.c           |  2 ++
 t/t0410-partial-clone.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4c2a56d..578a7c8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -750,6 +750,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
+				if (is_promisor_object(&oid))
+					continue;
 				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index b1d404e..002e071 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -125,4 +125,17 @@ test_expect_success 'missing object, but promised, passes fsck' '
 	git -C repo fsck
 '
 
+test_expect_success 'missing CLI object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	promise_and_delete "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo fsck "$A"
+'
+
 test_done
-- 
2.9.3

