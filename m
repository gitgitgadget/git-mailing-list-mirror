Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F95F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 01:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeGPBxY (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 21:53:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbeGPBxY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Jul 2018 21:53:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:78f3:848c:e199:5398])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6A15E60734;
        Mon, 16 Jul 2018 01:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531704507;
        bh=bt+JzfYBt0f5RZuh8bkJnKJD4uRrCQiOWdSkbIKECbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dj2ljY1zjZDVtgNyD72S1hO865dOO7xMloKesZ7DmiqgP1hIZfMjW2vN6gYJbJKqL
         nfSJg6MK41WgzAfrg7kwfplc7OuBnJPL7QK1x/+pHnBi2lt+tkBZrHPMV9DxBk08Tp
         8sBrj+oA2+WeZ+/JKpRSrnMYaPYnQ19h0ZdeSttmOlAqH5mXXBr9jYLjjB+TtubJnQ
         YaqrtLdh5ZjiAn7P2N98gSW+IHHVw44jvdBh0uf/JYeby3P1snLQLNTEnWsLWt8DiY
         jWSwMpvjc9E1KVmtnUcKYayL4uttdky6ke6wla1z1tJlNv2fg8TIIirshlQCGfThh/
         ecsQm0aFaU70+qbKi3wyx3q40mGmo8XxVpahAADSGdkwyF042qSJ+1ASvaa2pC6rK3
         9BEt7tG04IQeSqimjvZmahggf7IMjt0yfpbCxrR8Krfq1zIA7IKnLb5aSW5e7V+3jx
         tSHG9Pmdq7QWG1OMj8XWjTT7dZQowrbFsDliCyqevWftvDE72KB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 09/16] builtin/update-index: simplify parsing of cacheinfo
Date:   Mon, 16 Jul 2018 01:28:01 +0000
Message-Id: <20180716012808.961328-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180716012808.961328-1-sandals@crustytoothpaste.net>
References: <20180716012808.961328-1-sandals@crustytoothpaste.net>
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
 
