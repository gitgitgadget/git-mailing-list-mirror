Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF1C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547B52071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UXxRYx46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgAYXAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46800 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727440AbgAYXAm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:42 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6CA6460E50;
        Sat, 25 Jan 2020 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993241;
        bh=NwYHtyx0uOjbzh6Yi98k3PN7tzgVmJ6Q23SkInWH7Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UXxRYx46ennZUaCiMkPpdoz9Yf6nnSWoWa8gXvMAlYl4mkSiBG3K2+S3FPLiTgPv6
         d9h4ugGBC5w/09O2/udLc1gXxr9yqo2HSyiAmKU2OF5YLMLRW2yl4R6bwpr7qJpGcy
         lseCZ5P2kAYk5uiNfnsI3ig+Hewp6YqDjDQNUPxTi7aMn/HSO2UMkO2jqhbfoLj4FT
         FMSmtzwjRPMYgd3UWZ7jXAYzyLFratV3JULJAI9L9glWh0VmKY1Oh8AbstBlPemQj0
         V5KJE1ReZ7pgk6Z+BCQkCNuJILp4h5gktvvkOcsDdPmcgrrJwyPtGdv1LGmSLJNqU7
         4gtOl8A37QfOc2i1fWVvE16O9+khXBIZ5YF7vv3jJ2Jk/6XWfWyQjBy1abmKr5x1bc
         LrGKyfrwvkH2aT7KMrmK8BmskxK2+maWoqwMT18VVM082HgbajqK0qavhcmEXPcGYT
         ZTsKrg/Jz35gfr+eNTKATVRAkeSzxKMQ9zdZmbr/AVeG/RRC8aI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/22] t3206: make hash size independent
Date:   Sat, 25 Jan 2020 23:00:08 +0000
Message-Id: <20200125230035.136348-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the one assertion in this test that still uses SHA-1 to use test_oid
to be independent of the hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3206-range-diff.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 0575dd72b1..bd808f87ed 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -102,6 +102,14 @@ test_expect_success 'setup' '
 	n3 sha256:3b0a644
 	n4 sha256:e461653
 
+	# mode change
+	o1 sha1:4d39cb3
+	o2 sha1:26c107f
+	o3 sha1:4c1e0f5
+	o1 sha256:d0dd598
+	o2 sha256:c4a279e
+	o3 sha256:78459d7
+
 	# added and removed
 	s1 sha1:096b1ba
 	s2 sha1:d92e698
@@ -336,7 +344,7 @@ test_expect_success 'renamed file' '
 test_expect_success 'file with mode only change' '
 	git range-diff --no-color --submodule=log topic...mode-only-change >actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	1:  fccce22 ! 1:  4d39cb3 s/4/A/
+	1:  $(test_oid t2) ! 1:  $(test_oid o1) s/4/A/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -352,7 +360,7 @@ test_expect_success 'file with mode only change' '
 	    Z 7
 	    +
 	    + ## other-file (new) ##
-	2:  147e64e ! 2:  26c107f s/11/B/
+	2:  $(test_oid t3) ! 2:  $(test_oid o2) s/11/B/
 	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
@@ -368,7 +376,7 @@ test_expect_success 'file with mode only change' '
 	    Z 14
 	    +
 	    + ## other-file (mode change 100644 => 100755) ##
-	3:  a63e992 = 3:  4c1e0f5 s/12/B/
+	3:  $(test_oid t4) = 3:  $(test_oid o3) s/12/B/
 	EOF
 	test_cmp expect actual
 '
