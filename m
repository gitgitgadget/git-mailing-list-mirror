Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56940C4345F
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330A8206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ULHoZIOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGMCuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:50:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40820 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728714AbgGMCuG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:50:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B00F060A69;
        Mon, 13 Jul 2020 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608575;
        bh=UaAP0hIH8vxcehmCkzB++tkC53e5f9DbrGFPfaFhQj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ULHoZIOrQBbO1tWZbg4TXQqGJ2jhM8+bRJKMnVW1km6XXDJBOm4oXESVBPaJSyhPA
         6Vb7kWBo5vcRo0okj/4Zpy9RAiR/V3Y7uA1NG9nlNZz+2Ro9Om40UF09yWfMXZaUv8
         TUWaOSdjn4uHBiDAolwRA277KLK7xNIYWg4rISUdy34ec3h9PIsS1RduTBSQs9s8Dj
         bA1XKCQQSP4GFloERoqVFqgnYKPmxD92ErjXFke/jEqNmT/JpGQQ5A7CMd7i1YmyQq
         1FmYGQrVg4cHR5JP0w6Er0oAi9hwpZixLWdko5sYxHdx9eH+lFqC0ntjmMtQx0hEYF
         vgV+VC49Q9zKD7rFOkQpkhIG9CoQpmbHRNj85Ws7zSiqi6eI3rpLV2fXNYMRv/2CCs
         L5mFV4+xNnRi6uEwBj4dIUgPQz02Qkpc3lu93VZwFu5tMKmVQfOZ0vay3C56z5v0yJ
         wscn0qOAQiI9n89cxDXjTtJjUUwS0h/36XAUBzd/7eUbX+rv/7m
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 24/39] t9350: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:54 +0000
Message-Id: <20200713024909.3714837-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test checks for several commit object sizes to verify that objects
are encoded as expected. However, the size of a commit object differs
between SHA-1 and SHA-256, since each contains a hex representation of
the tree's object ID. Since these are root commits, compute the size of
each commit by using a constant plus the size of a single hex object ID.

In addition, use $ZERO_OID instead of a hard-coded object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9350-fast-export.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 690c90fb82..ba79db6a17 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -7,6 +7,7 @@ test_description='git fast-export'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	test_oid_init &&
 
 	echo break it > file0 &&
 	git add file0 &&
@@ -132,12 +133,12 @@ test_expect_success 'reencoding iso-8859-7' '
 	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
-		 # The commit object, if not re-encoded, would be 240 bytes.
+		 # The commit object, if not re-encoded, would be 200 bytes plus hash.
 		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
 		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
 		 # to \xCF\x80 (\317\200) in UTF-8 adds a byte.  Check for
 		 # the expected size.
-		 test 221 -eq "$(git cat-file -s i18n)" &&
+		 test $(($(test_oid hexsz) + 181)) -eq "$(git cat-file -s i18n)" &&
 		 # ...and for the expected translation of bytes.
 		 git cat-file commit i18n >actual &&
 		 grep $(printf "\317\200") actual &&
@@ -164,12 +165,12 @@ test_expect_success 'preserving iso-8859-7' '
 	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
-		 # The commit object, if not re-encoded, is 240 bytes.
+		 # The commit object, if not re-encoded, is 200 bytes plus hash.
 		 # Removing the "encoding iso-8859-7\n" header would drops 20
 		 # bytes.  Re-encoding the Pi character from \xF0 (\360) in
 		 # iso-8859-7 to \xCF\x80 (\317\200) in UTF-8 adds a byte.
 		 # Check for the expected size...
-		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
+		 test $(($(test_oid hexsz) + 200)) -eq "$(git cat-file -s i18n-no-recoding)" &&
 		 # ...as well as the expected byte.
 		 git cat-file commit i18n-no-recoding >actual &&
 		 grep $(printf "\360") actual &&
@@ -192,7 +193,7 @@ test_expect_success 'encoding preserved if reencoding fails' '
 		 grep ^encoding actual &&
 		 # Verify that the commit has the expected size; i.e.
 		 # that no bytes were re-encoded to a different encoding.
-		 test 252 -eq "$(git cat-file -s i18n-invalid)" &&
+		 test $(($(test_oid hexsz) + 212)) -eq "$(git cat-file -s i18n-invalid)" &&
 		 # ...and check for the original special bytes
 		 grep $(printf "\360") actual &&
 		 grep $(printf "\377") actual)
@@ -694,7 +695,7 @@ test_expect_success 'delete ref because entire history excluded' '
 	git fast-export to-delete ^to-delete >actual &&
 	cat >expected <<-EOF &&
 	reset refs/heads/to-delete
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 
 	EOF
 	test_cmp expected actual
@@ -704,7 +705,7 @@ test_expect_success 'delete refspec' '
 	git fast-export --refspec :refs/heads/to-delete >actual &&
 	cat >expected <<-EOF &&
 	reset refs/heads/to-delete
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 
 	EOF
 	test_cmp expected actual
