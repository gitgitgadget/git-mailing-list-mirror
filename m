Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47207C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16242206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FA4Bp0QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLUTuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727416AbfLUTuP (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:15 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BF5F6607F6;
        Sat, 21 Dec 2019 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957813;
        bh=Lkm4f1zvcKX1E8taS2hvrebseUA1x4Fu8PyrMGBqHyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=FA4Bp0QYwxfNF0s/ijcTJNaXQbpHlRJw+vAutU5E8hved3w9lA0bRCknV7NlARk3C
         0qG97bZ9X/HrlFijGNBSda1tWAoY8DdPloHb2gCozQ9U3ytW62o7MmggjwuhnETs2L
         9iwZfuITdz2j6lX3+3WNJAYWLZIC7NRVKtQdbYBO4RCZUqmuN2zhOZibRAI4JLIs8S
         U/0U/lS85q45071FQ6BgmUQ3L57Ueti0MHxEmlPiXTXm7QhdZMDY37gENgFQDOKXy5
         v9dCc9+AxO6+I4Mmd8Qjrd0DmK7yiRsTYfj0HjiNKkzivC8prDSoRBg82F2ezFqTLE
         9y3dQNaOLNnOw1IG4+3FdaF9xJ+4gmpNx5KTN1BHX2TzTu7tylWcnQu2HJo6A/twCR
         qs8f+c7uFk6+EqWR33MNn+zqs8V3FQsQRCFYITs4KrBkDJmx8APvQejzdsZYI0r3+c
         DUo+n95ZHXBfg8dtKSyjUjUCRFBsALSXESTsRpNaxOLWGxp7DBn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/20] t5530: compute results based on object length
Date:   Sat, 21 Dec 2019 19:49:31 +0000
Message-Id: <20191221194936.1346664-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compute the various pkt-line values based on the length of the object
IDs in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5530-upload-pack-error.sh | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index a1d3031d40..4ce9a9f704 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -14,7 +14,7 @@ corrupt_repo () {
 }
 
 test_expect_success 'setup and corrupt repository' '
-
+	test_oid_init &&
 	echo file >file &&
 	git add file &&
 	git rev-parse :file &&
@@ -31,9 +31,10 @@ test_expect_success 'fsck fails' '
 '
 
 test_expect_success 'upload-pack fails due to error in pack-objects packing' '
-
-	printf "0032want %s\n00000009done\n0000" \
-		$(git rev-parse HEAD) >input &&
+	head=$(git rev-parse HEAD) &&
+	hexsz=$(test_oid hexsz) &&
+	printf "%04xwant %s\n00000009done\n0000" \
+		$(($hexsz + 10)) $head >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	test_i18ngrep "unable to read" output.err &&
 	test_i18ngrep "pack-objects died" output.err
@@ -51,16 +52,17 @@ test_expect_success 'fsck fails' '
 '
 test_expect_success 'upload-pack fails due to error in rev-list' '
 
-	printf "0032want %s\n0034shallow %s00000009done\n0000" \
-		$(git rev-parse HEAD) $(git rev-parse HEAD^) >input &&
+	printf "%04xwant %s\n%04xshallow %s00000009done\n0000" \
+		$(($hexsz + 10)) $(git rev-parse HEAD) \
+		$(($hexsz + 12)) $(git rev-parse HEAD^) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	grep "bad tree object" output.err
 '
 
 test_expect_success 'upload-pack fails due to bad want (no object)' '
 
-	printf "0045want %s multi_ack_detailed\n00000009done\n0000" \
-		"deadbeefdeadbeefdeadbeefdeadbeefdeadbeef" >input &&
+	printf "%04xwant %s multi_ack_detailed\n00000009done\n0000" \
+		$(($hexsz + 29)) $(test_oid deadbeef) >input &&
 	test_must_fail git upload-pack . <input >output 2>output.err &&
 	grep "not our ref" output.err &&
 	grep "ERR" output &&
@@ -70,8 +72,8 @@ test_expect_success 'upload-pack fails due to bad want (no object)' '
 test_expect_success 'upload-pack fails due to bad want (not tip)' '
 
 	oid=$(echo an object we have | git hash-object -w --stdin) &&
-	printf "0045want %s multi_ack_detailed\n00000009done\n0000" \
-		"$oid" >input &&
+	printf "%04xwant %s multi_ack_detailed\n00000009done\n0000" \
+		$(($hexsz + 29)) "$oid" >input &&
 	test_must_fail git upload-pack . <input >output 2>output.err &&
 	grep "not our ref" output.err &&
 	grep "ERR" output &&
@@ -80,8 +82,8 @@ test_expect_success 'upload-pack fails due to bad want (not tip)' '
 
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
 
-	printf "0032want %s\n00000009done\n0000" \
-		$(git rev-parse HEAD) >input &&
+	printf "%04xwant %s\n00000009done\n0000" \
+		$((hexsz + 10)) $(git rev-parse HEAD) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	grep "bad tree object" output.err &&
 	grep "pack-objects died" output.err
