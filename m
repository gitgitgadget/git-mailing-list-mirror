Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58048C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD91223BE
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 22:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="f8fDcRty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgFSWvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:51:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgFSWvf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 18:51:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D107660A62;
        Fri, 19 Jun 2020 22:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592607094;
        bh=CQU1uFJvbhgXo5lAz9npfF/EORtng3o9n9vqKrMBAIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=f8fDcRtySMMSBlfD8LUwCbdzfyIBsGfmXGJanY1jSGhb3qiGGlX4vYYXpxj9hIlxm
         LYgdUoTlt1GosUqglpR68inrJ4qY5qBLSTz9iIjPWADhJfsR1n9PvDGkD9SMDz+I7K
         AVM/xHDcp8d8WXL+t/XJ/b2rtebwwwkiPDCsE/tyrB/GINNX9PEoCgRI5HuCYUnFTe
         YpQwo4QTbKP2JNIsnuB66tARs0XNxfpqDPRUkwdMMguDVwU72a2eUoEDWZ+MSF88BL
         uwiye9M455OZ0itBdyLYhgM6dPF9eHEk23PEocgBDWg5GO8dMYlLipOUHk0UCc0wVC
         KU3/Ww0PmdYfYB+2YmtVnj5ut/WtCJ7wnNuvnIJA8h2Ij5G+gH3PvuJOF+oxu+/Pvd
         KWtOwGY8Q47+1tLJE1lnBC+v1yckrleotRJdXtSSlDpREjsR8pIVRvWDY3YSuVM60o
         DcqKD/YGlj+r8OrAg9fP0/yy/RyvR+jQKLVkQU9P/KlPasvhSkG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Matthew DeVore <matvore@google.com>, Eric Wong <e@80x24.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH 06/14] t9101: make hash independent
Date:   Fri, 19 Jun 2020 22:39:39 +0000
Message-Id: <20200619223947.947067-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619223947.947067-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the object ID for our test .gitignore file, let's
compute it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9101-git-svn-props.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index c26c4b0927..8b5681dd68 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -160,11 +160,13 @@ cat >create-ignore.expect <<\EOF
 /no-such-file*
 EOF
 
-cat >create-ignore-index.expect <<\EOF
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	.gitignore
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/.gitignore
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/nested/.gitignore
-100644 8c52e5dfcd0a8b6b6bcfe6b41b89bcbf493718a5 0	deeply/nested/directory/.gitignore
+expectoid=$(git hash-object create-ignore.expect)
+
+cat >create-ignore-index.expect <<EOF
+100644 $expectoid 0	.gitignore
+100644 $expectoid 0	deeply/.gitignore
+100644 $expectoid 0	deeply/nested/.gitignore
+100644 $expectoid 0	deeply/nested/directory/.gitignore
 EOF
 
 test_expect_success 'test create-ignore' "
