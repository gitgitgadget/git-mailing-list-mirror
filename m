Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F8520281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964864AbdKBUVO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:42497 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964857AbdKBUVM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4A7ED844EC;
        Thu,  2 Nov 2017 16:21:12 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6497D845A7;
        Thu,  2 Nov 2017 16:21:11 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 4/9] fsck: support referenced promisor objects
Date:   Thu,  2 Nov 2017 20:20:47 +0000
Message-Id: <20171102202052.58762-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102202052.58762-1-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fsck to not treat missing promisor objects indirectly pointed to
by refs as an error when extensions.partialcloneremote is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsck.c           | 11 +++++++++++
 t/t0410-partial-clone.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ee937bb..4c2a56d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -149,6 +149,15 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (obj->flags & REACHABLE)
 		return 0;
 	obj->flags |= REACHABLE;
+
+	if (is_promisor_object(&obj->oid))
+		/*
+		 * Further recursion does not need to be performed on this
+		 * object since it is a promisor object (so it does not need to
+		 * be added to "pending").
+		 */
+		return 0;
+
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
@@ -208,6 +217,8 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!(obj->flags & HAS_OBJ)) {
+		if (is_promisor_object(&obj->oid))
+			return;
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", printable_type(obj),
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5a03ead..b1d404e 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -102,4 +102,27 @@ test_expect_success 'missing ref object, but promised, passes fsck' '
 	git -C repo fsck
 '
 
+test_expect_success 'missing object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+	test_commit -C repo 3 &&
+	git -C repo tag -a annotated_tag -m "annotated tag" &&
+
+	C=$(git -C repo rev-parse 1) &&
+	T=$(git -C repo rev-parse 2^{tree}) &&
+	B=$(git hash-object repo/3.t) &&
+	AT=$(git -C repo rev-parse annotated_tag) &&
+
+	promise_and_delete "$C" &&
+	promise_and_delete "$T" &&
+	promise_and_delete "$B" &&
+	promise_and_delete "$AT" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.9.3

