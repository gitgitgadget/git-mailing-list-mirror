Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA216C4345F
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6F42053B
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lq/fBvEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbgGWBK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40530 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387643AbgGWBK1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B18BF60CF6
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466595;
        bh=yISpjiYdNb20ay038vbmc40m1f3lZfeDdvoTNXqWBQM=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=lq/fBvEbEO40HMJH+Su6yLvci4qFK8IaedC+4+5CSyToE2/8eEQ/uZpa8WU6V05mc
         Cj7JpdqGq4I7MlCiO6JMIUdXob9X4W/1+R3bxS0QuuoVfzdtZKOcmLmmOQuSK0nx0k
         85tsteQrHrZ3ffxA+CoQ8sQqXl6ufpniVmtMGv1enLPCcxELQTUE7WsrgHVhEFsxxT
         ExRNI64aBCByENNlNgnrcfkxcfUgLv9FMR8i72lklYSVA+tCV0qE3v0vjBMlLkMBcW
         EMsRxCTFTykQ7+DVPrNvLGYO/qgAfcoRW7wvl8aCjjIFSL+hjJzVpyHs7/uE+wbzPG
         iUdi6eOA4UozQN30iJnnFjlzPmYtMP4q7EIWm/2xf2VhB1Ki8RhfSe+iT0UdVOV8Ml
         HD90irNOHqRRC6YET0ogi1QNIayD6+0X1reJgAwvxwi+GAjSJFnVXe+ObHQBl5s6ZX
         y06NKZSrgkuyBNU1yDMaoGpjQQ0LzgiAAHESjy6fj8KPXRKEYei
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 12/39] t7201: abstract away SHA-1-specific constants
Date:   Thu, 23 Jul 2020 01:09:16 +0000
Message-Id: <20200723010943.2329634-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
