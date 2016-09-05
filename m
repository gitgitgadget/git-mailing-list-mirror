Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBCB2070F
	for <e@80x24.org>; Mon,  5 Sep 2016 20:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964955AbcIEUKY (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:10:24 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42990 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964885AbcIEUI1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2DE02280AB;
        Mon,  5 Sep 2016 20:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106106;
        bh=+XqRZR6VHfEP8kyVSv0BVaoqxN+XufIkTYESS05DFDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+gE0qLkpI5hMo5q5E4+Dfipm/azKvw91D0d4WXPPt6flBuX8BbFxhdYkdM05fqbT
         RV9bqsA9TMdyXzpVXxpmCJReIGNB94rBucCxfnTzZMpLStFVJAyyTLnug8R18+lrqL
         H9V/8kqkkGE1EI1yeiaBomRDUsdGSGwGXixNbaRFbjzuCYkmFbKE9NodF3FLZUBZ32
         g7f81MosPc/QyM/XJEmJTBJ5DNCiMYp5eAdu1ZJKFQmUMyY/km1i4xJP9h0tVNW36/
         Y3t+xOSlA3w2Y5xEczWiSSYEgUqHXiNKAXbNvm1t0/iAXfiF2CceWz5lFCI/VwXxx/
         Nan+fewfWbV4z/oIjW1VrZEc1zS1b6g0up+6s/mglDjHhwqJfLmPUcrBALz7jzTnry
         +lmeT8J8w9uZePUrxUxSBLxTQ6jOCrN2yNpdVUBaWg7bEEVJkTCeF3xRZvS6SbE+QA
         yrV1DPf37+ej41Z4qYbvbXI7el4rBmo9XUIIxXk/puF9ydXEFlP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 05/20] builtin/cat-file: convert struct expand_data to use struct object_id
Date:   Mon,  5 Sep 2016 20:07:56 +0000
Message-Id: <20160905200811.697889-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct cache_entry to use struct object_id by applying the
following semantic patch and the object_id transforms from contrib,
plus the actual change to the struct:

@@
struct expand_data E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct expand_data *E1;
@@
- E1->sha1
+ E1->oid.hash

@@
struct expand_data E1;
@@
- E1.delta_base_sha1
+ E1.delta_base_oid.hash

@@
struct expand_data *E1;
@@
- E1->delta_base_sha1
+ E1->delta_base_oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2dfe6265..16b0b8c9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -128,12 +128,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 }
 
 struct expand_data {
-	unsigned char sha1[20];
+	struct object_id oid;
 	enum object_type type;
 	unsigned long size;
 	off_t disk_size;
 	const char *rest;
-	unsigned char delta_base_sha1[20];
+	struct object_id delta_base_oid;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -176,7 +176,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 
 	if (is_atom("objectname", atom, len)) {
 		if (!data->mark_query)
-			strbuf_addstr(sb, sha1_to_hex(data->sha1));
+			strbuf_addstr(sb, oid_to_hex(&data->oid));
 	} else if (is_atom("objecttype", atom, len)) {
 		if (data->mark_query)
 			data->info.typep = &data->type;
@@ -199,9 +199,10 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			strbuf_addstr(sb, data->rest);
 	} else if (is_atom("deltabase", atom, len)) {
 		if (data->mark_query)
-			data->info.delta_base_sha1 = data->delta_base_sha1;
+			data->info.delta_base_sha1 = data->delta_base_oid.hash;
 		else
-			strbuf_addstr(sb, sha1_to_hex(data->delta_base_sha1));
+			strbuf_addstr(sb,
+				      oid_to_hex(&data->delta_base_oid));
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
@@ -232,7 +233,7 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 
 static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
 {
-	const unsigned char *sha1 = data->sha1;
+	const unsigned char *sha1 = data->oid.hash;
 
 	assert(data->info.typep);
 
@@ -266,8 +267,9 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
-		printf("%s missing\n", obj_name ? obj_name : sha1_to_hex(data->sha1));
+	    sha1_object_info_extended(data->oid.hash, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
+		printf("%s missing\n",
+		       obj_name ? obj_name : oid_to_hex(&data->oid));
 		fflush(stdout);
 		return;
 	}
@@ -290,7 +292,7 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
-	result = get_sha1_with_context(obj_name, flags, data->sha1, &ctx);
+	result = get_sha1_with_context(obj_name, flags, data->oid.hash, &ctx);
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
@@ -336,7 +338,7 @@ struct object_cb_data {
 static void batch_object_cb(const unsigned char sha1[20], void *vdata)
 {
 	struct object_cb_data *data = vdata;
-	hashcpy(data->expand->sha1, sha1);
+	hashcpy(data->expand->oid.hash, sha1);
 	batch_object_write(NULL, data->opt, data->expand);
 }
 
