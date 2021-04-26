Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E4C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D799261007
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhDZRso (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:48:44 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:39200 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237548AbhDZRs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:28 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 686AA80593;
        Mon, 26 Apr 2021 13:47:45 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 11/30] subtree: t7900: add porcelain tests for 'pull' and 'push'
Date:   Mon, 26 Apr 2021 11:45:06 -0600
Message-Id: <20210426174525.3937858-12-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

The 'pull' and 'push' subcommands deserve their own sections in the tests.
Add some basic tests for them.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Don't switch unrelated uses of vanilla test_create_repo over to
   subtree_test_create_repo; this has been moved to happen in an
   earlier commit.
 - Fix whitespace.

 contrib/subtree/t/t7900-subtree.sh | 127 +++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 9afba2f282..ce6861c22d 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -427,6 +427,133 @@ test_expect_success 'split "sub dir"/ with --branch for an incompatible branch'
 	)
 '
 
+#
+# Tests for 'git subtree pull'
+#
+
+test_expect_success 'pull requires option --prefix' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		test_must_fail git subtree pull ./"sub proj" HEAD >out 2>err &&
+
+		echo "You must provide the --prefix option." >expected &&
+		test_must_be_empty out &&
+		test_cmp expected err
+	)
+'
+
+test_expect_success 'pull requires path given by option --prefix must exist' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" HEAD >out 2>err &&
+
+		echo "'\''sub dir'\'' does not exist; use '\''git subtree add'\''" >expected &&
+		test_must_be_empty out &&
+		test_cmp expected err
+	)
+'
+
+test_expect_success 'pull basic operation' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	(
+		cd "$test_count" &&
+		exp=$(git -C "sub proj" rev-parse --verify HEAD:) &&
+		git subtree pull --prefix="sub dir" ./"sub proj" HEAD &&
+		act=$(git rev-parse --verify HEAD:"sub dir") &&
+		test "$act" = "$exp"
+	)
+'
+
+#
+# Tests for 'git subtree push'
+#
+
+test_expect_success 'push requires option --prefix' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD &&
+		echo "You must provide the --prefix option." >expected &&
+		test_must_fail git subtree push "./sub proj" from-mainline >actual 2>&1 &&
+		test_debug "printf '"expected: "'" &&
+		test_debug "cat expected" &&
+		test_debug "printf '"actual: "'" &&
+		test_debug "cat actual" &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'push requires path given by option --prefix must exist' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD &&
+		echo "'\''non-existent-directory'\'' does not exist; use '\''git subtree add'\''" >expected &&
+		test_must_fail git subtree push --prefix=non-existent-directory "./sub proj" from-mainline >actual 2>&1 &&
+		test_debug "printf '"expected: "'" &&
+		test_debug "cat expected" &&
+		test_debug "printf '"actual: "'" &&
+		test_debug "cat actual" &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'push basic operation' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	test_create_commit "$test_count" main2 &&
+	test_create_commit "$test_count/sub proj" sub2 &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree merge --prefix="sub dir" FETCH_HEAD &&
+		before=$(git rev-parse --verify HEAD) &&
+		split_hash=$(git subtree split --prefix="sub dir") &&
+		git subtree push --prefix="sub dir" ./"sub proj" from-mainline &&
+		test "$before" = "$(git rev-parse --verify HEAD)" &&
+		test "$split_hash" = "$(git -C "sub proj" rev-parse --verify refs/heads/from-mainline)"
+	)
+'
+
 #
 # Validity checking
 #
-- 
2.31.1

