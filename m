Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A34520248
	for <e@80x24.org>; Wed, 10 Apr 2019 23:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfDJXfG (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 19:35:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35440 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfDJXfF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Apr 2019 19:35:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4828:c54d:8751:d24b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1206360458;
        Wed, 10 Apr 2019 23:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1554939303;
        bh=ena8IyPmi2kfiwa7vVroo7h6J32nO3KGw+d9iudIqeY=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iPIzNGMpYbcyDcxjVZmoyuYP8lSI3FS9GlybKGEbtNphlFaVgWSB7VplGB0y06cSl
         EvoIZ+W37R/fOh73Zq0gfEdoHhat4oRuErvuZ/tmsmpS5JedkLVCJIsgFN5vQDJRGp
         T0bs1VsBRYMJcclUYLejl+8KRtduBIGuZSTr5Pjop7YjlKIAFz/i1hwUMqRTyZk9AA
         keg3yxm+vKHwCiXyNjFpFPHPsFCkqZkJiyhvioCR8snhbYqrQWB4iERdRaCKWVATqx
         n3Lr2LkDc+8ulybCxejT+KYQyxffTZncYMdRriwRCsmzedmeVVPay3dEBYW98tponG
         xZCGnq6U1Fx0Km+HJJSbpnj8ezjKqS6Abxdpq3txNnm9dkGfX9lrCo5In7kJs7tA1y
         ZTnPeoGA1szwrWIw90z2RHzm1M58HnoT4mRfbjON2m1AUTIBziYg/YJ/DBYFwkRFSQ
         hjnBG+JvQlXuXCSOLRY8FW3QMaq9axH5L32mNS/+Pz/Rt6pBCMf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] send-email: default to quoted-printable when CR is present
Date:   Wed, 10 Apr 2019 23:34:50 +0000
Message-Id: <20190410233450.765424-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7a36987fff ("send-email: add an auto option for transfer encoding",
2018-07-08), git send-email learned how to automatically determine the
transfer encoding for a patch. However, the only criterion considered
was the length of the lines.

Another case we need to consider is that of carriage returns. Because
emails have CRLF endings when canonicalized, we don't want to write raw
carriage returns into a patch, lest they be stripped off as an artifact
of the transport. Ensure that we choose quoted-printable encoding if the
patch we're sending contains carriage returns.

Note that we are guaranteed to always correctly encode carriage returns
when writing quoted-printable since we explicitly specify the line
ending as "\n", forcing MIME::QuotedPrint to encode our carriage return
as "=OD".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-send-email.perl   |  2 +-
 t/t9001-send-email.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8200d58cdc..751cabf479 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1872,7 +1872,7 @@ sub apply_transfer_encoding {
 	$message = MIME::Base64::decode($message)
 		if ($from eq 'base64');
 
-	$to = ($message =~ /.{999,}/) ? 'quoted-printable' : '8bit'
+	$to = ($message =~ /(?:.{999,}|\r)/) ? 'quoted-printable' : '8bit'
 		if $to eq 'auto';
 
 	die __("cannot send message as 7bit")
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ee1efcc59d..1e3ac3c384 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -481,6 +481,20 @@ test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable'
 	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
 '
 
+test_expect_success $PREREQ 'carriage returns with auto encoding are quoted-printable' '
+	clean_fake_sendmail &&
+	cp $patches cr.patch &&
+	printf "this is a line\r\n" >>cr.patch &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--transfer-encoding=auto \
+		--no-validate \
+		cr.patch &&
+	grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
+'
+
 for enc in auto quoted-printable base64
 do
 	test_expect_success $PREREQ "--validate passes with encoding $enc" '
