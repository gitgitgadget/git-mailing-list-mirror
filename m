Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B78C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B820776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GsIuRvCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405097AbgFSR5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39670 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436502AbgFSR5C (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:57:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E19A60A7A;
        Fri, 19 Jun 2020 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589389;
        bh=Mo6wZuC9p3nChbBxsGl44GyZeJquT3ZYpX4+z7OuAXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=GsIuRvCWMs30DZDFe02VabblGB/nwN2PldnyBNZet3/IEiahaG6eKtOkK92a9QSXI
         vyh/sJKfaeYG+dVkYe6O/vdjGArWzF6sUq3nkMjK0quQ/oSffnvfXAg2jtwDsyb+jj
         x8HLAunx0FflHO6sUN7eZN85CA8wbDDATlYLY53bTzUBmuYDiR8chjAkIWsc2bODKD
         J5iF8v1BjDcWYWyoVPF5d2QUHybyyVpWcvF/oY6TUbcT4NM0DuGeUDGbkoDtRVebcW
         NouY6XvTvNGORAUIFia7q3NgEDOaev+BooZMTfiMStZmdnoIVwOCEAfnWRcsa+34r7
         qu0mB2WFzJR4rnRseNDtJ6VBCz1pCXup4wH3lae1G3BDWHeI+umdj4q3Y2twqIwzMq
         lX/jeu8dIT9oXpqzZXGIf88bDGtlmTr60DNCMUEwZnv4s8XJEeOu6nGkUh8xbq0cDL
         ZzYz5OjPpD2xrTrc3M7D+uz/IhYdmGHjOwku22ui9TlMJN4OdsJ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 32/44] t5500: make hash independent
Date:   Fri, 19 Jun 2020 17:55:49 +0000
Message-Id: <20200619175601.569856-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has hard-coded pkt-lines with object IDs.  The pkt-line
lengths necessarily differ between hash algorithms, so generate these
lines with the packetize helper so they're always the right size.  In
addition, we will require an object-format capability for SHA-256, so
pass that capability on to the upload-pack process.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5500-fetch-pack.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8c54e34ef1..dfed113247 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -871,9 +871,10 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 
 	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
 	0012command=fetch
+	$(echo "object-format=$(test_oid algo)" | packetize)
 	00010013deepen-since 1
-	0032want $(git rev-parse other)
-	0032have $(git rev-parse master)
+	$(echo "want $(git rev-parse other)" | packetize)
+	$(echo "have $(git rev-parse master)" | packetize)
 	0000
 	EOF
 	)
