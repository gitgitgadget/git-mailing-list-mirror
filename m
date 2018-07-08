Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E5B1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbeGHXhB (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54356 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933087AbeGHXg7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:59 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8EBCE60746;
        Sun,  8 Jul 2018 23:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093017;
        bh=bt+JzfYBt0f5RZuh8bkJnKJD4uRrCQiOWdSkbIKECbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0ceCMImUOGPWhxiuA9vyLw55tv36qda25E1ehq6P+iccOxOVPwYqBm8WHlxL0dzb3
         ZjOQekzwqI7j+mjpH/vhdz6Mh5T9ZVt0fD2aHWuUrwvDRZFhvXbi0N1i817dTVNgHJ
         s7bNbkeXjnBntyvFbwZo2/RWyinEzycWqMChOBRajYT/et9gf3CCi/I3XGRy/ArPKC
         WG4xLy/erBjIq1z1pWfBOrryle0SaaIgfFk9Wq5jHJMWReJUtG1nE3oEk08bIwD08K
         STY92EXsBsrDI0R/poGLwVjEx5m6I8D7XgHhS09BUQDjxIi3oEstge9oGZiXqRYogG
         /pTUjS2gJhPDPP/dPQAGEDU5Xvn+Kj7RI+k9Lb2w+92gyaWyrIKiT80TorWXIIcIRJ
         mB4KfHXZu1pMUroO7pcQRbnxXx+EeE/PA9qLR292sHy/JdP4QU8IIHSaWfB/a8u3Pt
         uX6I/Qll642d0VvRcTL5YoTARTvJAqVn20qS/eDpUdqS6d2jYyZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/17] builtin/update-index: simplify parsing of cacheinfo
Date:   Sun,  8 Jul 2018 23:36:31 +0000
Message-Id: <20180708233638.520172-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch from using get_oid_hex to parse_oid_hex to simplify pointer
operations and avoid the need for a hash-related constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/update-index.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 031cef5229..3206c5ad45 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -827,6 +827,7 @@ static int parse_new_style_cacheinfo(const char *arg,
 {
 	unsigned long ul;
 	char *endp;
+	const char *p;
 
 	if (!arg)
 		return -1;
@@ -837,9 +838,9 @@ static int parse_new_style_cacheinfo(const char *arg,
 		return -1; /* not a new-style cacheinfo */
 	*mode = ul;
 	endp++;
-	if (get_oid_hex(endp, oid) || endp[GIT_SHA1_HEXSZ] != ',')
+	if (parse_oid_hex(endp, oid, &p) || *p != ',')
 		return -1;
-	*path = endp + GIT_SHA1_HEXSZ + 1;
+	*path = p + 1;
 	return 0;
 }
 
