Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BA8C35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06020838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ql6XoM1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBGAxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgBGAxd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 616DC607EF;
        Fri,  7 Feb 2020 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036812;
        bh=NwYHtyx0uOjbzh6Yi98k3PN7tzgVmJ6Q23SkInWH7Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ql6XoM1opKYfgyzj5FvYIyrLG8WKlyKPXjBB/Ddp6Uy300TQD5Db+kKY/2aKM86mT
         NIm1ss+9pJ/lP16z5sKsJXMRazAWYxNrNFtXybbLGr1B9CCtOjkfTt9TUMgxLiVg6v
         GWSHv+OPZWC4uwwc661jxbir40f8BXWQtsis0VnFi4AVlG90HDp0945fbwRmYbCBtq
         rFHqAxu6cLG0N4k6OvzCHsC3qXjGlKuaoorxIZQBT+3S3iDBf75+0jmJMAPiUYFP+G
         IrBIsTNqRqYlsJE5JuF15LwXzcMzJdtOaL9GMucNS3JCxbfO1/3NLPS4ZNoJSq7Z8f
         LnWaZBBMJdp0zIgfiUtB00yjT+MYiG2JU2NEX95HGt6aTXLFdL+YrG/3tJyNLdpmr/
         WBfgJ0r07HTpHqZQSsRSpCOfJTgWtAjX2Vy02x5pCSOGYpOGrisrULkfTXzfvhhWDm
         aSSqMyjyI08YoiZGQ5bAOk0zv2x0IU4H6ZoAo7OwH3kpiQRA/Fv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/21] t3206: make hash size independent
Date:   Fri,  7 Feb 2020 00:52:35 +0000
Message-Id: <20200207005254.1495851-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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
