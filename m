Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B543AEEB56E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbjIHXLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbjIHXLk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:11:40 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B6F1705
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:11:34 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39318)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdR-006Mmt-5F; Fri, 08 Sep 2023 17:11:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdP-009u13-GA; Fri, 08 Sep 2023 17:11:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:21 -0500
Message-Id: <20230908231049.2035003-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdP-009u13-GA;;;mid=<20230908231049.2035003-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+noybTYetKZVPWNmFnWPMZwPRygUOVSGo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 04/32] object-name: Initial support for ^{sha1} and ^{sha256}
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Documentation/technical/hash-function-transition.txt it suggests
supporting references like abac87a^{sha1} and f787cac^{sha256}.

This changes goes a step farther and supports a short oid in any
algorithm, and to just ensures enough of the oid is present to
disambiguate between all possible oids in any algorithm.

Support for suffixes of ^{sha1} and ^{sha256} is implemented as it is
easy, and can be handy for testing.  To support this mode of operation
two flags are added: GET_OID_SHA1, and GET_OID_SHA256.

By default when an oid is specified in an algorithm that does not
match the algorithm of the repository, the oid is translated to the
oid that matches the hash algorithm of the repository.  This ensures
oids that don't match the repository hash algorithm can be used
everywhere oids can currently be used.

A new flag is added GET_OID_UNTRANSLATED that suppresses the
translation of an oid into the repositories hash algorithm.
This is useful for testing and raw tools like git cat-file.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 hash-ll.h     |  3 +++
 object-name.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/hash-ll.h b/hash-ll.h
index 10d84cc20888..2a4f72d70c3f 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -143,8 +143,11 @@ struct object_id {
 #define GET_OID_BLOB             040
 #define GET_OID_FOLLOW_SYMLINKS 0100
 #define GET_OID_RECORD_PATH     0200
+#define GET_OID_SHA1           01000
+#define GET_OID_SHA256         02000
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
+#define GET_OID_UNTRANSLATED  020000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 0bfa29dbbfe9..ebe87f5c4fdd 100644
--- a/object-name.c
+++ b/object-name.c
@@ -25,6 +25,7 @@
 #include "midx.h"
 #include "commit-reach.h"
 #include "date.h"
+#include "object-file-convert.h"
 
 static int get_oid_oneline(struct repository *r, const char *, struct object_id *, struct commit_list *);
 
@@ -32,6 +33,7 @@ typedef int (*disambiguate_hint_fn)(struct repository *, const struct object_id
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
+	int algo;
 	char hex_pfx[GIT_MAX_HEXSZ + 1];
 	struct object_id bin_pfx;
 
@@ -49,6 +51,10 @@ struct disambiguate_state {
 
 static void update_candidates(struct disambiguate_state *ds, const struct object_id *current)
 {
+	/* Is the oid encoded in the desired algo? */
+	if (ds->algo && (current->algo != ds->algo))
+		return;
+
 	if (ds->always_call_fn) {
 		ds->ambiguous = ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
 		return;
@@ -134,6 +140,8 @@ static void unique_in_midx(struct multi_pack_index *m,
 {
 	uint32_t num, i, first = 0;
 	const struct object_id *current = NULL;
+	int len = ds->len > ds->repo->hash_algo->hexsz ?
+		ds->repo->hash_algo->hexsz : ds->len;
 	num = m->num_objects;
 
 	if (!num)
@@ -149,7 +157,7 @@ static void unique_in_midx(struct multi_pack_index *m,
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		current = nth_midxed_object_oid(&oid, m, i);
-		if (!match_hash(ds->len, ds->bin_pfx.hash, current->hash))
+		if (!match_hash(len, ds->bin_pfx.hash, current->hash))
 			break;
 		update_candidates(ds, current);
 	}
@@ -159,6 +167,8 @@ static void unique_in_pack(struct packed_git *p,
 			   struct disambiguate_state *ds)
 {
 	uint32_t num, i, first = 0;
+	int len = ds->len > ds->repo->hash_algo->hexsz ?
+		ds->repo->hash_algo->hexsz : ds->len;
 
 	if (p->multi_pack_index)
 		return;
@@ -177,7 +187,7 @@ static void unique_in_pack(struct packed_git *p,
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		struct object_id oid;
 		nth_packed_object_id(&oid, p, i);
-		if (!match_hash(ds->len, ds->bin_pfx.hash, oid.hash))
+		if (!match_hash(len, ds->bin_pfx.hash, oid.hash))
 			break;
 		update_candidates(ds, &oid);
 	}
@@ -188,6 +198,10 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
+	/* Skip, unless oids from the repository algorithm are wanted */
+	if (ds->algo && (&hash_algos[ds->algo] != ds->repo->hash_algo))
+		return;
+
 	for (m = get_multi_pack_index(ds->repo); m && !ds->ambiguous;
 	     m = m->next)
 		unique_in_midx(m, ds);
@@ -330,7 +344,7 @@ static int init_object_disambiguation(struct repository *r,
 {
 	int i;
 
-	if (len < MINIMUM_ABBREV || len > the_hash_algo->hexsz)
+	if (len < MINIMUM_ABBREV || len > GIT_MAX_HEXSZ)
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
@@ -357,6 +371,7 @@ static int init_object_disambiguation(struct repository *r,
 	ds->len = len;
 	ds->hex_pfx[len] = '\0';
 	ds->repo = r;
+	ds->algo = GIT_HASH_UNKNOWN;
 	prepare_alt_odb(r);
 	return 0;
 }
@@ -491,9 +506,10 @@ static int repo_collect_ambiguous(struct repository *r UNUSED,
 	return collect_ambiguous(oid, data);
 }
 
-static int sort_ambiguous(const void *a, const void *b, void *ctx)
+static int sort_ambiguous(const void *va, const void *vb, void *ctx)
 {
 	struct repository *sort_ambiguous_repo = ctx;
+	const struct object_id *a = va, *b = vb;
 	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
 	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
@@ -503,8 +519,13 @@ static int sort_ambiguous(const void *a, const void *b, void *ctx)
 	 * Sorts by hash within the same object type, just as
 	 * oid_array_for_each_unique() would do.
 	 */
-	if (a_type == b_type)
-		return oidcmp(a, b);
+	if (a_type == b_type) {
+		/* Is the hash algorithm the same? */
+		if (a->algo == b->algo)
+			return oidcmp(a, b);
+		else
+			return a->algo < b->algo ? -1 : 1;
+	}
 
 	/*
 	 * Between object types show tags, then commits, and finally
@@ -553,6 +574,11 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	else
 		ds.fn = default_disambiguate_hint;
 
+	if (flags & GET_OID_SHA1)
+		ds.algo = GIT_HASH_SHA1;
+	else if (flags & GET_OID_SHA256)
+		ds.algo = GIT_HASH_SHA256;
+
 	find_short_object_filename(&ds);
 	find_short_packed_object(&ds);
 	status = finish_object_disambiguation(&ds, oid);
@@ -606,6 +632,15 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		strbuf_release(&out.sb);
 	}
 
+	/* Ensure oid->algo is set */
+	if (oid->algo == GIT_HASH_UNKNOWN)
+		oid->algo = hash_algo_by_ptr(r->hash_algo);
+
+	/* Return oids using the repository's hash algorithm */
+	if ((&hash_algos[oid->algo] != r->hash_algo) &&
+	    !(flags & GET_OID_UNTRANSLATED))
+		repo_oid_to_algop(r, oid, r->hash_algo, oid);
+
 	return status;
 }
 
@@ -787,10 +822,12 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 			      const struct object_id *oid, int len)
 {
+	const struct git_hash_algo *algo =
+		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
-	const unsigned hexsz = r->hash_algo->hexsz;
+	const unsigned hexsz = algo->hexsz;
 
 	if (len < 0) {
 		unsigned long count = repo_approximate_object_count(r);
@@ -1158,6 +1195,14 @@ static int peel_onion(struct repository *r, const char *name, int len,
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
+
+	if (starts_with(sp, "sha1}"))
+		return get_short_oid(r, name, len - 7, oid,
+				     lookup_flags | GET_OID_SHA1);
+	else if (starts_with(sp, "sha256"))
+		return get_short_oid(r, name, len - 9, oid,
+				     lookup_flags | GET_OID_SHA256);
+
 	if (starts_with(sp, "commit}"))
 		expected_type = OBJ_COMMIT;
 	else if (starts_with(sp, "tag}"))
-- 
2.41.0

