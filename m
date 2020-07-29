Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34417C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7342067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="G1nfU9JH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgG2XPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41172 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbgG2XPd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 08C8E61022;
        Wed, 29 Jul 2020 23:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064501;
        bh=mi0KGAza1eIU6SWvF9PqV2wgYiq8RLiR97VENOj3NVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=G1nfU9JHjjwcLJFViHRxDvAoh8gHCy/XtjosBv6M9szVq8J+FGtJ7ADtBkh+rt1cK
         aogEUjYAuwSBHfAgSzdFTvQN79ZvctzwHAmYmHRjMUaybM6+44/Qbpv8x8hexamOCj
         OWB/9StTpDtPYwlFLuXugBjijSIs+nOcbaImeeNeN54U4DyhA5tUwvaNabMsowWbrz
         l8y1q0wL90QdJcWObuoCaiEPXg6tGZQsi0ZdmrflIyF4KZuxCNU+ddvjKSvh//yq+E
         zbde21VNXvYAYlGKXT+8Ye/IqGt/e3i03BcDqwk14ztwjPXxlN+tqjknjqKiAcTjTM
         ciwbNi821W2e0cDeQhUvkmecbK078Kp/X3VSeu8QPyJbSM7+zLiEQGi0VxZ1c4rCAG
         B15AyuYIKAjV0EbJssbP8qVqSex1qCxqcXTX/9QMh/f9j4PQxt4pZQjUKauSE/lIdE
         yylFfIQRbm/l9qNdUYQMaU/0u+Fne6ixEiHKg2h6UfwUJZlJzg3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 34/39] t: add test_oid option to select hash algorithm
Date:   Wed, 29 Jul 2020 23:14:23 +0000
Message-Id: <20200729231428.3658647-35-sandals@crustytoothpaste.net>
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

In some tests, we have data files which are written with a particular
hash algorithm. Instead of keeping two copies of the test files, we can
keep one, and translate the value on the fly.

In order to do so, we'll need to read both the source algorithm and the
current algorithm, so add an optional flag to the test_oid helper that
lets us look up a value for a specified hash algorithm. This should
not cause any conflicts with existing tests, since key arguments to
test_oid are allowed to contains only shell identifier characters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0000-basic.sh        | 11 +++++++++++
 t/test-lib-functions.sh | 12 +++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2ff176cd5d..2599d026a2 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -928,6 +928,17 @@ test_expect_success 'test_oid can look up data for SHA-256' '
 	test "$hexsz" -eq 64
 '
 
+test_expect_success 'test_oid can look up data for a specified algorithm' '
+	rawsz="$(test_oid --hash=sha1 rawsz)" &&
+	hexsz="$(test_oid --hash=sha1 hexsz)" &&
+	test "$rawsz" -eq 20 &&
+	test "$hexsz" -eq 40 &&
+	rawsz="$(test_oid --hash=sha256 rawsz)" &&
+	hexsz="$(test_oid --hash=sha256 hexsz)" &&
+	test "$rawsz" -eq 32 &&
+	test "$hexsz" -eq 64
+'
+
 test_expect_success 'test_bool_env' '
 	(
 		sane_unset envvar &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 3103be8a32..2608e80f11 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1468,7 +1468,17 @@ test_oid_cache () {
 # Look up a per-hash value based on a key ($1).  The value must have been loaded
 # by test_oid_init or test_oid_cache.
 test_oid () {
-	local var="test_oid_${test_hash_algo}_$1" &&
+	local algo="${test_hash_algo}" &&
+
+	case "$1" in
+	--hash=*)
+		algo="${1#--hash=}" &&
+		shift;;
+	*)
+		;;
+	esac &&
+
+	local var="test_oid_${algo}_$1" &&
 
 	# If the variable is unset, we must be missing an entry for this
 	# key-hash pair, so exit with an error.
