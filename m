Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F2C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4E4206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Hd4fQTA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfLUTuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41950 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727145AbfLUTuG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1F564607F0;
        Sat, 21 Dec 2019 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957805;
        bh=GQsS/lbLwzG1mmcJX4agdWd1aF/W4PpFsGSL5y5RFg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Hd4fQTA2BGKptu9avvlJMA1SJbwxCUzu+8L9Ydj8SKAn/WVGFp5LlOUfz7Acx/vYR
         +sAXzczCRk8ZyxzmzYG5LjHpvvnTBgepROCsT2COtNYBw5cgZ4IElm37Miz1sWe8UO
         HRWzsOJt6Ah2fGRc3TyIcNlkfKWbtcKVxLCj9PvPOPOL65xxdq5dY3sPK3EVy9u1hT
         6pY3xdYtGVEp4aRj4zQVG4RqPGT6Jhl/sEYwgA2iVdGkOpk9tx++/XyQh9sMQaKJPz
         d6X4pE0NQuyZccaWqhSWwml4KQ/kDWQFXrk1OZhW6z50iR9CZQE0zAly13frjoyVo5
         RWwm74FIy2h+ctN+fiRmxltrezMYlMm7196eGiMCmOsJUJn8PuA7NUb7b+yQY7Xe7y
         tUpO9sxiydjTT1d6e5q7r5MKwiwI1q3SGBKpEjj0xJNHkruBjc/ZW3OQgmPW6Ov4yz
         AImd7kSU1JFhQOjtH43TFNMMfUmcQq8FD1GMlLIJsIXpE7dYzg5
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/20] t4054: make hash-size independent
Date:   Sat, 21 Dec 2019 19:49:17 +0000
Message-Id: <20191221194936.1346664-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the length of an object ID when creating a tree,
generate it based on $ZERO_OID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4054-diff-bogus-tree.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index fcae82fffa..8c95f152b2 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -4,8 +4,9 @@ test_description='test diff with a bogus tree containing the null sha1'
 . ./test-lib.sh
 
 test_expect_success 'create bogus tree' '
+	name=$(echo $ZERO_OID | sed -e "s/00/Q/g") &&
 	bogus_tree=$(
-		printf "100644 fooQQQQQQQQQQQQQQQQQQQQQ" |
+		printf "100644 fooQ$name" |
 		q_to_nul |
 		git hash-object -w --stdin -t tree
 	)
