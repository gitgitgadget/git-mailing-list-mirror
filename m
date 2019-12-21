Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A47C2D0D2
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF03D206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Hkg5SEgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLUTuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:23 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727432AbfLUTuQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:16 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4B626607F0;
        Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957815;
        bh=qY0ZHloioPbDruu92dopk+ecUSiLkjlZdzJYZz37vOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Hkg5SEgzfXsp1qegN3/ssmhB6anoHsVfhXjK9SkpAr3J9dyWaeREP6TVAh7IMavFF
         C94FZkkhuip1pIvqlBJM6OvrDYTUJVZducyJb/NpBMv9Fe/G/5O6iq5Hnrpsx4oMY6
         W+ls2jI2wjTMDxHmznp9dPuDDLDPtxheq22nekP5aSAWcvjqAxofLn/5y0C6niecfU
         0QMuBTNjwJoSSms2IUMro8Rd+/qb6i/aXS/eU0Ywut+OXzoJppdMhxoG304vKFpEq/
         Hc6Ee2x4vQcj5WlTtydCfJz+bi4hcmnudbJFFnvgJkdB+f64VVvqz+aEKsr05LBjwN
         XkUYfeqB3l5iVCKf7WM8rfEeKVoypsvP3uoYO5Osqk3gLtKO8mdsYNmCcVLhzNul1b
         t1opc4yaUIaPOecNyHokEpZRta4BK8D+2+arhBEyxC/bPtPRJWvhE7puLK9/RiXNxs
         G9V79idZMQaHU/GYFNqujiDMQHDt2a7/Fo05GBcUaYPQo/m7F86
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 20/20] t5604: make hash independent
Date:   Sat, 21 Dec 2019 19:49:36 +0000
Message-Id: <20191221194936.1346664-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make our values hash independent, we turn the directory of the object
into "Y" and the file name into "Z" after having sorted items by their
name. However, when using SHA-256, one of our file names begins with an
"a" character, which means it sorts into the wrong place in the list,
causing the test to fail.

Since we don't care about the order of these items, just sort them after
stripping actual hash contents, which means they'll work with any hash
algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5604-clone-reference.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 4894237ab8..0c74b4e21a 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -326,15 +326,16 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
 	for raw in $(ls T*.raw)
 	do
 		sed -e "s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" -e "/commit-graph/d" \
-		    -e "/multi-pack-index/d" <$raw >$raw.de-sha || return 1
+		    -e "/multi-pack-index/d" <$raw >$raw.de-sha-1 &&
+		sort $raw.de-sha-1 >$raw.de-sha || return 1
 	done &&
 
 	cat >expected-files <<-EOF &&
 	./Y/Z
 	./Y/Z
+	./Y/Z
 	./a-loose-dir/Z
 	./an-object
-	./Y/Z
 	./info/packs
 	./pack/pack-Z.idx
 	./pack/pack-Z.pack
