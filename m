Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F3C33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0522081E
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TMtjCclN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMMke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37614 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbgAMMkd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B35E9607F8;
        Mon, 13 Jan 2020 12:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919233;
        bh=NwYHtyx0uOjbzh6Yi98k3PN7tzgVmJ6Q23SkInWH7Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TMtjCclN5kBA6Da1lvVv9846GiOsu13RfwdiKZMlWgveYWTazfxpOcEBbe8GW7LAi
         3N5M4gfCKxG8xhoNG5b5/zVX8usK/bzAaoqF8TU08sVMhtcLR3wXdIHp8XJOwpTxe2
         nGXIAguKCC7+Zeg2LY3dd3YvPxhdFi5mqTZbAYnuHgs90nK+mq01WwYvzZNKxo52Vj
         a2mASboiGb1y0BsotDBZeX/ZmbIfU2TRV/PNiqUgmo+XH6gtKwtsu+Qfioj1XLdCz/
         tTpvd8guT+8HrWCySNM3qdy2U9CA70V3SQQ2hKgj5E/AztugStsWv6PS5OW67IFgIB
         YsObzD1/R2q6KAZuXGmbioDxUHrwEFLC8BjzMwvg5QeC6innlExVoyMEYSi+plptS0
         A36tS3yq6t19El/Jl3KqCLpj8fKgCA0AdoMBBl6ehaWR7EjED12dAvPmK8lEZOihx5
         86tzAJQYAsLzIAXsNyZ+ouEmivT7+DzWefTJeZi9DWmNSiRsjri
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 02/24] t3206: make hash size independent
Date:   Mon, 13 Jan 2020 12:38:35 +0000
Message-Id: <20200113123857.3684632-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
