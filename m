Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6079AC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiAKCTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 21:19:07 -0500
Received: from ring.crustytoothpaste.net ([172.105.110.227]:33250 "EHLO
        ring.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiAKCTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:19:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9D15E5B236;
        Tue, 11 Jan 2022 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1641867545;
        bh=IZvk5MKnkQgtGo0zlpZRpp6sqDFFA0rF811+XVH2IIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wT48nXR77irlaLBU+xuf603fQ5WQBcOThlYBvmCStqq9Un0u3ohbowVE7jLUXm+JO
         UdBq615qDpcXMB1HrjMisl34GPG5GtGKL9xhm4ZWzewJyIbXXB1FFLlIwr0wb1vNC9
         B0QeQ11LPBcN4OGN5lEZ6lStc659Znj+JXq2LTL4dfDO6ptxKNpiJ5cu0p8EUBHksy
         vVBmBRF5kWJk7CjGz2IFxtHuBTIeoLj/y+e1iqn4sRqijxT/tE6qTsCmSNGcLA7hQr
         2oFVn5uZAfd2mYepv5lmBRQchxOzO7IdxW3caZE+cwQp67Gp9rR4YsLUcF+cHLuPXd
         SjBygsMWlw48950viVQ3bJreP/B0krXaAe/Y48/0XqJ8PrJTXVVHVEdx7+u8c/WDgA
         /mWbg+0L23aN0/T9emml8f8kunNRYNP/5jm+S5q1BRLCCpPwvjcKl7qa2rfv93cKXC
         H2JC72deY8VBZboTO3WR1nalOZWHlYGdTy8zyPgy27WI64Tesr6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/2] t0027: add tests for eol without text in .gitattributes
Date:   Tue, 11 Jan 2022 02:15:06 +0000
Message-Id: <20220111021507.531736-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220111021507.531736-1-sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now, it isn't clear what the behavior is when the eol attribute is
set in .gitattributes but the text attribute is not.  Let's add some
tests to document this behavior in our code, which happens to be that
the behavior is as if we set the text attribute implicitly.  This will
make sure we don't accidentally change the behavior, which somebody is
probably relying on, and serve as documentation to developers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0027-auto-crlf.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 4a5c5c602c..c5f7ac63b0 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -597,6 +597,12 @@ do
 	# auto: core.autocrlf=false and core.eol unset(or native) uses native eol
 	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	# core.autocrlf false, .gitattributes sets eol
+	checkout_files     ""    "$id" "lf"   false   ""       LF    CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     ""    "$id" "crlf" false   ""       CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
+	# core.autocrlf true, .gitattributes sets eol
+	checkout_files     ""    "$id" "lf"   true    ""       LF    CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     ""    "$id" "crlf" true    ""       CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 done
 
 # The rest of the tests are unique; do the usual linting.
