Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF24BC33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C09721569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Rp0bzhtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgAMMkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37622 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728646AbgAMMki (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5003A607FA;
        Mon, 13 Jan 2020 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919237;
        bh=gbLmKUXxtyA158kwNXH2y6D9PAn8TpijdENNDxul7F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Rp0bzhtWzwDVz+LKu9yyua6jcnKvfP1TvVFrTcVP2J5d7stZSGVOMOMdHyzlkjKqM
         GeGPWOj5Sw0OGqa0CLVcAWxub0FNY2M5fyrNU1m6z8S2pJNL52PUL5JSSZW6lqHcUd
         5QAtBeb72GQyLvGP5J0CCHDGg6xtrSEgBeZGxDzyngGJAhxK79M30DN8LV/VpLlTmG
         5mZATxtNUOfa35IcJ5+dlhaARD2aQRJfvi4l7hMz0QU65lyKJn8lfLWlB3og5PkBDU
         2x7Q2607fR5nxL6im00SLmUKAljlEpi9F2F8GLbzpmB2LYhsp2Mx1b66TzDm9uIQIK
         pTqlY+SgHjL3M5OKIjPMY4zAiiYilcE6xzge8v+HqgmCWP2+Gsf07qOto/LFIv8yCr
         rQsiQKse/oM05PZEcT3AQT+itPy5d4GREC7js9odiQTp8M9njXIlrANoV9rQE29kjw
         Hes6kZiw1UBvhI9WiRt8eItwzXguUx4thauX8g/O9/j4x4+8j2q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 11/24] t4211: make test hash independent
Date:   Mon, 13 Jan 2020 12:38:44 +0000
Message-Id: <20200113123857.3684632-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
 
