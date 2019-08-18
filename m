Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588D01F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfHRUFg (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbfHRUFd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1BC756047B;
        Sun, 18 Aug 2019 20:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158732;
        bh=JhBZFnOaQjAoCia784S193pbaRGrvBbZfYGG9sF8kA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=D3SJI3NLEGzKDJ/AGDs0soQ7LiMQYl5ny/wrfc9RUKBCPGuztOWQSAh4ozSk/WZQA
         4q9xB63Lg0L73WKveqvm9tUvO1Jp26iP1ydGoAd1Yrd+Rv5TMNg2ZzqzHvt3qIjpgM
         kyVZFBI0aJnQyv+PhPDDuKNfBhDIYyx3pkst01NLfcFEHiRC9LsA0fuO+SXS/5kEd2
         o3tb+Td3hrKSjQQXJJw1s3ziApUco1KlC7Bq8N4k7eacUY6Ai1FwmVOpZKWNBC9EtS
         SZJ/bVyntEjzkpiFelYa+v6r5YYwH9zaeNQWOMSLHw3v5nASTZtdIks/GMdvN3jb+O
         1yr5n3G4QtKEr7VmTndzoztyZQSXcXyE6sYPXlBv/8qba47DcNCz8RCb0VX+QbBk4z
         XxkiiCVjK2RFKublRpGSwhhFED9zPN9kx6j0Hk1/kZNkC7LTbL3101CzyXWsitUbOZ
         OX8L3gE3/wR/UMqkF57h2veoRBcEAFSwKQ8YB5Dgx2KwNBNVP6c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 03/26] fetch-pack: use parse_oid_hex
Date:   Sun, 18 Aug 2019 20:04:04 +0000
Message-Id: <20190818200427.870753-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding constants, use parse_oid_hex to compute a pointer
and use it in further parsing operations.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 65be043f2a..1f56b8a6d7 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -168,16 +168,16 @@ static enum ack_type get_ack(struct packet_reader *reader,
 	if (!strcmp(reader->line, "NAK"))
 		return NAK;
 	if (skip_prefix(reader->line, "ACK ", &arg)) {
-		if (!get_oid_hex(arg, result_oid)) {
-			arg += 40;
-			len -= arg - reader->line;
+		const char *p;
+		if (!parse_oid_hex(arg, result_oid, &p)) {
+			len -= p - reader->line;
 			if (len < 1)
 				return ACK;
-			if (strstr(arg, "continue"))
+			if (strstr(p, "continue"))
 				return ACK_continue;
-			if (strstr(arg, "common"))
+			if (strstr(p, "common"))
 				return ACK_common;
-			if (strstr(arg, "ready"))
+			if (strstr(p, "ready"))
 				return ACK_ready;
 			return ACK;
 		}
