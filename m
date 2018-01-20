Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238501FAE2
	for <e@80x24.org>; Sat, 20 Jan 2018 07:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbeATHnw (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 02:43:52 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50282 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeATHnv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 02:43:51 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 36EA11F576;
        Sat, 20 Jan 2018 07:43:51 +0000 (UTC)
Date:   Sat, 20 Jan 2018 07:43:51 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fsck: fix leak when traversing trees
Message-ID: <20180120074351.GA12439@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While fsck_walk/fsck_walk_tree/parse_tree populates "struct tree"
idempotently, it is still up to the fsck_walk caller to call
free_tree_buffer.

Fixes: ad2db4030e42890e ("fsck: remove redundant parse_tree() invocation")

Signed-off-by: Eric Wong <e@80x24.org>
---
 These APIs could probably be made to be less error-prone,
 but at least this stops my little machine from OOM-ing.

 builtin/fsck.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04846d46f9..92ce775a74 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -171,7 +171,13 @@ static void mark_object_reachable(struct object *obj)
 
 static int traverse_one_object(struct object *obj)
 {
-	return fsck_walk(obj, obj, &fsck_walk_options);
+	int result = fsck_walk(obj, obj, &fsck_walk_options);
+
+	if (obj->type == OBJ_TREE) {
+		struct tree *tree = (struct tree *)obj;
+		free_tree_buffer(tree);
+	}
+	return result;
 }
 
 static int traverse_reachable(void)
-- 
EW
