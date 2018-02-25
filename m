Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401391F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeBYVNa (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33964 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751928AbeBYVMx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C8B3060E58;
        Sun, 25 Feb 2018 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593172;
        bh=9z8OLOa2u260m0wXwYvts2hEXb/bO1CGCjn/aGqW0zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=BwbSj5f/UiCF5Nai3ZCsC5PPUwGctphjRmSIW4edWDA4jJ9ab3+4/FHhkqYiJeixm
         T2QLTAsW/29XLj4XkKDOirLZnCWMK5w4EJS1uxupbaVVgjJkn9+wwW0yoYfqcitcXJ
         YzZDFFl8NuDwg5DR3JCcHMngS9mGTi1S1pLSwQMmSylfIpepAZApzfi+UwNG4x8Bw9
         x3oN7FfLxAK6YHSOrizjOde3o16ixfbXxIJKgpwuyH3WbCOLiONR2Ir31F1BYI5w3L
         4JeogunBKAfydScHT8uZuO9KimRL4/4BL+xQvaS9MEdh1rxPY/QuieaoLqoKdYkTww
         91I0QB1DuYanCcUihY2IK2XBYymFbLCbdM+jOSehjmA/AK/Jb1EpF3okQve3cs/jp6
         o9VPA2zCXYzXaTGMuSoML1hT39tAAsxt/wQy2LQNTLAmYUp1e2TxwubARTT7rPX/oU
         c4ORdyk6J96MTfrNZbQ9K064QA7XEH9jgz5WWX6dHkB0C2K8Gzt
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 26/36] sha1_file: convert sha1_object_info* to object_id
Date:   Sun, 25 Feb 2018 21:12:02 +0000
Message-Id: <20180225211212.477570-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert sha1_object_info and sha1_object_info_extended to take pointers
to struct object_id and rename them to use "oid" instead of "sha1" in
their names.  Update the declaration and definition and apply the
following semantic patch, plus the standard object_id transforms:

@@
expression E1, E2;
@@
- sha1_object_info(E1.hash, E2)
+ oid_object_info(&E1, E2)

@@
expression E1, E2;
@@
- sha1_object_info(E1->hash, E2)
+ oid_object_info(E1, E2)

@@
expression E1, E2, E3;
@@
- sha1_object_info_extended(E1.hash, E2, E3)
+ oid_object_info_extended(&E1, E2, E3)

@@
expression E1, E2, E3;
@@
- sha1_object_info_extended(E1->hash, E2, E3)
+ oid_object_info_extended(E1, E2, E3)
---
 archive-tar.c            |  2 +-
 archive-zip.c            |  2 +-
 blame.c                  |  4 ++--
 builtin/cat-file.c       | 14 +++++++-------
 builtin/fast-export.c    |  2 +-
 builtin/fetch.c          |  2 +-
 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  4 ++--
 builtin/ls-tree.c        |  2 +-
 builtin/mktree.c         |  2 +-
 builtin/pack-objects.c   |  7 +++----
 builtin/prune.c          |  2 +-
 builtin/replace.c        | 10 +++++-----
 builtin/tag.c            |  4 ++--
 builtin/unpack-objects.c |  2 +-
 cache.h                  |  6 +++---
 diff.c                   |  2 +-
 fast-import.c            | 10 +++++-----
 list-objects-filter.c    |  2 +-
 object.c                 |  2 +-
 pack-bitmap-write.c      |  3 +--
 packfile.c               |  4 ++--
 reachable.c              |  2 +-
 refs.c                   |  2 +-
 remote.c                 |  2 +-
 sequencer.c              |  3 ++-
 sha1_file.c              | 22 +++++++++++-----------
 sha1_name.c              | 12 ++++++------
 streaming.c              |  2 +-
 submodule.c              |  2 +-
 tag.c                    |  2 +-
 31 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 7a0d31d847..3563bcb9f2 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -276,7 +276,7 @@ static int write_tar_entry(struct archiver_args *args,
 		memcpy(header.name, path, pathlen);
 
 	if (S_ISREG(mode) && !args->convert &&
-	    sha1_object_info(oid->hash, &size) == OBJ_BLOB &&
+	    oid_object_info(oid, &size) == OBJ_BLOB &&
 	    size > big_file_threshold)
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
diff --git a/archive-zip.c b/archive-zip.c
index 18b951b732..6b20bce4d1 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -325,7 +325,7 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = 0;
 		buffer = NULL;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type = sha1_object_info(oid->hash, &size);
+		enum object_type type = oid_object_info(oid, &size);
 
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
diff --git a/blame.c b/blame.c
index 1fc22b304b..c1df10cdd2 100644
--- a/blame.c
+++ b/blame.c
@@ -81,7 +81,7 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		unsigned mode;
 
 		if (!get_tree_entry(commit_oid->hash, path, blob_oid.hash, &mode) &&
-		    sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
+		    oid_object_info(&blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
 
@@ -506,7 +506,7 @@ static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 			   origin->path,
 			   origin->blob_oid.hash, &origin->mode))
 		goto error_out;
-	if (sha1_object_info(origin->blob_oid.hash, NULL) != OBJ_BLOB)
+	if (oid_object_info(&origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cf9ea5c796..3264bada39 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -77,7 +77,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.typename = &sb;
-		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
+		if (oid_object_info_extended(&oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -88,7 +88,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
-		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
+		if (oid_object_info_extended(&oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%lu\n", size);
 		return 0;
@@ -116,7 +116,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		/* else fallthrough */
 
 	case 'p':
-		type = sha1_object_info(oid.hash, NULL);
+		type = oid_object_info(&oid, NULL);
 		if (type < 0)
 			die("Not a valid object name %s", obj_name);
 
@@ -140,7 +140,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			struct object_id blob_oid;
-			if (sha1_object_info(oid.hash, NULL) == OBJ_TAG) {
+			if (oid_object_info(&oid, NULL) == OBJ_TAG) {
 				char *buffer = read_sha1_file(oid.hash, &type, &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
@@ -150,7 +150,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			} else
 				oidcpy(&blob_oid, &oid);
 
-			if (sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
+			if (oid_object_info(&blob_oid, NULL) == OBJ_BLOB)
 				return stream_blob_to_fd(1, &blob_oid, NULL, 0);
 			/*
 			 * we attempted to dereference a tag to a blob
@@ -340,8 +340,8 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    sha1_object_info_extended(data->oid.hash, &data->info,
-				      OBJECT_INFO_LOOKUP_REPLACE) < 0) {
+	    oid_object_info_extended(&data->oid, &data->info,
+				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
 		fflush(stdout);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 293a6615fa..02ec19060d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -947,7 +947,7 @@ static void import_marks(char *input_file)
 		if (last_idnum < mark)
 			last_idnum = mark;
 
-		type = sha1_object_info(oid.hash, NULL);
+		type = oid_object_info(&oid, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(&oid));
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3b8988e51d..81076d698c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -626,7 +626,7 @@ static int update_local_ref(struct ref *ref,
 	struct branch *current_branch = branch_get(NULL);
 	const char *pretty_ref = prettify_refname(ref->name);
 
-	type = sha1_object_info(ref->new_oid.hash, NULL);
+	type = oid_object_info(&ref->new_oid, NULL);
 	if (type < 0)
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 57509a4eac..e57621cf74 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -65,7 +65,7 @@ static const char *printable_type(struct object *obj)
 	const char *ret;
 
 	if (obj->type == OBJ_NONE) {
-		enum object_type type = sha1_object_info(obj->oid.hash, NULL);
+		enum object_type type = oid_object_info(&obj->oid, NULL);
 		if (type > 0)
 			object_as_type(obj, type, 0);
 	}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a0ca525e99..27aa50396b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -221,7 +221,7 @@ static unsigned check_object(struct object *obj)
 
 	if (!(obj->flags & FLAG_CHECKED)) {
 		unsigned long size;
-		int type = sha1_object_info(obj->oid.hash, &size);
+		int type = oid_object_info(&obj->oid, &size);
 		if (type <= 0)
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
@@ -810,7 +810,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		enum object_type has_type;
 		unsigned long has_size;
 		read_lock();
-		has_type = sha1_object_info(oid->hash, &has_size);
+		has_type = oid_object_info(oid, &has_size);
 		if (has_type < 0)
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c98253adbb..d44b4f9c27 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -94,7 +94,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 			char size_text[24];
 			if (!strcmp(type, blob_type)) {
 				unsigned long size;
-				if (sha1_object_info(oid->hash, &size) == OBJ_BAD)
+				if (oid_object_info(oid, &size) == OBJ_BAD)
 					xsnprintf(size_text, sizeof(size_text),
 						  "BAD");
 				else
diff --git a/builtin/mktree.c b/builtin/mktree.c
index d6ca19d835..298ad6665a 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -116,7 +116,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	/* Check the type of object identified by sha1 */
-	obj_type = sha1_object_info(oid.hash, NULL);
+	obj_type = oid_object_info(&oid, NULL);
 	if (obj_type < 0) {
 		if (allow_missing) {
 			; /* no problem - missing objects are presumed to be of the right type */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ef63aa5878..f8148eb9d5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1516,7 +1516,7 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	entry->type = sha1_object_info(entry->idx.oid.hash, &entry->size);
+	entry->type = oid_object_info(&entry->idx.oid, &entry->size);
 	/*
 	 * The error condition is checked in prepare_pack().  This is
 	 * to permit a missing preferred base object to be ignored
@@ -1578,8 +1578,7 @@ static void drop_reused_delta(struct object_entry *entry)
 		 * And if that fails, the error will be recorded in entry->type
 		 * and dealt with in prepare_pack().
 		 */
-		entry->type = sha1_object_info(entry->idx.oid.hash,
-					       &entry->size);
+		entry->type = oid_object_info(&entry->idx.oid, &entry->size);
 	}
 }
 
@@ -2708,7 +2707,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 static int add_loose_object(const struct object_id *oid, const char *path,
 			    void *data)
 {
-	enum object_type type = sha1_object_info(oid->hash, NULL);
+	enum object_type type = oid_object_info(oid, NULL);
 
 	if (type < 0) {
 		warning("loose object at %s could not be examined", path);
diff --git a/builtin/prune.c b/builtin/prune.c
index 4cfec82f40..f77a4a4379 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -50,7 +50,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = sha1_object_info(oid->hash, NULL);
+		enum object_type type = oid_object_info(oid, NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? typename(type) : "unknown");
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 83d3235721..1fa40039b4 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -53,8 +53,8 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			if (get_oid(refname, &object))
 				return error("Failed to resolve '%s' as a valid ref.", refname);
 
-			obj_type = sha1_object_info(object.hash, NULL);
-			repl_type = sha1_object_info(oid->hash, NULL);
+			obj_type = oid_object_info(&object, NULL);
+			repl_type = oid_object_info(oid, NULL);
 
 			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
 			       oid_to_hex(oid), typename(repl_type));
@@ -162,8 +162,8 @@ static int replace_object_oid(const char *object_ref,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	obj_type = sha1_object_info(object->hash, NULL);
-	repl_type = sha1_object_info(repl->hash, NULL);
+	obj_type = oid_object_info(object, NULL);
+	repl_type = oid_object_info(repl, NULL);
 	if (!force && obj_type != repl_type)
 		die("Objects must be of the same type.\n"
 		    "'%s' points to a replaced object of type '%s'\n"
@@ -290,7 +290,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	if (get_oid(object_ref, &old) < 0)
 		die("Not a valid object name: '%s'", object_ref);
 
-	type = sha1_object_info(old.hash, NULL);
+	type = oid_object_info(&old, NULL);
 	if (type < 0)
 		die("unable to get object type for %s", oid_to_hex(&old));
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 17d6bc0836..3340cbedd4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -211,7 +211,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 	struct strbuf header = STRBUF_INIT;
 	char *path = NULL;
 
-	type = sha1_object_info(object->hash, NULL);
+	type = oid_object_info(object, NULL);
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
@@ -294,7 +294,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 	}
 
 	strbuf_addstr(sb, " (");
-	type = sha1_object_info(oid->hash, NULL);
+	type = oid_object_info(oid, NULL);
 	switch (type) {
 	default:
 		strbuf_addstr(sb, "object of unknown type");
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 7235d2ffbf..6e712081e0 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -198,7 +198,7 @@ static int check_object(struct object *obj, int type, void *data, struct fsck_op
 
 	if (!(obj->flags & FLAG_OPEN)) {
 		unsigned long size;
-		int type = sha1_object_info(obj->oid.hash, &size);
+		int type = oid_object_info(&obj->oid, &size);
 		if (type != obj->type || type <= 0)
 			die("object of unexpected type");
 		obj->flags |= FLAG_WRITTEN;
diff --git a/cache.h b/cache.h
index b1a117e404..b965a073f2 100644
--- a/cache.h
+++ b/cache.h
@@ -1212,8 +1212,8 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 	return do_lookup_replace_object(sha1);
 }
 
-/* Read and unpack a sha1 file into memory, write memory to a sha1 file */
-extern int sha1_object_info(const unsigned char *, unsigned long *);
+/* Read and unpack an object file into memory, write memory to an object file */
+extern int oid_object_info(const struct object_id *, unsigned long *);
 
 extern int hash_object_file(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid);
@@ -1773,7 +1773,7 @@ struct object_info {
 #define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
-extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
+extern int oid_object_info_extended(const struct object_id *, struct object_info *, unsigned flags);
 
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
diff --git a/diff.c b/diff.c
index 94117bcbbf..d838ee2e9a 100644
--- a/diff.c
+++ b/diff.c
@@ -3615,7 +3615,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 	else {
 		enum object_type type;
 		if (size_only || (flags & CHECK_BINARY)) {
-			type = sha1_object_info(s->oid.hash, &s->size);
+			type = oid_object_info(&s->oid, &s->size);
 			if (type < 0)
 				die("unable to read %s",
 				    oid_to_hex(&s->oid));
diff --git a/fast-import.c b/fast-import.c
index 0f818cd932..71b60f9068 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1913,7 +1913,7 @@ static void read_marks(void)
 			die("corrupt mark line: %s", line);
 		e = find_object(&oid);
 		if (!e) {
-			enum object_type type = sha1_object_info(oid.hash, NULL);
+			enum object_type type = oid_object_info(&oid, NULL);
 			if (type < 0)
 				die("object not found: %s", oid_to_hex(&oid));
 			e = insert_object(&oid);
@@ -2443,7 +2443,7 @@ static void file_change_m(const char *p, struct branch *b)
 		enum object_type expected = S_ISDIR(mode) ?
 						OBJ_TREE: OBJ_BLOB;
 		enum object_type type = oe ? oe->type :
-					sha1_object_info(oid.hash, NULL);
+					oid_object_info(&oid, NULL);
 		if (type < 0)
 			die("%s not found: %s",
 					S_ISDIR(mode) ?  "Tree" : "Blob",
@@ -2603,7 +2603,7 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 			die("Not a blob (actually a %s): %s",
 				typename(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
-		enum object_type type = sha1_object_info(oid.hash, NULL);
+		enum object_type type = oid_object_info(&oid, NULL);
 		if (type < 0)
 			die("Blob not found: %s", command_buf.buf);
 		if (type != OBJ_BLOB)
@@ -2890,7 +2890,7 @@ static void parse_new_tag(const char *arg)
 	} else if (!get_oid(from, &oid)) {
 		struct object_entry *oe = find_object(&oid);
 		if (!oe) {
-			type = sha1_object_info(oid.hash, NULL);
+			type = oid_object_info(&oid, NULL);
 			if (type < 0)
 				die("Not a valid object: %s", from);
 		} else
@@ -3048,7 +3048,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 	unsigned long size;
 	char *buf = NULL;
 	if (!oe) {
-		enum object_type type = sha1_object_info(oid->hash, NULL);
+		enum object_type type = oid_object_info(oid, NULL);
 		if (type < 0)
 			die("object not found: %s", oid_to_hex(oid));
 		/* cache it! */
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4356c45368..0ec83aaf18 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -117,7 +117,7 @@ static enum list_objects_filter_result filter_blobs_limit(
 		assert(obj->type == OBJ_BLOB);
 		assert((obj->flags & SEEN) == 0);
 
-		t = sha1_object_info(obj->oid.hash, &object_length);
+		t = oid_object_info(&obj->oid, &object_length);
 		if (t != OBJ_BLOB) { /* probably OBJ_NONE */
 			/*
 			 * We DO NOT have the blob locally, so we cannot
diff --git a/object.c b/object.c
index c63f02a40f..be8f23271b 100644
--- a/object.c
+++ b/object.c
@@ -254,7 +254,7 @@ struct object *parse_object(const struct object_id *oid)
 
 	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
-	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
+	     oid_object_info(oid, NULL) == OBJ_BLOB)) {
 		struct object_id reploid;
 		hashcpy(reploid.hash, repl);
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..41ae27fb19 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -73,8 +73,7 @@ void bitmap_writer_build_type_index(struct pack_idx_entry **index,
 			break;
 
 		default:
-			real_type = sha1_object_info(entry->idx.oid.hash,
-						     NULL);
+			real_type = oid_object_info(&entry->idx.oid, NULL);
 			break;
 		}
 
diff --git a/packfile.c b/packfile.c
index e3b1db7dd5..6619813756 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1101,7 +1101,7 @@ static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
 		return OBJ_BAD;
 	nth_packed_object_oid(&oid, p, revidx->nr);
 	mark_bad_packed_object(p, oid.hash);
-	type = sha1_object_info(oid.hash, NULL);
+	type = oid_object_info(&oid, NULL);
 	if (type <= OBJ_NONE)
 		return OBJ_BAD;
 	return type;
@@ -1461,7 +1461,7 @@ static void *read_object(const struct object_id *oid, enum object_type *type,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (sha1_object_info_extended(oid->hash, &oi, 0) < 0)
+	if (oid_object_info_extended(oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
diff --git a/reachable.c b/reachable.c
index 88d7d679da..44c9c0f92c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -77,7 +77,7 @@ static void add_recent_object(const struct object_id *oid,
 	 * later processing, and the revision machinery expects
 	 * commits and tags to have been parsed.
 	 */
-	type = sha1_object_info(oid->hash, NULL);
+	type = oid_object_info(oid, NULL);
 	if (type < 0)
 		die("unable to get object info for %s", oid_to_hex(oid));
 
diff --git a/refs.c b/refs.c
index 20ba82b434..8b7a77fe5e 100644
--- a/refs.c
+++ b/refs.c
@@ -301,7 +301,7 @@ enum peel_status peel_object(const struct object_id *name, struct object_id *oid
 	struct object *o = lookup_unknown_object(name->hash);
 
 	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(name->hash, NULL);
+		int type = oid_object_info(name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
 	}
diff --git a/remote.c b/remote.c
index 4e93753e19..619ce28a58 100644
--- a/remote.c
+++ b/remote.c
@@ -1361,7 +1361,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			continue; /* not a tag */
 		if (string_list_has_string(&dst_tag, ref->name))
 			continue; /* they already have it */
-		if (sha1_object_info(ref->new_oid.hash, NULL) != OBJ_TAG)
+		if (oid_object_info(&ref->new_oid, NULL) != OBJ_TAG)
 			continue; /* be conservative */
 		item = string_list_append(&src_tag, ref->name);
 		item->util = ref;
diff --git a/sequencer.c b/sequencer.c
index ed7c42ba7d..604f3162ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2868,7 +2868,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 
 		if (!get_oid(name, &oid)) {
 			if (!lookup_commit_reference_gently(&oid, 1)) {
-				enum object_type type = sha1_object_info(oid.hash, NULL);
+				enum object_type type = oid_object_info(&oid,
+									NULL);
 				return error(_("%s: can't cherry-pick a %s"),
 					name, typename(type));
 			}
diff --git a/sha1_file.c b/sha1_file.c
index 19995766b6..1719c218e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1222,14 +1222,14 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 
 int fetch_if_missing = 1;
 
-int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
+int oid_object_info_extended(const struct object_id *oid, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
-				    lookup_replace_object(sha1) :
-				    sha1;
+				    lookup_replace_object(oid->hash) :
+				    oid->hash;
 	int already_retried = 0;
 	struct object_id realoid;
 
@@ -1298,7 +1298,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		return sha1_object_info_extended(realoid.hash, oi, 0);
+		return oid_object_info_extended(&realoid, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1310,15 +1310,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 }
 
 /* returns enum object_type or negative */
-int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
+int oid_object_info(const struct object_id *oid, unsigned long *sizep)
 {
 	enum object_type type;
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (sha1_object_info_extended(sha1, &oi,
-				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
+	if (oid_object_info_extended(oid, &oi,
+				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
 }
@@ -1335,7 +1335,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	hashcpy(oid.hash, sha1);
 
-	if (sha1_object_info_extended(oid.hash, &oi, 0) < 0)
+	if (oid_object_info_extended(&oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1733,8 +1733,8 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 	if (!startup_info->have_repository)
 		return 0;
 	hashcpy(oid.hash, sha1);
-	return sha1_object_info_extended(oid.hash, NULL,
-					 flags | OBJECT_INFO_SKIP_CACHED) >= 0;
+	return oid_object_info_extended(&oid, NULL,
+					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
 int has_object_file(const struct object_id *oid)
@@ -1976,7 +1976,7 @@ int read_pack_header(int fd, struct pack_header *header)
 
 void assert_oid_type(const struct object_id *oid, enum object_type expect)
 {
-	enum object_type type = sha1_object_info(oid->hash, NULL);
+	enum object_type type = oid_object_info(oid, NULL);
 	if (type < 0)
 		die("%s is not a valid object", oid_to_hex(oid));
 	if (type != expect)
diff --git a/sha1_name.c b/sha1_name.c
index dd68e68f45..6d4c6033c8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -238,7 +238,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 
 static int disambiguate_commit_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(oid->hash, NULL);
+	int kind = oid_object_info(oid, NULL);
 	return kind == OBJ_COMMIT;
 }
 
@@ -247,7 +247,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 	struct object *obj;
 	int kind;
 
-	kind = sha1_object_info(oid->hash, NULL);
+	kind = oid_object_info(oid, NULL);
 	if (kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -262,7 +262,7 @@ static int disambiguate_committish_only(const struct object_id *oid, void *cb_da
 
 static int disambiguate_tree_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(oid->hash, NULL);
+	int kind = oid_object_info(oid, NULL);
 	return kind == OBJ_TREE;
 }
 
@@ -271,7 +271,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 	struct object *obj;
 	int kind;
 
-	kind = sha1_object_info(oid->hash, NULL);
+	kind = oid_object_info(oid, NULL);
 	if (kind == OBJ_TREE || kind == OBJ_COMMIT)
 		return 1;
 	if (kind != OBJ_TAG)
@@ -286,7 +286,7 @@ static int disambiguate_treeish_only(const struct object_id *oid, void *cb_data_
 
 static int disambiguate_blob_only(const struct object_id *oid, void *cb_data_unused)
 {
-	int kind = sha1_object_info(oid->hash, NULL);
+	int kind = oid_object_info(oid, NULL);
 	return kind == OBJ_BLOB;
 }
 
@@ -365,7 +365,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-	type = sha1_object_info(oid->hash, NULL);
+	type = oid_object_info(oid, NULL);
 	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(oid);
 		if (commit) {
diff --git a/streaming.c b/streaming.c
index 042d6082e8..344678e95f 100644
--- a/streaming.c
+++ b/streaming.c
@@ -117,7 +117,7 @@ static enum input_source istream_source(const unsigned char *sha1,
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = sha1_object_info_extended(oid.hash, oi, 0);
+	status = oid_object_info_extended(&oid, oi, 0);
 	if (status < 0)
 		return stream_error;
 
diff --git a/submodule.c b/submodule.c
index d4a482e647..a2c89224a9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -817,7 +817,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 {
 	struct has_commit_data *cb = data;
 
-	enum object_type type = sha1_object_info(oid->hash, NULL);
+	enum object_type type = oid_object_info(oid, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
diff --git a/tag.c b/tag.c
index 0b63c3f1ec..ea963e406a 100644
--- a/tag.c
+++ b/tag.c
@@ -41,7 +41,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 	unsigned long size;
 	int ret;
 
-	type = sha1_object_info(oid->hash, NULL);
+	type = oid_object_info(oid, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
 				name_to_report ?
