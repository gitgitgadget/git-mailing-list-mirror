Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD0420248
	for <e@80x24.org>; Sat, 13 Apr 2019 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfDMWqM (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 18:46:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727190AbfDMWqM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Apr 2019 18:46:12 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4828:c54d:8751:d24b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 51E3C600FB;
        Sat, 13 Apr 2019 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1555195566;
        bh=FWvnHp5ZKrOFYpS87f14SPQz/9Z2UuUzAbdaBkNKMMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dz4WifKYf5DSVsjaQl4hDfoi9dicZ1CN9UKuR7aKczpwGNvwUIbJwwB86kXzqTQCg
         V9NOYWC+p8gFYgerRZPaONUl5RF2VZ+aqlqqOft7OWeSOWzkVo/2mdCBV4JK4PQTc8
         IQf58IM244CK/t5pweEuOVz4pbkwFXRqQ6akj5hSnI1nv0HEaAgPYfNMu1NzosboI1
         AqBJP4a1UjqoMQZpNIYaPWOIVoZl4MdsX9Mpul0raRBMVlSh2HYBouEoGP8RxuUb4u
         OEtOq1sBZFGXrvSdUB7iPoasZLVsx+N/t26SI61pBZfFW9Mm1u5Fs3HgF4n3wlGFEl
         1s3U/Prgz1h7MMyJwfyU37ufKTTjchMHY4v3LCqfXD5CU75mwUZMDkKuFH/iqEUaJq
         6uPjFcn+QVKMDTy0Xikmdupds/REChZJX1YuURxHPNDTPKXMmJu3rm33nOkZl/I7w+
         14tumKF3bbbQmkgVoK+iFnnm1nGy4CAfq4CzfVHmTWvzBn26GJb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] send-email: default to quoted-printable when CR is present
Date:   Sat, 13 Apr 2019 22:45:51 +0000
Message-Id: <20190413224551.882125-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190410233450.765424-1-sandals@crustytoothpaste.net>
References: <20190410233450.765424-1-sandals@crustytoothpaste.net>
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
as "=0D".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v1:
* Fix typo "=OD" for "=0D".

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
