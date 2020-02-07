Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978BC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BD21741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HVSzUw7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBGAxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727473AbgBGAxn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:43 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C52160FC8;
        Fri,  7 Feb 2020 00:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036821;
        bh=v2ra5Eax7vyEoIVpdVzxoQPYGq+Dzugdnx/nwcCR7xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HVSzUw7sGnFHOF3eMb2fA9JWOy6fBuoWwg25gRaA2fIYV6x5mNkppDV20JluNLAo0
         ybhd0nuQ0eQCiCPLfvdYiNjiUgic1sUiaZYXSLLA7TX+TDuv48apW5kKOcT8jeSfaf
         h5+2jlnl49ddlGdXJNsRskGNeqBbo2trz9iCfgOno1DslFQJ4Kl8xDFG6zbSsj1jev
         D50yO9I1tDV3aDoCJJeQ+lSC6S74oiGJOuBsE4ijq7BLURefMRMil6f5pyq/MexM/s
         11HmBd4E2H3vjwi/f4muI0tDWcP7Eo0oiVGTrCDpQdf8zL8eAA8ygcWsscRaeqaJ7p
         jQOq2mRnGLjm+2cV98LDYXRaQrJd6eg+Jqge/jDVeL8V0UkqnFbXQxESmS3L5xdBZb
         Ac72VPZKwSiHQngzC6s85LAmqQbGEkjVzol2uOsEwpZGWk1AySz9zIo5LE4srVdNPm
         z8aDtS6qVi6rFvNUysuqQBA3dCzjwinFPOWxpbSZ4N1nnxCkq0L
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/21] t6000: abstract away SHA-1-specific constants
Date:   Fri,  7 Feb 2020 00:52:52 +0000
Message-Id: <20200207005254.1495851-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6000-rev-list-misc.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b8cf82349b..a0baf9ee43 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -104,13 +104,16 @@ test_expect_success 'rev-list can show index objects' '
 	#   - we do not show the root tree; since we updated the index, it
 	#     does not have a valid cache tree
 	#
-	cat >expect <<-\EOF &&
-	8e4020bb5a8d8c873b25de15933e75cc0fc275df one
-	d9d3a7417b9605cfd88ee6306b28dadc29e6ab08 only-in-index
-	9200b628cf9dc883a85a7abc8d6e6730baee589c two
-	EOF
 	echo only-in-index >only-in-index &&
 	test_when_finished "git reset --hard" &&
+	rev1=$(git rev-parse HEAD:one) &&
+	rev2=$(git rev-parse HEAD:two) &&
+	revi=$(git hash-object only-in-index) &&
+	cat >expect <<-EOF &&
+	$rev1 one
+	$revi only-in-index
+	$rev2 two
+	EOF
 	git add only-in-index &&
 	git rev-list --objects --indexed-objects >actual &&
 	test_cmp expect actual
