Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E82C35243
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5752071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JcTn8+/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAYXAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46812 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgAYXAp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:45 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2FF6C60FC6;
        Sat, 25 Jan 2020 23:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993245;
        bh=gbLmKUXxtyA158kwNXH2y6D9PAn8TpijdENNDxul7F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JcTn8+/gOqlNhnzlJpXLIf4g5e4zlSw4GVxoIwYG8MkMnviLfwoihJrGDNLuzuAg0
         CXVaeZBedvJPwMFOvbuXX7ITquPZ2XaSO0XCsxBlR/nmwDcPdvMDqeH03A8RMyaecG
         1xm5dR8whAKIxkfZV6m/oia0cnUlE/D7KfNKq1g7X/LJLpFKnH3lsWFs3oWOWKn9Jj
         sizpP7r+aY7Qch/8uqGmQdpmXg5cjRf2c9ITJrqvlTQZQ7QNROInHI4VIgS7LluXD4
         +LRzwMmupxIJjH0+2zWlhw+RlcyNzPmZFRa+rp556D9D3PGn1YjJb4OqJWDiklrb4R
         Fb7LuueInYxgSUeAcP7Q4lXo3KPOg8bnuUUqpC3bTPQNT3w5zw2meoYq9WA3jw7FFn
         kkQtqI7KWYxX08qKvyULLc6LgIdNB2teq5misZ3xfn1pVoGBh44usxmRaOwBgLe9Ci
         oXLlyUEhwZ9/w19b9fp+atUqFzJ+Fm414U2mEl0cJudp1PD7yqg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/22] t4211: make test hash independent
Date:   Sat, 25 Jan 2020 23:00:16 +0000
Message-Id: <20200125230035.136348-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses several test files that contain hard-coded SHA-1 object
IDs. Replace these values with generic ones of the correct size so that
the test works with either SHA-1 or SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4211-line-log.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 8319163744..2cbfd8dd9e 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -8,10 +8,20 @@ test_expect_success 'setup (import history)' '
 	git reset --hard
 '
 
+process_output () {
+	x07="$_x05[0-9a-f][0-9a-f]"
+	sed -e "s/commit $OID_REGEX/commit $ZERO_OID/" \
+	    -e "s/commit $_x40$/commit $ZERO_OID/" \
+	    -e "s/Merge: $x07 $x07$/Merge: 0000000 0000000/" \
+	    "$1"
+}
+
 canned_test_1 () {
 	test_expect_$1 "$2" "
-		git log $2 >actual &&
-		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$3 actual
+		git log $2 >result &&
+		process_output result >actual &&
+		process_output \"\$TEST_DIRECTORY\"/t4211/expect.$3 >expected &&
+		test_cmp expected actual
 	"
 }
 
