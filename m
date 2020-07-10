Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6983EC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4892073A
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zpsjEKX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGJCsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40392 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbgGJCsf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CA3260A69;
        Fri, 10 Jul 2020 02:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349311;
        bh=RpVYnItus+HxXa/K46QzWilqF94JaaAdzDof62lZ1fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zpsjEKX8uJ8AyARAqOv3GWqGpkxttWHAEpLlO3OXH0TNOucQswF69H5hQ7mKhJ1ty
         kLu14KTIm/phSkO3w3AoOI7WTeHFb3hb+suj0ObKTXqBgYxyjfxSDLfIOrCh3iQmFp
         wKkvpQxITiXYfmb504IeOd3+7u5m+TQzQzAPCzRnzAEZzIClqLY3Cc1+3KiNbq7KcZ
         BEVcJ60FD+Vtb++rvdq7plyJdHEl/T/F34b4en+Ed/eIVd1uzz59qxBMtYIupN49Sh
         D5Q+XKSAX7aCmD0DADtbzS75+4GYD22TfD47ghAXshattys0XbdK7fMZ+4sRnjausv
         n3tAuvFtqU1P/U3leOg7tvbSPzHkB8LTy3KLxcXV6jg2gVsTXb5dnZLmcbl/Jln2Kl
         QPe5BSaW23DUcigUfMverLxGQHrh65L6mqqma1Z/0mYMbydSW5KhuP8m0Cf+HZ59FD
         uNuM/LqL/sbAxKASrN7wF/T4l57qrtnhw2+BmNlRjpXJuXDUMa9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 18/38] t8002: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:08 +0000
Message-Id: <20200710024728.3100527-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the length of an object ID instead of of hard-coding 40-based
values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8002-blame.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index eea048e52c..557c886559 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -6,6 +6,10 @@ test_description='git blame'
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
+test_expect_success 'setup' '
+	test_oid_init
+'
+
 test_expect_success 'blame untracked file in empty repo' '
 	>untracked &&
 	test_must_fail git blame untracked
@@ -105,17 +109,18 @@ test_expect_success 'blame --abbrev=<n> works' '
 '
 
 test_expect_success 'blame -l aligns regular and boundary commits' '
-	check_abbrev 40 -l HEAD &&
-	check_abbrev 39 -l ^HEAD
+	hexsz=$(test_oid hexsz) &&
+	check_abbrev $hexsz         -l HEAD &&
+	check_abbrev $((hexsz - 1)) -l ^HEAD
 '
 
-test_expect_success 'blame --abbrev=40 behaves like -l' '
-	check_abbrev 40 --abbrev=40 HEAD &&
-	check_abbrev 39 --abbrev=40 ^HEAD
+test_expect_success 'blame --abbrev with full length behaves like -l' '
+	check_abbrev $hexsz         --abbrev=$hexsz HEAD &&
+	check_abbrev $((hexsz - 1)) --abbrev=$hexsz ^HEAD
 '
 
-test_expect_success '--no-abbrev works like --abbrev=40' '
-	check_abbrev 40 --no-abbrev
+test_expect_success '--no-abbrev works like --abbrev with full length' '
+	check_abbrev $hexsz --no-abbrev
 '
 
 test_expect_success '--exclude-promisor-objects does not BUG-crash' '
