Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A43C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7320675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mCuYul1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgEMAy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:54:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731856AbgEMAys (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E39B60CFE;
        Wed, 13 May 2020 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331286;
        bh=5MOVjLFFh3lkhlysaSMSoRifk6+bxVZ1Bm4EklDEL8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mCuYul1Na2NtRq6BKtJU7g5vy9mWq+zZifdvv7RuBSEMKwoNw79FWaDTERZNzzHC1
         QTiy/feJc7slFHvGTPEsW25xLP8z+uCh2GY37ILQDFUXZjVUH2BdbaxhXIt2k0ps+A
         tY36zBTo9QVnNRIzdpbO7EX+S0iIhm7ks/7160Ms/LY4+9yYB0bvfxihCBOxXBOccm
         NcdaA6yNMHijO35WR/zPOsbIEnDsg9zfiQWaJaFeb5Qm1fwpQAHIMt0Txdsv28FLkv
         OJWSweU366OITaBrN54oIsPcLz9HjQioqkZ5YFZRs7CeJxDU5qnLFOR8OxDAtN+YBc
         N5uYU1sZ4geLgnNntIxuGaJ3S/v91JQ1z7rGbsP5pKUAN/7wTi/I8QiCXIaBYQ8Dov
         n9nQfXg2u8b+HROWr/DMGkZM/Tk+l/+ZzSSk+DXOzPssakyCkjLyyFig1+Nj/LeCD2
         TrnPiwSmrYX52C304yMceTknzmtjH83Ufkkte0us6aWlJqwwLOE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 21/44] t5704: send object-format capability with SHA-256
Date:   Wed, 13 May 2020 00:54:01 +0000
Message-Id: <20200513005424.81369-22-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we speak protocol v2 in this test, we must pass the object-format
header if the algorithm is not SHA-1.  Otherwise, git upload-pack fails
because the hash algorithm doesn't match and not because we've failed to
speak the protocol correctly.  Pass the header so that our assertions
test what we're really interested in.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5704-protocol-violations.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 950cfb21fe..47e78932b9 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -6,9 +6,20 @@ communications if the other side says something unexpected. We are mostly
 making sure that we do not segfault or otherwise behave badly.'
 . ./test-lib.sh
 
+# If we don't print the object format, we'll fail for a spurious reason: the
+# mismatched object format.
+print_object_format () {
+	local algo=$(test_oid algo) &&
+	if test "$algo" != "sha1"
+	then
+		packetize "object-format=$algo"
+	fi
+}
+
 test_expect_success 'extra delim packet in v2 ls-refs args' '
 	{
 		packetize command=ls-refs &&
+		print_object_format &&
 		printf 0001 &&
 		# protocol expects 0000 flush here
 		printf 0001
@@ -21,6 +32,7 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
 test_expect_success 'extra delim packet in v2 fetch args' '
 	{
 		packetize command=fetch &&
+		print_object_format &&
 		printf 0001 &&
 		# protocol expects 0000 flush here
 		printf 0001
