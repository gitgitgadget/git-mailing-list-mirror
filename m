Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E9C433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9D720767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XlATvhSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgFVSE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39982 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730204AbgFVSE0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2158B60A5C;
        Mon, 22 Jun 2020 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849065;
        bh=CKXqyLpVG2H0LquA9U6HCRvE2fzakReJAFg20+nBFT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XlATvhSwkcfdsjyvDFHDWNLjW/QiBU9fpXyLXdiEFrmfvlM4uS8IgYASNhJfDcnIl
         4SMGO7SxMJk89c1kAZu3pu4scbopV0Q/YYLwn5TKwbMVq/mQN1kGs6CCeUbxskr0zO
         w8TUg+z+ztRghmJGdg8rcsVLK4TzTl1UCUArTK7Tg4dCa+O/IP6y3IERXwt5tzxsMo
         ZhyeSK0FSJYjCqJy879bSG9HH3yW/gwpYr8uAHf8X/1CLpLzPovO/j1CNUZkIVs87K
         L7ReNBoPIsTvUEjNsCHkIzebb3Zd56gz+dpsbdzUoh0iXb9Ww6KJYlAlhSmFK8l8Xo
         UfhtRcLY+FC5rbXD7AjlCuGmGkl/7zAcih69xlS6/55MqontUN7p2sbImVLbYoT/Cl
         uF61TMJYfCwmy9BYgqV/5Rc8qojQ8qAtOWD3MJKfHIz7XQrfCb/nIcVT7N7ducOM8F
         i98Z+d2LvOglzlBcmR2kb2tp1oqawoJGDFuJzCt5T8KvR2GE+Ts
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/14] t9168: make test hash independent
Date:   Mon, 22 Jun 2020 18:04:06 +0000
Message-Id: <20200622180418.2418483-3-sandals@crustytoothpaste.net>
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
 t/t9168-git-svn-partially-globbed-names.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
index bdf6e84999..854b3419b2 100755
--- a/t/t9168-git-svn-partially-globbed-names.sh
+++ b/t/t9168-git-svn-partially-globbed-names.sh
@@ -49,7 +49,7 @@ test_expect_success 'test refspec prefixed globbing' '
 			 "tags/t_*/src/a:refs/remotes/tags/t_*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/t_end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.end &&
+	cut -d" " -f2- actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/t_end~1)" = \
 		"$(git rev-parse refs/remotes/branches/b_start)" &&
@@ -87,7 +87,7 @@ test_expect_success 'test left-hand-side only prefixed globbing' '
 	test $(git rev-parse refs/remotes/two/tags/t_end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/b_start) &&
 	git log --pretty=oneline refs/remotes/two/tags/t_end >actual &&
-	sed -e "s/^.\{41\}//" actual >output.two &&
+	cut -d" " -f2- actual >output.two &&
 	test_cmp expect.two output.two
 	'
 
@@ -129,7 +129,7 @@ test_expect_success 'test prefixed globs match just prefix' '
 	test $(git rev-parse refs/remotes/three/tags/t_~1) = \
 	     $(git rev-parse refs/remotes/three/branches/b_) &&
 	git log --pretty=oneline refs/remotes/three/tags/t_ >actual &&
-	sed -e "s/^.\{41\}//" actual >output.three &&
+	cut -d" " -f2- actual >output.three &&
 	test_cmp expect.three output.three
 	'
 
@@ -199,7 +199,7 @@ test_expect_success 'test globbing in the middle of the word' '
 	test $(git rev-parse refs/remotes/five/tags/fghij~1) = \
 	     $(git rev-parse refs/remotes/five/branches/abcde) &&
 	git log --pretty=oneline refs/remotes/five/tags/fghij >actual &&
-	sed -e "s/^.\{41\}//" actual >output.five &&
+	cut -d" " -f2- actual >output.five &&
 	test_cmp expect.five output.five
 	'
 
