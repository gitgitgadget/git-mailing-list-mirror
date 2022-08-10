Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFDC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiHJVCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiHJVCr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:02:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7029A7A525
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:02:46 -0700 (PDT)
Received: (qmail 6842 invoked by uid 109); 10 Aug 2022 21:02:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 21:02:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15543 invoked by uid 111); 10 Aug 2022 21:02:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 17:02:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 17:02:45 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/3] fsck: actually detect bad file modes in trees
Message-ID: <YvQc9egGzwFomQbw@coredump.intra.peff.net>
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the normal tree_desc code to iterate over trees in fsck, meaning
we only see the canonicalized modes it returns. And hence we'd never see
anything unexpected, since it will coerce literally any garbage into one
of our normal and accepted modes.

We can use the new RAW_MODES flag to see the real modes, and then use
the existing code to actually analyze them. The existing code is written
as allow-known-good, so there's not much point in testing a variety of
breakages. The one tested here should be S_IFREG but with nonsense
permissions.

Do note that the error-reporting here isn't great. We don't mention the
specific bad mode, but just that the tree has one or more broken modes.
But when you go to look at it with "git ls-tree", we'll report the
canonicalized mode! This isn't ideal, but given that this should come up
rarely, and that any number of other tree corruptions might force you
into looking at the binary bytes via "cat-file", it's not the end of the
world. And it's something we can improve on top later if we choose.

Reported-by: Xavier Morel <xavier.morel@masklinn.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c          |  2 +-
 t/t1450-fsck.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 5acc982a7c..b3da1d68c0 100644
--- a/fsck.c
+++ b/fsck.c
@@ -578,7 +578,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 	const char *o_name;
 	struct name_stack df_dup_candidates = { NULL };
 
-	if (init_tree_desc_gently(&desc, buffer, size, 0)) {
+	if (init_tree_desc_gently(&desc, buffer, size, TREE_DESC_RAW_MODES)) {
 		retval += report(options, tree_oid, OBJ_TREE,
 				 FSCK_MSG_BAD_TREE,
 				 "cannot be parsed as a tree");
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index ab7f31f1dc..53c2aa10b7 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -364,6 +364,20 @@ test_expect_success 'tree entry with type mismatch' '
 	test_i18ngrep ! "dangling blob" out
 '
 
+test_expect_success 'tree entry with bogus mode' '
+	test_when_finished "remove_object \$blob" &&
+	test_when_finished "remove_object \$tree" &&
+	blob=$(echo blob | git hash-object -w --stdin) &&
+	blob_oct=$(echo $blob | hex2oct) &&
+	tree=$(printf "100000 foo\0${blob_oct}" |
+	       git hash-object -t tree --stdin -w --literally) &&
+	git fsck 2>err &&
+	cat >expect <<-EOF &&
+	warning in tree $tree: badFilemode: contains bad file modes
+	EOF
+	test_cmp expect err
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	badoid=$(test_oid deadbeef) &&
 	cat >invalid-tag <<-EOF &&
-- 
2.37.1.917.gf0c714241f

