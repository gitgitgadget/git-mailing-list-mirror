Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15560C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD6F20771
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gLdM06Rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgFVSE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39972 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730151AbgFVSE0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8BA1A60791;
        Mon, 22 Jun 2020 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849064;
        bh=GrrbOwxtfZN0cors2SlMO+VoQjRZiEcLyy3X9tGla/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gLdM06RjHMz2uYILCiwxoGk2jEFs1ytKOQVq9RMAf6caKgcJQrBx/+vlClaVoMYxA
         PaSQNVfMkIfEYHFFSyOvfU2xHlqy48r/RkQuIRR5RLOVIgJpGrSkTRBA8RO1IBC76W
         6ag6XbWbSAMzMxQar48thOVN9ZWxK4rCTxhGWmW584X2Izp4r2J3UdApwTBIm/veRZ
         gZ5zVm70t5NMdWt+Tyxk4cf5+lho/QFpXAVBwCBROSnJQf9NH3ctIQrM6+EuO6URVD
         NVgvtXro/H7MqAQkz1zx5t3nznaZs+hHfcDNiNGHbDG3BinPyAfMXv+YQTMmJpFzR+
         hOPTu+Ui/lDrb8t1f5t0g8dKO+ny7ivES7krN64qcdH1pSjnaYS2j/sES74ctBtyFy
         wiE5OvKokJ/hHUqhvj0z72Wgg5R74sw4O4xyJJPhcYzSCk7MNgwC72FtmRZrC8YOJ6
         /vd4FeldfxFOEGVEEqINeIO2Trw/HAm7aZK4m8BLu9GRuVsyYO4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/14] t9109: make test hash independent
Date:   Mon, 22 Jun 2020 18:04:05 +0000
Message-Id: <20200622180418.2418483-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of stripping off the first 41 characters of git log output,
let's just strip off the first space-separated component, which will
work for any size hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9109-git-svn-multi-glob.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index c1e7542a37..648dcee1ea 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -48,7 +48,7 @@ test_expect_success 'test refspec globbing' '
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.end &&
+	cut -d" " -f2- actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/end~1)" = \
 		"$(git rev-parse refs/remotes/branches/v1/start)" &&
@@ -84,7 +84,7 @@ test_expect_success 'test left-hand-side only globbing' '
 	test $(git rev-parse refs/remotes/two/tags/end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/v1/start) &&
 	git log --pretty=oneline refs/remotes/two/tags/end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.two &&
+	cut -d" " -f2- actual >output.two &&
 	test_cmp expect.two output.two
 	'
 cat > expect.four <<EOF
@@ -135,7 +135,7 @@ test_expect_success 'test another branch' '
 	test $(git rev-parse refs/remotes/four/tags/next~2) = \
 	     $(git rev-parse refs/remotes/four/branches/v2/start) &&
 	git log --pretty=oneline refs/remotes/four/tags/next >actual &&
-	sed -e "s/^.\{41\}//" actual >output.four &&
+	cut -d" " -f2- actual >output.four &&
 	test_cmp expect.four output.four
 	'
 
