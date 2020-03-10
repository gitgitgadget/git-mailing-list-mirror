Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB72C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F222222D9
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vH5NDIbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgCJSWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51060 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbgCJSWM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:12 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7E86F607A4;
        Tue, 10 Mar 2020 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864531;
        bh=YvvbImcKAiREaCMZ5zEKjrZLsCHfpa0QMcIMusR2OLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vH5NDIbbUAk4vhaG37eBTgl2ITSsHS3PEfQrb6zKb7olj8HL8EC+lbI86l4JZeBK0
         zC5dqe4OpcSJAmm+1edhLU7/09yRiPLy7bEcsMI0uMrC52fz9JP+6PACNIRbT7BFGC
         +1cSGp8th8CDbEUyfpbACDOmc1vTNAJX/Vn9qkvaBlXIEx0hoyc7TKoH6sLmwAsc79
         OhsAje71fYMWFhMns3kXZjE+bJk4Kk7zMMW5cG/wD2yxRHjlELR6XY8BzJmpkD/izD
         jUiHUJk3tBNuHfiQGmn98p85CSsPXDz8USnmkt496gEOGbzYA/WeDTvi/D+FLIAnTd
         E8aa4mB+wuQ3+TWRthkSFWw1OxZTV8T1pczG0TeP6x62QXWf/Awhm49eP3e49DJgcn
         KaDOVaeTey5/k71gzR4biwmRzXEPBH93YgXtdCby8rfgMPjd4XkLYJg9889zQJZo97
         VYfmrmILgbDVYIEv5A74FP0e+yAZoNnqap8pFNZKxTAmmXnm5cN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/8] builtin/clone: compute checkout metadata for clones
Date:   Tue, 10 Mar 2020 18:20:43 +0000
Message-Id: <20200310182046.748959-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200310182046.748959-1-sandals@crustytoothpaste.net>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
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
 builtin/clone.c       |  6 +++++-
 t/t0021-conversion.sh | 10 +++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 1ad26f4d8c..00e5427ef1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -780,11 +780,12 @@ static int checkout(int submodule_progress)
 	if (!strcmp(head, "HEAD")) {
 		if (advice_detached_head)
 			detach_advice(oid_to_hex(&oid));
+		free(head);
+		head = NULL;
 	} else {
 		if (!starts_with(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 	}
-	free(head);
 
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
@@ -799,6 +800,7 @@ static int checkout(int submodule_progress)
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	init_checkout_metadata(&opts.meta, head, &oid, NULL);
 
 	tree = parse_tree_indirect(&oid);
 	parse_tree(tree);
@@ -806,6 +808,8 @@ static int checkout(int submodule_progress)
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
