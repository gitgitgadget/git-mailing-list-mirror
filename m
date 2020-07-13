Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2559DC43466
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FFD206B6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1OTurYWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgGMCuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40842 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728800AbgGMCuN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CD18660A6B;
        Mon, 13 Jul 2020 02:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608581;
        bh=/Y2IAakbQXZRpXTcNI3dlWOYa+RXHLvR5qZqNy0IV9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1OTurYWwy6qDaoYTALeIP/eC11C42+v3b5vVsfaJzWQxrYD5/Mtc+YeZ6lu4Bs6Oo
         bOhDaFjn3DkzpwQkZAFv2fPXBG45vRTyt/I3a6p+M1UcDKjcK9lFTmd+Oew/M2IJ2z
         NlLcLogG8atZsrWCV+Lr4xGatQxj+ETT/RHSLyEIWNwuKU3Md5yb02sbhf7oO8PlFy
         9/81YyP3mo6w/fecheX0vmcQVPI1lYS+Tptf5psW+23k0WKnXR1nwArSokx9iKwBVR
         2/jIXQjtr1iaKsLPcYYlbLtpqJPGIXOnWaBgP5fLJakHeJNzpnHEwx0xf+Jzex8Thn
         kooToyMkOcYkUyM/tWXYHFqbEzVOtHIVdFB0Q1R+s6bNkvL3NQ81iGt9BRiMNuuKgD
         WgeXUnUAoPsYp3og4QtJaiociwo0X7awQsABzQOWxaIcHEyo6cJ/ko7ONamdtPjFQV
         GL7I25Av57XmuJKN6q6MmWUcZpu3rsNbW7m/l6aza1br9CUYxAU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 36/39] t: make SHA1 prerequisite depend on default hash
Date:   Mon, 13 Jul 2020 02:49:06 +0000
Message-Id: <20200713024909.3714837-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the SHA1 prerequisite depends on the output of git
hash-object.  However, in order for that to produce sane behavior, we
must be in a repository.  If we are not, the default will remain SHA-1,
and we'll produce wrong results if we're using SHA-256 for the testsuite
but the test assertion starts when we're not in a repository.

Check the environment variable we use for this purpose, leaving it to
default to SHA-1 if none is specified.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 307bb2207e..ea2d308f62 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1689,7 +1689,8 @@ test_lazy_prereq CURL '
 # which will not work with other hash algorithms and tests that work but don't
 # test anything meaningful (e.g. special values which cause short collisions).
 test_lazy_prereq SHA1 '
-	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
+	{ test -z "$GIT_DEFAULT_HASH" || test "$GIT_DEFAULT_HASH" = "sha1"; }
 '
 
 test_lazy_prereq REBASE_P '
