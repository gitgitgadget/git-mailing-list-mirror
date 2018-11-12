Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A18F1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeKMAm0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:42:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:35690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:42:26 -0500
Received: (qmail 29335 invoked by uid 109); 12 Nov 2018 14:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:48:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11232 invoked by uid 111); 12 Nov 2018 14:48:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:48:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:48:47 -0500
Date:   Mon, 12 Nov 2018 09:48:47 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 3/9] rename "alternate_object_database" to "object_directory"
Message-ID: <20181112144846.GC7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for unifying the handling of alt odb's and the normal
repo object directory, let's use a more neutral name. This patch is
purely mechanical, swapping the type name, and converting any variables
named "alt" to "odb". There should be no functional change, but it will
reduce the noise in subsequent diffs.

Signed-off-by: Jeff King <peff@peff.net>
---
I waffled on calling this object_database instead of object_directory.
But really, it is very specifically about the directory (packed
storage, including packs from alternates, is handled elsewhere).

 builtin/count-objects.c     |  4 ++--
 builtin/fsck.c              | 16 ++++++-------
 builtin/submodule--helper.c |  6 ++---
 commit-graph.c              | 10 ++++----
 object-store.h              | 14 +++++------
 object.c                    | 10 ++++----
 packfile.c                  |  8 +++----
 sha1-file.c                 | 48 ++++++++++++++++++-------------------
 sha1-name.c                 | 20 ++++++++--------
 transport.c                 |  2 +-
 10 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a7cad052c6..3fae474f6f 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -78,10 +78,10 @@ static int count_cruft(const char *basename, const char *path, void *data)
 	return 0;
 }
 
-static int print_alternate(struct alternate_object_database *alt, void *data)
+static int print_alternate(struct object_directory *odb, void *data)
 {
 	printf("alternate: ");
-	quote_c_style(alt->path, NULL, stdout, 0);
+	quote_c_style(odb->path, NULL, stdout, 0);
 	putchar('\n');
 	return 0;
 }
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b10f2b154c..55153cf92a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -688,7 +688,7 @@ static struct option fsck_opts[] = {
 int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 
 	/* fsck knows how to handle missing promisor objects */
 	fetch_if_missing = 0;
@@ -725,14 +725,14 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
 	} else {
-		struct alternate_object_database *alt_odb_list;
+		struct object_directory *alt_odb_list;
 
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb(the_repository);
 		alt_odb_list = the_repository->objects->alt_odb_list;
-		for (alt = alt_odb_list; alt; alt = alt->next)
-			fsck_object_dir(alt->path);
+		for (odb = alt_odb_list; odb; odb = odb->next)
+			fsck_object_dir(odb->path);
 
 		if (check_full) {
 			struct packed_git *p;
@@ -840,12 +840,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			errors_found |= ERROR_COMMIT_GRAPH;
 
 		prepare_alt_odb(the_repository);
-		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+		for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.argv = verify_argv;
 			commit_graph_verify.git_cmd = 1;
 			verify_argv[2] = "--object-dir";
-			verify_argv[3] = alt->path;
+			verify_argv[3] = odb->path;
 			if (run_command(&commit_graph_verify))
 				errors_found |= ERROR_COMMIT_GRAPH;
 		}
@@ -861,12 +861,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			errors_found |= ERROR_COMMIT_GRAPH;
 
 		prepare_alt_odb(the_repository);
-		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
+		for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
 			child_process_init(&midx_verify);
 			midx_verify.argv = midx_argv;
 			midx_verify.git_cmd = 1;
 			midx_argv[2] = "--object-dir";
-			midx_argv[3] = alt->path;
+			midx_argv[3] = odb->path;
 			if (run_command(&midx_verify))
 				errors_found |= ERROR_COMMIT_GRAPH;
 		}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 28b9449e82..3ae451bc46 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1265,7 +1265,7 @@ struct submodule_alternate_setup {
 	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
 
 static int add_possible_reference_from_superproject(
-		struct alternate_object_database *alt, void *sas_cb)
+		struct object_directory *odb, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
 	size_t len;
@@ -1274,11 +1274,11 @@ static int add_possible_reference_from_superproject(
 	 * If the alternate object store is another repository, try the
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
-	if (strip_suffix(alt->path, "/objects", &len)) {
+	if (strip_suffix(odb->path, "/objects", &len)) {
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
-		strbuf_add(&sb, alt->path, len);
+		strbuf_add(&sb, odb->path, len);
 
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..5dd3f5b15c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -230,7 +230,7 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
  */
 static int prepare_commit_graph(struct repository *r)
 {
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 	char *obj_dir;
 	int config_value;
 
@@ -255,10 +255,10 @@ static int prepare_commit_graph(struct repository *r)
 	obj_dir = r->objects->objectdir;
 	prepare_commit_graph_one(r, obj_dir);
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list;
-	     !r->objects->commit_graph && alt;
-	     alt = alt->next)
-		prepare_commit_graph_one(r, alt->path);
+	for (odb = r->objects->alt_odb_list;
+	     !r->objects->commit_graph && odb;
+	     odb = odb->next)
+		prepare_commit_graph_one(r, odb->path);
 	return !!r->objects->commit_graph;
 }
 
diff --git a/object-store.h b/object-store.h
index 63b7605a3e..122d5f75e2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -7,8 +7,8 @@
 #include "sha1-array.h"
 #include "strbuf.h"
 
-struct alternate_object_database {
-	struct alternate_object_database *next;
+struct object_directory {
+	struct object_directory *next;
 
 	/* see alt_scratch_buf() */
 	struct strbuf scratch;
@@ -32,14 +32,14 @@ struct alternate_object_database {
 };
 void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
+typedef int alt_odb_fn(struct object_directory *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 
 /*
  * Allocate a "struct alternate_object_database" but do _not_ actually
  * add it to the list of alternates.
  */
-struct alternate_object_database *alloc_alt_odb(const char *dir);
+struct object_directory *alloc_alt_odb(const char *dir);
 
 /*
  * Add the directory to the on-disk alternates file; the new entry will also
@@ -60,7 +60,7 @@ void add_to_alternates_memory(const char *dir);
  * alternate. Always use this over direct access to alt->scratch, as it
  * cleans up any previous use of the scratch buffer.
  */
-struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
+struct strbuf *alt_scratch_buf(struct object_directory *odb);
 
 struct packed_git {
 	struct packed_git *next;
@@ -100,8 +100,8 @@ struct raw_object_store {
 	/* Path to extra alternate object database if not NULL */
 	char *alternate_db;
 
-	struct alternate_object_database *alt_odb_list;
-	struct alternate_object_database **alt_odb_tail;
+	struct object_directory *alt_odb_list;
+	struct object_directory **alt_odb_tail;
 
 	/*
 	 * Objects that should be substituted by other objects
diff --git a/object.c b/object.c
index e54160550c..6af8e908bb 100644
--- a/object.c
+++ b/object.c
@@ -482,17 +482,17 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_alt_odb(struct alternate_object_database *alt)
+static void free_alt_odb(struct object_directory *odb)
 {
-	strbuf_release(&alt->scratch);
-	oid_array_clear(&alt->loose_objects_cache);
-	free(alt);
+	strbuf_release(&odb->scratch);
+	oid_array_clear(&odb->loose_objects_cache);
+	free(odb);
 }
 
 static void free_alt_odbs(struct raw_object_store *o)
 {
 	while (o->alt_odb_list) {
-		struct alternate_object_database *next;
+		struct object_directory *next;
 
 		next = o->alt_odb_list->next;
 		free_alt_odb(o->alt_odb_list);
diff --git a/packfile.c b/packfile.c
index f2850a00b5..d6d511cfd2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -966,16 +966,16 @@ static void prepare_packed_git_mru(struct repository *r)
 
 static void prepare_packed_git(struct repository *r)
 {
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 
 	if (r->objects->packed_git_initialized)
 		return;
 	prepare_multi_pack_index_one(r, r->objects->objectdir, 1);
 	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
-		prepare_multi_pack_index_one(r, alt->path, 0);
-		prepare_packed_git_one(r, alt->path, 0);
+	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
+		prepare_multi_pack_index_one(r, odb->path, 0);
+		prepare_packed_git_one(r, odb->path, 0);
 	}
 	rearrange_packed_git(r);
 
diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..a3cc650a0a 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -353,16 +353,16 @@ void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned cha
 	fill_sha1_path(buf, sha1);
 }
 
-struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
+struct strbuf *alt_scratch_buf(struct object_directory *odb)
 {
-	strbuf_setlen(&alt->scratch, alt->base_len);
-	return &alt->scratch;
+	strbuf_setlen(&odb->scratch, odb->base_len);
+	return &odb->scratch;
 }
 
-static const char *alt_sha1_path(struct alternate_object_database *alt,
+static const char *alt_sha1_path(struct object_directory *odb,
 				 const unsigned char *sha1)
 {
-	struct strbuf *buf = alt_scratch_buf(alt);
+	struct strbuf *buf = alt_scratch_buf(odb);
 	fill_sha1_path(buf, sha1);
 	return buf->buf;
 }
@@ -374,7 +374,7 @@ static int alt_odb_usable(struct raw_object_store *o,
 			  struct strbuf *path,
 			  const char *normalized_objdir)
 {
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
@@ -388,8 +388,8 @@ static int alt_odb_usable(struct raw_object_store *o,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = o->alt_odb_list; alt; alt = alt->next) {
-		if (!fspathcmp(path->buf, alt->path))
+	for (odb = o->alt_odb_list; odb; odb = odb->next) {
+		if (!fspathcmp(path->buf, odb->path))
 			return 0;
 	}
 	if (!fspathcmp(path->buf, normalized_objdir))
@@ -402,7 +402,7 @@ static int alt_odb_usable(struct raw_object_store *o,
  * Prepare alternate object database registry.
  *
  * The variable alt_odb_list points at the list of struct
- * alternate_object_database.  The elements on this list come from
+ * object_directory.  The elements on this list come from
  * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
  * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
  * whose contents is similar to that environment variable but can be
@@ -419,7 +419,7 @@ static void read_info_alternates(struct repository *r,
 static int link_alt_odb_entry(struct repository *r, const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
-	struct alternate_object_database *ent;
+	struct object_directory *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
@@ -540,9 +540,9 @@ static void read_info_alternates(struct repository *r,
 	free(path);
 }
 
-struct alternate_object_database *alloc_alt_odb(const char *dir)
+struct object_directory *alloc_alt_odb(const char *dir)
 {
-	struct alternate_object_database *ent;
+	struct object_directory *ent;
 
 	FLEX_ALLOC_STR(ent, path, dir);
 	strbuf_init(&ent->scratch, 0);
@@ -684,7 +684,7 @@ char *compute_alternate_path(const char *path, struct strbuf *err)
 
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
-	struct alternate_object_database *ent;
+	struct object_directory *ent;
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
@@ -743,10 +743,10 @@ static int check_and_freshen_local(const struct object_id *oid, int freshen)
 
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects->alt_odb_list; alt; alt = alt->next) {
-		const char *path = alt_sha1_path(alt, oid->hash);
+	for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
+		const char *path = alt_sha1_path(odb, oid->hash);
 		if (check_and_freshen_file(path, freshen))
 			return 1;
 	}
@@ -893,7 +893,7 @@ int git_open_cloexec(const char *name, int flags)
 static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 			  struct stat *st, const char **path)
 {
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
@@ -905,8 +905,8 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 
 	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
-		*path = alt_sha1_path(alt, sha1);
+	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
+		*path = alt_sha1_path(odb, sha1);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -922,7 +922,7 @@ static int open_sha1_file(struct repository *r,
 			  const unsigned char *sha1, const char **path)
 {
 	int fd;
-	struct alternate_object_database *alt;
+	struct object_directory *odb;
 	int most_interesting_errno;
 	static struct strbuf buf = STRBUF_INIT;
 
@@ -936,8 +936,8 @@ static int open_sha1_file(struct repository *r,
 	most_interesting_errno = errno;
 
 	prepare_alt_odb(r);
-	for (alt = r->objects->alt_odb_list; alt; alt = alt->next) {
-		*path = alt_sha1_path(alt, sha1);
+	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
+		*path = alt_sha1_path(odb, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
@@ -2139,14 +2139,14 @@ struct loose_alt_odb_data {
 	void *data;
 };
 
-static int loose_from_alt_odb(struct alternate_object_database *alt,
+static int loose_from_alt_odb(struct object_directory *odb,
 			      void *vdata)
 {
 	struct loose_alt_odb_data *data = vdata;
 	struct strbuf buf = STRBUF_INIT;
 	int r;
 
-	strbuf_addstr(&buf, alt->path);
+	strbuf_addstr(&buf, odb->path);
 	r = for_each_loose_file_in_objdir_buf(&buf,
 					      data->cb, NULL, NULL,
 					      data->data);
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..2594aa79f8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -95,8 +95,8 @@ static int match_sha(unsigned, const unsigned char *, const unsigned char *);
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	int subdir_nr = ds->bin_pfx.hash[0];
-	struct alternate_object_database *alt;
-	static struct alternate_object_database *fakeent;
+	struct object_directory *odb;
+	static struct object_directory *fakeent;
 
 	if (!fakeent) {
 		/*
@@ -110,24 +110,24 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 	}
 	fakeent->next = the_repository->objects->alt_odb_list;
 
-	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
+	for (odb = fakeent; odb && !ds->ambiguous; odb = odb->next) {
 		int pos;
 
-		if (!alt->loose_objects_subdir_seen[subdir_nr]) {
-			struct strbuf *buf = alt_scratch_buf(alt);
+		if (!odb->loose_objects_subdir_seen[subdir_nr]) {
+			struct strbuf *buf = alt_scratch_buf(odb);
 			for_each_file_in_obj_subdir(subdir_nr, buf,
 						    append_loose_object,
 						    NULL, NULL,
-						    &alt->loose_objects_cache);
-			alt->loose_objects_subdir_seen[subdir_nr] = 1;
+						    &odb->loose_objects_cache);
+			odb->loose_objects_subdir_seen[subdir_nr] = 1;
 		}
 
-		pos = oid_array_lookup(&alt->loose_objects_cache, &ds->bin_pfx);
+		pos = oid_array_lookup(&odb->loose_objects_cache, &ds->bin_pfx);
 		if (pos < 0)
 			pos = -1 - pos;
-		while (!ds->ambiguous && pos < alt->loose_objects_cache.nr) {
+		while (!ds->ambiguous && pos < odb->loose_objects_cache.nr) {
 			const struct object_id *oid;
-			oid = alt->loose_objects_cache.oid + pos;
+			oid = odb->loose_objects_cache.oid + pos;
 			if (!match_sha(ds->len, ds->bin_pfx.hash, oid->hash))
 				break;
 			update_candidates(ds, oid);
diff --git a/transport.c b/transport.c
index 5a74b609ff..040e92c134 100644
--- a/transport.c
+++ b/transport.c
@@ -1433,7 +1433,7 @@ struct alternate_refs_data {
 	void *data;
 };
 
-static int refs_from_alternate_cb(struct alternate_object_database *e,
+static int refs_from_alternate_cb(struct object_directory *e,
 				  void *data)
 {
 	struct strbuf path = STRBUF_INIT;
-- 
2.19.1.1577.g2c5b293d4f

