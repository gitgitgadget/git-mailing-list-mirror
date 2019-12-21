Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C99C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB66206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="E8myIs2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLUTuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42024 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727407AbfLUTuN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:13 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 44DF0607F5;
        Sat, 21 Dec 2019 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957812;
        bh=KzLh50KhxrNY0zRCl+KV38C88B3ae2G6UJUI2kUSEYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=E8myIs2FKipLa6xQJBE+HmudsRFj+195xaGdkTz+xX6IAzZjmSVE/2NwFXbmM7x2q
         yx+/qbisj24hSe5oZwkkULVY+AM42I8vY7bF8aErXYu2KGjLu1VIO6Sz5OS7T3k4v6
         9d6CTNkAvnlLaqpVyByi4jTPcm7UBe80RtCCcWeSeDyqb+PTQNXMb5UoL3ZOjL5ZaT
         gkUTl9p7zqC6eD8SkmwxMjtedG7aY2cOIcVJMA6vAo1DVaAkQjQaw0ippFEKylPN6H
         Cl7fthHKppjbvlXmGQUq/ZivKO7jVV61iCK9f24hrJH2KJ2eN3aqERHMvaDhTNffFX
         6aGppPC3d6w1KKAk2g8ACn/LbrC15Xp5REjcU3s07uQ6IFZqSbhnoyfVaZ8HNLyz08
         3PT8rMeueONO9NTZZw7BG1rTvyZyzcufQCDsMCuZmt0+8PMH3K7BA/nKJRYK343NxQ
         m67eQjsZFEN0qfJVaNyekczpc+uzLnfG81sPT9Q86JwHH86iF1Q
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/20] t5512: abstract away SHA-1-specific constants
Date:   Sat, 21 Dec 2019 19:49:30 +0000
Message-Id: <20191221194936.1346664-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
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
 t/t5512-ls-remote.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index d7b9f9078f..62152bad1d 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -230,9 +230,10 @@ test_expect_success 'ls-remote --symref' '
 '
 
 test_expect_success 'ls-remote with filtered symref (refname)' '
-	cat >expect <<-\EOF &&
+	rev=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
 	ref: refs/heads/master	HEAD
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	HEAD
+	$rev	HEAD
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
@@ -242,10 +243,10 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 
 test_expect_failure 'ls-remote with filtered symref (--heads)' '
 	git symbolic-ref refs/heads/foo refs/tags/mark &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	ref: refs/tags/mark	refs/heads/foo
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	$rev	refs/heads/foo
+	$rev	refs/heads/master
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
@@ -254,9 +255,9 @@ test_expect_failure 'ls-remote with filtered symref (--heads)' '
 '
 
 test_expect_success 'ls-remote --symref omits filtered-out matches' '
-	cat >expect <<-\EOF &&
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/foo
-	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/heads/master
+	cat >expect <<-EOF &&
+	$rev	refs/heads/foo
+	$rev	refs/heads/master
 	EOF
 	# Protocol v2 supports sending symrefs for refs other than HEAD, so use
 	# protocol v0 here.
