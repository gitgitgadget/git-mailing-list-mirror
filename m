Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1891C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68672080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CK6dBcl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgGWBJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:09:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729401AbgGWBJx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:53 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 440D2609CF
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466592;
        bh=OgCPGLxbLEhOK6+oRjiyLc+hvZl35cGnjxku2gGi4NE=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=CK6dBcl++hKxvhDfiOSOXPcLIMOMgkjgW2uzcGwHD6SpaUc/6f1Y9qPo0/fubfkGw
         HpI7mjn47jYcHdv+av6LvfSAnyaKExLWtXUAIAgPlhneTfIdFVhfBLZYVIfMqkgmgt
         CzdIn83Xqxf+IQzg9O3wj8QngOjV7UcKfmxWRLI6EHiW1B7+jfpw8TAASlHJgiiumE
         egjWFxA3fZqF09Jz1UyBCldP3LEfVb7LpC25mRe73uzm9XWMG5xWDLB9zGanjpAMoX
         AOv1EKM3uz1ouBsbPvq2ZcZiHa4sqV3yANzxa71i5Ikmjhc7cn53HsOLZoQBezmZ6z
         g14RmZ+AeTk9MxNrIQoQLATSjDqDbF8WNCscC5mc9y7Ud3e58hdUQYeKTfEFOVbqCx
         wBzbjwv3eO2BFjwtYgWd9QCIBRirWZlDNFnu9CAhwVPX7bW8+7kZugQsRT63tqDWi0
         zQ4vkJbTyO+RGuuBLHSRsAVITdX0yEx6QvfxOUu5YRPpnSYYzRc
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 03/39] t3305: make hash agnostic
Date:   Thu, 23 Jul 2020 01:09:07 +0000
Message-Id: <20200723010943.2329634-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When computing the fanout length, let's use test_oid to look up the
hexadecimal size of the hash in question instead of hard-coding a value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3305-notes-fanout.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 3b4753e1b4..d5a94b7174 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -7,7 +7,7 @@ test_description='Test that adding/removing many notes triggers automatic fanout
 path_has_fanout() {
 	path=$1 &&
 	fanout=$2 &&
-	after_last_slash=$((40 - $fanout * 2)) &&
+	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
 	echo $path | grep -q "^\([0-9a-f]\{2\}/\)\{$fanout\}[0-9a-f]\{$after_last_slash\}$"
 }
 
@@ -31,6 +31,7 @@ all_notes_have_fanout() {
 }
 
 test_expect_success 'tweak test environment' '
+	test_oid_init &&
 	git checkout -b nondeterminism &&
 	test_commit A &&
 	git checkout --orphan with_notes;
