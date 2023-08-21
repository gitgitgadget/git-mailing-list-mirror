Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C7FEE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjHUU0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHUU0M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:26:12 -0400
X-Greylist: delayed 1158 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 13:26:10 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [IPv6:2a01:4f8:10b:ddb::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF0101
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:26:10 -0700 (PDT)
Received: from leda.eworm.de (p54b794e3.dip0.t-ipconnect.de [84.183.148.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id A736122AE00;
        Mon, 21 Aug 2023 22:26:08 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 45C44181247; Mon, 21 Aug 2023 22:26:08 +0200 (CEST)
From:   Christian Hesse <list@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Hesse <mail@eworm.de>
Subject: [PATCH v2 1/1] t6300: fix match with insecure memory
Date:   Mon, 21 Aug 2023 22:25:36 +0200
Message-ID: <20230821202606.49067-1-list@eworm.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821222448.1524a5fc@leda.eworm.net>
References: <20230821222448.1524a5fc@leda.eworm.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

Running the tests in a build environment makes gnupg print a warning:

gpg: Warning: using insecure memory!

This warning breaks the match, as `head` misses one line. Let's strip
the line, make `head` return what is expected and fix the match.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 t/t6300-for-each-ref.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5b434ab451..0f9981798e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1764,12 +1764,13 @@ test_expect_success GPGSSH 'setup for signature atom using ssh' '
 
 test_expect_success GPG2 'bare signature atom' '
 	git verify-commit first-signed 2>out.raw &&
-	grep -Ev "checking the trustdb|PGP trust model" out.raw >out &&
+	grep -Ev "checking the trustdb|PGP trust model|using insecure memory" out.raw >out &&
 	head -3 out >expect &&
 	tail -1 out >>expect &&
 	echo  >>expect &&
 	git for-each-ref refs/tags/first-signed \
-		--format="%(signature)" >actual &&
+		--format="%(signature)" >out.raw &&
+	grep -Ev "using insecure memory" out.raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.41.0

