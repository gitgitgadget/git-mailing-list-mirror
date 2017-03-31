Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E41C20966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935093AbdCaBko (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:44 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59226 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935069AbdCaBkM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:12 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 53477280B8;
        Fri, 31 Mar 2017 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924410;
        bh=mnTKpk54ob9vsvwTQ6+qOGh7I7f1RH6LIPuMLFpE56I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuhGvHMGZdznNAXdJD5O8u9vs4qXwE8TYySF46LRgUBuCgm8sgUgPmprjWLqNW8Yf
         75uI0Er4JB80DK3Gh/p+y6bK0iX8L0lrgkMDnDxoE4QrnY1DZ3dEz+52cdN83miCWm
         cO2a1OjDhtawIGcOmLSnkHpbVmsiJpghqu3UV3wnx2PQi47myE+LqD11JTP45y6WWU
         Sw1NV3ljsMXRbiHu1DRN+ziqp60QW56s0iHOceL5leAG3GRLDsfCAoJivnF20Ysvyb
         twFDj9xJMMz5QgW1BkZ5acJvFxLaROpepnn+1Mv6/WSoPcDkmnFf5vDVbt84CRwMi1
         tn56VD8gAQp3jJ9CqdpH/lxpMSyevEC2ZoZ5+QBtsBXauCTWpRr7ziiZTcsjUtPPGm
         EP8W8rqQq5/NnSFW/5tlnCNk7mz8ymG/ugLchvGkJUyJIfmH1O2tiSWFtlS0ns2KCd
         kqCk6LeR2od3UY2GwjO0IHWzuYR5ZgAO4Aff54pnqQm/w1faTrd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/20] sha1_name: convert disambiguate_hint_fn to take object_id
Date:   Fri, 31 Mar 2017 01:39:52 +0000
Message-Id: <20170331014001.953484-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function pointer type and the functions that implement it
to take a struct object_id.  Introduce a temporary in
show_ambiguous_object to avoid having to convert for_each_abbrev at this
point.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 64 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index cf6f4be0c6..2e38aedfa5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -11,7 +11,7 @@
 
 static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
 
-typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
+typedef int (*disambiguate_hint_fn)(const struct object_id *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
@@ -29,7 +29,7 @@ struct disambiguate_state {
 	unsigned always_call_fn:1;
 };
 
-static void update_candidates(struct disambiguate_state *ds, const unsigned char *current)
+static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
 {
 	if (ds->always_call_fn) {
 		ds->ambiguous = ds->fn(current, ds->cb_data) ? 1 : 0;
@@ -37,10 +37,10 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 	}
 	if (!ds->candidate_exists) {
 		/* this is the first candidate */
-		hashcpy(ds->candidate.hash, current);
+		oidcpy(&ds->candidate, current);
 		ds->candidate_exists = 1;
 		return;
-	} else if (!hashcmp(ds->candidate.hash, current)) {
+	} else if (!oidcmp(&ds->candidate, current)) {
 		/* the same as what we already have seen */
 		return;
 	}
@@ -52,14 +52,14 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 	}
 
 	if (!ds->candidate_checked) {
-		ds->candidate_ok = ds->fn(ds->candidate.hash, ds->cb_data);
+		ds->candidate_ok = ds->fn(&ds->candidate, ds->cb_data);
 		ds->disambiguate_fn_used = 1;
 		ds->candidate_checked = 1;
 	}
 
 	if (!ds->candidate_ok) {
 		/* discard the candidate; we know it does not satisfy fn */
-		hashcpy(ds->candidate.hash, current);
+		oidcpy(&ds->candidate, current);
 		ds->candidate_checked = 0;
 		return;
 	}
@@ -107,15 +107,15 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 			continue;
 
 		while (!ds->ambiguous && (de = readdir(dir)) != NULL) {
-			unsigned char sha1[20];
+			struct object_id oid;
 
-			if (strlen(de->d_name) != 38)
+			if (strlen(de->d_name) != GIT_SHA1_HEXSZ - 2)
 				continue;
 			if (memcmp(de->d_name, ds->hex_pfx + 2, ds->len - 2))
 				continue;
-			memcpy(hex + 2, de->d_name, 38);
-			if (!get_sha1_hex(hex, sha1))
-				update_candidates(ds, sha1);
+			memcpy(hex + 2, de->d_name, GIT_SHA1_HEXSZ - 2);
+			if (!get_oid_hex(hex, &oid))
+				update_candidates(ds, &oid);
 		}
 		closedir(dir);
 	}
@@ -140,7 +140,7 @@ static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
 	uint32_t num, last, i, first = 0;
-	const unsigned char *current = NULL;
+	const struct object_id *current = NULL;
 
 	open_pack_index(p);
 	num = p->num_objects;
@@ -169,8 +169,9 @@ static void unique_in_pack(struct packed_git *p,
 	 * 0, 1 or more objects that actually match(es).
 	 */
 	for (i = first; i < num && !ds->ambiguous; i++) {
-		current = nth_packed_object_sha1(p, i);
-		if (!match_sha(ds->len, ds->bin_pfx.hash, current))
+		struct object_id oid;
+		current = nth_packed_object_oid(&oid, p, i);
+		if (!match_sha(ds->len, ds->bin_pfx.hash, current->hash))
 			break;
 		update_candidates(ds, current);
 	}
@@ -213,7 +214,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 		 * same repository!
 		 */
 		ds->candidate_ok = (!ds->disambiguate_fn_used ||
-				    ds->fn(ds->candidate.hash, ds->cb_data));
+				    ds->fn(&ds->candidate, ds->cb_data));
 
 	if (!ds->candidate_ok)
 		return SHORT_NAME_AMBIGUOUS;
@@ -222,57 +223,57 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 	return 0;
 }
 
-static int disambiguate_commit_only(const unsigned char *sha1, void *cb_data_unused)
+static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(sha1, NULL);
+	int kind = sha1_object_info(oid->hash, NULL);
 	return kind == OBJ_COMMIT;
 }
 
-static int disambiguate_committish_only(const unsigned char *sha1, void *cb_data_unused)
+static int disambiguate_committish_only(const struct object_id *oid, void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = sha1_object_info(sha1, NULL);
+	kind = sha1_object_info(oid->hash, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(sha1), NULL, 0);
+	obj = deref_tag(parse_object(oid->hash), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
 }
 
-static int disambiguate_tree_only(const unsigned char *sha1, void *cb_data_unused)
+static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(sha1, NULL);
+	int kind = sha1_object_info(oid->hash, NULL);
 	return kind == OBJ_TREE;
 }
 
-static int disambiguate_treeish_only(const unsigned char *sha1, void *cb_data_unused)
+static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_unused)
 {
 	struct object *obj;
 	int kind;
 
-	kind = sha1_object_info(sha1, NULL);
+	kind = sha1_object_info(oid->hash, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(parse_object(sha1), NULL, 0);
+	obj = deref_tag(parse_object(oid->hash), NULL, 0);
 	if (obj && (obj->type == OBJ_TREE || obj->type == OBJ_COMMIT))
 		return 1;
 	return 0;
 }
 
-static int disambiguate_blob_only(const unsigned char *sha1, void *cb_data_unused)
+static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(sha1, NULL);
+	int kind = sha1_object_info(oid->hash, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -344,10 +345,13 @@ static int init_object_disambiguation(const char *name, int len,
 static int show_ambiguous_object(const unsigned char *sha1, void *data)
 {
 	const struct disambiguate_state *ds = data;
+	struct object_id oid;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-	if (ds->fn && !ds->fn(sha1, ds->cb_data))
+
+	hashcpy(oid.hash, sha1);
+	if (ds->fn && !ds->fn(&oid, ds->cb_data))
 		return 0;
 
 	type = sha1_object_info(sha1, NULL);
@@ -422,9 +426,9 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
-static int collect_ambiguous(const unsigned char *sha1, void *data)
+static int collect_ambiguous(const struct object_id *oid, void *data)
 {
-	sha1_array_append(data, sha1);
+	sha1_array_append(data, oid->hash);
 	return 0;
 }
 
