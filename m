Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6DAC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA8120838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qJFeIUhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBGAxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55534 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbgBGAxg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6143E607F1;
        Fri,  7 Feb 2020 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036813;
        bh=79/n1YAIotuv5jj6iSCqMtjPRSQQePp3bN9xE4fha1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qJFeIUhsDbxPrqBs+HgtOQZ7jT/oalGHl6NgtZusMHw2eetyJjFpZgD+S97ks0bEi
         x6m2H3kLSQt+MAB4IEFLMZaHBkVW7rT56eEJSYMJcLWGmBzOHkIc8tgkMm+X6DfW5x
         ohaFRLsPLFAJzvM6Xc+No3Bg/KGe9LDZEfMK5S0Jvllj32h+Cl9UeHrJQ+NiAga9At
         qC8HsOZ3X2HeVQHTlceHgHD/TjEFPAr67JrElaL92/0tWpDE18XkJTRMuAE5VNC0Vk
         DGRqTYt/BAigEYZBD1HDyOnKH8GDIBDnI+boOHzsbGZQooQdZrFRk8+uc/nhwXQEMt
         QCiTgQe7xgXy8LXBSKEqNgLnBvxkp6cRyeu2eNXN0oLoiMgw6k923NvEPKAcCExrP6
         LvqS8r1ziKEslgEsD6AvW/gcSs0xRKp55wi3IqciCCQphuxrBxb0VcvBZ5eIsTPFEd
         vD5G2lR+RTYDBNG/El6T3X4Wq02IZgGAtZzXWJifR5hmJtI+YHL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/21] t3309: make test work with SHA-256
Date:   Fri,  7 Feb 2020 00:52:37 +0000
Message-Id: <20200207005254.1495851-5-sandals@crustytoothpaste.net>
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
 t/t3309-notes-merge-auto-resolve.sh | 228 ++++++++++++++++++----------
 1 file changed, 144 insertions(+), 84 deletions(-)

diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index 14c2adf970..141d3e4ca4 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -23,7 +23,67 @@ test_expect_success 'setup commits' '
 	test_commit 12th &&
 	test_commit 13th &&
 	test_commit 14th &&
-	test_commit 15th
+	test_commit 15th &&
+
+	test_oid_cache <<-EOF
+	hash15a sha1:457a85d6c814ea208550f15fcc48f804ac8dc023
+	hash14a sha1:b0c95b954301d69da2bc3723f4cb1680d355937c
+	hash13a sha1:5d30216a129eeffa97d9694ffe8c74317a560315
+	hash12a sha1:dd161bc149470fd890dd4ab52a4cbd79bbd18c36
+	hash11a sha1:7abbc45126d680336fb24294f013a7cdfa3ed545
+	hash10a sha1:b8d03e173f67f6505a76f6e00cf93440200dd9be
+	hash09a sha1:20c613c835011c48a5abe29170a2402ca6354910
+	hash08a sha1:a3daf8a1e4e5dc3409a303ad8481d57bfea7f5d6
+	hash07a sha1:897003322b53bc6ca098e9324ee508362347e734
+	hash06a sha1:11d97fdebfa5ceee540a3da07bce6fa0222bc082
+	hash15b sha1:68b8630d25516028bed862719855b3d6768d7833
+	hash14b sha1:5de7ea7ad4f47e7ff91989fb82234634730f75df
+	hash13b sha1:3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc
+	hash12b sha1:a66055fa82f7a03fe0c02a6aba3287a85abf7c62
+	hash05b sha1:154508c7a0bcad82b6fe4b472bc4c26b3bf0825b
+	hash04b sha1:e2bfd06a37dd2031684a59a6e2b033e212239c78
+	hash03b sha1:5772f42408c0dd6f097a7ca2d24de0e78d1c46b1
+	hash15c sha1:9b4b2c61f0615412da3c10f98ff85b57c04ec765
+	hash11c sha1:7e3c53503a3db8dd996cb62e37c66e070b44b54d
+	hash08c sha1:851e1638784a884c7dd26c5d41f3340f6387413a
+	hash05c sha1:99fc34adfc400b95c67b013115e37e31aa9a6d23
+	hash02c sha1:283b48219aee9a4105f6cab337e789065c82c2b9
+	hash15d sha1:7c4e546efd0fe939f876beb262ece02797880b54
+	hash05d sha1:6c841cc36ea496027290967ca96bd2bef54dbb47
+	hash15e sha1:d682107b8bf7a7aea1e537a8d5cb6a12b60135f1
+	hash05e sha1:357b6ca14c7afd59b7f8b8aaaa6b8b723771135b
+	hash15f sha1:6be90240b5f54594203e25d9f2f64b7567175aee
+	hash05f sha1:660311d7f78dc53db12ac373a43fca7465381a7e
+
+	hash15a sha256:45b1558e5c1b75f570010fa48aaa67bb2289fcd431b34ad81cb4c8b95f4f872a
+	hash14a sha256:6e7af179ea4dd28afdc83ae6912ba0098cdeff764b26a8b750b157dd81749092
+	hash13a sha256:7353089961baf555388e1bac68c67c8ea94b08ccbd97532201cf7f6790703052
+	hash12a sha256:5863e4521689ee1879ceab3b38d39e93ab5b51ec70aaf6a96ad388fbdedfa25e
+	hash11a sha256:82a0ec0338b4ecf8b44304badf4ad38d7469dc41827f38d7ba6c42e3bae3ee98
+	hash10a sha256:e84f2564e92de9792c93b8d197262c735d7ccb1de6025cef8759af8f6c3308eb
+	hash09a sha256:4dd07764bcec696f195c0ea71ae89e174876403af1637e4642b8f4453fd23028
+	hash08a sha256:02132c4546cd88a1d0aa5854dd55da120927f7904ba16afe36fe03e91a622067
+	hash07a sha256:369baf7d00c6720efdc10273493555f943051f84a4706fb24caeb353fa4789db
+	hash06a sha256:52d32c10353583b2d96a5849b1f1f43c8018e76f3e8ef1b0d46eb5cff7cdefaf
+	hash15b sha256:345e6660b345fa174738a31a7a59423c394bdf414804e200bc510c65d971ae96
+	hash14b sha256:7653a6596021c52e405cba979eea15a729993e7102b9a61ba4667e34f0ead4a1
+	hash13b sha256:0f202a0b6b9690de2349c173dfd766a37e82744f61c14f1c389306f1d69f470b
+	hash12b sha256:eb00f219c026136ea6535b16ff8ec3efa510e6bf50098ca041e1a2a1d4b79840
+	hash05b sha256:993b2290cd0c24c27c849d99f1904f3b590f77af0f539932734ad05679ac5a2f
+	hash04b sha256:c7fba0d6104917fbf35258f40b9fa4fc697cfa992deecd1570a3b08d0a5587a9
+	hash03b sha256:7287a2d78a3766c181b08df38951d784b08b72a44f571ed6d855bd0be22c70f6
+	hash15c sha256:62316660a22bf97857dc4a16709ec4d93a224e8c9f37d661ef91751e1f4c4166
+	hash11c sha256:51c3763de9b08309370adc5036d58debb331980e73097902957c444602551daa
+	hash08c sha256:22cf1fa29599898a7218c51135d66ed85d22aad584f77db3305dedce4c3d4798
+	hash05c sha256:2508fd86db980f0508893a1c1571bdf3b2ee113dc25ddb1a3a2fb94bd6cd0d58
+	hash02c sha256:63bb527e0b4e1c8e1dd0d54dd778ca7c3718689fd6e37c473044cfbcf1cacfdb
+	hash15d sha256:667acb4e2d5f8df15e5aea4506dfd16d25bc7feca70fdb0d965a7222f983bb88
+	hash05d sha256:09e6b5a6fe666c4a027674b6611a254b7d2528cd211c6b5288d1b4db6c741dfa
+	hash15e sha256:e8cbf52f6fcadc6de3c7761e64a89e9fe38d19a03d3e28ef6ca8596d93fc4f3a
+	hash05e sha256:cdb1e19f7ba1539f95af51a57edeb88a7ecc97d3c2f52da8c4c86af308595607
+	hash15f sha256:29c14cb92da448a923963b8a43994268b19c2e57913de73f3667421fd2c0eeec
+	hash05f sha256:14a6e641b2c0a9f398ebac6b4d34afa5efea4c52d2631382f45f8f662266903b
+	EOF
 '
 
 commit_sha1=$(git rev-parse 1st^{commit})
@@ -68,16 +128,16 @@ test_expect_success 'setup merge base (x)' '
 '
 
 cat <<EOF | sort >expect_notes_x
-457a85d6c814ea208550f15fcc48f804ac8dc023 $commit_sha15
-b0c95b954301d69da2bc3723f4cb1680d355937c $commit_sha14
-5d30216a129eeffa97d9694ffe8c74317a560315 $commit_sha13
-dd161bc149470fd890dd4ab52a4cbd79bbd18c36 $commit_sha12
-7abbc45126d680336fb24294f013a7cdfa3ed545 $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-20c613c835011c48a5abe29170a2402ca6354910 $commit_sha9
-a3daf8a1e4e5dc3409a303ad8481d57bfea7f5d6 $commit_sha8
-897003322b53bc6ca098e9324ee508362347e734 $commit_sha7
-11d97fdebfa5ceee540a3da07bce6fa0222bc082 $commit_sha6
+$(test_oid hash15a) $commit_sha15
+$(test_oid hash14a) $commit_sha14
+$(test_oid hash13a) $commit_sha13
+$(test_oid hash12a) $commit_sha12
+$(test_oid hash11a) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash09a) $commit_sha9
+$(test_oid hash08a) $commit_sha8
+$(test_oid hash07a) $commit_sha7
+$(test_oid hash06a) $commit_sha6
 EOF
 
 cat >expect_log_x <<EOF
@@ -141,16 +201,16 @@ test_expect_success 'setup local branch (y)' '
 '
 
 cat <<EOF | sort >expect_notes_y
-68b8630d25516028bed862719855b3d6768d7833 $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
-a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
-7abbc45126d680336fb24294f013a7cdfa3ed545 $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-20c613c835011c48a5abe29170a2402ca6354910 $commit_sha9
-154508c7a0bcad82b6fe4b472bc4c26b3bf0825b $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
+$(test_oid hash15b) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13b) $commit_sha13
+$(test_oid hash12b) $commit_sha12
+$(test_oid hash11a) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash09a) $commit_sha9
+$(test_oid hash05b) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
 EOF
 
 cat >expect_log_y <<EOF
@@ -214,16 +274,16 @@ test_expect_success 'setup remote branch (z)' '
 '
 
 cat <<EOF | sort >expect_notes_z
-9b4b2c61f0615412da3c10f98ff85b57c04ec765 $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-5d30216a129eeffa97d9694ffe8c74317a560315 $commit_sha13
-7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
-897003322b53bc6ca098e9324ee508362347e734 $commit_sha7
-99fc34adfc400b95c67b013115e37e31aa9a6d23 $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+$(test_oid hash15c) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13a) $commit_sha13
+$(test_oid hash11c) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash08c) $commit_sha8
+$(test_oid hash07a) $commit_sha7
+$(test_oid hash05c) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash02c) $commit_sha2
 EOF
 
 cat >expect_log_z <<EOF
@@ -306,16 +366,16 @@ test_expect_success 'merge z into y with invalid configuration option => Fail/No
 '
 
 cat <<EOF | sort >expect_notes_ours
-68b8630d25516028bed862719855b3d6768d7833 $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
-a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
-7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-154508c7a0bcad82b6fe4b472bc4c26b3bf0825b $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+$(test_oid hash15b) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13b) $commit_sha13
+$(test_oid hash12b) $commit_sha12
+$(test_oid hash11c) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash05b) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02c) $commit_sha2
 EOF
 
 cat >expect_log_ours <<EOF
@@ -395,16 +455,16 @@ test_expect_success 'reset to pre-merge state (y)' '
 '
 
 cat <<EOF | sort >expect_notes_theirs
-9b4b2c61f0615412da3c10f98ff85b57c04ec765 $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
-7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
-99fc34adfc400b95c67b013115e37e31aa9a6d23 $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+$(test_oid hash15c) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13b) $commit_sha13
+$(test_oid hash11c) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash08c) $commit_sha8
+$(test_oid hash05c) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02c) $commit_sha2
 EOF
 
 cat >expect_log_theirs <<EOF
@@ -473,17 +533,17 @@ test_expect_success 'reset to pre-merge state (y)' '
 '
 
 cat <<EOF | sort >expect_notes_union
-7c4e546efd0fe939f876beb262ece02797880b54 $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
-a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
-7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
-6c841cc36ea496027290967ca96bd2bef54dbb47 $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+$(test_oid hash15d) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13b) $commit_sha13
+$(test_oid hash12b) $commit_sha12
+$(test_oid hash11c) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash08c) $commit_sha8
+$(test_oid hash05d) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02c) $commit_sha2
 EOF
 
 cat >expect_log_union <<EOF
@@ -574,17 +634,17 @@ test_expect_success 'merge z into y with "manual" per-ref only checks specific r
 '
 
 cat <<EOF | sort >expect_notes_union2
-d682107b8bf7a7aea1e537a8d5cb6a12b60135f1 $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
-a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
-7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
-357b6ca14c7afd59b7f8b8aaaa6b8b723771135b $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+$(test_oid hash15e) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13b) $commit_sha13
+$(test_oid hash12b) $commit_sha12
+$(test_oid hash11c) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash08c) $commit_sha8
+$(test_oid hash05e) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02c) $commit_sha2
 EOF
 
 cat >expect_log_union2 <<EOF
@@ -648,17 +708,17 @@ test_expect_success 'reset to pre-merge state (z)' '
 '
 
 cat <<EOF | sort >expect_notes_cat_sort_uniq
-6be90240b5f54594203e25d9f2f64b7567175aee $commit_sha15
-5de7ea7ad4f47e7ff91989fb82234634730f75df $commit_sha14
-3a631fdb6f41b05b55d8f4baf20728ba8f6fccbc $commit_sha13
-a66055fa82f7a03fe0c02a6aba3287a85abf7c62 $commit_sha12
-7e3c53503a3db8dd996cb62e37c66e070b44b54d $commit_sha11
-b8d03e173f67f6505a76f6e00cf93440200dd9be $commit_sha10
-851e1638784a884c7dd26c5d41f3340f6387413a $commit_sha8
-660311d7f78dc53db12ac373a43fca7465381a7e $commit_sha5
-e2bfd06a37dd2031684a59a6e2b033e212239c78 $commit_sha4
-5772f42408c0dd6f097a7ca2d24de0e78d1c46b1 $commit_sha3
-283b48219aee9a4105f6cab337e789065c82c2b9 $commit_sha2
+$(test_oid hash15f) $commit_sha15
+$(test_oid hash14b) $commit_sha14
+$(test_oid hash13b) $commit_sha13
+$(test_oid hash12b) $commit_sha12
+$(test_oid hash11c) $commit_sha11
+$(test_oid hash10a) $commit_sha10
+$(test_oid hash08c) $commit_sha8
+$(test_oid hash05f) $commit_sha5
+$(test_oid hash04b) $commit_sha4
+$(test_oid hash03b) $commit_sha3
+$(test_oid hash02c) $commit_sha2
 EOF
 
 cat >expect_log_cat_sort_uniq <<EOF
