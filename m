Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058C1C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D980020809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QmQqFEP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgG2XPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728076AbgG2XPA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:00 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B2F356101D;
        Wed, 29 Jul 2020 23:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064497;
        bh=eTqVeOVIS5vfeTzqh2ut7sQmwkFSE34dvNVpjdO3LAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QmQqFEP5QvKbYG0yykEBiZqBCTssKLq9T+2Jb7abfMuqP7C3rFQ8HZJgWeA/eBz/d
         sQ7xGEYMNlL4Xo2yfGWe0R4uTUfiTWCQF18QTovsZZTWCT7UYzLSsYgOzlZP71k+f8
         yRQM1U3vfADTsqw7TcIAiP7emj6V2FOjvSYplFArcHkNoYwuQwYkc5oInahAQtdSH6
         caKebquZwOmHHmbKlLK9f0IMbShfJaWysE9STxajHVCs0A9B9MYIHCmk7s/AGwI6Vf
         I+gebn0FMJREvYgUKEabVWcaNy3veXFpzqQP95R/bom0FBNvPZl/EQUZVJi30cuTL9
         7Y0/gcYOYyVx4uY8X41Y6dbUrs3H+nDIPlSpz0y46IPI66PLAz1AgM+xJrHB5pKR2K
         JgukKxr+in99DcCRlGmuD9DOMgEXnqoECvi3RKjxyhHICYPDmOHm6hxUBYdBtOT4Mp
         5WTqgYE76jZS6d4WYMna8g/Z42vErrOl7x56aKuyP4m3MzKJAPm
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 24/39] t9350: make hash size independent
Date:   Wed, 29 Jul 2020 23:14:13 +0000
Message-Id: <20200729231428.3658647-25-sandals@crustytoothpaste.net>
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

This test checks for several commit object sizes to verify that objects
are encoded as expected. However, the size of a commit object differs
between SHA-1 and SHA-256, since each contains a hex representation of
the tree's object ID. Since these are root commits, compute the size of
each commit by using a constant plus the size of a single hex object ID.

In addition, use $ZERO_OID instead of a hard-coded object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t9350-fast-export.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 690c90fb82..1372842559 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -132,12 +132,12 @@ test_expect_success 'reencoding iso-8859-7' '
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
@@ -164,12 +164,12 @@ test_expect_success 'preserving iso-8859-7' '
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
@@ -192,7 +192,7 @@ test_expect_success 'encoding preserved if reencoding fails' '
 		 grep ^encoding actual &&
 		 # Verify that the commit has the expected size; i.e.
 		 # that no bytes were re-encoded to a different encoding.
-		 test 252 -eq "$(git cat-file -s i18n-invalid)" &&
+		 test $(($(test_oid hexsz) + 212)) -eq "$(git cat-file -s i18n-invalid)" &&
 		 # ...and check for the original special bytes
 		 grep $(printf "\360") actual &&
 		 grep $(printf "\377") actual)
@@ -694,7 +694,7 @@ test_expect_success 'delete ref because entire history excluded' '
 	git fast-export to-delete ^to-delete >actual &&
 	cat >expected <<-EOF &&
 	reset refs/heads/to-delete
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 
 	EOF
 	test_cmp expected actual
@@ -704,7 +704,7 @@ test_expect_success 'delete refspec' '
 	git fast-export --refspec :refs/heads/to-delete >actual &&
 	cat >expected <<-EOF &&
 	reset refs/heads/to-delete
-	from 0000000000000000000000000000000000000000
+	from $ZERO_OID
 
 	EOF
 	test_cmp expected actual
