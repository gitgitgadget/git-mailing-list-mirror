Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8581C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C922120663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wxVccLIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgGJCtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40486 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgGJCtN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:49:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 19AAA60A63;
        Fri, 10 Jul 2020 02:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349314;
        bh=UaAP0hIH8vxcehmCkzB++tkC53e5f9DbrGFPfaFhQj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wxVccLIkIWqzSNNXD1wjDzTNDImlCFDgiwsv930qaVxb46EVSRZTiSUjUoIUBhk1+
         X6hkov+E7eO6WWYw4e0Jp+EhIQPvJ1qNAK635mHC18Kq4+ZWU91yBa8VxBOWud74fX
         AHdmQ4GsgIAARQNury27nmEXnOP2EnE8I1OdEa0jLBcv3XEfCjq41NuQZMa0Y29oB1
         QpzJkwmvPTZtXI/V5LMavO706YR4m/knoQGGvmdWsAEce4jny2kQUywNDFb8L+v4Op
         bs0hVvXO4aQTUIO4UJQPUVoJABZ4Kuu1GvJe1mRuvN6ciXrt9LRHgHoJ9Fgx0leIWF
         qDDpkuyq8MKmTeGfkUSWGJqLNiRtSj0mzd6VgISfAcEgowDYRzqbr87gUf6cneb5tL
         M7414fck4YPwAfofaC2Jko5/n6jukmWrZHz0WT8Jjh/JR2RhViWQSdoAN95IdZumQv
         TZR9EDUcYlDu3er52En1rNHgmvd99NEfgWdsvlxirprAIQ0g8Eo
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 24/38] t9350: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:14 +0000
Message-Id: <20200710024728.3100527-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
