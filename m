Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7509DC2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BBE206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WYP/d3Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLUTuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727395AbfLUTuN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:13 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B92C1607F3;
        Sat, 21 Dec 2019 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957812;
        bh=V57brEwgq17IQ/MqeNuAMkk9mMQ5p0CUxAgofrzrDjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WYP/d3Z3ciaubR5MgPO1QAN87foJkVOLosnMqIj49Ve1p51ok8KngHnYG0+xwRMsG
         JdQKlob2D09Pf7/PFcQ8+SqqGnLqDqNRATwGra8VjdHJQ+BHyx2TPShr1mpbjQwtDM
         cwhn57mZcKbVZbNLMVFbbCegVMNM9LaUMMDsi+ToSKG3NulzWoto/Zr8d/iKa/0lZX
         PfujKh0OgrU/k0Ecl3EyAcTUiX2Cvr9saSLfRXMwMve2PmgsnrDXUNwBMv5ZM18u6q
         c7PKSPiWCpBL+dLyQsoGATo/gCyUrRGsJWCZAdIiAMuKrAERAm0WlGdFotiH+xO9vr
         NSl7J0g3qFKfJE7OEKtKu6exsA+9LkUKeVwLFiA/KYfSzgrDg+LMkMoLxFXDJqaLIs
         x8BCrHBLatRyJpqM41tG7WlYhQ2VCQhJjxeTC1dyltjHvi6SALXbQF8fGD+TrGQeM0
         Vi/o/ZA0kEW8/tTWSg6wBTMjXbizNDwOeAGxZnHZa1+uaKG9VoC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/20] t5510: make hash size independent
Date:   Sat, 21 Dec 2019 19:49:29 +0000
Message-Id: <20191221194936.1346664-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use $OID_REGEX instead of hard-coding 40-based regular expressions.
Change invocations of cut with a hard-coded constant to split using a
delimiter instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5510-fetch.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b60282689..2ceae14164 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -11,7 +11,7 @@ D=$(pwd)
 
 test_bundle_object_count () {
 	git verify-pack -v "$1" >verify.out &&
-	test "$2" = $(grep '^[0-9a-f]\{40\} ' verify.out | wc -l)
+	test "$2" = $(grep "^$OID_REGEX " verify.out | wc -l)
 }
 
 convert_bundle_to_pack () {
@@ -261,9 +261,10 @@ test_expect_success 'create bundle 1' '
 '
 
 test_expect_success 'header of bundle looks right' '
+	head -n 4 "$D"/bundle1 &&
 	head -n 1 "$D"/bundle1 | grep "^#" &&
-	head -n 2 "$D"/bundle1 | grep "^-[0-9a-f]\{40\} " &&
-	head -n 3 "$D"/bundle1 | grep "^[0-9a-f]\{40\} " &&
+	head -n 2 "$D"/bundle1 | grep "^-$OID_REGEX " &&
+	head -n 3 "$D"/bundle1 | grep "^$OID_REGEX " &&
 	head -n 4 "$D"/bundle1 | grep "^$"
 '
 
@@ -289,7 +290,7 @@ test_expect_success 'bundle 1 has only 3 files ' '
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
 	git fetch ../bundle2 master:master &&
-	test "tip" = "$(git log -1 --pretty=oneline master | cut -b42-)"
+	test "tip" = "$(git log -1 --pretty=oneline master | cut -d" " -f2)"
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
