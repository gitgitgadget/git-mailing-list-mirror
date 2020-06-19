Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBEC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A04223BF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eKmb6vSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgFSWwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:52:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39828 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729795AbgFSWwC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:52:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E992160791;
        Fri, 19 Jun 2020 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607091;
        bh=GrrbOwxtfZN0cors2SlMO+VoQjRZiEcLyy3X9tGla/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eKmb6vSDcRCFxca8aBV4KYxU/XGbkSFJ9SPynXgMAtPaTSu/ps30dapJX7gTG/e4z
         CF2CpDD8b5R2ZjSPoAQFhf49qkrlgfPofVvxaGlrNdSwTHYCQFHYLt8xR/EUrJcGZX
         v469zxhEPP26aR9rLVdaqzVRphiDaWG3a1GIar98v/FIJ4+vxUR6t9Wi531pA/aKvV
         059UY77BOxLcKpsnESThjZVtYN4GCuBxcGvvNUR0lSA2bJkCi6bhuuCsCZOcUfafMQ
         X69JMGds6uFPHjXhxgTM69YmL2ftWImCPKveH85Fp0srK7vB+c+3P0PRKeS9Tl08V5
         KnWbYX0hC74tiF9sxkMN3nBHZ6E5ib+3Uc2XPbDn+tLfWLsOLIAjEPxeTZ1UjjawbQ
         +udnj/7oGLROXMw3TAhaoHujnbkZSEFVAp6rAU0gQB9lRWBf1LEUO/syrbyu/Op/zQ
         dWwwY1xZx7mR5p8LLbQh7G3XNAnIOQfLzWBtcsTZYFTHjYBa+HE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 01/14] t9109: make test hash independent
Date:   Fri, 19 Jun 2020 22:39:34 +0000
Message-Id: <20200619223947.947067-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
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
 
