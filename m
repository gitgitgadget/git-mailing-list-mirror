Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE99D207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046125AbdDWVfs (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:48 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37314 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046087AbdDWVfa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6FAC6280B3;
        Sun, 23 Apr 2017 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983329;
        bh=tPy2ko+j/g10Df4wjtQ/Dhm7MtB6Njhmh38YsjkP6H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCZUm50cscjyll64V48cb45MhNokxhSqnRRHPmz8ekSD2ofmBCzSjaVbvxHxwNId9
         u5kK38y/gnPE7XZLnskkq2j0x+RYjiygptqvf84FWPjZemZL9sVgS8nAKYX/lvWiPn
         0Oxmq9p1Dh5PhS4dX4U6Wj7pdIhK/kLlrFJ9r4MuImGHKDQri7+zVZ+fv7IaozsVj0
         4Ao6qf13jWfMW92snM8ab6+DlJsvsclgADQtW0s4+OBzoUwf+NP7DyOqzOVfdP/ufn
         f3zEfe1/fxhfKwCkFPXYnNVzx5GhxzMM6QGStkwqNkltr7iVZpv3X82TYkPdbTVpLv
         sVe8FSEAxMbrwJwlF4ARltH/tob+pirjgl/VTGxeX0o/xzRuBUi5wS5WSZnW9VFUib
         D5nMKXUDHECwm4q38h9AQkINcNPZNNatbIZKSvKca9B+zFe4IVLds67GtParrj7Blx
         0Za0t3GPvgvWfvJ8rX1RNY5pXtXimZZwoLWvOeP1EpL4EehS2NY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/53] bundle: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:06 +0000
Message-Id: <20170423213453.253425-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the bundle code, plus the sole external user of struct
ref_list_entry, to use struct object_id.  Include cache.h from within
bundle.h to provide the definition.  Convert some of the hash parsing
code to use parse_oid_hex to avoid needing to hard-code constant values.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bundle.c    | 33 +++++++++++++++++----------------
 bundle.h    |  4 +++-
 transport.c |  2 +-
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/bundle.c b/bundle.c
index bbf4efa0a..6e181bb3d 100644
--- a/bundle.c
+++ b/bundle.c
@@ -12,11 +12,11 @@
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
-static void add_to_ref_list(const unsigned char *sha1, const char *name,
+static void add_to_ref_list(const struct object_id *oid, const char *name,
 		struct ref_list *list)
 {
 	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
-	hashcpy(list->list[list->nr].sha1, sha1);
+	oidcpy(&list->list[list->nr].oid, oid);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
 }
@@ -40,8 +40,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	/* The bundle header ends with an empty line */
 	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
 	       buf.len && buf.buf[0] != '\n') {
-		unsigned char sha1[20];
+		struct object_id oid;
 		int is_prereq = 0;
+		const char *p;
 
 		if (*buf.buf == '-') {
 			is_prereq = 1;
@@ -54,9 +55,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		 * Prerequisites have object name that is optionally
 		 * followed by SP and subject line.
 		 */
-		if (get_sha1_hex(buf.buf, sha1) ||
-		    (buf.len > 40 && !isspace(buf.buf[40])) ||
-		    (!is_prereq && buf.len <= 40)) {
+		if (parse_oid_hex(buf.buf, &oid, &p) ||
+		    (*p && !isspace(*p)) ||
+		    (!is_prereq && !*p)) {
 			if (report_path)
 				error(_("unrecognized header: %s%s (%d)"),
 				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
@@ -64,9 +65,9 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 			break;
 		} else {
 			if (is_prereq)
-				add_to_ref_list(sha1, "", &header->prerequisites);
+				add_to_ref_list(&oid, "", &header->prerequisites);
 			else
-				add_to_ref_list(sha1, buf.buf + 41, &header->references);
+				add_to_ref_list(&oid, p + 1, &header->references);
 		}
 	}
 
@@ -115,7 +116,7 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
 			if (j == argc)
 				continue;
 		}
-		printf("%s %s\n", sha1_to_hex(r->list[i].sha1),
+		printf("%s %s\n", oid_to_hex(&r->list[i].oid),
 				r->list[i].name);
 	}
 	return 0;
@@ -141,7 +142,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	init_revisions(&revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
-		struct object *o = parse_object(e->sha1);
+		struct object *o = parse_object(e->oid.hash);
 		if (o) {
 			o->flags |= PREREQ_MARK;
 			add_pending_object(&revs, o, e->name);
@@ -149,7 +150,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		}
 		if (++ret == 1)
 			error("%s", message);
-		error("%s %s", sha1_to_hex(e->sha1), e->name);
+		error("%s %s", oid_to_hex(&e->oid), e->name);
 	}
 	if (revs.pending.nr != p->nr)
 		return ret;
@@ -285,16 +286,16 @@ static int compute_and_write_prerequisites(int bundle_fd,
 		return -1;
 	rls_fout = xfdopen(rls.out, "r");
 	while (strbuf_getwholeline(&buf, rls_fout, '\n') != EOF) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		if (buf.len > 0 && buf.buf[0] == '-') {
 			write_or_die(bundle_fd, buf.buf, buf.len);
-			if (!get_sha1_hex(buf.buf + 1, sha1)) {
-				struct object *object = parse_object_or_die(sha1, buf.buf);
+			if (!get_oid_hex(buf.buf + 1, &oid)) {
+				struct object *object = parse_object_or_die(oid.hash, buf.buf);
 				object->flags |= UNINTERESTING;
 				add_pending_object(revs, object, buf.buf);
 			}
-		} else if (!get_sha1_hex(buf.buf, sha1)) {
-			struct object *object = parse_object_or_die(sha1, buf.buf);
+		} else if (!get_oid_hex(buf.buf, &oid)) {
+			struct object *object = parse_object_or_die(oid.hash, buf.buf);
 			object->flags |= SHOWN;
 		}
 	}
diff --git a/bundle.h b/bundle.h
index 1584e4d82..e9a4cb6a7 100644
--- a/bundle.h
+++ b/bundle.h
@@ -1,10 +1,12 @@
 #ifndef BUNDLE_H
 #define BUNDLE_H
 
+#include "cache.h"
+
 struct ref_list {
 	unsigned int nr, alloc;
 	struct ref_list_entry {
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *name;
 	} *list;
 };
diff --git a/transport.c b/transport.c
index 4d33138a7..9bfcf870f 100644
--- a/transport.c
+++ b/transport.c
@@ -87,7 +87,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
-		hashcpy(ref->old_oid.hash, e->sha1);
+		oidcpy(&ref->old_oid, &e->oid);
 		ref->next = result;
 		result = ref;
 	}
