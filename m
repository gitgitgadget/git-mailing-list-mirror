Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A11C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B835D208E4
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Mc9j0FIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCTVwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:52:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58298 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgCTVwt (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Mar 2020 17:52:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02CFE6077C;
        Fri, 20 Mar 2020 21:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584741168;
        bh=XfmFXkdAA/fO+Wagphb1wi53mR3IwgHtzdUH0Huej9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Mc9j0FIvQR2GTFqxSXioh14s9j8HHI5IH3iEKPy1AdAcsN5EV20Ohth9/zMacd1ed
         xqW/XiZAbe+4un0HICCOVMorHMKVy4v25CAi7EWools1dqW/EOtolKtLO0yQZ3rBLo
         W2TLgorCUGWTT7NVNqGcGtdyh8HV6eTX3XM1ZRDzBXtnOm/PaTED77OMNRN4XsP2lU
         4oTsnx3LFNDKuMEitY8ogbIGyLxeNehLp0rD7pJLJ8tSdjfQxailBV2IdrKl8xUiPJ
         4MtcM67ifUVL8zgkl3r0VnCl/PypVc+DzOrGOQlaX+BfZjrBIB1hc9iVktgxi4K9dq
         ByXFUiS1WqVOLAWpPuwldjNtEvKBcndlStnr50Z8Z0qlf78ccRFeYMCiTxpzQrxUJ7
         RtxrFMvmH4pUBD3RmOEgC7gcTQ5C49jzwz+xKu3vkwRiR+Xl0We/3pcMNMl5WzZ79W
         tuHck0vi1FBS6UT9TGRLueRgDZnda8jS+GlkIVZ1IWJpFV5yP76
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] t3419: prevent failure when run with EXPENSIVE
Date:   Fri, 20 Mar 2020 21:52:41 +0000
Message-Id: <20200320215241.609049-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.0.rc2.221.ge327a58236c
In-Reply-To: <20200320213916.604658-1-sandals@crustytoothpaste.net>
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test runs a function which itself runs several assertions.  The
last of these assertions cleans up the .git/rebase-apply directory,
since when run with EXPENSIVE set, the function is invoked a second time
to run the same tests with a larger data set.

However, as of 2ac0d6273f ("rebase: change the default backend from "am"
to "merge"", 2020-02-15), the default backend of rebase has changed, and
cleaning up the rebase-apply directory has no effect: it no longer
exists, since we're using rebase-merge instead.

Since we don't really care which rebase backend is in use, let's just
use the command "git rebase --quit", which will do the right thing
regardless.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3419-rebase-patch-id.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 94552669ae..d934583776 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -91,7 +91,7 @@ do_tests () {
 		git commit -q -m squashed &&
 		git checkout -q other^{} &&
 		test_must_fail git rebase squashed &&
-		rm -rf .git/rebase-apply
+		git rebase --quit
 	'
 }
 
