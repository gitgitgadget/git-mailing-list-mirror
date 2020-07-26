Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C83C4345D
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC842065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dEfYHk+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGZTzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40778 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727862AbgGZTzP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:55:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0F18760D01;
        Sun, 26 Jul 2020 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793284;
        bh=hWcmAlf36LEgH0FqH3pnOO/cZSi2N6MHIq2qyXaXDWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dEfYHk+oORDpfdk1paKnKxQfL++14x2+Jg0fvNnHyo+LdRJoAk0boSHwVeaMiE1ok
         vRYbjcg1plIojErjsGWnpFQK0geplyF4lV42AmKfrW9aaMeEJpHN+sN0rhPXoWLhvt
         C9ARmgg5oC8nt4W8t25DblHoJN3R/HRv9yuNfMBV2xT/+AXVo9R4jHbzC8egLvAKpu
         nw8JLb3oJ3A57qL1LBlAgHMXLXjHssYoTNzMFySgOzfPHirEcwKxuj0DFprb6AWx0z
         b8XFmto+AychrN804lTKewHtwfxszp5TN2jv4MAsv6aRJ6YF8QmQ0pTxG4hTTg+nWB
         IHSjb3Cx61PN4Mzm4gGDhhzYUcGjtSx5dcns8nVrAsnX8mKOv//lSnRM67gGUSVRNQ
         XVkSZ3vlsfiADxTbWMzIM2g755t99kJt/xrQe8JchaC+F7GwLLihblFBoQMcqI2whJ
         uE/2CuZg7+V7oK/cUzYnzSl3U+h4o/1kBvOkywBT6d1k9z5UjS8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 08/39] t6500: specify test values for SHA-256
Date:   Sun, 26 Jul 2020 19:53:53 +0000
Message-Id: <20200726195424.626969-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this test, we want to produce several blobs whose first two hex
characters are "17", since we look at this object directory as a proxy
for how many loose objects there are before we need to GC.  Use
test_oid_cache to specify strings that will hash to the right values
when turned into blobs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6500-gc.sh | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 0a69a67117..4a3b8f48ac 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -10,7 +10,24 @@ test_expect_success 'setup' '
 	# do not let the amount of physical memory affects gc
 	# behavior, make sure we always pack everything to one pack by
 	# default
-	git config gc.bigPackThreshold 2g
+	git config gc.bigPackThreshold 2g &&
+
+	# These are simply values which, when hashed as a blob with a newline,
+	# produce a hash where the first byte is 0x17 in their respective
+	# algorithms.
+	test_oid_cache <<-EOF
+	obj1 sha1:263
+	obj1 sha256:34
+
+	obj2 sha1:410
+	obj2 sha256:174
+
+	obj3 sha1:523
+	obj3 sha256:313
+
+	obj4 sha1:790
+	obj4 sha256:481
+	EOF
 '
 
 test_expect_success 'gc empty repository' '
@@ -85,13 +102,13 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	# We need to create two object whose sha1s start with 17
 	# since this is what git gc counts.  As it happens, these
 	# two blobs will do so.
-	test_commit 263 &&
-	test_commit 410 &&
+	test_commit "$(test_oid obj1)" &&
+	test_commit "$(test_oid obj2)" &&
 	# Our first gc will create a pack; our second will create a second pack
 	git gc --auto &&
 	ls .git/objects/pack | sort >existing_packs &&
-	test_commit 523 &&
-	test_commit 790 &&
+	test_commit "$(test_oid obj3)" &&
+	test_commit "$(test_oid obj4)" &&
 
 	git gc --auto 2>err &&
 	test_i18ngrep ! "^warning:" err &&
