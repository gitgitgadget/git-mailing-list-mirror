Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31771F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBLBXw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34352 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbfBLBXq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4857360E60;
        Tue, 12 Feb 2019 01:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934625;
        bh=SW5OJPhBLpqJ3hRLr4aeX6PSfsTg2E9HV5uvCFjbuCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=eiH3pM71TET9eGOkBMO5T6AEQ/AzOAfmhfiquoI8Mh0IMbsGVpVTXyU7RCuI0ubbz
         dgdXvFF+pMexBLNW2pFJNZOPyXPHOp+To19z9CbN6JHlECTRTrJIher84ItYUSLBGr
         v2FZXN53/4+KO3cU2mwJaYd4YMUUmnUsVMw0guKUU6PrEzIBJVISRfEMsvzhzalrNE
         HqiL6yWKW5b2qTbb4EN1aJN/bdaMCREWZlpVEhwQmPDpqREPa3Dc9q57HPdQIgPn9T
         TnpT08lEjrINYofLjzApH/sl8JGOciwHtHzOr1uT1KDlSRSJtfvQFeetTqqOg9nswe
         o5V8ovLqVUyQWJfKCtx0KOBFFZcsrQzKb/5VuNa5SDD1jqlXyhpBGMgtRGcoIA0YJ6
         xLDvRXvarFNROYfwCFp/tKbI0DEmp1eooye4E71G7xd9/5Dl2pTGGd0NaESag1o+Sh
         fdncF9w6OV9Sg+NLHWX5n2UgtnXPmaCJ7HBCa9uOLEN/DLBHz9d
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 30/31] Git.pm: make hash size independent
Date:   Tue, 12 Feb 2019 01:22:55 +0000
Message-Id: <20190212012256.1005924-31-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
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
