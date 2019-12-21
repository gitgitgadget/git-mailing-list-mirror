Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85804C2D0D2
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEC6206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kR+Z7rOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLUTuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:22 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727428AbfLUTuP (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C55ED607F3;
        Sat, 21 Dec 2019 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957815;
        bh=o9qSVhnSJTkcJlYalEm9XG4el8iSPbIeRWtV3YG5L50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=kR+Z7rOqG/duaWaMhJZjU9RFPFE1ABrHACCEI0JwIa/nDoiaspp51BEalcOl/81WJ
         or4Jv+aX2jc7QixwR6AatXqDnKZZjhyac59mdrINN6FBP2deRmPJscSmWjrjt0CGYj
         /sgY17oDNtnzVXGKeKgsloEW6xpEpREZveULVk4XpF4TlPBeZLU3jVq3AA47rK9oB8
         VsdJ1ZJlo8wGUIh4zLXfEY4F4Qqq7+UhjbW9/cCxUDMqzWnUqMycDOCJYrwIsPmSaV
         tZmwpF7QhSl0gtAxeuPVUKTY9GxncpnUe1YAknyj5b8eSeoe1sF9dilOqS7GTNXrKI
         VghvYR+FTtqBaJirl8cv+qViZvZgYrMyALmYFxoNgAi3ggoOwEnVPpLyShFsRI2aHS
         i3zb253eXkQ1skkHOJz3wyy/JPqfaKy9nwJHJrPidmar2ywUqHOMQL5BpETHMBImp/
         p7tXaGJpXYL28Orp4gLgmgu6rtkGSyL+8zILt53SyndHDFJi4uW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/20] t5601: switch into repository to hash object
Date:   Sat, 21 Dec 2019 19:49:35 +0000
Message-Id: <20191221194936.1346664-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test performs a clone from outside any repository. Consequently,
the hash algorithm used defaults to SHA-1. When the test is running with
SHA-256, this results in an object ID that is not usable by the rest of
the test. In order to ensure that we provide a usable value, switch into
the source repository before hashing.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5601-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index ad8c41176e..84ea2a3eb7 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -635,10 +635,10 @@ partial_clone_server () {
 	rm -rf "$SERVER" client &&
 	test_create_repo "$SERVER" &&
 	test_commit -C "$SERVER" one &&
-	HASH1=$(git hash-object "$SERVER/one.t") &&
+	HASH1=$(git -C "$SERVER" hash-object one.t) &&
 	git -C "$SERVER" revert HEAD &&
 	test_commit -C "$SERVER" two &&
-	HASH2=$(git hash-object "$SERVER/two.t") &&
+	HASH2=$(git -C "$SERVER" hash-object two.t) &&
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
 	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1
 }
