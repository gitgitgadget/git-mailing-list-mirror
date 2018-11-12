Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112721F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeKMAoR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:44:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:35734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:44:17 -0500
Received: (qmail 29470 invoked by uid 109); 12 Nov 2018 14:50:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:50:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11300 invoked by uid 111); 12 Nov 2018 14:50:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:50:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:50:39 -0500
Date:   Mon, 12 Nov 2018 09:50:39 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 6/9] sha1-file: use an object_directory for the main object
 dir
Message-ID: <20181112145039.GF7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our handling of alternate object directories is needlessly different
from the main object directory. As a result, many places in the code
basically look like this:

  do_something(r->objects->objdir);

  for (odb = r->objects->alt_odb_list; odb; odb = odb->next)
        do_something(odb->path);

That gets annoying when do_something() is non-trivial, and we've
resorted to gross hacks like creating fake alternates (see
find_short_object_filename()).

Instead, let's give each raw_object_store a unified list of
object_directory structs. The first will be the main store, and
everything after is an alternate. Very few callers even care about the
distinction, and can just loop over the whole list (and those who care
can just treat the first element differently).

A few observations:

  - we don't need r->objects->objectdir anymore, and can just
    mechanically convert that to r->objects->odb->path

  - object_directory's path field needs to become a real pointer rather
    than a FLEX_ARRAY, in order to fill it with expand_base_dir()

  - we'll call prepare_alt_odb() earlier in many functions (i.e.,
    outside of the loop). This may result in us calling it even when our
    function would be satisfied looking only at the main odb.

    But this doesn't matter in practice. It's not a very expensive
    operation in the first place, and in the majority of cases it will
    be a noop. We call it already (and cache its results) in
    prepare_packed_git(), and we'll generally check packs before loose
    objects. So essentially every program is going to call it
    immediately once per program.

    Arguably we should just prepare_alt_odb() immediately upon setting
    up the repository's object directory, which would save us sprinkling
    calls throughout the code base (and forgetting to do so has been a
    source of subtle bugs in the past). But I've stopped short of that
    here, since there are already a lot of other moving parts in this
    patch.

  - Most call sites just get shorter. The check_and_freshen() functions
    are an exception, because they have entry points to handle local and
    nonlocal directories separately.

Signed-off-by: Jeff King <peff@peff.net>
---
If the "the first one is the main store, the rest are alternates" bit is
too subtle, we could mark each "struct object_directory" with a bit for
"is_local".

 builtin/fsck.c |  21 ++-------
 builtin/grep.c |   2 +-
 commit-graph.c |   5 +-
 environment.c  |   4 +-
 object-store.h |  27 ++++++-----
 object.c       |  19 ++++----
 packfile.c     |  10 ++--
 path.c         |   2 +-
 repository.c   |   8 +++-
 sha1-file.c    | 122 ++++++++++++++++++-------------------------------
 sha1-name.c    |  17 ++-----
 11 files changed, 90 insertions(+), 147 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 55153cf92a..15338bd178 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -725,13 +725,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(mark_packed_for_connectivity, NULL, 0);
 	} else {
-		struct object_directory *alt_odb_list;
-
-		fsck_object_dir(get_object_directory());
-
 		prepare_alt_odb(the_repository);
-		alt_odb_list = the_repository->objects->alt_odb_list;
-		for (odb = alt_odb_list; odb; odb = odb->next)
+		for (odb = the_repository->objects->odb; odb; odb = odb->next)
 			fsck_object_dir(odb->path);
 
 		if (check_full) {
@@ -834,13 +829,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
 
-		commit_graph_verify.argv = verify_argv;
-		commit_graph_verify.git_cmd = 1;
-		if (run_command(&commit_graph_verify))
-			errors_found |= ERROR_COMMIT_GRAPH;
-
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
+		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
 			child_process_init(&commit_graph_verify);
 			commit_graph_verify.argv = verify_argv;
 			commit_graph_verify.git_cmd = 1;
@@ -855,13 +845,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
 		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
 
-		midx_verify.argv = midx_argv;
-		midx_verify.git_cmd = 1;
-		if (run_command(&midx_verify))
-			errors_found |= ERROR_COMMIT_GRAPH;
-
 		prepare_alt_odb(the_repository);
-		for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
+		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
 			child_process_init(&midx_verify);
 			midx_verify.argv = midx_argv;
 			midx_verify.git_cmd = 1;
diff --git a/builtin/grep.c b/builtin/grep.c
index d8508ddf79..714c8d91ba 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -441,7 +441,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objects->objectdir);
+	add_to_alternates_memory(submodule.objects->odb->path);
 	grep_read_unlock();
 
 	if (oid) {
diff --git a/commit-graph.c b/commit-graph.c
index 5dd3f5b15c..99163c244b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -231,7 +231,6 @@ static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
 static int prepare_commit_graph(struct repository *r)
 {
 	struct object_directory *odb;
-	char *obj_dir;
 	int config_value;
 
 	if (r->objects->commit_graph_attempted)
@@ -252,10 +251,8 @@ static int prepare_commit_graph(struct repository *r)
 	if (!commit_graph_compatible(r))
 		return 0;
 
-	obj_dir = r->objects->objectdir;
-	prepare_commit_graph_one(r, obj_dir);
 	prepare_alt_odb(r);
-	for (odb = r->objects->alt_odb_list;
+	for (odb = r->objects->odb;
 	     !r->objects->commit_graph && odb;
 	     odb = odb->next)
 		prepare_commit_graph_one(r, odb->path);
diff --git a/environment.c b/environment.c
index 3f3c8746c2..441ce56690 100644
--- a/environment.c
+++ b/environment.c
@@ -274,9 +274,9 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!the_repository->objects->objectdir)
+	if (!the_repository->objects->odb)
 		BUG("git environment hasn't been setup");
-	return the_repository->objects->objectdir;
+	return the_repository->objects->odb->path;
 }
 
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
diff --git a/object-store.h b/object-store.h
index b2fa0d0df0..30faf7b391 100644
--- a/object-store.h
+++ b/object-store.h
@@ -24,19 +24,14 @@ struct object_directory {
 	 * Path to the alternative object store. If this is a relative path,
 	 * it is relative to the current working directory.
 	 */
-	char path[FLEX_ARRAY];
+	char *path;
 };
+
 void prepare_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct object_directory *, void *);
 int foreach_alt_odb(alt_odb_fn, void*);
 
-/*
- * Allocate a "struct alternate_object_database" but do _not_ actually
- * add it to the list of alternates.
- */
-struct object_directory *alloc_alt_odb(const char *dir);
-
 /*
  * Add the directory to the on-disk alternates file; the new entry will also
  * take effect in the current process.
@@ -80,17 +75,21 @@ struct multi_pack_index;
 
 struct raw_object_store {
 	/*
-	 * Path to the repository's object store.
-	 * Cannot be NULL after initialization.
+	 * Set of all object directories; the main directory is first (and
+	 * cannot be NULL after initialization). Subsequent directories are
+	 * alternates.
 	 */
-	char *objectdir;
+	struct object_directory *odb;
+	struct object_directory **odb_tail;
+	int loaded_alternates;
 
-	/* Path to extra alternate object database if not NULL */
+	/*
+	 * A list of alternate object directories loaded from the environment;
+	 * this should not generally need to be accessed directly, but will
+	 * populate the "odb" list when prepare_alt_odb() is run.
+	 */
 	char *alternate_db;
 
-	struct object_directory *alt_odb_list;
-	struct object_directory **alt_odb_tail;
-
 	/*
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).
diff --git a/object.c b/object.c
index dd485ac629..79d636091c 100644
--- a/object.c
+++ b/object.c
@@ -482,26 +482,26 @@ struct raw_object_store *raw_object_store_new(void)
 	return o;
 }
 
-static void free_alt_odb(struct object_directory *odb)
+static void free_object_directory(struct object_directory *odb)
 {
+	free(odb->path);
 	oid_array_clear(&odb->loose_objects_cache);
 	free(odb);
 }
 
-static void free_alt_odbs(struct raw_object_store *o)
+static void free_object_directories(struct raw_object_store *o)
 {
-	while (o->alt_odb_list) {
+	while (o->odb) {
 		struct object_directory *next;
 
-		next = o->alt_odb_list->next;
-		free_alt_odb(o->alt_odb_list);
-		o->alt_odb_list = next;
+		next = o->odb->next;
+		free_object_directory(o->odb);
+		o->odb = next;
 	}
 }
 
 void raw_object_store_clear(struct raw_object_store *o)
 {
-	FREE_AND_NULL(o->objectdir);
 	FREE_AND_NULL(o->alternate_db);
 
 	oidmap_free(o->replace_map, 1);
@@ -511,8 +511,9 @@ void raw_object_store_clear(struct raw_object_store *o)
 	o->commit_graph = NULL;
 	o->commit_graph_attempted = 0;
 
-	free_alt_odbs(o);
-	o->alt_odb_tail = NULL;
+	free_object_directories(o);
+	o->odb_tail = NULL;
+	o->loaded_alternates = 0;
 
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_all_packs(o);
diff --git a/packfile.c b/packfile.c
index d6d511cfd2..1eda33247f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -970,12 +970,12 @@ static void prepare_packed_git(struct repository *r)
 
 	if (r->objects->packed_git_initialized)
 		return;
-	prepare_multi_pack_index_one(r, r->objects->objectdir, 1);
-	prepare_packed_git_one(r, r->objects->objectdir, 1);
+
 	prepare_alt_odb(r);
-	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
-		prepare_multi_pack_index_one(r, odb->path, 0);
-		prepare_packed_git_one(r, odb->path, 0);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		int local = (odb == r->objects->odb);
+		prepare_multi_pack_index_one(r, odb->path, local);
+		prepare_packed_git_one(r, odb->path, local);
 	}
 	rearrange_packed_git(r);
 
diff --git a/path.c b/path.c
index ba06ec5b2d..e8609cf56d 100644
--- a/path.c
+++ b/path.c
@@ -383,7 +383,7 @@ static void adjust_git_path(const struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objects->objectdir);
+		replace_dir(buf, git_dir_len + 7, repo->objects->odb->path);
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (repo->different_commondir)
diff --git a/repository.c b/repository.c
index 5dd1486718..7b02e1dffa 100644
--- a/repository.c
+++ b/repository.c
@@ -63,8 +63,14 @@ void repo_set_gitdir(struct repository *repo,
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-	expand_base_dir(&repo->objects->objectdir, o->object_dir,
+
+	if (!repo->objects->odb) {
+		repo->objects->odb = xcalloc(1, sizeof(*repo->objects->odb));
+		repo->objects->odb_tail = &repo->objects->odb->next;
+	}
+	expand_base_dir(&repo->objects->odb->path, o->object_dir,
 			repo->commondir, "objects");
+
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
diff --git a/sha1-file.c b/sha1-file.c
index 15db6b61a9..503262edd2 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -346,11 +346,12 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-static const char *odb_loose_path(const char *path, struct strbuf *buf,
+static const char *odb_loose_path(struct object_directory *odb,
+				  struct strbuf *buf,
 				  const unsigned char *sha1)
 {
 	strbuf_reset(buf);
-	strbuf_addstr(buf, path);
+	strbuf_addstr(buf, odb->path);
 	strbuf_addch(buf, '/');
 	fill_sha1_path(buf, sha1);
 	return buf->buf;
@@ -359,7 +360,7 @@ static const char *odb_loose_path(const char *path, struct strbuf *buf,
 const char *loose_object_path(struct repository *r, struct strbuf *buf,
 			      const unsigned char *sha1)
 {
-	return odb_loose_path(r->objects->objectdir, buf, sha1);
+	return odb_loose_path(r->objects->odb, buf, sha1);
 }
 
 /*
@@ -383,7 +384,7 @@ static int alt_odb_usable(struct raw_object_store *o,
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (odb = o->alt_odb_list; odb; odb = odb->next) {
+	for (odb = o->odb; odb; odb = odb->next) {
 		if (!fspathcmp(path->buf, odb->path))
 			return 0;
 	}
@@ -442,11 +443,12 @@ static int link_alt_odb_entry(struct repository *r, const char *entry,
 		return -1;
 	}
 
-	ent = alloc_alt_odb(pathbuf.buf);
+	ent = xcalloc(1, sizeof(*ent));
+	ent->path = xstrdup(pathbuf.buf);
 
 	/* add the alternate entry */
-	*r->objects->alt_odb_tail = ent;
-	r->objects->alt_odb_tail = &(ent->next);
+	*r->objects->odb_tail = ent;
+	r->objects->odb_tail = &(ent->next);
 	ent->next = NULL;
 
 	/* recursively add alternates */
@@ -500,7 +502,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, r->objects->objectdir);
+	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
 	if (strbuf_normalize_path(&objdirbuf) < 0)
 		die(_("unable to normalize object directory: %s"),
 		    objdirbuf.buf);
@@ -535,15 +537,6 @@ static void read_info_alternates(struct repository *r,
 	free(path);
 }
 
-struct object_directory *alloc_alt_odb(const char *dir)
-{
-	struct object_directory *ent;
-
-	FLEX_ALLOC_STR(ent, path, dir);
-
-	return ent;
-}
-
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file lock = LOCK_INIT;
@@ -580,7 +573,7 @@ void add_to_alternates_file(const char *reference)
 		fprintf_or_die(out, "%s\n", reference);
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
-		if (the_repository->objects->alt_odb_tail)
+		if (the_repository->objects->loaded_alternates)
 			link_alt_odb_entries(the_repository, reference,
 					     '\n', NULL, 0);
 	}
@@ -680,7 +673,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	int r = 0;
 
 	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects->alt_odb_list; ent; ent = ent->next) {
+	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
 		r = fn(ent, cb);
 		if (r)
 			break;
@@ -690,13 +683,13 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 
 void prepare_alt_odb(struct repository *r)
 {
-	if (r->objects->alt_odb_tail)
+	if (r->objects->loaded_alternates)
 		return;
 
-	r->objects->alt_odb_tail = &r->objects->alt_odb_list;
 	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
 
-	read_info_alternates(r, r->objects->objectdir, 0);
+	read_info_alternates(r, r->objects->odb->path, 0);
+	r->objects->loaded_alternates = 1;
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
@@ -723,24 +716,27 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_local(const struct object_id *oid, int freshen)
+static int check_and_freshen_odb(struct object_directory *odb,
+				 const struct object_id *oid,
+				 int freshen)
 {
-	static struct strbuf buf = STRBUF_INIT;
-
-	loose_object_path(the_repository, &buf, oid->hash);
+	static struct strbuf path = STRBUF_INIT;
+	odb_loose_path(odb, &path, oid->hash);
+	return check_and_freshen_file(path.buf, freshen);
+}
 
-	return check_and_freshen_file(buf.buf, freshen);
+static int check_and_freshen_local(const struct object_id *oid, int freshen)
+{
+	return check_and_freshen_odb(the_repository->objects->odb, oid, freshen);
 }
 
 static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
 {
 	struct object_directory *odb;
-	static struct strbuf path = STRBUF_INIT;
 
 	prepare_alt_odb(the_repository);
-	for (odb = the_repository->objects->alt_odb_list; odb; odb = odb->next) {
-		odb_loose_path(odb->path, &path, oid->hash);
-		if (check_and_freshen_file(path.buf, freshen))
+	for (odb = the_repository->objects->odb->next; odb; odb = odb->next) {
+		if (check_and_freshen_odb(odb, oid, freshen))
 			return 1;
 	}
 	return 0;
@@ -889,14 +885,9 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 	struct object_directory *odb;
 	static struct strbuf buf = STRBUF_INIT;
 
-	*path = loose_object_path(r, &buf, sha1);
-	if (!lstat(*path, st))
-		return 0;
-
 	prepare_alt_odb(r);
-	errno = ENOENT;
-	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
-		*path = odb_loose_path(odb->path, &buf, sha1);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		*path = odb_loose_path(odb, &buf, sha1);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -913,21 +904,16 @@ static int open_sha1_file(struct repository *r,
 {
 	int fd;
 	struct object_directory *odb;
-	int most_interesting_errno;
+	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
 
-	*path = loose_object_path(r, &buf, sha1);
-	fd = git_open(*path);
-	if (fd >= 0)
-		return fd;
-	most_interesting_errno = errno;
-
 	prepare_alt_odb(r);
-	for (odb = r->objects->alt_odb_list; odb; odb = odb->next) {
-		*path = odb_loose_path(odb->path, &buf, sha1);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		*path = odb_loose_path(odb, &buf, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
+
 		if (most_interesting_errno == ENOENT)
 			most_interesting_errno = errno;
 	}
@@ -2120,43 +2106,23 @@ int for_each_loose_file_in_objdir(const char *path,
 	return r;
 }
 
-struct loose_alt_odb_data {
-	each_loose_object_fn *cb;
-	void *data;
-};
-
-static int loose_from_alt_odb(struct object_directory *odb,
-			      void *vdata)
-{
-	struct loose_alt_odb_data *data = vdata;
-	struct strbuf buf = STRBUF_INIT;
-	int r;
-
-	strbuf_addstr(&buf, odb->path);
-	r = for_each_loose_file_in_objdir_buf(&buf,
-					      data->cb, NULL, NULL,
-					      data->data);
-	strbuf_release(&buf);
-	return r;
-}
-
 int for_each_loose_object(each_loose_object_fn cb, void *data,
 			  enum for_each_object_flags flags)
 {
-	struct loose_alt_odb_data alt;
-	int r;
+	struct object_directory *odb;
 
-	r = for_each_loose_file_in_objdir(get_object_directory(),
-					  cb, NULL, NULL, data);
-	if (r)
-		return r;
+	prepare_alt_odb(the_repository);
+	for (odb = the_repository->objects->odb; odb; odb = odb->next) {
+		int r = for_each_loose_file_in_objdir(odb->path, cb, NULL,
+						      NULL, data);
+		if (r)
+			return r;
 
-	if (flags & FOR_EACH_OBJECT_LOCAL_ONLY)
-		return 0;
+		if (flags & FOR_EACH_OBJECT_LOCAL_ONLY)
+			break;
+	}
 
-	alt.cb = cb;
-	alt.data = data;
-	return foreach_alt_odb(loose_from_alt_odb, &alt);
+	return 0;
 }
 
 static int check_stream_sha1(git_zstream *stream,
diff --git a/sha1-name.c b/sha1-name.c
index 96a8e71482..358ca5e288 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -96,22 +96,11 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	int subdir_nr = ds->bin_pfx.hash[0];
 	struct object_directory *odb;
-	static struct object_directory *fakeent;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!fakeent) {
-		/*
-		 * Create a "fake" alternate object database that
-		 * points to our own object database, to make it
-		 * easier to get a temporary working space in
-		 * alt->name/alt->base while iterating over the
-		 * object databases including our own.
-		 */
-		fakeent = alloc_alt_odb(get_object_directory());
-	}
-	fakeent->next = the_repository->objects->alt_odb_list;
-
-	for (odb = fakeent; odb && !ds->ambiguous; odb = odb->next) {
+	for (odb = the_repository->objects->odb;
+	     odb && !ds->ambiguous;
+	     odb = odb->next) {
 		int pos;
 
 		if (!odb->loose_objects_subdir_seen[subdir_nr]) {
-- 
2.19.1.1577.g2c5b293d4f

