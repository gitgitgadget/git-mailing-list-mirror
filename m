Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224AEC4CECE
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68552071C
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0NE9Z2ZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbgCPSF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:05:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55326 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732279AbgCPSF5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Mar 2020 14:05:57 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CECA760CF2;
        Mon, 16 Mar 2020 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584381956;
        bh=5J7sFsIEn2UpDxLg7134Ml1SM5uJU4ijkg5GSLxh7l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0NE9Z2ZFQrPcooMgqq5fE7JcDmdI/y3Xl97lcDPIj/QUotLNJP7Yt0IN3P/VdhyQC
         669KUFVFQAVcBAFERUylDuWwlm+zD75zqEDzEUvXlBpQRZrPsjCSGTNasbmDYuIoLb
         OW3H3aPi2YA2r4oCX9eH+rP8y0ri43UkvnnOViAd4A3JCxGFPfL9kNBtt3OFCd6a/n
         CFmqaDs9BSs0l5U7rXdkYsZ86eDZAsWoIcKyTHcfiXHFmtJpVsx5kAMX8VVuxFo8BX
         NOY88A3fu3kIafUaif57jKbyFL/kyK5i6frWZGQOu1igpgzmk5kZwMiTB/sENWC6K2
         V93TfjdCYYZ1AsWiICT+8u7OL0IRZe5F9+vaGhiLuK9Ic6fav3TYwICHcCYTeLp3Hc
         5ROHhwzMXfZ0abyzHNWfc1F1Y+0FK0zxDPCwRQbglWsdM4pJyi7wj+gEUsDlAr4GNW
         GTpxsFBeK/+pkJM1nNRaM4bnqMKV3OmsuDoz6W8jIAGxo+wtePK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 6/8] builtin/rebase: compute checkout metadata for rebases
Date:   Mon, 16 Mar 2020 18:05:06 +0000
Message-Id: <20200316180508.367809-7-sandals@crustytoothpaste.net>
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

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/rebase.c      |  1 +
 sequencer.c           |  1 +
 t/t0021-conversion.sh | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d16..27a07d4e78 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -868,6 +868,7 @@ static int reset_head(struct object_id *oid, const char *action,
 	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
 	unpack_tree_opts.update = 1;
 	unpack_tree_opts.merge = 1;
+	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
 	if (!detach_head)
 		unpack_tree_opts.reset = 1;
 
diff --git a/sequencer.c b/sequencer.c
index e528225e78..0dd34496fd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3290,6 +3290,7 @@ static int do_reset(struct repository *r,
 	unpack_tree_opts.fn = oneway_merge;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.update = 1;
+	init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
 
 	if (repo_read_index_unmerged(r)) {
 		rollback_lock_file(&lock);
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index ad329044a3..3efb0dad20 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -382,7 +382,8 @@ test_expect_success PERL 'required process filter should filter data' '
 		test_cmp_count expected.log debug.log &&
 
 		git commit -m "test commit 2" &&
-		META="ref=refs/heads/master treeish=$(git rev-parse --verify master)" &&
+		MASTER=$(git rev-parse --verify master) &&
+		META="ref=refs/heads/master treeish=$MASTER" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
 
 		filter_git checkout --quiet --no-progress . &&
@@ -425,6 +426,42 @@ test_expect_success PERL 'required process filter should filter data' '
 	)
 '
 
+test_expect_success PERL 'required process filter should filter data for various subcommands' '
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
+	test_config_global filter.protocol.required true &&
+	(
+		cd repo &&
+
+		S=$(file_size test.r) &&
+		S2=$(file_size test2.r) &&
+		S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x=.r") &&
+		M=$(git hash-object test.r) &&
+		M2=$(git hash-object test2.r) &&
+		M3=$(git hash-object "testsubdir/test3 '\''sq'\'',\$x=.r") &&
+		EMPTY=$(git hash-object /dev/null) &&
+
+		MASTER=$(git rev-parse --verify master) &&
+
+		cp "$TEST_ROOT/test.o" test5.r &&
+		git add test5.r &&
+		git commit -m "test commit 3" &&
+		git checkout empty-branch &&
+		filter_git rebase --onto empty-branch master^^ master &&
+		META="ref=refs/heads/master treeish=$(git rev-parse --verify master)" &&
+		cat >expected.log <<-EOF &&
+			START
+			init handshake complete
+			IN: smudge test.r $META blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge test2.r $META blob=$M2 $S2 [OK] -- OUT: $S2 . [OK]
+			IN: smudge test4-empty.r $META blob=$EMPTY 0 [OK] -- OUT: 0  [OK]
+			IN: smudge test5.r $META blob=$M $S [OK] -- OUT: $S . [OK]
+			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $META blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
+			STOP
+		EOF
+		test_cmp_exclude_clean expected.log debug.log
+	)
+'
+
 test_expect_success PERL 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&
 	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
