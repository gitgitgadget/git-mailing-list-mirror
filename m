Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C1C1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932643AbeCLC3A (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34492 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932577AbeCLC24 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 30236610E8;
        Mon, 12 Mar 2018 02:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821734;
        bh=q768cRwPSh4fMZRo3NWqdMGLKJXb1BNeiUY8QFSouDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=U5IlP5tsdYmJecERJQMwKamnNUbPNKU/QEnceiAUS1GSwFOVnPXKqeBbcEOiVR4/v
         NIZ5y3DnUOhw51qQ3vET3JBRuHdBfhno1KTbWwvBGFB6CyVlb8oWxoUJ5KR/bk163s
         4TM1y2JYQTfqhqEVy1uv2jwaC1mo4lLPbPNBMYJhSJvfa2gLlqZMMvFsvxp7XcNRze
         6PvYaf4I46Mh5fhl4y0rT9FkBoEXhMDSvG2T/nH8MMsRJD81olbKgf4yPbMpul2pDk
         ezNoToznxvmPNSnINQ/imF7IvQY8wcP2mmgTxRS9rGIsQYtDR1JTB4n5/O/r1QZe32
         T4FbGOzt5oyt0lkWZkuWvwUVsW/I12W1CLQaHvWabglYJW8/efq0RJIo1fL7h7HIrK
         jNRKzyRcWnW88bzRClxcrBxF8u9JfWJDnnOOmER9t+Ht9el7WzK0B3yb+Z0eAcKYQ8
         5nuICtlT6lvAW29G876U1GXw6eb8NrnVZWApVceJ30h2DWfptbG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 33/36] sha1_file: convert read_sha1_file to struct object_id
Date:   Mon, 12 Mar 2018 02:27:53 +0000
Message-Id: <20180312022756.483934-34-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert read_sha1_file to take a pointer to struct object_id and rename
it read_object_file.  Do the same for read_sha1_file_extended.

Convert one use in grep.c to use the new function without any other code
change, since the pointer being passed is a void pointer that is already
initialized with a pointer to struct object_id.  Update the declaration
and definitions of the modified functions, and apply the following
semantic patch to convert the remaining callers:

@@
expression E1, E2, E3;
@@
- read_sha1_file(E1.hash, E2, E3)
+ read_object_file(&E1, E2, E3)

@@
expression E1, E2, E3;
@@
- read_sha1_file(E1->hash, E2, E3)
+ read_object_file(E1, E2, E3)

@@
expression E1, E2, E3, E4;
@@
- read_sha1_file_extended(E1.hash, E2, E3, E4)
+ read_object_file_extended(&E1, E2, E3, E4)

@@
expression E1, E2, E3, E4;
@@
- read_sha1_file_extended(E1->hash, E2, E3, E4)
+ read_object_file_extended(E1, E2, E3, E4)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 apply.c                  |  4 ++--
 archive.c                |  2 +-
 bisect.c                 |  3 ++-
 blame.c                  |  8 ++++----
 builtin/cat-file.c       | 14 ++++++++------
 builtin/difftool.c       |  2 +-
 builtin/fast-export.c    |  4 ++--
 builtin/fmt-merge-msg.c  |  2 +-
 builtin/grep.c           |  2 +-
 builtin/index-pack.c     |  5 +++--
 builtin/log.c            |  2 +-
 builtin/merge-tree.c     |  5 +++--
 builtin/mktag.c          |  2 +-
 builtin/notes.c          |  6 +++---
 builtin/pack-objects.c   | 16 ++++++----------
 builtin/reflog.c         |  2 +-
 builtin/tag.c            |  4 ++--
 builtin/unpack-file.c    |  2 +-
 builtin/unpack-objects.c |  2 +-
 builtin/verify-commit.c  |  2 +-
 bundle.c                 |  2 +-
 cache.h                  | 10 +++++-----
 combine-diff.c           |  2 +-
 commit.c                 |  6 +++---
 config.c                 |  2 +-
 diff.c                   |  2 +-
 dir.c                    |  2 +-
 entry.c                  |  2 +-
 fast-import.c            |  6 +++---
 fsck.c                   |  2 +-
 grep.c                   |  2 +-
 http-push.c              |  2 +-
 mailmap.c                |  2 +-
 match-trees.c            |  4 ++--
 merge-blobs.c            |  4 ++--
 merge-recursive.c        |  4 ++--
 notes-cache.c            |  2 +-
 notes-merge.c            |  2 +-
 notes.c                  |  8 ++++----
 object.c                 |  2 +-
 read-cache.c             |  4 ++--
 ref-filter.c             |  2 +-
 remote-testsvn.c         |  4 ++--
 rerere.c                 |  4 ++--
 sha1_file.c              | 20 ++++++++++----------
 streaming.c              |  2 +-
 submodule-config.c       |  2 +-
 tag.c                    |  4 ++--
 tree-walk.c              |  4 ++--
 tree.c                   |  2 +-
 xdiff-interface.c        |  2 +-
 51 files changed, 104 insertions(+), 103 deletions(-)

diff --git a/apply.c b/apply.c
index f8f15edc7c..b1e1bd58bf 100644
--- a/apply.c
+++ b/apply.c
@@ -3180,7 +3180,7 @@ static int apply_binary(struct apply_state *state,
 		unsigned long size;
 		char *result;
 
-		result = read_sha1_file(oid.hash, &type, &size);
+		result = read_object_file(&oid, &type, &size);
 		if (!result)
 			return error(_("the necessary postimage %s for "
 				       "'%s' cannot be read"),
@@ -3242,7 +3242,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
 		unsigned long sz;
 		char *result;
 
-		result = read_sha1_file(oid->hash, &type, &sz);
+		result = read_object_file(oid, &type, &sz);
 		if (!result)
 			return -1;
 		/* XXX read_sha1_file NUL-terminates */
diff --git a/archive.c b/archive.c
index 1ab62d426e..93ab175b0b 100644
--- a/archive.c
+++ b/archive.c
@@ -72,7 +72,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 	const struct commit *commit = args->convert ? args->commit : NULL;
 
 	path += args->baselen;
-	buffer = read_sha1_file(oid->hash, type, sizep);
+	buffer = read_object_file(oid, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
diff --git a/bisect.c b/bisect.c
index f6d05bd66f..ad395bb2b8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -132,7 +132,8 @@ static void show_list(const char *debug, int counted, int nr,
 		unsigned flags = commit->object.flags;
 		enum object_type type;
 		unsigned long size;
-		char *buf = read_sha1_file(commit->object.oid.hash, &type, &size);
+		char *buf = read_object_file(&commit->object.oid, &type,
+					     &size);
 		const char *subject_start;
 		int subject_len;
 
diff --git a/blame.c b/blame.c
index cc2cc92944..78c9808bd1 100644
--- a/blame.c
+++ b/blame.c
@@ -297,8 +297,8 @@ static void fill_origin_blob(struct diff_options *opt,
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
-			file->ptr = read_sha1_file(o->blob_oid.hash, &type,
-						   &file_size);
+			file->ptr = read_object_file(&o->blob_oid, &type,
+						     &file_size);
 		file->size = file_size;
 
 		if (!file->ptr)
@@ -1829,8 +1829,8 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 				    &sb->final_buf_size))
 			;
 		else
-			sb->final_buf = read_sha1_file(o->blob_oid.hash, &type,
-						       &sb->final_buf_size);
+			sb->final_buf = read_object_file(&o->blob_oid, &type,
+							 &sb->final_buf_size);
 
 		if (!sb->final_buf)
 			die(_("cannot read blob %s for path %s"),
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4382b4447e..2c46d257cd 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -32,7 +32,7 @@ static int filter_object(const char *path, unsigned mode,
 {
 	enum object_type type;
 
-	*buf = read_sha1_file(oid->hash, &type, size);
+	*buf = read_object_file(oid, &type, size);
 	if (!*buf)
 		return error(_("cannot read object %s '%s'"),
 			     oid_to_hex(oid), path);
@@ -130,7 +130,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 		if (type == OBJ_BLOB)
 			return stream_blob_to_fd(1, &oid, NULL, 0);
-		buf = read_sha1_file(oid.hash, &type, &size);
+		buf = read_object_file(&oid, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
@@ -141,7 +141,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			struct object_id blob_oid;
 			if (oid_object_info(&oid, NULL) == OBJ_TAG) {
-				char *buffer = read_sha1_file(oid.hash, &type, &size);
+				char *buffer = read_object_file(&oid, &type,
+								&size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
 				    get_oid_hex(target, &blob_oid))
@@ -304,8 +305,9 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 				enum object_type type;
 				if (!textconv_object(data->rest, 0100644, oid,
 						     1, &contents, &size))
-					contents = read_sha1_file(oid->hash, &type,
-								  &size);
+					contents = read_object_file(oid,
+								    &type,
+								    &size);
 				if (!contents)
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
@@ -321,7 +323,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 		unsigned long size;
 		void *contents;
 
-		contents = read_sha1_file(oid->hash, &type, &size);
+		contents = read_object_file(oid, &type, &size);
 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bcc79d1888..ee8dce019e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -306,7 +306,7 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 	} else {
 		enum object_type type;
 		unsigned long size;
-		data = read_sha1_file(oid->hash, &type, &size);
+		data = read_object_file(oid, &type, &size);
 		if (!data)
 			die(_("could not read object %s for symlink %s"),
 				oid_to_hex(oid), path);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d75a3a45d3..a15898d641 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -237,7 +237,7 @@ static void export_blob(const struct object_id *oid)
 		object = (struct object *)lookup_blob(oid);
 		eaten = 0;
 	} else {
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_object_file(oid, &type, &size);
 		if (!buf)
 			die ("Could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
@@ -682,7 +682,7 @@ static void handle_tag(const char *name, struct tag *tag)
 		return;
 	}
 
-	buf = read_sha1_file(tag->object.oid.hash, &type, &size);
+	buf = read_object_file(&tag->object.oid, &type, &size);
 	if (!buf)
 		die ("Could not read tag %s", oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0bc0dda99c..bd680be687 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -488,7 +488,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		struct object_id *oid = origins.items[i].util;
 		enum object_type type;
 		unsigned long size, len;
-		char *buf = read_sha1_file(oid->hash, &type, &size);
+		char *buf = read_object_file(oid, &type, &size);
 		struct strbuf sig = STRBUF_INIT;
 
 		if (!buf || type != OBJ_TAG)
diff --git a/builtin/grep.c b/builtin/grep.c
index 386a86b66e..bf50bab6f8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -306,7 +306,7 @@ static void *lock_and_read_oid_file(const struct object_id *oid, enum object_typ
 	void *data;
 
 	grep_read_lock();
-	data = read_sha1_file(oid->hash, type, size);
+	data = read_object_file(oid, type, size);
 	grep_read_unlock();
 	return data;
 }
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 32a98f3102..7873e7243f 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -815,7 +815,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
-		has_data = read_sha1_file(oid->hash, &has_type, &has_size);
+		has_data = read_object_file(oid, &has_type, &has_size);
 		read_unlock();
 		if (!data)
 			data = new_data = get_data_from_pack(obj_entry);
@@ -1373,7 +1373,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (objects[d->obj_no].real_type != OBJ_REF_DELTA)
 			continue;
-		base_obj->data = read_sha1_file(d->oid.hash, &type, &base_obj->size);
+		base_obj->data = read_object_file(&d->oid, &type,
+						  &base_obj->size);
 		if (!base_obj->data)
 			continue;
 
diff --git a/builtin/log.c b/builtin/log.c
index 411339c1ed..71f68a3e4f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -518,7 +518,7 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(oid->hash, &type, &size);
+	char *buf = read_object_file(oid, &type, &size);
 	int offset = 0;
 
 	if (!buf)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d01ddecf66..32736e0b10 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -60,7 +60,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	const char *path = entry->path;
 
 	if (!entry->stage)
-		return read_sha1_file(entry->blob->object.oid.hash, &type, size);
+		return read_object_file(&entry->blob->object.oid, &type, size);
 	base = NULL;
 	if (entry->stage == 1) {
 		base = entry->blob;
@@ -82,7 +82,8 @@ static void *origin(struct merge_list *entry, unsigned long *size)
 	enum object_type type;
 	while (entry) {
 		if (entry->stage == 2)
-			return read_sha1_file(entry->blob->object.oid.hash, &type, size);
+			return read_object_file(&entry->blob->object.oid,
+						&type, size);
 		entry = entry->link;
 	}
 	return NULL;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 810b24bef3..cfb777b3c8 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -23,7 +23,7 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 	int ret = -1;
 	enum object_type type;
 	unsigned long size;
-	void *buffer = read_sha1_file(oid->hash, &type, &size);
+	void *buffer = read_object_file(oid, &type, &size);
 	const unsigned char *repl = lookup_replace_object(oid->hash);
 
 	if (buffer) {
diff --git a/builtin/notes.c b/builtin/notes.c
index 08ab9d7130..5ddfa44cde 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -122,7 +122,7 @@ static void copy_obj_to_fd(int fd, const struct object_id *oid)
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf = read_sha1_file(oid->hash, &type, &size);
+	char *buf = read_object_file(oid, &type, &size);
 	if (buf) {
 		if (size)
 			write_or_die(fd, buf, size);
@@ -253,7 +253,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 
 	if (get_oid(arg, &object))
 		die(_("failed to resolve '%s' as a valid ref."), arg);
-	if (!(buf = read_sha1_file(object.hash, &type, &len))) {
+	if (!(buf = read_object_file(&object, &type, &len))) {
 		free(buf);
 		die(_("failed to read object '%s'."), arg);
 	}
@@ -608,7 +608,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		/* Append buf to previous note contents */
 		unsigned long size;
 		enum object_type type;
-		char *prev_buf = read_sha1_file(note->hash, &type, &size);
+		char *prev_buf = read_object_file(note, &type, &size);
 
 		strbuf_grow(&d.buf, size + 1);
 		if (d.buf.len && prev_buf && size)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a0ccbf6699..a1d674608a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -122,11 +122,10 @@ static void *get_delta(struct object_entry *entry)
 	void *buf, *base_buf, *delta_buf;
 	enum object_type type;
 
-	buf = read_sha1_file(entry->idx.oid.hash, &type, &size);
+	buf = read_object_file(&entry->idx.oid, &type, &size);
 	if (!buf)
 		die("unable to read %s", oid_to_hex(&entry->idx.oid));
-	base_buf = read_sha1_file(entry->delta->idx.oid.hash, &type,
-				  &base_size);
+	base_buf = read_object_file(&entry->delta->idx.oid, &type, &base_size);
 	if (!base_buf)
 		die("unable to read %s",
 		    oid_to_hex(&entry->delta->idx.oid));
@@ -270,8 +269,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		    (st = open_istream(&entry->idx.oid, &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
-			buf = read_sha1_file(entry->idx.oid.hash, &type,
-					     &size);
+			buf = read_object_file(&entry->idx.oid, &type, &size);
 			if (!buf)
 				die(_("unable to read %s"),
 				    oid_to_hex(&entry->idx.oid));
@@ -1190,7 +1188,7 @@ static struct pbase_tree_cache *pbase_tree_get(const struct object_id *oid)
 	/* Did not find one.  Either we got a bogus request or
 	 * we need to read and perhaps cache.
 	 */
-	data = read_sha1_file(oid->hash, &type, &size);
+	data = read_object_file(oid, &type, &size);
 	if (!data)
 		return NULL;
 	if (type != OBJ_TREE) {
@@ -1870,8 +1868,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Load data if not already done */
 	if (!trg->data) {
 		read_lock();
-		trg->data = read_sha1_file(trg_entry->idx.oid.hash, &type,
-					   &sz);
+		trg->data = read_object_file(&trg_entry->idx.oid, &type, &sz);
 		read_unlock();
 		if (!trg->data)
 			die("object %s cannot be read",
@@ -1884,8 +1881,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->data) {
 		read_lock();
-		src->data = read_sha1_file(src_entry->idx.oid.hash, &type,
-					   &sz);
+		src->data = read_object_file(&src_entry->idx.oid, &type, &sz);
 		read_unlock();
 		if (!src->data) {
 			if (src_entry->preferred_base) {
diff --git a/builtin/reflog.c b/builtin/reflog.c
index ac3dcd7a51..25f7c5ef0b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -74,7 +74,7 @@ static int tree_is_complete(const struct object_id *oid)
 	if (!tree->buffer) {
 		enum object_type type;
 		unsigned long size;
-		void *data = read_sha1_file(oid->hash, &type, &size);
+		void *data = read_object_file(oid, &type, &size);
 		if (!data) {
 			tree->object.flags |= INCOMPLETE;
 			return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index 11a9883d27..86450bae05 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -168,7 +168,7 @@ static void write_tag_body(int fd, const struct object_id *oid)
 	enum object_type type;
 	char *buf, *sp;
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		return;
 	/* skip header */
@@ -304,7 +304,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		strbuf_addstr(sb, "object of unknown type");
 		break;
 	case OBJ_COMMIT:
-		if ((buf = read_sha1_file(oid->hash, &type, &size)) != NULL) {
+		if ((buf = read_object_file(oid, &type, &size)) != NULL) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 32e0155577..300eb59657 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -9,7 +9,7 @@ static char *create_temp_file(struct object_id *oid)
 	unsigned long size;
 	int fd;
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_object_file(oid, &type, &size);
 	if (!buf || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6d553374c0..af02e1bc6b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -422,7 +422,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
 		return;
 
-	base = read_sha1_file(base_oid.hash, &type, &base_size);
+	base = read_object_file(&base_oid, &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
 		      oid_to_hex(&base_oid));
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 05315ea7c9..dcdaada111 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -44,7 +44,7 @@ static int verify_commit(const char *name, unsigned flags)
 	if (get_oid(name, &oid))
 		return error("commit '%s' not found.", name);
 
-	buf = read_sha1_file(oid.hash, &type, &size);
+	buf = read_object_file(&oid, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.", name);
 	if (type != OBJ_COMMIT)
diff --git a/bundle.c b/bundle.c
index efe547e25f..902c9b5448 100644
--- a/bundle.c
+++ b/bundle.c
@@ -222,7 +222,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	if (revs->max_age == -1 && revs->min_age == -1)
 		goto out;
 
-	buf = read_sha1_file(tag->oid.hash, &type, &size);
+	buf = read_object_file(&tag->oid, &type, &size);
 	if (!buf)
 		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
diff --git a/cache.h b/cache.h
index 9293c14564..3c9718cc8c 100644
--- a/cache.h
+++ b/cache.h
@@ -1185,12 +1185,12 @@ extern char *xdg_config_home(const char *filename);
  */
 extern char *xdg_cache_home(const char *filename);
 
-extern void *read_sha1_file_extended(const unsigned char *sha1,
-				     enum object_type *type,
-				     unsigned long *size, int lookup_replace);
-static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
+extern void *read_object_file_extended(const struct object_id *oid,
+				       enum object_type *type,
+				       unsigned long *size, int lookup_replace);
+static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
 {
-	return read_sha1_file_extended(sha1, type, size, 1);
+	return read_object_file_extended(oid, type, size, 1);
 }
 
 /*
diff --git a/combine-diff.c b/combine-diff.c
index cf55f03b75..2ef495963f 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -306,7 +306,7 @@ static char *grab_blob(const struct object_id *oid, unsigned int mode,
 		*size = fill_textconv(textconv, df, &blob);
 		free_filespec(df);
 	} else {
-		blob = read_sha1_file(oid->hash, &type, size);
+		blob = read_object_file(oid, &type, size);
 		if (type != OBJ_BLOB)
 			die("object '%s' is not a blob!", oid_to_hex(oid));
 	}
diff --git a/commit.c b/commit.c
index 6d77787af9..ca474a7c11 100644
--- a/commit.c
+++ b/commit.c
@@ -266,7 +266,7 @@ const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
-		ret = read_sha1_file(commit->object.oid.hash, &type, &size);
+		ret = read_object_file(&commit->object.oid, &type, &size);
 		if (!ret)
 			die("cannot read commit object %s",
 			    oid_to_hex(&commit->object.oid));
@@ -383,7 +383,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return -1;
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
+	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
@@ -1206,7 +1206,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	desc = merge_remote_util(parent);
 	if (!desc || !desc->obj)
 		return;
-	buf = read_sha1_file(desc->obj->oid.hash, &type, &size);
+	buf = read_object_file(&desc->obj->oid, &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
 	len = parse_signature(buf, size);
diff --git a/config.c b/config.c
index b0c20e6cb8..c698988f5e 100644
--- a/config.c
+++ b/config.c
@@ -1488,7 +1488,7 @@ int git_config_from_blob_oid(config_fn_t fn,
 	unsigned long size;
 	int ret;
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		return error("unable to load config blob object '%s'", name);
 	if (type != OBJ_BLOB) {
diff --git a/diff.c b/diff.c
index b463078d57..5c8f3e16e8 100644
--- a/diff.c
+++ b/diff.c
@@ -3626,7 +3626,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 				return 0;
 			}
 		}
-		s->data = read_sha1_file(s->oid.hash, &type, &s->size);
+		s->data = read_object_file(&s->oid, &type, &s->size);
 		if (!s->data)
 			die("unable to read %s", oid_to_hex(&s->oid));
 		s->should_free = 1;
diff --git a/dir.c b/dir.c
index dedbf5d476..63a917be45 100644
--- a/dir.c
+++ b/dir.c
@@ -243,7 +243,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 	*size_out = 0;
 	*data_out = NULL;
 
-	data = read_sha1_file(oid->hash, &type, &sz);
+	data = read_object_file(oid, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return -1;
diff --git a/entry.c b/entry.c
index 6c33112aea..d3f26ec8ca 100644
--- a/entry.c
+++ b/entry.c
@@ -85,7 +85,7 @@ static int create_file(const char *path, unsigned int mode)
 static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
-	void *blob_data = read_sha1_file(ce->oid.hash, &type, size);
+	void *blob_data = read_object_file(&ce->oid, &type, size);
 
 	if (blob_data) {
 		if (type == OBJ_BLOB)
diff --git a/fast-import.c b/fast-import.c
index dc63af1eb6..b300e4416d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1412,7 +1412,7 @@ static void load_tree(struct tree_entry *root)
 			die("Can't load tree %s", oid_to_hex(oid));
 	} else {
 		enum object_type type;
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_object_file(oid, &type, &size);
 		if (!buf || type != OBJ_TREE)
 			die("Can't load tree %s", oid_to_hex(oid));
 	}
@@ -2967,7 +2967,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	char *buf;
 
 	if (!oe || oe->pack_id == MAX_PACK_ID) {
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_object_file(oid, &type, &size);
 	} else {
 		type = oe->type;
 		buf = gfi_unpack_entry(oe, &size);
@@ -3072,7 +3072,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 		buf = gfi_unpack_entry(oe, &size);
 	} else {
 		enum object_type unused;
-		buf = read_sha1_file(oid->hash, &unused, &size);
+		buf = read_object_file(oid, &unused, &size);
 	}
 	if (!buf)
 		die("Can't load object %s", oid_to_hex(oid));
diff --git a/fsck.c b/fsck.c
index 5c8c12dde3..9218c2a643 100644
--- a/fsck.c
+++ b/fsck.c
@@ -811,7 +811,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		enum object_type type;
 
 		buffer = to_free =
-			read_sha1_file(tag->object.oid.hash, &type, &size);
+			read_object_file(&tag->object.oid, &type, &size);
 		if (!buffer)
 			return report(options, &tag->object,
 				FSCK_MSG_MISSING_TAG_OBJECT,
diff --git a/grep.c b/grep.c
index 834b8eb439..65b90c10a3 100644
--- a/grep.c
+++ b/grep.c
@@ -2015,7 +2015,7 @@ static int grep_source_load_oid(struct grep_source *gs)
 	enum object_type type;
 
 	grep_read_lock();
-	gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
+	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
 	grep_read_unlock();
 
 	if (!gs->buf)
diff --git a/http-push.c b/http-push.c
index 7dcd9daf62..ff82b63133 100644
--- a/http-push.c
+++ b/http-push.c
@@ -361,7 +361,7 @@ static void start_put(struct transfer_request *request)
 	ssize_t size;
 	git_zstream stream;
 
-	unpacked = read_sha1_file(request->obj->oid.hash, &type, &len);
+	unpacked = read_object_file(&request->obj->oid, &type, &len);
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", type_name(type), len) + 1;
 
 	/* Set it up */
diff --git a/mailmap.c b/mailmap.c
index cb921b4db6..13f0d2884e 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -224,7 +224,7 @@ static int read_mailmap_blob(struct string_list *map,
 	if (get_oid(name, &oid) < 0)
 		return 0;
 
-	buf = read_sha1_file(oid.hash, &type, &size);
+	buf = read_object_file(&oid, &type, &size);
 	if (!buf)
 		return error("unable to read mailmap object at %s", name);
 	if (type != OBJ_BLOB)
diff --git a/match-trees.c b/match-trees.c
index 10d6c39d47..72cc2baa3f 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -54,7 +54,7 @@ static void *fill_tree_desc_strict(struct tree_desc *desc,
 	enum object_type type;
 	unsigned long size;
 
-	buffer = read_sha1_file(hash->hash, &type, &size);
+	buffer = read_object_file(hash, &type, &size);
 	if (!buffer)
 		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
@@ -180,7 +180,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	if (*subpath)
 		subpath++;
 
-	buf = read_sha1_file(oid1->hash, &type, &sz);
+	buf = read_object_file(oid1, &type, &sz);
 	if (!buf)
 		die("cannot read tree %s", oid_to_hex(oid1));
 	init_tree_desc(&desc, buf, sz);
diff --git a/merge-blobs.c b/merge-blobs.c
index 9b6eac22e4..fa49c17287 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -11,7 +11,7 @@ static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 	unsigned long size;
 	enum object_type type;
 
-	buf = read_sha1_file(obj->object.oid.hash, &type, &size);
+	buf = read_object_file(&obj->object.oid, &type, &size);
 	if (!buf)
 		return -1;
 	if (type != OBJ_BLOB) {
@@ -66,7 +66,7 @@ void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct
 			return NULL;
 		if (!our)
 			our = their;
-		return read_sha1_file(our->object.oid.hash, &type, size);
+		return read_object_file(&our->object.oid, &type, size);
 	}
 
 	if (fill_mmfile_blob(&f1, our) < 0)
diff --git a/merge-recursive.c b/merge-recursive.c
index 85f8cbee99..c55401698d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -842,7 +842,7 @@ static int update_file_flags(struct merge_options *o,
 			goto update_index;
 		}
 
-		buf = read_sha1_file(oid->hash, &type, &size);
+		buf = read_object_file(oid, &type, &size);
 		if (!buf)
 			return err(o, _("cannot read object %s '%s'"), oid_to_hex(oid), path);
 		if (type != OBJ_BLOB) {
@@ -1656,7 +1656,7 @@ static int read_oid_strbuf(struct merge_options *o,
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		return err(o, _("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
diff --git a/notes-cache.c b/notes-cache.c
index 398e61d5e9..e61988e503 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -77,7 +77,7 @@ char *notes_cache_get(struct notes_cache *c, struct object_id *key_oid,
 	value_oid = get_note(&c->tree, key_oid);
 	if (!value_oid)
 		return NULL;
-	value = read_sha1_file(value_oid->hash, &type, &size);
+	value = read_object_file(value_oid, &type, &size);
 
 	*outsize = size;
 	return value;
diff --git a/notes-merge.c b/notes-merge.c
index c09c5e0e47..8e0726a941 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -322,7 +322,7 @@ static void write_note_to_worktree(const struct object_id *obj,
 {
 	enum object_type type;
 	unsigned long size;
-	void *buf = read_sha1_file(note->hash, &type, &size);
+	void *buf = read_object_file(note, &type, &size);
 
 	if (!buf)
 		die("cannot read note %s for object %s",
diff --git a/notes.c b/notes.c
index d25121a65d..a386d450c4 100644
--- a/notes.c
+++ b/notes.c
@@ -796,13 +796,13 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 
 	/* read in both note blob objects */
 	if (!is_null_oid(new_oid))
-		new_msg = read_sha1_file(new_oid->hash, &new_type, &new_len);
+		new_msg = read_object_file(new_oid, &new_type, &new_len);
 	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
 		free(new_msg);
 		return 0;
 	}
 	if (!is_null_oid(cur_oid))
-		cur_msg = read_sha1_file(cur_oid->hash, &cur_type, &cur_len);
+		cur_msg = read_object_file(cur_oid, &cur_type, &cur_len);
 	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
 		free(cur_msg);
 		free(new_msg);
@@ -858,7 +858,7 @@ static int string_list_add_note_lines(struct string_list *list,
 		return 0;
 
 	/* read_sha1_file NUL-terminates */
-	data = read_sha1_file(oid->hash, &t, &len);
+	data = read_object_file(oid, &t, &len);
 	if (t != OBJ_BLOB || !data || !len) {
 		free(data);
 		return t != OBJ_BLOB || !data;
@@ -1217,7 +1217,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (!oid)
 		return;
 
-	if (!(msg = read_sha1_file(oid->hash, &type, &msglen)) || type != OBJ_BLOB) {
+	if (!(msg = read_object_file(oid, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/object.c b/object.c
index 4063e955db..8e32f0d33b 100644
--- a/object.c
+++ b/object.c
@@ -266,7 +266,7 @@ struct object *parse_object(const struct object_id *oid)
 		return lookup_object(oid->hash);
 	}
 
-	buffer = read_sha1_file(oid->hash, &type, &size);
+	buffer = read_object_file(oid, &type, &size);
 	if (buffer) {
 		struct object_id reploid;
 		hashcpy(reploid.hash, repl);
diff --git a/read-cache.c b/read-cache.c
index 977921d90c..3f0246fe88 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -184,7 +184,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 	if (strbuf_readlink(&sb, ce->name, expected_size))
 		return -1;
 
-	buffer = read_sha1_file(ce->oid.hash, &type, &size);
+	buffer = read_object_file(&ce->oid, &type, &size);
 	if (buffer) {
 		if (size == sb.len)
 			match = memcmp(buffer, sb.buf, size);
@@ -2683,7 +2683,7 @@ void *read_blob_data_from_index(const struct index_state *istate,
 	}
 	if (pos < 0)
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->oid.hash, &type, &sz);
+	data = read_object_file(&istate->cache[pos]->oid, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
diff --git a/ref-filter.c b/ref-filter.c
index ca2bc7e6b2..9a333e21b5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -728,7 +728,7 @@ int verify_ref_format(struct ref_format *format)
 static void *get_obj(const struct object_id *oid, struct object **obj, unsigned long *sz, int *eaten)
 {
 	enum object_type type;
-	void *buf = read_sha1_file(oid->hash, &type, sz);
+	void *buf = read_object_file(oid, &type, sz);
 
 	if (buf)
 		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
diff --git a/remote-testsvn.c b/remote-testsvn.c
index bcebb4c789..c4bb9a8ba9 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -61,7 +61,7 @@ static char *read_ref_note(const struct object_id *oid)
 	init_notes(NULL, notes_ref, NULL, 0);
 	if (!(note_oid = get_note(NULL, oid)))
 		return NULL;	/* note tree not found */
-	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)))
+	if (!(msg = read_object_file(note_oid, &type, &msglen)))
 		error("Empty notes tree. %s", notes_ref);
 	else if (!msglen || type != OBJ_BLOB) {
 		error("Note contains unusable content. "
@@ -108,7 +108,7 @@ static int note2mark_cb(const struct object_id *object_oid,
 	enum object_type type;
 	struct rev_note note;
 
-	if (!(msg = read_sha1_file(note_oid->hash, &type, &msglen)) ||
+	if (!(msg = read_object_file(note_oid, &type, &msglen)) ||
 			!msglen || type != OBJ_BLOB) {
 		free(msg);
 		return 1;
diff --git a/rerere.c b/rerere.c
index 79203c6c1e..8af6b660e0 100644
--- a/rerere.c
+++ b/rerere.c
@@ -981,8 +981,8 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 			break;
 		i = ce_stage(ce) - 1;
 		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = read_sha1_file(ce->oid.hash, &type,
-						       &size);
+			mmfile[i].ptr = read_object_file(&ce->oid, &type,
+							 &size);
 			mmfile[i].size = size;
 		}
 	}
diff --git a/sha1_file.c b/sha1_file.c
index e2b8e7694e..cdd49e5274 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1363,17 +1363,17 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_sha1_file_extended(const unsigned char *sha1,
-			      enum object_type *type,
-			      unsigned long *size,
-			      int lookup_replace)
+void *read_object_file_extended(const struct object_id *oid,
+				enum object_type *type,
+				unsigned long *size,
+				int lookup_replace)
 {
 	void *data;
 	const struct packed_git *p;
 	const char *path;
 	struct stat st;
-	const unsigned char *repl = lookup_replace ? lookup_replace_object(sha1)
-						   : sha1;
+	const unsigned char *repl = lookup_replace ? lookup_replace_object(oid->hash)
+						   : oid->hash;
 
 	errno = 0;
 	data = read_object(repl, type, size);
@@ -1381,12 +1381,12 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 		return data;
 
 	if (errno && errno != ENOENT)
-		die_errno("failed to read object %s", sha1_to_hex(sha1));
+		die_errno("failed to read object %s", oid_to_hex(oid));
 
 	/* die if we replaced an object with one that does not exist */
-	if (repl != sha1)
+	if (repl != oid->hash)
 		die("replacement %s not found for %s",
-		    sha1_to_hex(repl), sha1_to_hex(sha1));
+		    sha1_to_hex(repl), oid_to_hex(oid));
 
 	if (!stat_sha1_file(repl, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
@@ -1415,7 +1415,7 @@ void *read_object_with_reference(const struct object_id *oid,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = read_sha1_file(actual_oid.hash, &type, &isize);
+		buffer = read_object_file(&actual_oid, &type, &isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
diff --git a/streaming.c b/streaming.c
index 3f4be1ea2c..72a3ca8d08 100644
--- a/streaming.c
+++ b/streaming.c
@@ -492,7 +492,7 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	st->u.incore.buf = read_sha1_file_extended(oid->hash, type, &st->size, 0);
+	st->u.incore.buf = read_object_file_extended(oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
 
diff --git a/submodule-config.c b/submodule-config.c
index 602ba8ca8b..3f2075764f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -520,7 +520,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	if (submodule)
 		goto out;
 
-	config = read_sha1_file(oid.hash, &type, &config_size);
+	config = read_object_file(&oid, &type, &config_size);
 	if (!config || type != OBJ_BLOB)
 		goto out;
 
diff --git a/tag.c b/tag.c
index db3e31034c..86b1dcbb82 100644
--- a/tag.c
+++ b/tag.c
@@ -49,7 +49,7 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 				find_unique_abbrev(oid, DEFAULT_ABBREV),
 				type_name(type));
 
-	buf = read_sha1_file(oid->hash, &type, &size);
+	buf = read_object_file(oid, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
 				name_to_report ?
@@ -182,7 +182,7 @@ int parse_tag(struct tag *item)
 
 	if (item->object.parsed)
 		return 0;
-	data = read_sha1_file(item->object.oid.hash, &type, &size);
+	data = read_object_file(&item->object.oid, &type, &size);
 	if (!data)
 		return error("Could not read %s",
 			     oid_to_hex(&item->object.oid));
diff --git a/tree-walk.c b/tree-walk.c
index b7e504070c..e11b3063af 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -713,8 +713,8 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 			 */
 			retval = DANGLING_SYMLINK;
 
-			contents = read_sha1_file(current_tree_oid.hash, &type,
-						  &link_len);
+			contents = read_object_file(&current_tree_oid, &type,
+						    &link_len);
 
 			if (!contents)
 				goto done;
diff --git a/tree.c b/tree.c
index 1a0f03f520..1c68ea586b 100644
--- a/tree.c
+++ b/tree.c
@@ -219,7 +219,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.oid.hash, &type, &size);
+	buffer = read_object_file(&item->object.oid, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 770e1f7f81..9315bc0ede 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -191,7 +191,7 @@ void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
 		return;
 	}
 
-	ptr->ptr = read_sha1_file(oid->hash, &type, &size);
+	ptr->ptr = read_object_file(oid, &type, &size);
 	if (!ptr->ptr || type != OBJ_BLOB)
 		die("unable to read blob object %s", oid_to_hex(oid));
 	ptr->size = size;
