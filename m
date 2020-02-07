Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4FC352A3
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C66214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="096D75dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBGAxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:35 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGAxf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:35 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBAD1607F0;
        Fri,  7 Feb 2020 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036813;
        bh=Z9U1zvLnfQogIDvg83Wg6XxuFe3EDwtyaQtub457np8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=096D75dMvs7mRb0xYsi31sYoCF3Xg+z3pNGoD0lSITuBoBEKMAG+ugPC8TWm8/1sO
         Ob52WsnPDMANRRynMlqnAdu3p78kr1Rx8mvZ5OT0LkXB9gZlk6lnAR/mwaa34X4D+t
         iefAO5NLs/i5onBMHxE1xdZtEr6VIz1jJC8+zNan+ATzNk2tvyILHYSdbbFdyO4H/P
         FdUn+aD8DcKSoEiObFd5nhWkiYk9U8SvOB9JWzUKsZFEB3KpBRQrjdrRnFC3TQWVTl
         HPDU5o0qjYIa9/I+3C5X8kyUq3Py/MfoWo9ZCksiUWpLOeSKL3uPSZqkTbWs05kHkQ
         q2RcRT7OIYFwDkWflKpaUegnSnR7Hh+mSXomlcKm6KZIFd48azl2EbdsNOGA5gsuyd
         sqTjaskWl8Rq2M5LNSg1ycVNjFZLwR4TowapFEOAoEEnilTws+CZ/9QeBnK/xqakrD
         BllEFB8spAitp4+Qnd62KRs+Gs673OKzoiq3wzMI0TiuQBOaCTg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/21] t3308: make test work with SHA-256
Date:   Fri,  7 Feb 2020 00:52:36 +0000
Message-Id: <20200207005254.1495851-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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
 t/t3308-notes-merge.sh | 83 ++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index d60588ec8f..790e292966 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -20,7 +20,34 @@ test_expect_success setup '
 	git notes add -m "Notes on 3rd commit" 3rd &&
 	git notes add -m "Notes on 4th commit" 4th &&
 	# Copy notes to remote-notes
-	git fetch . refs/notes/*:refs/remote-notes/origin/*
+	git fetch . refs/notes/*:refs/remote-notes/origin/* &&
+
+	test_oid_init &&
+	test_oid_cache <<-EOF
+	hash4a sha1:5e93d24084d32e1cb61f7070505b9d2530cca987
+	hash3a sha1:8366731eeee53787d2bdf8fc1eff7d94757e8da0
+	hash2a sha1:eede89064cd42441590d6afec6c37b321ada3389
+	hash1a sha1:daa55ffad6cb99bf64226532147ffcaf5ce8bdd1
+	hash5b sha1:0f2efbd00262f2fd41dfae33df8765618eeacd99
+	hash4b sha1:dec2502dac3ea161543f71930044deff93fa945c
+	hash3b sha1:4069cdb399fd45463ec6eef8e051a16a03592d91
+	hash2c sha1:d000d30e6ddcfce3a8122c403226a2ce2fd04d9d
+	hash1c sha1:43add6bd0c8c0bc871ac7991e0f5573cfba27804
+	hash4d sha1:1f257a3a90328557c452f0817d6cc50c89d315d4
+	hash3d sha1:05a4927951bcef347f51486575b878b2b60137f2
+
+	hash4a sha256:eef876be1d32ac2e2e42240e0429325cec116e55e88cb2969899fac695aa762f
+	hash3a sha256:cf7cd1bc091d7ba4166a86df864110e42087cd893a5ae96bc50d637e0290939d
+	hash2a sha256:21ddde7ebce2c285213898cb04deca0fd3209610cf7aaf8222e4e2f45262fae2
+	hash1a sha256:f9fe0eda16c6027732ed9d4295689a03abd16f893be69b3dcbf4037ddb191921
+	hash5b sha256:20046f2244577797a9e3d3f790ea9eca4d8a6bafb2a5570bcb0e03aa02ce100b
+	hash4b sha256:f90563d134c61a95bb88afbd45d48ccc9e919c62aa6fbfcd483302b3e4d8dbcb
+	hash3b sha256:988f2aca9f2d87e93e6a73197c2bb99560cc44a2f92d18653968f956f01221e0
+	hash2c sha256:84153b777b4d42827a756c6578dcdb59d8ae5d1360b874fb37c430150c825c26
+	hash1c sha256:9beb2bc4eef72e4c4087be168a20573e34d993d9ab1883055f23e322afa06567
+	hash4d sha256:32de39dc06e679a7abb2d4a55ede7709b3124340a4a90aa305971b1c72ac319d
+	hash3d sha256:fa73b20e41cbb7541c4c81d1535016131dbfbeb05bf6a71f6115e9cad31c7af5
+	EOF
 '
 
 commit_sha1=$(git rev-parse 1st^{commit})
@@ -40,10 +67,10 @@ verify_notes () {
 }
 
 cat <<EOF | sort >expect_notes_x
-5e93d24084d32e1cb61f7070505b9d2530cca987 $commit_sha4
-8366731eeee53787d2bdf8fc1eff7d94757e8da0 $commit_sha3
-eede89064cd42441590d6afec6c37b321ada3389 $commit_sha2
-daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 $commit_sha1
+$(test_oid hash4a) $commit_sha4
+$(test_oid hash3a) $commit_sha3
+$(test_oid hash2a) $commit_sha2
+$(test_oid hash1a) $commit_sha1
 EOF
 
 cat >expect_log_x <<EOF
@@ -126,10 +153,10 @@ test_expect_success 'merge previous notes commit (y^ => y) => No-op' '
 '
 
 cat <<EOF | sort >expect_notes_y
-0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
-dec2502dac3ea161543f71930044deff93fa945c $commit_sha4
-4069cdb399fd45463ec6eef8e051a16a03592d91 $commit_sha3
-daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 $commit_sha1
+$(test_oid hash5b) $commit_sha5
+$(test_oid hash4b) $commit_sha4
+$(test_oid hash3b) $commit_sha3
+$(test_oid hash1a) $commit_sha1
 EOF
 
 cat >expect_log_y <<EOF
@@ -193,11 +220,11 @@ test_expect_success 'merge empty notes ref (z => y)' '
 '
 
 cat <<EOF | sort >expect_notes_y
-0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
-dec2502dac3ea161543f71930044deff93fa945c $commit_sha4
-4069cdb399fd45463ec6eef8e051a16a03592d91 $commit_sha3
-d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
-43add6bd0c8c0bc871ac7991e0f5573cfba27804 $commit_sha1
+$(test_oid hash5b) $commit_sha5
+$(test_oid hash4b) $commit_sha4
+$(test_oid hash3b) $commit_sha3
+$(test_oid hash2c) $commit_sha2
+$(test_oid hash1c) $commit_sha1
 EOF
 
 cat >expect_log_y <<EOF
@@ -231,9 +258,9 @@ test_expect_success 'change notes on other notes ref (y)' '
 '
 
 cat <<EOF | sort >expect_notes_x
-0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
-1f257a3a90328557c452f0817d6cc50c89d315d4 $commit_sha4
-daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 $commit_sha1
+$(test_oid hash5b) $commit_sha5
+$(test_oid hash4d) $commit_sha4
+$(test_oid hash1a) $commit_sha1
 EOF
 
 cat >expect_log_x <<EOF
@@ -262,10 +289,10 @@ test_expect_success 'change notes on notes ref (x)' '
 '
 
 cat <<EOF | sort >expect_notes_x
-0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
-1f257a3a90328557c452f0817d6cc50c89d315d4 $commit_sha4
-d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
-43add6bd0c8c0bc871ac7991e0f5573cfba27804 $commit_sha1
+$(test_oid hash5b) $commit_sha5
+$(test_oid hash4d) $commit_sha4
+$(test_oid hash2c) $commit_sha2
+$(test_oid hash1c) $commit_sha1
 EOF
 
 cat >expect_log_x <<EOF
@@ -296,8 +323,8 @@ test_expect_success 'merge y into x => Non-conflicting 3-way merge' '
 '
 
 cat <<EOF | sort >expect_notes_w
-05a4927951bcef347f51486575b878b2b60137f2 $commit_sha3
-d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
+$(test_oid hash3d) $commit_sha3
+$(test_oid hash2c) $commit_sha2
 EOF
 
 cat >expect_log_w <<EOF
@@ -326,11 +353,11 @@ test_expect_success 'create notes on new, separate notes ref (w)' '
 '
 
 cat <<EOF | sort >expect_notes_x
-0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
-1f257a3a90328557c452f0817d6cc50c89d315d4 $commit_sha4
-05a4927951bcef347f51486575b878b2b60137f2 $commit_sha3
-d000d30e6ddcfce3a8122c403226a2ce2fd04d9d $commit_sha2
-43add6bd0c8c0bc871ac7991e0f5573cfba27804 $commit_sha1
+$(test_oid hash5b) $commit_sha5
+$(test_oid hash4d) $commit_sha4
+$(test_oid hash3d) $commit_sha3
+$(test_oid hash2c) $commit_sha2
+$(test_oid hash1c) $commit_sha1
 EOF
 
 cat >expect_log_x <<EOF
