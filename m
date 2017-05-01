Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41661FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642319AbdEACaY (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:24 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35626 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642313AbdEACaE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4F12A280B1;
        Mon,  1 May 2017 02:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605803;
        bh=B746u6Sm7BmkcOL+7Oi1j/JhEhYh1PbxHLbpo1vd0QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z1zwJL15VwuEYM/Q7B9lQABlIfS5vWc1g5bmakd5aLDBn+Ep/EqUUHNK0nT0mZI2F
         UkjvJARW7OWx8NBaysgw/N+20vzqMFED89WoMswM7+60Qafcw4sJ7YiWz9T4Dk/XtG
         XtGxyPWs0tCe6+wWqcmfDMO2lVc6OCd/b1l0yusIp/KCFhbyWpq7c4/e2NY1EYW1qh
         0fP7qdr5CdUaZscwnhvefEtzPKPX7gnadG4KXQDiVg0xTm+H+zeGT9+ZywxVSxSFUz
         hD4aWmV8J+2GrDX7omrwULe/7kZLHmKChfDfOR5CPSoRgZ3yjVDd7Mv8Cf+nPMJREW
         xWOsFrO0MGbqn4e6dfkDKSM5/NZ0z1ky313ibMhd5eiNBHp7fjSQgbT+TbVOGHCQBg
         9RoCG/VS3VoN+McCbb6rtaCmAhGcu0YNbOAPTlwS4uHT5g5eLBPjcRO9TPAPs4SlDl
         p88/XFG1aKyMzEYg780clJDDpOGy67g06KN4NiK0uIoSkIy/zGO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/53] builtin/name-rev: convert to struct object_id
Date:   Mon,  1 May 2017 02:28:57 +0000
Message-Id: <20170501022946.258735-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all the uses of unsigned char [20] to struct object_id.  Also,
convert some hard-coded integers into constants.

name_rev_line accepts a wide variety of free-form input and only
interprets 40-character hex values, passing through everything else.
Consequently, it is not a good candidate for parse_oid_hex, which is
much stricter.

This change is a prerequisite for converting parse_object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/name-rev.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 92a5d8a5d..00760ecc6 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -114,7 +114,7 @@ struct name_ref_data {
 
 static struct tip_table {
 	struct tip_table_entry {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *refname;
 	} *table;
 	int nr;
@@ -122,13 +122,13 @@ static struct tip_table {
 	int sorted;
 } tip_table;
 
-static void add_to_tip_table(const unsigned char *sha1, const char *refname,
+static void add_to_tip_table(const struct object_id *oid, const char *refname,
 			     int shorten_unambiguous)
 {
 	refname = name_ref_abbrev(refname, shorten_unambiguous);
 
 	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
-	hashcpy(tip_table.table[tip_table.nr].sha1, sha1);
+	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
 	tip_table.table[tip_table.nr].refname = xstrdup(refname);
 	tip_table.nr++;
 	tip_table.sorted = 0;
@@ -137,7 +137,7 @@ static void add_to_tip_table(const unsigned char *sha1, const char *refname,
 static int tipcmp(const void *a_, const void *b_)
 {
 	const struct tip_table_entry *a = a_, *b = b_;
-	return hashcmp(a->sha1, b->sha1);
+	return oidcmp(&a->oid, &b->oid);
 }
 
 static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
@@ -194,7 +194,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 			return 0;
 	}
 
-	add_to_tip_table(oid->hash, path, can_abbreviate_output);
+	add_to_tip_table(oid, path, can_abbreviate_output);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
@@ -216,7 +216,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 static const unsigned char *nth_tip_table_ent(size_t ix, void *table_)
 {
 	struct tip_table_entry *table = table_;
-	return table[ix].sha1;
+	return table[ix].oid.hash;
 }
 
 static const char *get_exact_ref_match(const struct object *o)
@@ -301,9 +301,9 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
 		if (!ishex(*p))
 			forty = 0;
-		else if (++forty == 40 &&
+		else if (++forty == GIT_SHA1_HEXSZ &&
 			 !ishex(*(p+1))) {
-			unsigned char sha1[40];
+			struct object_id oid;
 			const char *name = NULL;
 			char c = *(p+1);
 			int p_len = p - p_start + 1;
@@ -311,9 +311,9 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			forty = 0;
 
 			*(p+1) = 0;
-			if (!get_sha1(p - 39, sha1)) {
+			if (!get_oid(p - (GIT_SHA1_HEXSZ - 1), &oid)) {
 				struct object *o =
-					lookup_object(sha1);
+					lookup_object(oid.hash);
 				if (o)
 					name = get_rev_name(o, &buf);
 			}
@@ -323,7 +323,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 				continue;
 
 			if (data->name_only)
-				printf("%.*s%s", p_len - 40, p_start, name);
+				printf("%.*s%s", p_len - GIT_SHA1_HEXSZ, p_start, name);
 			else
 				printf("%.*s (%s)", p_len, p_start, name);
 			p_start = p + 1;
@@ -374,18 +374,18 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		cutoff = 0;
 
 	for (; argc; argc--, argv++) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct object *object;
 		struct commit *commit;
 
-		if (get_sha1(*argv, sha1)) {
+		if (get_oid(*argv, &oid)) {
 			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
 					*argv);
 			continue;
 		}
 
 		commit = NULL;
-		object = parse_object(sha1);
+		object = parse_object(oid.hash);
 		if (object) {
 			struct object *peeled = deref_tag(object, *argv, 0);
 			if (peeled && peeled->type == OBJ_COMMIT)
