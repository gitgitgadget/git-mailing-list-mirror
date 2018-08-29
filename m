Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC381F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeH2EvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:51:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727166AbeH2EvY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:51:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A6C5A6075D;
        Wed, 29 Aug 2018 00:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504228;
        bh=/RJTG5P1aATLGhJ+UYNOQgC+lRFidWGNNxnUFfDEblE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Yk2l+z7BmwnmzMBCY7SHrckS91LxizEKCsyCQEE/MVDJd5s4pbwLzeYy1vJbw6BnS
         qF2J05eSu2Z8mRfMTnaF6UjEjv4ju10H7U25WUi8O9Ma9x8W35Dq4kzdHdQEMBmpg5
         rDcZNfMExQjRlf6HU0H2Uq7LIEpR2/LQQCDPtlU9f58wpL2M1bt8tfg4z32NKU6IGO
         Q8jFtNSUucgPs6+BAJxi78L2PXQ6SQit7to/6nCryPKXU7l9eDgXA1DndGfkQzr75U
         FirCaeFPP9xwXHx81M2Qe4miy34CaAigIKgT4ni/tViyrxUhMK1Ts6t0xpnbZFO9dV
         imRJC0mHhBLJqhRaVyG7Szy7atlaOIxBvA2xlGwUk2O6CfZPs/XHlQv82sedTWfBFw
         +J07rbKMTvuK0njP95U8zlC0MfDH0w/o5WVBGQH6feuwRH83d8YgJUrvdfA1Wy7nEq
         AEPTnLmr2taDdo3uUureYEDDg22XtpGGFtyk7ojOrgPpI1LNeSK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 07/11] t1006: make hash size independent
Date:   Wed, 29 Aug 2018 00:56:38 +0000
Message-Id: <20180829005642.980617-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005642.980617-1-sandals@crustytoothpaste.net>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the size of the tree and commit objects we're creating by
checking for the size of an object ID and computing the resulting sizes
accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1006-cat-file.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7f19d591f2..a7c95bb785 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -140,15 +140,17 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 	test_cmp expect actual
 '
 
+test_oid_init
+
 tree_sha1=$(git write-tree)
-tree_size=33
+tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello"
 
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
 
 commit_message="Initial commit"
 commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
-commit_size=177
+commit_size=$(($(test_oid hexsz) + 137))
 commit_content="tree $tree_sha1
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
