Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DBAC433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C73220809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tJS50CE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgG2XPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41152 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbgG2XPS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 30874607A2;
        Wed, 29 Jul 2020 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064487;
        bh=ZPoC5ssbhrXfBhfkPWrIH9XL3MN0grtVK0m1KwB5YGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tJS50CE+jAPzWBGIP1uOZnleDc/9Qwhw3y4EguFcEERkQVnyevGQ7f7NBQ6DO54jU
         fJPhARuPekMZBoUprussq4fR3KeKnwz+WJrRfF335lXRnNi9pisvv4xzSHKSv79ZFv
         C8gc57R4r4fqZ8I/FdxY/a2wdi5ApTRNtquz5+APC3NYrvuHuvMOExr4hxQ5BjstPb
         fVt3vQdZYWHq4mXokTf7Cq/VtEdjwcwITYOBNRcVlLHTWClWs6X7az4mQkV5ZZpioj
         3xKOuo1+vA8SNlPmLV0c9uMAM+CYDEbc4OwBuKVbaOOxBVnH1PyJET6OqIQSucBWOg
         7koD/Yg4yuBxibNJVo4P34XCMfoon3mcNS1qbznPQ+szICtEbDTp7YQuVkn0zL+3hx
         INcXxqkzmSBeT4/bhQ3MiHG7/fRt5Rgn3+IdPKdhqnI7ZspiHXcyYd6rzS9T6net+p
         qYs+W5fup4f7JFwhtMkbIw3Gik203c2VDNQp2pqs0BR3WdrCNRb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 03/39] t3305: make hash agnostic
Date:   Wed, 29 Jul 2020 23:13:52 +0000
Message-Id: <20200729231428.3658647-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
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
 t/t3305-notes-fanout.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 3b4753e1b4..94c1b02251 100755
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
 
