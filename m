Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CAE1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 01:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeKBKWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 06:22:22 -0400
Received: from mail.aclindsay.com ([45.79.160.72]:50208 "EHLO
        mail.aclindsay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBKWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 06:22:22 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2018 06:22:22 EDT
Received: from localhost.localdomain (cpe-65-190-6-212.nc.res.rr.com [65.190.6.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.aclindsay.com (Postfix) with ESMTPSA id D26285E209;
        Thu,  1 Nov 2018 21:09:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aclindsay.com;
        s=dkimselector; t=1541120979;
        bh=LVy5i+JNIcHUUrYO2CVY3jgmp9+0ubxsuTrzDxcZRuY=;
        h=From:To:Cc:Subject:Date;
        b=Tdgoa77DAwqr5IXuBkpdjx6tiuDkfk+yGDVYV6bmV1MT8cOQDOUO9ytzJYpi0K+rD
         zjrdoVCicbvTJH3P/dcAyG55bVqaTGSAEtJpr/xGgEo/I4L/YoecP0EPjwK9VQcrLe
         NsTkGJIUrzWxnGDce1dTNt4tt6nC6tA+3wV2YVqI=
From:   Aaron Lindsay <aaron@aclindsay.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Junio C Hamano <gitster@pobox.com>,
        Aaron Lindsay <aaron@aclindsay.com>
Subject: [PATCH] send-email: Avoid empty transfer encoding header
Date:   Thu,  1 Nov 2018 21:09:34 -0400
Message-Id: <20181102010934.15473-1-aaron@aclindsay.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a small bug introduced by "7a36987ff (send-email: add an auto option
for transfer encoding, 2018-07-14)

I saw the following message when setting --transfer-encoding for a file
with the same encoding:
    $ git send-email --transfer-encoding=8bit example.patch
    Use of uninitialized value $xfer_encoding in concatenation (.) or string
    at /usr/lib/git-core/git-send-email line 1744.

Signed-off-by: Aaron Lindsay <aaron@aclindsay.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.19.1

