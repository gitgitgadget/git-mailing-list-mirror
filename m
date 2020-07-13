Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C1EC433EC
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BA9206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CEGcgzn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGMCti (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:38 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40618 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728118AbgGMCta (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 79A5F60A5C;
        Mon, 13 Jul 2020 02:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608568;
        bh=yISpjiYdNb20ay038vbmc40m1f3lZfeDdvoTNXqWBQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CEGcgzn/Y2q/dZG82VgQ696dB2e3KnAkWRKZiHdB4OdBTamEVrsI7coO7byyiJf7h
         2bfWM5cv2YdhKbW04sOSGs+K5D6ttmb6BPPMaIznwmqjTFqpiyuzcOgZ7I943FHXxB
         JB33NRQh1/rVEfr6pzqraYKhYxJQ9ju5IBpYfrORe/Wm2xddDpVr24QfTeNT3fN19d
         HpsK3Kn6Qs1GmkZIIOQ6Ru8nErMFwmNX3oSCAfy4xSiIgGr7xUzupPxq2fnYP7wI/9
         Sagh9qOwSFMmbK4Rkwe67CtnIxkryu4DJ8N2IP3WalujHlL7HelOwuOJ8fPYurTuqC
         xuGwUMkCg8jwcI8s3mvwpxNb2IvaaBEA0mp2XsRqlo4j0K7idklGiXDH0OByS5GBDw
         bW9Tk2F0RUNMHzfOBngbG4wpS6mtVjyc5HFHYCykblq0d9AFAzr47sbh4/P7UDJMX8
         k1/1yQOe1W4dFLy7JCCZbzjGvJmcY3RE1zed9v1SuW5ftzUQnp2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 12/39] t7201: abstract away SHA-1-specific constants
Date:   Mon, 13 Jul 2020 02:48:42 +0000
Message-Id: <20200713024909.3714837-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
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
