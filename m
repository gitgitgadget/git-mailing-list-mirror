Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEAA1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999545AbdEACbZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:25 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36056 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642366AbdEACag (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4EC7B280C5;
        Mon,  1 May 2017 02:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605808;
        bh=bU1IrTUlNtnykTpZhNtgtukFmdu3rCw99SrJIl6dJFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkDl5EUSojRRjUgBjP9Al8kaTgb7U7QeIelFbAgsAPqgIjkbZL7BsqT7X+N/8pWj6
         CaeCIQS9xywX5I5S4cR0+MaHPZs8OjH7j/Gmbwz8TYk4LsZ9/Hfkb6Nl/JubXtWPOz
         FBMOQ/eUAOni2YLgVEz3IEoHQQVE37hJnMlFTIitPJl5pXiMKHKypBbdG6ZItwqAUN
         N+XVHcKyeK2E4NzFu6JMEmcAW5ijVZOeqRkniOgRkOt42Mi9xiR0mGioOIVfhazaPH
         U0C+TGVCtWzTc+AZox8+/w2A1j2VFctJORAYkfe+YRbRE0fvYf+MUfWNxT7ORz1g7M
         +SY3EpS0NnKSW59Ifj+7mNURlIo7ezHUysA6mWrQNFxPINSx3fVUXmmTR17//Y2VkM
         UQ8GNxxAnVrH/gTausGe48ofXRGT6jmdLRHEtOXey7esEn2QW1NKC4PxXXNiCYMvZo
         fRq1nk9YLdReiIjL6RLj6RokuvQt18Q9pJwURdWHPe9VmQWulfX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 23/53] builtin/tag: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:16 +0000
Message-Id: <20170501022946.258735-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
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
