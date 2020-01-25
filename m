Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F4C35243
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B7A2071E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ya5c//2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAYXAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46816 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbgAYXAq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:46 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2DBCE60FC4;
        Sat, 25 Jan 2020 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993244;
        bh=sEkMDkqpK1OBWfbnfF1hxcDEn7IDQWSLwlTLd+96VQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Ya5c//2bH6OufDV3OxLG3pHHTfq9tQmpxfydt7ByYrqkzB3EhbmeHfkPy8b490prR
         hDeHInylwinyTT+LJOVggD99YRUnd5ggn84haNQ5vEIqT6MEQUS16kDkJQ9Pt8ItGy
         6LWhtRZuMnuqnodoUmbBuoRgjQjxuXwiSN3NbrEOi5q6QliTAjVGcGwSINCILv5REZ
         HDKDxNJTvZE15DdePividXjtSUuTW7iPZd6U9M0AHv7OJxOgcUscXzNzkBf0obF5o4
         7JJF9L9g3Wmms4qES5I3ktkwLegmJ0V4EiZ9r0MxXU6g3poIPYkBHRQ/Eko1rbTUXB
         GfsYyfzRI820iIARaWoVKotUHZE2pi2vAOpsmVYduQbDZFT8udS4RqJb5s+NBJjNbN
         CuQHs6tKsKQtNzSRn3M1bBJ/zAhwwmmMib6J9EMosT8GzJ4Wirc/C2omZ0ecKciC9N
         esGjNEKCIO/qDdGysZ+BUhtdxWggEzaHKdg1wMI7+G0+Y49HxIO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/22] t4013: make test hash independent
Date:   Sat, 25 Jan 2020 23:00:14 +0000
Message-Id: <20200125230035.136348-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test produces a large number of diff formats and compares the
output with test files that have content specific to SHA-1. Since we are
more interested in the format of the diffs, and not their specific
values, which are tested elsewhere, add a function which uses sed to
transform these specific object IDs into generic ones of the right size,
which we can then compare.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4013-diff-various.sh | 44 +++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5ac94b390d..6f5f05c3a8 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -120,6 +120,30 @@ test_expect_success setup '
 +*++ [initial] Initial
 EOF
 
+process_diffs () {
+	x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
+	x07="$_x05[0-9a-f][0-9a-f]" &&
+	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
+	    -e "s/From $_x40 /From $ZERO_OID /" \
+	    -e "s/from $_x40)/from $ZERO_OID)/" \
+	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
+	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
+	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
+	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
+	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
+	    -e "s/^$_x40 /$ZERO_OID /" \
+	    -e "s/^$_x40$/$ZERO_OID/" \
+	    -e "s/$x07\.\.$x07/fffffff..fffffff/g" \
+	    -e "s/$x07,$x07\.\.$x07/fffffff,fffffff..fffffff/g" \
+	    -e "s/$x07 $x07 $x07/fffffff fffffff fffffff/g" \
+	    -e "s/$x07 $x07 /fffffff fffffff /g" \
+	    -e "s/Merge: $x07 $x07/Merge: fffffff fffffff/g" \
+	    -e "s/$x07\.\.\./fffffff.../g" \
+	    -e "s/ $x04\.\.\./ ffff.../g" \
+	    -e "s/ $x04/ ffff/g" \
+	    "$1"
+}
+
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
 while read magic cmd
 do
@@ -158,13 +182,15 @@ do
 		} >"$actual" &&
 		if test -f "$expect"
 		then
+			process_diffs "$actual" >actual &&
+			process_diffs "$expect" >expect &&
 			case $cmd in
 			*format-patch* | *-stat*)
-				test_i18ncmp "$expect" "$actual";;
+				test_i18ncmp expect actual;;
 			*)
-				test_cmp "$expect" "$actual";;
+				test_cmp expect actual;;
 			esac &&
-			rm -f "$actual"
+			rm -f "$actual" actual expect
 		else
 			# this is to help developing new tests.
 			cp "$actual" "$expect"
@@ -383,16 +409,22 @@ test_expect_success 'log -S requires an argument' '
 test_expect_success 'diff --cached on unborn branch' '
 	echo ref: refs/heads/unborn >.git/HEAD &&
 	git diff --cached >result &&
-	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached" result
+	process_diffs result >actual &&
+	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--cached" >expected &&
+	test_cmp expected actual
 '
 
 test_expect_success 'diff --cached -- file on unborn branch' '
 	git diff --cached -- file0 >result &&
-	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" result
+	process_diffs result >actual &&
+	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--cached_--_file0" >expected &&
+	test_cmp expected actual
 '
 test_expect_success 'diff --line-prefix with spaces' '
 	git diff --line-prefix="| | | " --cached -- file0 >result &&
-	test_cmp "$TEST_DIRECTORY/t4013/diff.diff_--line-prefix_--cached_--_file0" result
+	process_diffs result >actual &&
+	process_diffs "$TEST_DIRECTORY/t4013/diff.diff_--line-prefix_--cached_--_file0" >expected &&
+	test_cmp expected actual
 '
 
 test_expect_success 'diff-tree --stdin with log formatting' '
