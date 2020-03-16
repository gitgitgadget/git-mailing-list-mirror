Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6767C3F2CE
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D88920719
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cobhT2zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbgCPSF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:05:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732211AbgCPSF4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Mar 2020 14:05:56 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 68C16609D3;
        Mon, 16 Mar 2020 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584381955;
        bh=bB6INAiBBqi/3jA3jv1ISIuniJPMPy98jX7zs3ypJkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cobhT2zRi6cNz9oO5LSRRmxA4NOC/39hQr2AfePHlcAFLVMfxyq/4CBhhbUiJsRze
         tChFP58aN4j6n4ZayEqzEqsH9ExTpRmsvfu+579GXelt7q7dXKPBgyf4Kb+YUXVxWF
         +pL9gToc5BAhOxpSheCtPXbeaG4+JEtPjg8EPPNYyCbaQ2GCME8QDvIhrJP7kJhKHF
         cAGZ88LgqfNo6GwndrDZNZdY9ZG/YCJEf0HqD6pJxNjEv5u8VLQNxjC9fVRuiiRBjA
         5EoYaMULVFmBtJdJKZiHQuzRmBRlAfXRAW6lilbCw+chywyz58q6n9VSiSdShmSsDv
         qtkGZvgQ71+hDbUGkhycKDKztSinwkkTU5w2cMZV6kJQvQjF64s3B7pO714Pjnr+oc
         xhx6qm2I/BbxbdUwkyWcWdrcQL7bKjbmgzheQ2DMbjM6glUksjwjzl9f0UwDgixS8h
         xjmbU5+cgt7zlztKmT8L54UJE0zC51BHrltM+tvu/+HVMBEbA6q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/8] builtin/clone: compute checkout metadata for clones
Date:   Mon, 16 Mar 2020 18:05:05 +0000
Message-Id: <20200316180508.367809-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200316180508.367809-1-sandals@crustytoothpaste.net>
References: <20200316180508.367809-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

When checking out a commit, provide metadata to the filter process
including the ref we're using.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/clone.c       |  5 ++++-
 t/t0021-conversion.sh | 10 +++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c..d28b4d4bc5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -780,11 +780,11 @@ static int checkout(int submodule_progress)
 	if (!strcmp(head, "HEAD")) {
 		if (advice_detached_head)
 			detach_advice(oid_to_hex(&oid));
+		FREE_AND_NULL(head);
 	} else {
 		if (!starts_with(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 	}
-	free(head);
 
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
@@ -799,6 +799,7 @@ static int checkout(int submodule_progress)
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	init_checkout_metadata(&opts.meta, head, &oid, NULL);
 
 	tree = parse_tree_indirect(&oid);
 	parse_tree(tree);
@@ -806,6 +807,8 @@ static int checkout(int submodule_progress)
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
 
+	free(head);
+
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 4b8d6a74a7..ad329044a3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -748,7 +748,8 @@ test_expect_success PERL 'delayed checkout in process filter' '
 	) &&
 
 	S=$(file_size "$TEST_ROOT/test.o") &&
-	M="blob=$(git -C repo rev-parse --verify master:test.a)" &&
+	PM="ref=refs/heads/master treeish=$(git -C repo rev-parse --verify master) " &&
+	M="${PM}blob=$(git -C repo rev-parse --verify master:test.a)" &&
 	cat >a.exp <<-EOF &&
 		START
 		init handshake complete
@@ -789,8 +790,11 @@ test_expect_success PERL 'delayed checkout in process filter' '
 
 		rm *.a *.b &&
 		filter_git checkout . &&
-		test_cmp_count ../a.exp a.log &&
-		test_cmp_count ../b.exp b.log &&
+		# We are not checking out a ref here, so filter out ref metadata.
+		sed -e "s!$PM!!" ../a.exp >a.exp.filtered &&
+		sed -e "s!$PM!!" ../b.exp >b.exp.filtered &&
+		test_cmp_count a.exp.filtered a.log &&
+		test_cmp_count b.exp.filtered b.log &&
 
 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.a &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.a &&
