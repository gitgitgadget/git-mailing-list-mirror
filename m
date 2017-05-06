Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51654207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbdEFWMH (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:07 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37650 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754299AbdEFWLS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8CBE6280C2;
        Sat,  6 May 2017 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108671;
        bh=bU1IrTUlNtnykTpZhNtgtukFmdu3rCw99SrJIl6dJFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncF2wmV2u8wCSklCFrT+RVcfVczuyegFiq7ynN7gi8Z3Vs/mlby0OHoexdVxAI5pg
         sqSm9BVH8aiCybyCb1q5pvEA0ZAGtTkNMNPOLj8LZyipNTdNHePnzehfFM2yY826aR
         8y+nyxDIyuKu8x/b326Jo0m58mVXjc7koQZTtkfGbuV/0WEOyHBJbMHu5ppJM0Oi0O
         1VlfUjiQaEsxerGjJOG1tF8zaB5/FtXBO4bfTK548gw/hx2c+LU2+//GmJHDSHAUrN
         5kvukDMg/dqWZtzqdExQjTTm0P2Bg0nw/QVCVROEAoUnOEZeIrmGEGqIFny5bE2kxo
         3wNcYEW4n7BQuUkm2AF+FRkb79IFAdB8iN33bcF7ZbS0wamnygbk3hr3gZabP71uIz
         kVO7gBaXojOyQdx6s3pQiSpffePolcaHUq1PTsR7dSYT8NvfDMAo4i1NiWlO9UQKl3
         hTa4XtD9X1dOyFCbggTPSe97LU25zmtpwmdpf/CtcKuP41O6NNM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 23/53] builtin/tag: convert to struct object_id
Date:   Sat,  6 May 2017 22:10:08 +0000
Message-Id: <20170506221038.296722-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Parts of this module call lookup_commit_reference, which we want to
convert.  The module is small and mostly self-contained, so convert the
rest of it while we're at it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/tag.c | 66 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 222404522..597c925e3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -66,7 +66,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1, const void *cb_data);
+				const struct object_id *oid, const void *cb_data);
 
 static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 			     const void *cb_data)
@@ -74,17 +74,17 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 	const char **p;
 	struct strbuf ref = STRBUF_INIT;
 	int had_error = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	for (p = argv; *p; p++) {
 		strbuf_reset(&ref);
 		strbuf_addf(&ref, "refs/tags/%s", *p);
-		if (read_ref(ref.buf, sha1)) {
+		if (read_ref(ref.buf, oid.hash)) {
 			error(_("tag '%s' not found."), *p);
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref.buf, sha1, cb_data))
+		if (fn(*p, ref.buf, &oid, cb_data))
 			had_error = 1;
 	}
 	strbuf_release(&ref);
@@ -92,16 +92,16 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 }
 
 static int delete_tag(const char *name, const char *ref,
-		      const unsigned char *sha1, const void *cb_data)
+		      const struct object_id *oid, const void *cb_data)
 {
-	if (delete_ref(NULL, ref, sha1, 0))
+	if (delete_ref(NULL, ref, oid->hash, 0))
 		return 1;
-	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(sha1, DEFAULT_ABBREV));
+	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 	return 0;
 }
 
 static int verify_tag(const char *name, const char *ref,
-		      const unsigned char *sha1, const void *cb_data)
+		      const struct object_id *oid, const void *cb_data)
 {
 	int flags;
 	const char *fmt_pretty = cb_data;
@@ -110,11 +110,11 @@ static int verify_tag(const char *name, const char *ref,
 	if (fmt_pretty)
 		flags = GPG_VERIFY_OMIT_STATUS;
 
-	if (gpg_verify_tag(sha1, name, flags))
+	if (gpg_verify_tag(oid->hash, name, flags))
 		return -1;
 
 	if (fmt_pretty)
-		pretty_print_ref(name, sha1, fmt_pretty);
+		pretty_print_ref(name, oid->hash, fmt_pretty);
 
 	return 0;
 }
@@ -182,13 +182,13 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void write_tag_body(int fd, const unsigned char *sha1)
+static void write_tag_body(int fd, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
 	char *buf, *sp;
 
-	buf = read_sha1_file(sha1, &type, &size);
+	buf = read_sha1_file(oid->hash, &type, &size);
 	if (!buf)
 		return;
 	/* skip header */
@@ -204,11 +204,11 @@ static void write_tag_body(int fd, const unsigned char *sha1)
 	free(buf);
 }
 
-static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
+static int build_tag_object(struct strbuf *buf, int sign, struct object_id *result)
 {
 	if (sign && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
-	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
+	if (write_sha1_file(buf->buf, buf->len, tag_type, result->hash) < 0)
 		return error(_("unable to write tag file"));
 	return 0;
 }
@@ -223,15 +223,15 @@ struct create_tag_options {
 	} cleanup_mode;
 };
 
-static void create_tag(const unsigned char *object, const char *tag,
+static void create_tag(const struct object_id *object, const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       unsigned char *prev, unsigned char *result)
+		       struct object_id *prev, struct object_id *result)
 {
 	enum object_type type;
 	struct strbuf header = STRBUF_INIT;
 	char *path = NULL;
 
-	type = sha1_object_info(object, NULL);
+	type = sha1_object_info(object->hash, NULL);
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
@@ -240,7 +240,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 		    "type %s\n"
 		    "tag %s\n"
 		    "tagger %s\n\n",
-		    sha1_to_hex(object),
+		    oid_to_hex(object),
 		    typename(type),
 		    tag,
 		    git_committer_info(IDENT_STRICT));
@@ -254,7 +254,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 		if (fd < 0)
 			die_errno(_("could not create file '%s'"), path);
 
-		if (!is_null_sha1(prev)) {
+		if (!is_null_oid(prev)) {
 			write_tag_body(fd, prev);
 		} else {
 			struct strbuf buf = STRBUF_INIT;
@@ -296,7 +296,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	}
 }
 
-static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
+static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 {
 	enum object_type type;
 	struct commit *c;
@@ -310,17 +310,17 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
 		strbuf_addstr(sb, rla);
 	} else {
 		strbuf_addstr(sb, _("tag: tagging "));
-		strbuf_add_unique_abbrev(sb, sha1, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(sb, oid->hash, DEFAULT_ABBREV);
 	}
 
 	strbuf_addstr(sb, " (");
-	type = sha1_object_info(sha1, NULL);
+	type = sha1_object_info(oid->hash, NULL);
 	switch (type) {
 	default:
 		strbuf_addstr(sb, _("object of unknown type"));
 		break;
 	case OBJ_COMMIT:
-		if ((buf = read_sha1_file(sha1, &type, &size)) != NULL) {
+		if ((buf = read_sha1_file(oid->hash, &type, &size)) != NULL) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
@@ -328,7 +328,7 @@ static void create_reflog_msg(const unsigned char *sha1, struct strbuf *sb)
 		}
 		free(buf);
 
-		if ((c = lookup_commit_reference(sha1)) != NULL)
+		if ((c = lookup_commit_reference(oid->hash)) != NULL)
 			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
@@ -378,7 +378,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ref = STRBUF_INIT;
 	struct strbuf reflog_msg = STRBUF_INIT;
-	unsigned char object[20], prev[20];
+	struct object_id object, prev;
 	const char *object_ref, *tag;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
@@ -528,14 +528,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (argc > 2)
 		die(_("too many params"));
 
-	if (get_sha1(object_ref, object))
+	if (get_oid(object_ref, &object))
 		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
 
 	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
 
-	if (read_ref(ref.buf, prev))
-		hashclr(prev);
+	if (read_ref(ref.buf, prev.hash))
+		oidclr(&prev);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
@@ -550,24 +550,24 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
-	create_reflog_msg(object, &reflog_msg);
+	create_reflog_msg(&object, &reflog_msg);
 
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
-		create_tag(object, tag, &buf, &opt, prev, object);
+		create_tag(&object, tag, &buf, &opt, &prev, &object);
 	}
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref.buf, object, prev,
+	    ref_transaction_update(transaction, ref.buf, object.hash, prev.hash,
 				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
 				   reflog_msg.buf, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
-	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
-		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
+	if (force && !is_null_oid(&prev) && oidcmp(&prev, &object))
+		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev.hash, DEFAULT_ABBREV));
 
 	strbuf_release(&err);
 	strbuf_release(&buf);
