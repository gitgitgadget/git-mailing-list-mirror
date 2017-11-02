Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DB920281
	for <e@80x24.org>; Thu,  2 Nov 2017 20:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964868AbdKBUVP (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:21:15 -0400
Received: from siwi.pair.com ([209.68.5.199]:64899 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964856AbdKBUVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:21:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3D1D5845A8;
        Thu,  2 Nov 2017 16:21:11 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A7914845A7;
        Thu,  2 Nov 2017 16:21:10 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 3/9] fsck: support refs pointing to promisor objects
Date:   Thu,  2 Nov 2017 20:20:46 +0000
Message-Id: <20171102202052.58762-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102202052.58762-1-git@jeffhostetler.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

Teach fsck to not treat refs referring to missing promisor objects as an
error when extensions.partialclone is set.

For the purposes of warning about no default refs, such refs are still
treated as legitimate refs.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fsck.c           |  8 ++++++++
 t/t0410-partial-clone.sh | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2934299..ee937bb 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -434,6 +434,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 
 	obj = parse_object(oid);
 	if (!obj) {
+		if (is_promisor_object(oid)) {
+			/*
+			 * Increment default_refs anyway, because this is a
+			 * valid ref.
+			 */
+			 default_refs++;
+			 return 0;
+		}
 		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 52347fb..5a03ead 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -13,6 +13,14 @@ pack_as_from_promisor () {
 	>repo/.git/objects/pack/pack-$HASH.promisor
 }
 
+promise_and_delete () {
+	HASH=$(git -C repo rev-parse "$1") &&
+	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
+	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
+	git -C repo tag -d my_annotated_tag &&
+	delete_object repo "$HASH"
+}
+
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
 	test_create_repo repo &&
 	test_commit -C repo my_commit &&
@@ -78,4 +86,20 @@ test_expect_success 'missing reflog object alone fails fsck, even with extension
 	test_must_fail git -C repo fsck
 '
 
+test_expect_success 'missing ref object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+
+	# Reference $A only from ref
+	git -C repo branch my_branch "$A" &&
+	promise_and_delete "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialcloneremote "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.9.3

