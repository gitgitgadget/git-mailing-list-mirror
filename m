Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA711F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeH2EvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:51:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37232 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727232AbeH2EvV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:51:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C3B4F60758;
        Wed, 29 Aug 2018 00:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504226;
        bh=Yr5fywCLNlHXFaTTgEaZ2z7FODYHDSf1U6yPEzvd0Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=qz/+cJnDnF49hYSi67Z2R2qhLOyoTiyCrZHxHi26EnOfgxdfwqVluH6viIZ3MMzdT
         vY0OxeWanI3AjsHkdT2zx5eAhV9c7xRtqTXryMM7CyxWmcIyV/LO6D5aQXY0HN0D1y
         colJ3+RV9cdbWNkaf2DyTS+i+eD7O9ezu2U/vrE2cqS845PounZljJHsemrM5tDSRt
         h8pnXKfOnbQIsv9K42taS+RvL9ScMVl2xQHGSX/v6eH3i/zpUDJq2Cyczz4qL/hFn2
         wyHmhHUAhrpYy6ThvFVY0xHKTWSH0aTHhbxgi+R9rZuwZ/QXA12G3LUcFEIcXfgqfY
         rAGoPenHUf2vaQb5y7CdVmOqox5Xx0WzupCA5rstU3sqGRH1iK8f+YdclSo5eUqQVr
         STKS6mV4ZrNgbJnb8MMlPKDRRRgbT4ZxEUlNEzxsP7oJUIMTLizMc7UQgFqo61hKyx
         ebEsmF06R0S4P6FKXBcvZudtaLg6y/gxyF63ibYNMc3WjC54KSS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 05/11] t0027: make hash size independent
Date:   Wed, 29 Aug 2018 00:56:36 +0000
Message-Id: <20180829005642.980617-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005642.980617-1-sandals@crustytoothpaste.net>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We transform various object IDs into all-zero object IDs for comparison.
Adjust the length as well so that this works for all hash algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0027-auto-crlf.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index beb5927f77..0f1235d9d1 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -14,11 +14,13 @@ compare_files () {
 compare_ws_file () {
 	pfx=$1
 	exp=$2.expect
+	tmp=$2.tmp
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$tmp" &&
 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
+	sed -e "s/0000*/$ZERO_OID/" "$tmp" >"$exp" &&
 	test_cmp "$exp" "$act" &&
-	rm "$exp" "$act"
+	rm "$exp" "$act" "$tmp"
 }
 
 create_gitattributes () {
