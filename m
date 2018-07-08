Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E971F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933182AbeGHXhD (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54364 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbeGHXhB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:37:01 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 333CF6073F;
        Sun,  8 Jul 2018 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093019;
        bh=3Nzuy+b7v3r21t7yYDe8GdniVMFQ7v5Rr/T+vDbYanw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=N3fuZ0XLx+AN+LDNDtOk7MsmhtEZAZJ/l+HAAnpZFXHrneOmirKaJSrUmW9YkrDVL
         6RGGk6xU5Z8HT6P1LrbGUBNqPg3g/7kNB1UK41lqgzeQAqA3bYmwwr0sJR4I9WqnPW
         1cP0s/Lj0n++FW3ub+Q6YZYvZIZLw5uZIOJIQZAD3cXqc4cToyucdMUNMF9rjLDLi0
         HjMC11Ytz6LQSY1/B4Ama+MoFsLpzqSjL2DanwrPd7X258HWL4iSVxX5+X4vp/KNWi
         Z6s6Oas+Rqzbo0JggSjrXIkAnFsD9Nk5xAdJLN/fTatrsHq9xU7pncfywxwAmOWZe+
         jggGrVXJdCDGIzsP2rzLga5EsPP4e/b3IcAN07SV1hhQrSi/zAp1EH6BllfvCjYeck
         NyOkaIn0h1c/LVGDAWeBYaYN8yRl+Uxnk/Urhz7VauByViyQL4L9BnHWrpcBznlwKj
         xfDRNoywZ9rrDc1NRH4AJMyxYihOb/JOX9J9juOqntYNw+pkuDK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/17] builtin/fmt-merge-msg: make hash independent
Date:   Sun,  8 Jul 2018 23:36:32 +0000
Message-Id: <20180708233638.520172-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert several uses of GIT_SHA1_HEXSZ into references to the_hash_algo.
Switch other uses into a use of parse_oid_hex and uses of its computed
pointer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fmt-merge-msg.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bd680be687..e8c13a2c03 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -108,14 +108,15 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	struct string_list_item *item;
 	int pulling_head = 0;
 	struct object_id oid;
+	const unsigned hexsz = the_hash_algo->hexsz;
 
-	if (len < GIT_SHA1_HEXSZ + 3 || line[GIT_SHA1_HEXSZ] != '\t')
+	if (len < hexsz + 3 || line[hexsz] != '\t')
 		return 1;
 
-	if (starts_with(line + GIT_SHA1_HEXSZ + 1, "not-for-merge"))
+	if (starts_with(line + hexsz + 1, "not-for-merge"))
 		return 0;
 
-	if (line[GIT_SHA1_HEXSZ + 1] != '\t')
+	if (line[hexsz + 1] != '\t')
 		return 2;
 
 	i = get_oid_hex(line, &oid);
@@ -130,7 +131,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 
 	if (line[len - 1] == '\n')
 		line[len - 1] = 0;
-	line += GIT_SHA1_HEXSZ + 2;
+	line += hexsz + 2;
 
 	/*
 	 * At this point, line points at the beginning of comment e.g.
@@ -342,7 +343,7 @@ static void shortlog(const char *name,
 	const struct object_id *oid = &origin_data->oid;
 	int limit = opts->shortlog_len;
 
-	branch = deref_tag(parse_object(oid), oid_to_hex(oid), GIT_SHA1_HEXSZ);
+	branch = deref_tag(parse_object(oid), oid_to_hex(oid), the_hash_algo->hexsz);
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
@@ -545,6 +546,7 @@ static void find_merge_parents(struct merge_parents *result,
 		int len;
 		char *p = in->buf + pos;
 		char *newline = strchr(p, '\n');
+		const char *q;
 		struct object_id oid;
 		struct commit *parent;
 		struct object *obj;
@@ -552,10 +554,9 @@ static void find_merge_parents(struct merge_parents *result,
 		len = newline ? newline - p : strlen(p);
 		pos += len + !!newline;
 
-		if (len < GIT_SHA1_HEXSZ + 3 ||
-		    get_oid_hex(p, &oid) ||
-		    p[GIT_SHA1_HEXSZ] != '\t' ||
-		    p[GIT_SHA1_HEXSZ + 1] != '\t')
+		if (parse_oid_hex(p, &oid, &q) ||
+		    q[0] != '\t' ||
+		    q[1] != '\t')
 			continue; /* skip not-for-merge */
 		/*
 		 * Do not use get_merge_parent() here; we do not have
