Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0FC43467
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E542053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nTXFEPuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbgGWBKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40550 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387645AbgGWBKg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0F60A6101A
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466605;
        bh=/Y2IAakbQXZRpXTcNI3dlWOYa+RXHLvR5qZqNy0IV9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=nTXFEPuIl3OvW5A4a5t2sjUmNYmGlENw82x3wFMt8ocVgxuF1knPqMx6K649jUeLc
         59MnkMNqrBvx3QwYkVepqs4t6hCFMVE6AbV1OywPImoYifL2yaKULT/1SATGtpVgtf
         fa9xp9jmYMLkZvipToud8Z0xDP6N2/OG2pExd5pomI3gUv77zCsmNEzZUUWj1EHGEP
         CBjxKrtw4s4pkbYwV2M80M1A4/3LEazVCuFoa1eaf7wu1TrJtnJHvZJNR/fwOMDrIV
         oRhP+Nj04+Ai/CqQkHtuFyS5gAqBMZlHxy118rPnTa/KGUqNkOMroqas34CjLaksuO
         hsRTTVU3taqLJJdeaHkQZcK3apToLlKtjJOFdw5nBnbblN2b295Dcmc+f4cZab2Dbe
         tF4MeJhfjMvn4EdmaHwf0reTgUAocoZEwvbp0cuOeo7OyLhMuOdgyB1lRJPFCc4P8M
         gxTz1OeaE+tDBS+YFNbAwzz+i/b4fTdT98XMAztXFdFJxjI7EaR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 36/39] t: make SHA1 prerequisite depend on default hash
Date:   Thu, 23 Jul 2020 01:09:40 +0000
Message-Id: <20200723010943.2329634-37-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
