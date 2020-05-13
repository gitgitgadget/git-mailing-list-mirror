Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C236AC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F75220675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FKoPJzi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgEMAyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38092 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgEMAyj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A91760797;
        Wed, 13 May 2020 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331278;
        bh=Qe1db/Vkg2LYh4oBw4EKMmRj3837dhpHVhX2HJXmgH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FKoPJzi6tqQQOgzo4V7RRtTh9gVlddIobIA43mYMJuXHVc61J9tvqVZagnFNLT44j
         O388AFipQJDT25vEZgXPQiOxclCDhicozkxpwBlsgb8mjWBx25oGf7wj4Fe88bEdWp
         07AnNLCHOSotf8lAuwUH3Agfp4UVz4Atuqc6xRzTy+jiiEw6kB4V9qjG+sTvZ3hwXh
         +hK79FnCNpI8LCCDTV7CkQUjKcdzL69OdreQX8DFmZ+h9i8RMtXinKROCBnnBAjTNq
         TlzdB/Z7HOBfXVrM5NlUOplaj5m3iaeSplQdHesCwtKrEkPzrUjSAU4cHZTmsDh6yz
         qOdyw6fbO07tLusHGzA80+WGXSkpmrWZmCyPcziPeKRmSVVWoU4O1Aw1vk4+jrUhPj
         Gbr8074GohH0m5+XT4hWM8aeCWmvG2rWe4/NXU9ipFm0dFrLM3gVBamBkan4ingH5s
         zV5h4sPA7+vd5M4kk1SS/BcGFlib/dc7veqScH2Z4qe8m9rFQed
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 01/44] t1050: match object ID paths in a hash-insensitive way
Date:   Wed, 13 May 2020 00:53:41 +0000
Message-Id: <20200513005424.81369-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pattern here looking for failures is specific to SHA-1.  Let's
create a variable that matches the regex or glob pattern for a path
within the objects directory.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1050-large.sh | 2 +-
 t/test-lib.sh    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 184b479a21..7f88ea07c2 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -64,7 +64,7 @@ test_expect_success 'add a large file or two' '
 	test $count = 1 &&
 	cnt=$(git show-index <"$idx" | wc -l) &&
 	test $cnt = 2 &&
-	for l in .git/objects/??/??????????????????????????????????????
+	for l in .git/objects/$OIDPATH_REGEX
 	do
 		test_path_is_file "$l" || continue
 		bad=t
diff --git a/t/test-lib.sh b/t/test-lib.sh
index baf94546da..77e9a60fcb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1428,6 +1428,7 @@ test_oid_init
 
 ZERO_OID=$(test_oid zero)
 OID_REGEX=$(echo $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
+OIDPATH_REGEX=$(test_oid_to_path $ZERO_OID | sed -e 's/0/[0-9a-f]/g')
 EMPTY_TREE=$(test_oid empty_tree)
 EMPTY_BLOB=$(test_oid empty_blob)
 _z40=$ZERO_OID
