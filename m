Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7741DC352A4
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E620214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="tThIrcwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBGAxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55552 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbgBGAxg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DA015607F5;
        Fri,  7 Feb 2020 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036815;
        bh=r2cNqXzWffGtP7QKQins9se+/07yq+zTevTkdiA1ImY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=tThIrcwyU/IuRh9L2X7rTwgdF5uC/3dmFFkS0kEgVn15vbicLKmVISYFWmzVJJ9ZY
         WgVPEaWf9smkIa4jvxbW9H94lBJ9TSBhYOCvpyHIDaBMyeMd9Mh4k+AYpgtd1rLUtM
         lzJmJRGsc8UejQANb6n0o3Bdp6nrd77JYDMghaLEZP6a4ctkYg2XjlLvZ6rRCE+rMF
         jg8frPAbhXOaL3FOGYyYorGJZsav2UkJDj8SNheSoetUXZbMaviClEjn5TOrWfnpET
         QOY2gfJ49EmKM6Fvz9pikt3dpfTIv5ce7Rpm4tOT4549yNCDgpezDbQfJIkPCvaaCx
         A+0QL4gWg5Bw1d859XVDje1YoUTUSLRVWqtURouTMQsyF1v4a10DzcmTsxdBfZ/LrI
         ASojS3CkcumAKsE9poiFVt9HiE7+nbKqvW3lYUdNTZyAhBuFYdo49D8D8SyWI7PbVS
         U5L3QhNU1UcJuc/tPwREgEGEkDVdlM4XA1dRvzoGYNH/LgdSTa8
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/21] t4013: make test hash independent
Date:   Fri,  7 Feb 2020 00:52:40 +0000
Message-Id: <20200207005254.1495851-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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
index 5ac94b390d..dde3f11fec 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -120,6 +120,30 @@ test_expect_success setup '
 +*++ [initial] Initial
 EOF
 
+process_diffs () {
+	_x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
+	_x07="$_x05[0-9a-f][0-9a-f]" &&
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
+	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
+	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
+	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
+	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
+	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
+	    -e "s/$_x07\.\.\./fffffff.../g" \
+	    -e "s/ $_x04\.\.\./ ffff.../g" \
+	    -e "s/ $_x04/ ffff/g" \
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
