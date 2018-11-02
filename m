Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CAD1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 09:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeKBS7h (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 14:59:37 -0400
Received: from mail.aclindsay.com ([45.79.160.72]:39714 "EHLO
        mail.aclindsay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBS7h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 14:59:37 -0400
Received: from localhost.localdomain (cpe-65-190-6-212.nc.res.rr.com [65.190.6.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.aclindsay.com (Postfix) with ESMTPSA id 47D895E215;
        Fri,  2 Nov 2018 05:53:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aclindsay.com;
        s=dkimselector; t=1541152381;
        bh=caQSFzKer5xRexSgZkwuxpTzcacrupNCmnlfbTv16yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=v0RxrBSWpGSN98icLo8oVR0ujv3HiHcoZw386urND/4Zwrmd+QRuKnshsiRpgRHL7
         HOF7WNiti18vdOC8sN/imuwEhoiaFHf306KradPVIO+6Fb7+ZYsuGVhrBW4Xnbw1oY
         6eoh0vN8nEphqq4MPoyPX2uUwEviza0uWqR3WqdQ=
From:   Aaron Lindsay <aaron@aclindsay.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Junio C Hamano <gitster@pobox.com>,
        Aaron Lindsay <aaron@aclindsay.com>
Subject: [PATCH v2] send-email: Avoid empty transfer encoding header
Date:   Fri,  2 Nov 2018 05:52:38 -0400
Message-Id: <20181102095238.25766-1-aaron@aclindsay.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102015335.GC731755@genre.crustytoothpaste.net>
References: <20181102015335.GC731755@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a small bug introduced by "7a36987ff (send-email: add an auto option
for transfer encoding, 2018-07-14)"

I saw the following message when setting --transfer-encoding for a file
with the same encoding:
    $ git send-email --transfer-encoding=8bit example.patch
    Use of uninitialized value $xfer_encoding in concatenation (.) or string
    at /usr/lib/git-core/git-send-email line 1744.

v2 adds a test provided by brian m. carlson.

Signed-off-by: Aaron Lindsay <aaron@aclindsay.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-send-email.perl   |  2 +-
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac33..39c15bcc8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1834,7 +1834,7 @@ sub apply_transfer_encoding {
 	my $from = shift;
 	my $to = shift;
 
-	return $message if ($from eq $to and $from ne '7bit');
+	return ($message, $to) if ($from eq $to and $from ne '7bit');
 
 	require MIME::QuotedPrint;
 	require MIME::Base64;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1ef1a1900..ee1efcc59 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -492,6 +492,21 @@ do
 			--validate \
 			$patches longline.patch
 	'
+
+done
+
+for enc in 7bit 8bit quoted-printable base64
+do
+	test_expect_success $PREREQ "--transfer-encoding=$enc produces correct header" '
+		clean_fake_sendmail &&
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=nobody@example.com \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			--transfer-encoding=$enc \
+			$patches &&
+		grep "Content-Transfer-Encoding: $enc" msgtxt1
+	'
 done
 
 test_expect_success $PREREQ 'Invalid In-Reply-To' '
-- 
2.19.1

