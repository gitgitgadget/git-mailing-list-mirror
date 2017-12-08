Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCAF20C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbdLHP1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:27:38 -0500
Received: from siwi.pair.com ([209.68.5.199]:50007 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753792AbdLHP1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:27:36 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6099D844E8;
        Fri,  8 Dec 2017 10:27:35 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EA588844B8;
        Fri,  8 Dec 2017 10:27:34 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
Subject: [PATCH v7 03/10] fsck: support refs pointing to promisor objects
Date:   Fri,  8 Dec 2017 15:27:09 +0000
Message-Id: <20171208152716.64232-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171208152716.64232-1-git@jeffhostetler.com>
References: <20171208152716.64232-1-git@jeffhostetler.com>
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
index 3ddb3b9..bf75162 100755
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
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck
+'
+
 test_done
-- 
2.9.3

