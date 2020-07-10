Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2CC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CE120663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zUW1ta7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGJCst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40372 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbgGJCsm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A7AE760A62;
        Fri, 10 Jul 2020 02:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349313;
        bh=2Uk60eVF35Xko9Fm5hChI+Nwm1x48yRPe8IdOh07YRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zUW1ta7pvemU95agcNDlZP5qqoulshJICP5RrlPFtGTRmtlusPD93QijZfa4pJZkq
         VeDCSleEcMDTTTd0z8j/gdCyTp/YfqAsV7yGmWHi6G+Bj/QIDyI0U7dlmKd9EFuQGd
         AuUE93kLwMJWgJrPiw7LOjel81Fv7lulj2341yFyDoTC3RRv/AhZEQpm0BH0vz3+OV
         RhwWjMbv0KehumHEDQfJ6LFtdPQ9DZAGZghZaw2nNOIQURE/xDShfkT30rsOvs1nCu
         o1iN2wNb8DcQ+mlkTj0nakU1ASUKimc4CbN/l3CAuoOxoQVXFUhhvvWVCM+STX3YaD
         yW8HYjqi+57W8A7yir/fRdiPdSezepbN5UGp0vXaFHw8/G4d+puTOZKi/kDwJOkB1N
         lxiV4D51Je5raaPj0JxKAyoAI12CUGYx5diWL0E4qaNvpbKM0xn7Fsjs0gd6sjG8xb
         buUraRtTx1CC+XlZ8U9bGL5Nq7MTsiVFv9QH6guoEB3hYxDRVdW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 23/38] t9301: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:13 +0000
Message-Id: <20200710024728.3100527-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a hard-coded all-zeros object ID, use $ZERO_OID.
Compute the length of the object IDs in use and use this instead of
hard-coding the constant 40.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9301-fast-import-notes.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index ca223dca98..9d1aaac980 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -71,7 +71,7 @@ EOF
 INPUT_END
 
 test_expect_success 'set up master branch' '
-
+	test_oid_init &&
 	git fast-import <input &&
 	git whatchanged master
 '
@@ -470,12 +470,13 @@ test_expect_success 'add lots of commits and notes' '
 '
 
 test_expect_success 'verify that lots of notes trigger a fanout scheme' '
+	hexsz=$(test_oid hexsz) &&
 
 	# None of the entries in the top-level notes tree should be a full SHA1
 	git ls-tree --name-only refs/notes/many_notes |
 	while read path
 	do
-		if test $(expr length "$path") -ge 40
+		if test $(expr length "$path") -ge $hexsz
 		then
 			return 1
 		fi
@@ -518,7 +519,7 @@ test_expect_success 'verify that importing a notes tree respects the fanout sche
 	git ls-tree --name-only refs/notes/other_notes |
 	while read path
 	do
-		if test $(expr length "$path") -ge 40
+		if test $(expr length "$path") -ge $hexsz
 		then
 			return 1
 		fi
@@ -593,7 +594,7 @@ test_expect_success 'verify that changing notes respect existing fanout' '
 	git ls-tree --name-only refs/notes/many_notes |
 	while read path
 	do
-		if test $(expr length "$path") -ge 40
+		if test $(expr length "$path") -ge $hexsz
 		then
 			return 1
 		fi
@@ -616,7 +617,7 @@ i=$(($num_commits - $remaining_notes))
 for sha1 in $(git rev-list -n $i refs/heads/many_commits)
 do
 	cat >>input <<INPUT_END
-N 0000000000000000000000000000000000000000 $sha1
+N $ZERO_OID $sha1
 INPUT_END
 done
 
@@ -646,7 +647,6 @@ test_expect_success 'remove lots of notes' '
 '
 
 test_expect_success 'verify that removing notes trigger fanout consolidation' '
-
 	# All entries in the top-level notes tree should be a full SHA1
 	git ls-tree --name-only -r refs/notes/many_notes |
 	while read path
@@ -656,7 +656,7 @@ test_expect_success 'verify that removing notes trigger fanout consolidation' '
 		test "$path" = "deadbeef" && continue
 		test "$path" = "de/adbeef" && continue
 
-		if test $(expr length "$path") -ne 40
+		if test $(expr length "$path") -ne $hexsz
 		then
 			return 1
 		fi
