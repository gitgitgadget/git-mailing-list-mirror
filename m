Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23903C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087772071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 20:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="WY5NG1rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390651AbgEYUAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 16:00:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38856 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390616AbgEYUAc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 May 2020 16:00:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 976E560D1F;
        Mon, 25 May 2020 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590436800;
        bh=hYAhEgO21Q1ObbuQ8R0buMjNd5pGl8EufAeC4U72FN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WY5NG1rbXg5bR8BqX9jnJt2qAs58z4YxJ0dU7OKMQK1LP9fKWpcnniFTOk9stiGAm
         B0cWpCrTaL55/8pnBjY4aSxByjDuKxXotZ+6Ioh96sKnqPzgWhqViQOGeh8EfFvDqh
         vJ5bOvTe1eDLbWoFror+0NKkOFbqhUj7YdLTn38TNULewvRr8S6ulbZVGajMkJsbBR
         vWU8ObSjDx4ZXWkF+Jz+XA+jg85H75CsMyouURce/HUmRc7WhAWKGzBFTfoCU+nAeB
         opvz7ii7PzqmesZk3cEfF1TkakJFjkk3/6hD5cpOHzd/Mp3iQ/ifbmxpqEOEE8n766
         QnBCe5Z9JJUJ1qBA5RzF0/YapwHozutcQ//AYz98rTnXW/bI6G5jdOr8SycHG0g59Y
         l57uloOwZgkKOGB0Ml/vo30HGcVUENIRsLVaa8MCyMTEDZuH24m18mRFAJG+h0oFRM
         7RtbOru1yXZUjjS4WlmEpPeXRF5FHHFpUVZBcAcf73VaMtQel7u
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 41/44] t5704: send object-format capability with SHA-256
Date:   Mon, 25 May 2020 19:59:27 +0000
Message-Id: <20200525195930.309665-42-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200525195930.309665-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200525195930.309665-1-sandals@crustytoothpaste.net>
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
