Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A473C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A2620776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nzbWV+7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436489AbgFSR47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:59 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39596 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393787AbgFSR4l (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:41 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 297A560A73;
        Fri, 19 Jun 2020 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589394;
        bh=hYAhEgO21Q1ObbuQ8R0buMjNd5pGl8EufAeC4U72FN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nzbWV+7S2WX374uEW2Wh/yIjnIUWX8/tlH54Oaz4pIRPAhBTVcFXrJYDzOwC3EL+C
         rx5MxzyYZ7VRS3+hs1FXqEBuKhYfnFXYgNh9dZGOhCiFcoTyiXTDJPsr/PYWrN3W5c
         97fE5FgYtbwS0Vsd5zZbffdyvIXE3V6NB7uB9qppO3V83R8cA5dIQspYDcmaIjn3Qk
         R1VN2ppOol9wpH/DBiF+gVgYuSGGcFqeY3CFCd0caYsDOMsmorXDIZgPAWYCK76zO5
         GEmy/HyPBrN2ZrMqdzmRbCvORD9u0ffGmKICnTub+Gjy1eZ57flnOopV4T/FCrWVwK
         b9sekgPKEyr/Khjz+gyJU//PoWS7+id4UeeURQIrvEq2OGxd1xvIicxBoNrfoqhkW/
         mQdAmXGGY7kohHO1DpJRULdfxNw0ylSi+dRnM7lnu2fFxnCHQQ7OAzR6L1gVlN/ivn
         IdfC1P+0xIE3uXoijgZK8QlOY5LgJ6kkm541n9QuFYvkW5ZiWPq
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 41/44] t5704: send object-format capability with SHA-256
Date:   Fri, 19 Jun 2020 17:55:58 +0000
Message-Id: <20200619175601.569856-42-sandals@crustytoothpaste.net>
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

When we speak protocol v2 in this test, we must pass the object-format
header if the algorithm is not SHA-1.  Otherwise, git upload-pack fails
because the hash algorithm doesn't match and not because we've failed to
speak the protocol correctly.  Pass the header so that our assertions
test what we're really interested in.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5704-protocol-violations.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 950cfb21fe..5c941949b9 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -9,6 +9,7 @@ making sure that we do not segfault or otherwise behave badly.'
 test_expect_success 'extra delim packet in v2 ls-refs args' '
 	{
 		packetize command=ls-refs &&
+		packetize "object-format=$(test_oid algo)" &&
 		printf 0001 &&
 		# protocol expects 0000 flush here
 		printf 0001
@@ -21,6 +22,7 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
 test_expect_success 'extra delim packet in v2 fetch args' '
 	{
 		packetize command=fetch &&
+		packetize "object-format=$(test_oid algo)" &&
 		printf 0001 &&
 		# protocol expects 0000 flush here
 		printf 0001
