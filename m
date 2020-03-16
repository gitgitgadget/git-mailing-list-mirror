Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4350C5ACC0
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8D22073C
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Btn01PfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgCPSF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:05:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55320 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732285AbgCPSF6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Mar 2020 14:05:58 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A12B46088E;
        Mon, 16 Mar 2020 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584381956;
        bh=2hs4fKA4b4MLmUAktnDpzwKLklgU9Um0NMxFlSgWcb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Btn01PfLtxguAm+qVMFzW9UhFIc1QSvVPfoHy5XYWMypkZMO4f4Tl9iiAabx31CA5
         EAt9ox1kdn3mCmyxFM9EkDzK6y3ZXx+qZiBw3OzdUL2Yq+wA2kcI4sT6j6U5u6Y3xG
         rc1YcPGpmUAavaCgb1WZ7BZJYJqHx9u71yh7UhCzqNkD17JKHuzvGwHymkdjsYK+rw
         a+Xa2PzvTPfWhqDTeFgN8VhoJFTv3uXeA7iUvF3+hZQIb0cWh9akGj8cWLpw6QsmZ/
         oBnXUewRm5MI1Gn7yc9Jw5zf2ezeYZ+pf3hGLQycqfnRfW0L/NuEe6Hd7Q/1H9QEXS
         GyXoM6EuVIzLPhsd8Omp8+sQ39BMRAEEZohkYWiT+EU2XeanC5wO/kunLjE3oUq237
         uA16/dZCsnqxoIbuAI0R70QGpeK0y857q+vFCcRUcW3vAK3INGsSEZP2BXkIMpVuR3
         lUq+xxjhWzVzLi2XqgwcgFEyp/8OwnlyO3+zTjuZqldkATLZQvY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 8/8] t0021: test filter metadata for additional cases
Date:   Mon, 16 Mar 2020 18:05:08 +0000
Message-Id: <20200316180508.367809-9-sandals@crustytoothpaste.net>
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

Check that we get the expected data when performing a merges or
generating archives.  Note that we don't expect a ref for merges,
because we won't be checking out any particular ref, but instead a tree
of the merged data.  For archives, however, we expect a ref as normal if
we have one.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 t/t0021-conversion.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a026fd46b4..4bfffa9c31 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -488,6 +488,51 @@ test_expect_success PERL 'required process filter should filter data for various
 			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $META blob=$M3 $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
+		test_cmp_exclude_clean expected.log debug.log &&
+
+		git checkout -b merge empty-branch &&
+		git branch -f master $MASTER2 &&
+		filter_git merge master &&
+		META="treeish=$MASTER2" &&
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
+		test_cmp_exclude_clean expected.log debug.log &&
+
+		filter_git archive master >/dev/null &&
+		META="ref=refs/heads/master treeish=$MASTER2" &&
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
+		test_cmp_exclude_clean expected.log debug.log &&
+
+		TREE="$(git rev-parse $MASTER2^{tree})" &&
+		filter_git archive $TREE >/dev/null &&
+		META="treeish=$TREE" &&
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
 		test_cmp_exclude_clean expected.log debug.log
 	)
 '
