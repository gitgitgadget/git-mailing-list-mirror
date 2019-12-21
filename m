Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0B0C2D0D2
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAC1206EC
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K3ox0sID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLUTuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727367AbfLUTuL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2837C607F3;
        Sat, 21 Dec 2019 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957810;
        bh=Txhv7CT376l/OBmn3gPP51anoCBfITfStdPyM+moIV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=K3ox0sIDRJ70p4KIKETaIvWqZNuphc0zl3A6ls4hbi+vfvl2eu5gfGIwJmOiwRhC+
         ci1PwXWU0V0O0fAPqO3Kod/g+zIkwYKqzC7WjaOJFhMG0hoklDG7o4KwvtlSDDVnCa
         nPfwjDYmFEmEv/2m+ZMXOgb474N1v+W+JwABC+8tMZ/3cnvwVkvsKa3LidfIp6PCHs
         s1lomtZYikdSfBGslAjH9ShLfPJ6lbQHNjuSWsEaGPpwhjxa065GJ7R+qIbHQ9oNG9
         ++Wph/1N5ikouglSEoGHwX6TrNfzFki66Mo0ZJIf0EQfM0/MSMdoyn9ZBelFpj6GaW
         0kmN43txyHb2bosUsXKHC8vqBlzD5mMU1t0cvaI8ygHrnn8AJNjxO0E8eiEDvoCRM2
         RmCxsTHe37dj1WzUF2JqixivELVt62K3S9OPTqyKllSrzWihAfHgugSO0x3ybxQszN
         xX+4UmkEkcLijvn8Jk/D5GdYnM9XprxGBJMtOqBABvbI9hxkhXD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/20] t5319: make test work with SHA-256
Date:   Sat, 21 Dec 2019 19:49:26 +0000
Message-Id: <20191221194936.1346664-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test corrupts various locations in a multi-pack index to test
various error responses.  However, these offsets differ between SHA-1
indexes and SHA-256 indexes due to differences in object length.  Use
test_oid to look up the correct offsets based on the algorithm.
---
 t/t5319-multi-pack-index.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 464bb68e89..43a7a66c9d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -28,6 +28,20 @@ midx_read_expect () {
 	test_cmp expect actual
 }
 
+test_expect_success 'setup' '
+	test_oid_init &&
+	test_oid_cache <<-EOF
+	idxoff sha1:2999
+	idxoff sha256:3739
+
+	packnameoff sha1:652
+	packnameoff sha256:940
+
+	fanoutoff sha1:1
+	fanoutoff sha256:3
+	EOF
+'
+
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm -f pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
@@ -225,7 +239,7 @@ test_expect_success 'verify bad signature' '
 		"multi-pack-index signature"
 '
 
-HASH_LEN=20
+HASH_LEN=$(test_oid rawsz)
 NUM_OBJECTS=74
 MIDX_BYTE_VERSION=4
 MIDX_BYTE_OID_VERSION=5
@@ -238,9 +252,9 @@ MIDX_CHUNK_LOOKUP_WIDTH=12
 MIDX_OFFSET_PACKNAMES=$(($MIDX_HEADER_SIZE + \
 			 $MIDX_NUM_CHUNKS * $MIDX_CHUNK_LOOKUP_WIDTH))
 MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
-MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + 652))
+MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + $(test_oid packnameoff)))
 MIDX_OID_FANOUT_WIDTH=4
-MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + 1))
+MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + $(test_oid fanoutoff)))
 MIDX_OFFSET_OID_LOOKUP=$(($MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
 MIDX_BYTE_OID_LOOKUP=$(($MIDX_OFFSET_OID_LOOKUP + 16 * $HASH_LEN))
 MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
@@ -387,7 +401,7 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 	pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
 	idx64=objects64/pack/test-64-$pack64.idx &&
 	chmod u+w $idx64 &&
-	corrupt_data $idx64 2999 "\02" &&
+	corrupt_data $idx64 $(test_oid idxoff) "\02" &&
 	midx64=$(git multi-pack-index --object-dir=objects64 write) &&
 	midx_read_expect 1 63 5 objects64 " large-offsets"
 '
