Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B15C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7A2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OQJe8dn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAYXBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46818 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729012AbgAYXAx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:53 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1BE2160FC3;
        Sat, 25 Jan 2020 23:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993252;
        bh=v2ra5Eax7vyEoIVpdVzxoQPYGq+Dzugdnx/nwcCR7xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OQJe8dn+F1w4grnInN62qdEoU5oTDR8oRXGsQqXM6BnGa4IqJjzwDHFWBDyMwA4+/
         A84z4FIX+Z7izOZyIqcAsPOVWeywhjVGx9S5sv1N2m3F4os93cs7PQJdYtDmPIifgN
         RvqDrncVfylYS1HAGXWTXHC7PXgtdWHAHmACncQ5lZLFOAIzs5O7cL9tRzUuyottP2
         0GaqVdZhUC5kizwKxjsCVnLjz/mAfWHieK0378srqRZgyooPlHXJ4wMxSX3RdZb/Dm
         nAGALOXm7cj61m5QzdGvxHRdNjIc4eERwcDF9Kf7bTmFFwCVbifKxdoZmGlAcT97CI
         xdZeSE038+PMBzgoMpTofSHtl/1yfK4IKpuLcl6NnZFVIYCgxUpfi9Kp5ppCZAiei/
         7iWFTNfQ0sGRf7IZwb0MjUz5kh0Avnw38Ex88g2d7Dap36qFS94O9pbOLDMS/shmTO
         yeZqOEVS26o/y0Q+IGiaX+QEZkUae483yBVqgJCfR7lJ2J/G+AQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 21/23] t6000: abstract away SHA-1-specific constants
Date:   Sat, 25 Jan 2020 23:00:31 +0000
Message-Id: <20200125230035.136348-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
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
