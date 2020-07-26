Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F0AC433F2
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A062065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vjI5swlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgGZTyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727898AbgGZTyu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 38C2F607A2;
        Sun, 26 Jul 2020 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793289;
        bh=RpVYnItus+HxXa/K46QzWilqF94JaaAdzDof62lZ1fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vjI5swlbf22BpC8zFYOMN8mYBfiztGHY+ATq9beegm5XzArRGUeOWRVRC4oyf4u02
         AgWYzUV2vM0k9cnIFo5goKBIg3hp616VdXwmZeiABOyWaMdy0EaOOKOYc7SeqM7JC1
         el2sZ0LoHfj7F9Vleie7U1QdtqNe9B1VxvGHpc+s/J2CjUebq6gmbHY9YCkMIRuKEp
         OqtU4t0EAaAVcqqVi2Jx8+MaK1JJHWSr+7LvW00BndhfLco6CvlGwuRgQ27io7Nv6m
         sESeB3la/bzFMoK0IHyFsN0ga8UwNnITEzuSOmmaiOL/lWaV/Xm0I+BXB7eN8Lg9Kp
         sz7MxlnRMrUcVUTye34PfivL1alxOxb4wLBkJnmbDDHXFG1pg902E543G3PpJ+j8kP
         QsENpcrTI/ICNBHUyKSAmBrYVwRatIxInnGYbrNh4O4N0JK9gXDzXEqdPh+UpGmUpx
         LJpvkkjVKL5hjtaK+A5FHRKZ65C5jDwzmaBDD/jZ9suuXmaVPRE
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 18/39] t8002: make hash size independent
Date:   Sun, 26 Jul 2020 19:54:03 +0000
Message-Id: <20200726195424.626969-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
