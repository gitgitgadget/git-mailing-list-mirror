Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B934CC35243
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C8C2071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UC3kSglX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgAYXAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46812 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgAYXAo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:44 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4972660FC2;
        Sat, 25 Jan 2020 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993243;
        bh=snn3ipitnVKnfdSmFkxVT2rdkSiMLOg8kWgB9I9O0cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UC3kSglXDfMXcr1mPH92CjaBfysJKoCuNSSprruT+nl2vinajab/Lcw+Q0qdUHaea
         X0C3Nv1i1l0k9WgYdRDDK9e0+jqVsmFbItWPFtts0DS5VW4TiLC1/w58Z70s/MaqFT
         q0AB74QRTbUPSnqW82fojP5R44NuU7spvZC92Twc1Dd0IpIqJQ07MTGPZbgq5QkkZr
         2CdHrJP+FQJ4fOtRQuAib30a9AcIgZdcbQ9F4AGgd5SMTtrA2frVJ9DumGh2RVZflW
         zFbRwzsR5GjHF8SDJFEsIlvRrDI8qbJsF+X5GeyiuZfl2EsiRZayLjC576M8vUC40M
         hLfNXOR1oPgT93v7R23TlD3NkRlj1Ac+bLILcTiQMXv86WjSlW/Z7Bl5yn+6V1fHOG
         3GUkitmHLKGDPvlb6/dpATwaofhySfub8wy+lXWPQYOSnz0tixKWf7bzAIBVKeZ2Kz
         Ypmu1ytMKmtCCHU0gcPq9Lq7ijJUYxnLF+/t3vP+z5DdxDpqR4c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/22] t3310: make test work with SHA-256
Date:   Sat, 25 Jan 2020 23:00:12 +0000
Message-Id: <20200125230035.136348-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the hard-coded SHA-1 constants with the use of test_oid to look
up an appropriate constant for each hash algorithm.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3310-notes-merge-manual-resolve.sh | 84 ++++++++++++++++++---------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 2dea846e25..806d812a17 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -13,7 +13,39 @@ test_expect_success 'setup commits' '
 	test_commit 2nd &&
 	test_commit 3rd &&
 	test_commit 4th &&
-	test_commit 5th
+	test_commit 5th &&
+
+	test_oid_cache <<-EOF
+	hash04a sha1:6e8e3febca3c2bb896704335cc4d0c34cb2f8715
+	hash03a sha1:e5388c10860456ee60673025345fe2e153eb8cf8
+	hash02a sha1:ceefa674873670e7ecd131814d909723cce2b669
+	hash04b sha1:e2bfd06a37dd2031684a59a6e2b033e212239c78
+	hash03b sha1:5772f42408c0dd6f097a7ca2d24de0e78d1c46b1
+	hash01b sha1:b0a6021ec006d07e80e9b20ec9b444cbd9d560d3
+	hash04c sha1:cff59c793c20bb49a4e01bc06fb06bad642e0d54
+	hash02c sha1:283b48219aee9a4105f6cab337e789065c82c2b9
+	hash01c sha1:0a81da8956346e19bcb27a906f04af327e03e31b
+	hash04d sha1:00494adecf2d9635a02fa431308d67993f853968
+	hash01e sha1:f75d1df88cbfe4258d49852f26cfc83f2ad4494b
+	hash04f sha1:021faa20e931fb48986ffc6282b4bb05553ac946
+	hash01f sha1:0a59e787e6d688aa6309e56e8c1b89431a0fc1c1
+	hash05g sha1:304dfb4325cf243025b9957486eb605a9b51c199
+
+	hash04a	sha256:f18a935e65866345098b3b754071dbf9f3aa3520eb27a7b036b278c5e2f1ed7e
+	hash03a	sha256:713035dc94067a64e5fa6e4e1821b7c3bde49a77c7cb3f80eaadefa1ca41b3d2
+	hash02a	sha256:f160a67e048b6fa75bec3952184154045076692cf5dccd3da21e3fd34b7a3f0f
+	hash04b sha256:c7fba0d6104917fbf35258f40b9fa4fc697cfa992deecd1570a3b08d0a5587a9
+	hash03b sha256:7287a2d78a3766c181b08df38951d784b08b72a44f571ed6d855bd0be22c70f6
+	hash01b sha256:da96cf778c15d0a2bb76f98b2a62f6c9c01730fa7030e8f08ef0191048e7d620
+	hash04c sha256:cb615d2def4b834d5f55b2351df97dc92bee4f5009d285201427f349081c8aca
+	hash02c sha256:63bb527e0b4e1c8e1dd0d54dd778ca7c3718689fd6e37c473044cfbcf1cacfdb
+	hash01c sha256:5b87237ac1fbae0246256fed9f9a1f077c4140fb7e6444925f8dbfa5ae406cd8
+	hash04d sha256:eeddc9f9f6cb3d6b39b861659853f10891dc373e0b6eecb09e03e39b6ce64714
+	hash01e sha256:108f521b1a74c2e6d0b52a4eda87e09162bf847f7d190cfce496ee1af0b29a5a
+	hash04f sha256:901acda0454502b3bbd281f130c419e6c8de78afcf72a8def8d45ad31462bce4
+	hash01f sha256:a2d99d1b8bf23c8af7d9d91368454adc110dfd5cc068a4cebb486ee8f5a1e16c
+	hash05g sha256:4fef015b01da8efe929a68e3bb9b8fbad81f53995f097befe8ebc93f12ab98ec
+	EOF
 '
 
 commit_sha1=$(git rev-parse 1st^{commit})
@@ -33,9 +65,9 @@ verify_notes () {
 }
 
 cat <<EOF | sort >expect_notes_x
-6e8e3febca3c2bb896704335cc4d0c34cb2f8715 $commit_sha4
-e5388c10860456ee60673025345fe2e153eb8cf8 $commit_sha3
-ceefa674873670e7ecd131814d909723cce2b669 $commit_sha2
+$(test_oid hash04a) $commit_sha4
+$(test_oid hash03a) $commit_sha3
+$(test_oid hash02a) $commit_sha2
 EOF
 
 cat >expect_log_x <<EOF
@@ -63,9 +95,9 @@ test_expect_success 'setup merge base (x)' '
 '
 
 cat <<EOF | sort >expect_notes_y
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-b0a6021ec006d07e80e9b20ec9b444cbd9d560d3 $commit_sha1
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash01b) $commit_sha1
 EOF
 
 cat >expect_log_y <<EOF
@@ -95,9 +127,9 @@ test_expect_success 'setup local branch (y)' '
 '
 
 cat <<EOF | sort >expect_notes_z
-cff59c793c20bb49a4e01bc06fb06bad642e0d54 $commit_sha4
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
-0a81da8956346e19bcb27a906f04af327e03e31b $commit_sha1
+$(test_oid hash04c) $commit_sha4
+$(test_oid hash02c) $commit_sha2
+$(test_oid hash01c) $commit_sha1
 EOF
 
 cat >expect_log_z <<EOF
@@ -193,9 +225,9 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 '
 
 cat <<EOF | sort >expect_notes_z
-00494adecf2d9635a02fa431308d67993f853968 $commit_sha4
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
-0a81da8956346e19bcb27a906f04af327e03e31b $commit_sha1
+$(test_oid hash04d) $commit_sha4
+$(test_oid hash02c) $commit_sha2
+$(test_oid hash01c) $commit_sha1
 EOF
 
 cat >expect_log_z <<EOF
@@ -231,8 +263,8 @@ test_expect_success 'cannot do merge w/conflicts when previous merge is unfinish
 # Setup non-conflicting merge between x and new notes ref w
 
 cat <<EOF | sort >expect_notes_w
-ceefa674873670e7ecd131814d909723cce2b669 $commit_sha2
-f75d1df88cbfe4258d49852f26cfc83f2ad4494b $commit_sha1
+$(test_oid hash02a) $commit_sha2
+$(test_oid hash01e) $commit_sha1
 EOF
 
 cat >expect_log_w <<EOF
@@ -258,10 +290,10 @@ test_expect_success 'setup unrelated notes ref (w)' '
 '
 
 cat <<EOF | sort >expect_notes_w
-6e8e3febca3c2bb896704335cc4d0c34cb2f8715 $commit_sha4
-e5388c10860456ee60673025345fe2e153eb8cf8 $commit_sha3
-ceefa674873670e7ecd131814d909723cce2b669 $commit_sha2
-f75d1df88cbfe4258d49852f26cfc83f2ad4494b $commit_sha1
+$(test_oid hash04a) $commit_sha4
+$(test_oid hash03a) $commit_sha3
+$(test_oid hash02a) $commit_sha2
+$(test_oid hash01e) $commit_sha1
 EOF
 
 cat >expect_log_w <<EOF
@@ -291,10 +323,10 @@ test_expect_success 'can do merge without conflicts even if previous merge is un
 '
 
 cat <<EOF | sort >expect_notes_m
-021faa20e931fb48986ffc6282b4bb05553ac946 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
-0a59e787e6d688aa6309e56e8c1b89431a0fc1c1 $commit_sha1
+$(test_oid hash04f) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02c) $commit_sha2
+$(test_oid hash01f) $commit_sha1
 EOF
 
 cat >expect_log_m <<EOF
@@ -430,9 +462,9 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 '
 
 cat <<EOF | sort >expect_notes_m
-304dfb4325cf243025b9957486eb605a9b51c199 $commit_sha5
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
-0a59e787e6d688aa6309e56e8c1b89431a0fc1c1 $commit_sha1
+$(test_oid hash05g) $commit_sha5
+$(test_oid hash02c) $commit_sha2
+$(test_oid hash01f) $commit_sha1
 EOF
 
 cat >expect_log_m <<EOF
