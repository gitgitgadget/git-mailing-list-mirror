Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D2C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62E72067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g9v/pPnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgG2XPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbgG2XPW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 53CE36100C;
        Wed, 29 Jul 2020 23:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064491;
        bh=zmmreqcVssM8fklRR8fjcy4ONQ0aizZ1+4lGjEODa9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g9v/pPnwoW+E9mXpApADVOidz0ddYYYiiUZrZuiT/za7oe8C6+mha/X//qIacpGGS
         iid5ptRlF2PIjeeFBo6sdAOt+FdzQNlVsqsXRPdeVbBweJtF1sxqpUV89v0Y6fHz37
         CaTynwWCRVbTAeO/3HrhqJOclfbotqMY19LkYt26Ap6ecup+Ro4xhc+YGzeoDHikhB
         9jeFv7WSMXYugNveOMJ1BZNOiHfD+2m6ZyqYyGZKcYwwZ3SbGSg57Ui7pM1WxGCn0F
         5NlN8X7c12LuBmFJaM96ZAj1IYoTjK6PMFaWXHMnerFw5X6VLiW42kllF91EI9diG0
         GSIx3uXnO9r3iegUUN8wfZODn/f4LODngxBtYDJypNI1+8LYVL0u6y1VM61jRV7Lw8
         t7Ab7ZWpnHWZaQ2dg9Ot6nafFmmluDNp/4Mokl2IMKqqgE6Mcmnp6RBK8ChVrch913
         GGgnLcwRTGoWWS26j7igl/gBekacg551pzRjZDFJ/Gfv/pqtYHJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 12/39] t7201: abstract away SHA-1-specific constants
Date:   Wed, 29 Jul 2020 23:14:01 +0000
Message-Id: <20200729231428.3658647-13-sandals@crustytoothpaste.net>
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

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7201-co.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b696bae5f5..4d62b9b00f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -230,9 +230,10 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
 	git config advice.detachedHead false &&
+	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at 7329388" messages &&
+	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -248,9 +249,10 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
+	rev=$(git rev-parse --short renamer^) &&
 	git checkout -f renamer && git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
-	grep "HEAD is now at 7329388" messages &&
+	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
