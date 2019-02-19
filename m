Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41891F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfBSAGV (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:21 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34894 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732308AbfBSAGT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:19 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D97146108D;
        Tue, 19 Feb 2019 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534777;
        bh=SW5OJPhBLpqJ3hRLr4aeX6PSfsTg2E9HV5uvCFjbuCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UPr4cWpOD4k5rYOq/K3zvzi/o6ufm4D6ZKGbEW4+tN9nOCMh572s734Yw5Er90nVi
         knRCgRTQKLdji/wk+mJOwmPJve6KojENktZGJprVDtKKcOsC61r93sgPN+YnzqdFIZ
         J3un/Y2zA9fiw/t02ShzyUBIC69d63pszAft1f+yfJ1ErAIQRzL6rJzRzDm0HPoxs5
         vjD8NMEk2/OB4XE09t0C7uU8yRY1q4CJWl5ek0zqfSPGBhSik6VW+tL3B4ZFhyh5eg
         HFR4X4Bd+jJgp6au4UIrUpQTgY0QxoMmFDdqQkZQ1SbQAxEMYsSY5kXZLkfuTOnYUY
         eDeDi4yHkmCMRnPi53/dXswfQtU6a8B5TRMpBJkz05htQBMy/MEimm952WAY/CLajU
         sUYVUJXCSQ27IAOH1UB6zK5aOd4wrqkq0N6rFkArjfN+MV5cSrPrGvIIUBRgJ9RQIl
         jUDoAd4raI9AeFNVB6+MSU1rvbnkH1qgFR0csaGROGIifzzJjrr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 34/35] Git.pm: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:25 +0000
Message-Id: <20190219000526.476553-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The cat_blob function was matching on exactly 40 hex characters.  This
won't work with SHA-256, which uses 64-character hex object IDs.  While
it should be fine to simply match any number of hex characters since the
output is space delimited, be extra safe by matching either exactly 40
or exactly 64 hex characters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index d856930b2e..62c472e0ce 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -980,7 +980,7 @@ sub cat_blob {
 		return -1;
 	}
 
-	if ($description !~ /^[0-9a-fA-F]{40} \S+ (\d+)$/) {
+	if ($description !~ /^[0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})? \S+ (\d+)$/) {
 		carp "Unexpected result returned from git cat-file";
 		return -1;
 	}
