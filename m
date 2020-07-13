Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36504C43461
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AE9206B6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OkHpIzd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgGMCuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40818 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728737AbgGMCuE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 983CE60A6C;
        Mon, 13 Jul 2020 02:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608573;
        bh=nz4+OtGq3fE7rGU2uzYwanb+xiaiZY8Q9Rnalz28LGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OkHpIzd/q+Mv4C9QC76kD79gaTH5ebqoPmoLk5pTn204bpNnSnjTsvdQ9LY+LhaYw
         ccnsAPqMMyvLx6RBTph4e6aDprcDrbS6anNYC2wILJlfiWQZZLxr3Kx+/R+q0K8KLA
         fEhC+adZiXtu1dlPlh0AKmDZjfBJ2zpC+qIC035Jo8vW+zfKe8NW2yHdoVHxwERKwR
         ATNWoNFJWD+x5tTt2F8zrKpWj4MTU+SKoPIGaoxTpmEGKuXQIN5QxJV3m5EBOgw/Fq
         thWoh+f3EdA0noRrGJgRdmg/D4jC3E00KN0mz9pc11QraWX4YTAXJuOhjz0ySYsmq0
         jsEm/ebFGr9XQwSFlUA6KswTESpNNPvuI3OhTClPUlFCGAwd4nPQQXH0s2AGQsjnFV
         1SRjywVlMdDh015HjRsUWSJ8hMpTXc2PMytlfRkOw9dNDe56lw+xd8FlPed+XgGMg5
         /jqxg5+5mH4IivNMwWqaBHcb8HlM8ReKMwgVJ8lXk0oRuTkxmO1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 20/39] t8011: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:50 +0000
Message-Id: <20200713024909.3714837-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow lines which start with either a 40- or 64-character hex object ID,
to allow for both SHA-1 and SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8011-blame-split-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index 831125047b..8a4626d496 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup simulated porcelain' '
 	cat >read-porcelain.pl <<-\EOF
 	my $field = shift;
 	while (<>) {
-		if (/^[0-9a-f]{40} /) {
+		if (/^[0-9a-f]{40,64} /) {
 			flush();
 			$hash = $&;
 		} elsif (/^$field (.*)/) {
