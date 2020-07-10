Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D1DC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA3F20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qUxEkH35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJCsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgGJCsa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D415A60A64;
        Fri, 10 Jul 2020 02:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349309;
        bh=yISpjiYdNb20ay038vbmc40m1f3lZfeDdvoTNXqWBQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qUxEkH3598JR+dOiZG1jURe8P4/seoUerTE1ZWd77RXkM49ypsOJlVckz+uEyfKKF
         PuI2xkeRV2tTTN3JrmfFuzsGmTHDF/8BjKoSAXQb9WWAyhoT/WajI7Qh+wChUVYWUa
         5kaG8iGcxTJWJQ0ZX7jh8xFVt5dSNXuu0TXXjbYWf3x+BYhNrIkNN2W28oWu+Imn+G
         zFtwD8jby5dqF6+vIqFz7jvxEPDwOoFTnfk5C4W36cMMj6yvBk6GDRX6mRPIheZyJA
         xdTT60sYwjhxAUz5Hb3kqvpYVHmmIePieMRbuGNVL8C680/60UyYSRY1AmypBG+X0x
         mYK7ciq3dAmUWhPyrQ0CEmaPBRro8pBAxLmgoZoilaey7gQcHj79wfwDvnyyobm6PN
         we2F1AKZeO8B5I5cPzPME0a5FhRz3BQheNmj6zPwbN8CCMBvY48QZ0hHcq6IZoehar
         kKiFMd4k0U3vBVqFszRgS+k6wd1ns+mem0vc4+CORdMG/afd2S9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 12/38] t7201: abstract away SHA-1-specific constants
Date:   Fri, 10 Jul 2020 02:47:02 +0000
Message-Id: <20200710024728.3100527-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
 t/t7201-co.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b696bae5f5..d4fd760915 100755
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
@@ -250,7 +251,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	git checkout -f renamer && git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
-	grep "HEAD is now at 7329388" messages &&
+	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
