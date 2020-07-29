Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124C8C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9478207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y1KTWjBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgG2XOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:14:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbgG2XOw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:14:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DEB6760CF7;
        Wed, 29 Jul 2020 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064491;
        bh=eIQvm60Oj7JsGGMhk9Joi/xuIDtV9T/uP4vMss0aCBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=y1KTWjBJlu9agytFd0omZlJ8wDsmpbGa+Ji/QcSqo+1W/lk5ia7khqSqad4OtrvrW
         +3S/+wUHiobYPu2sCP4p+zepMh5CAy7qvTyESf328TBs4JM5H9GsvCTfzsMBM+2K+p
         QVXBnmFUTuO6o+iMmQ+b3o9TonaBpVevygrCirFPcEq2VwC2yLGSukkp8K7ki0MZII
         aIo3HXYN/4jfubpEwiIr28f6KLrrHrjdmnm3+a+rnlEeIqKP/dHFUzFljfoaryLHNO
         aXzV+wSlEjRGzykPCRB+WWeuqeOp/7bEWT7Jy77vuI1HjCCqgQlJV5pkFFFQCBoMad
         +ZVFjqp6hyafYNdtCzoQ/dYP2+66jJY2PafLjjzthzla4n3XMP1eRnD+UFiZFfWMni
         G5M2OwxoSJK/AFwXcL5+991ZSdptyLJ+mc0GaoRtbu3bZvrFXRAKwIN3ULU6Ds9NLf
         lcqNKBHnmw/nMHgOUYktd4PaxQGIHbsvw4IUmar1HO8CN0afT+N
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 11/39] t7063: make hash size independent
Date:   Wed, 29 Jul 2020 23:14:00 +0000
Message-Id: <20200729231428.3658647-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_oid instead of hard-coding algorithm-specific constants and
all-zero values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7063-status-untracked-cache.sh | 150 ++++++++++++++++--------------
 1 file changed, 80 insertions(+), 70 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 428cff9cf3..a682a3d826 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -75,14 +75,24 @@ test_expect_success 'setup' '
 	touch one two three done/one dtwo/two dthree/three &&
 	git add one two done/one &&
 	: >.git/info/exclude &&
-	git update-index --untracked-cache
+	git update-index --untracked-cache &&
+	test_oid_cache <<-EOF
+	root sha1:e6fcc8f2ee31bae321d66afd183fcb7237afae6e
+	root sha256:b90c672088c015b9c83876e919da311bad4cd39639fb139f988af6a11493b974
+
+	exclude sha1:13263c0978fb9fad16b2d580fb800b6d811c3ff0
+	exclude sha256:fe4aaa1bbbbce4cb8f73426748a14c5ad6026b26f90505a0bf2494b165a5b76c
+
+	done sha1:1946f0437f90c5005533cbe1736a6451ca301714
+	done sha256:7f079501d79f665b3acc50f5e0e9e94509084d5032ac20113a37dd5029b757cc
+	EOF
 '
 
 test_expect_success 'untracked cache is empty' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect-empty <<EOF &&
-info/exclude 0000000000000000000000000000000000000000
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $ZERO_OID
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
 EOF
@@ -100,17 +110,17 @@ EOF
 
 cat >../dump.expect <<EOF &&
 info/exclude $EMPTY_BLOB
-core.excludesfile 0000000000000000000000000000000000000000
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ 0000000000000000000000000000000000000000 recurse valid
+/ $ZERO_OID recurse valid
 dthree/
 dtwo/
 three
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
 three
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 
@@ -190,18 +200,18 @@ test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude $EMPTY_BLOB
-core.excludesfile 0000000000000000000000000000000000000000
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ 0000000000000000000000000000000000000000 recurse valid
+/ $ZERO_OID recurse valid
 dthree/
 dtwo/
 four
 three
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
 three
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -239,18 +249,18 @@ test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
 info/exclude $EMPTY_BLOB
-core.excludesfile 0000000000000000000000000000000000000000
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dthree/
 dtwo/
 three
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
 three
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -284,16 +294,16 @@ EOF
 test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dtwo/
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -303,14 +313,14 @@ test_expect_success 'move two from tracked to untracked' '
 	git rm --cached two &&
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/ $(test_oid root) recurse
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -342,17 +352,17 @@ EOF
 test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dtwo/
 two
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -362,14 +372,14 @@ test_expect_success 'move two from untracked to tracked' '
 	git add two &&
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/ $(test_oid root) recurse
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -401,16 +411,16 @@ EOF
 test_expect_success 'verify untracked cache dump' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dtwo/
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -447,16 +457,16 @@ EOF
 test_expect_success 'untracked cache correct after commit' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dtwo/
-/done/ 0000000000000000000000000000000000000000 recurse valid
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/ $ZERO_OID recurse valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -508,17 +518,17 @@ EOF
 test_expect_success 'untracked cache correct after status' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dtwo/
-/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
+/done/ $(test_oid done) recurse valid
 five
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -580,22 +590,22 @@ EOF
 test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 	test-tool dump-untracked-cache >../actual &&
 	cat >../expect-from-test-dump <<EOF &&
-info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
-core.excludesfile 0000000000000000000000000000000000000000
+info/exclude $(test_oid exclude)
+core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
 flags 00000006
-/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+/ $(test_oid root) recurse valid
 .gitignore
 dtwo/
-/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
+/done/ $(test_oid done) recurse valid
 five
 sub/
-/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/sub/ $ZERO_OID recurse check_only valid
 sub/
-/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
+/done/sub/sub/ $ZERO_OID recurse check_only valid
 file
-/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
-/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dthree/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
 	test_cmp ../expect-from-test-dump ../actual
@@ -806,8 +816,8 @@ test_expect_success '"status" after file replacement should be clean with UC=tru
 	test-tool dump-untracked-cache >../actual &&
 	grep -F "recurse valid" ../actual >../actual.grep &&
 	cat >../expect.grep <<EOF &&
-/ 0000000000000000000000000000000000000000 recurse valid
-/two/ 0000000000000000000000000000000000000000 recurse valid
+/ $ZERO_OID recurse valid
+/two/ $ZERO_OID recurse valid
 EOF
 	status_is_clean &&
 	test_cmp ../expect.grep ../actual.grep
