From: Jeff King <peff@peff.net>
Subject: [PATCH v3 11/22] use st_add and st_mult for allocation size
 computation
Date: Mon, 22 Feb 2016 17:44:35 -0500
Message-ID: <20160222224435.GK10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:44:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzDe-0005B4-PN
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbcBVWok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:44:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:47089 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752980AbcBVWoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:44:38 -0500
Received: (qmail 21702 invoked by uid 102); 22 Feb 2016 22:44:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:38 -0500
Received: (qmail 23086 invoked by uid 107); 22 Feb 2016 22:44:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:44:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:44:35 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286980>

If our size computation overflows size_t, we may allocate a
much smaller buffer than we expected and overflow it. It's
probably impossible to trigger an overflow in most of these
sites in practice, but it is easy enough convert their
additions and multiplications into overflow-checking
variants. This may be fixing real bugs, and it makes
auditing the code easier.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c              |  4 ++--
 builtin/apply.c        |  2 +-
 builtin/clean.c        |  2 +-
 builtin/fetch.c        |  2 +-
 builtin/index-pack.c   |  4 ++--
 builtin/merge.c        |  2 +-
 builtin/mv.c           |  4 ++--
 builtin/receive-pack.c |  2 +-
 combine-diff.c         | 14 +++++++-------
 commit.c               |  2 +-
 compat/mingw.c         |  4 ++--
 compat/qsort.c         |  2 +-
 compat/setenv.c        |  2 +-
 compat/win32/syslog.c  |  4 ++--
 diffcore-delta.c       |  6 ++++--
 diffcore-rename.c      |  2 +-
 dir.c                  |  4 ++--
 fast-import.c          |  2 +-
 refs.c                 |  2 +-
 remote.c               |  8 ++++----
 revision.c             |  2 +-
 sha1_file.c            | 20 +++++++++++---------
 sha1_name.c            |  5 ++---
 shallow.c              |  2 +-
 submodule.c            |  6 +++---
 25 files changed, 56 insertions(+), 53 deletions(-)

diff --git a/archive.c b/archive.c
index 0687afa..5d735ae 100644
--- a/archive.c
+++ b/archive.c
@@ -171,8 +171,8 @@ static void queue_directory(const unsigned char *sha1,
 		unsigned mode, int stage, struct archiver_context *c)
 {
 	struct directory *d;
-	size_t len = base->len + 1 + strlen(filename) + 1;
-	d = xmalloc(sizeof(*d) + len);
+	size_t len = st_add4(base->len, 1, strlen(filename), 1);
+	d = xmalloc(st_add(sizeof(*d), len));
 	d->up	   = c->bottom;
 	d->baselen = base->len;
 	d->mode	   = mode;
diff --git a/builtin/apply.c b/builtin/apply.c
index d61ac65..42c610e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2632,7 +2632,7 @@ static void update_image(struct image *img,
 	insert_count = postimage->len;
 
 	/* Adjust the contents */
-	result = xmalloc(img->len + insert_count - remove_count + 1);
+	result = xmalloc(st_add3(st_sub(img->len, remove_count), insert_count, 1));
 	memcpy(result, img->buf, applied_at);
 	memcpy(result + applied_at, postimage->buf, postimage->len);
 	memcpy(result + applied_at + postimage->len,
diff --git a/builtin/clean.c b/builtin/clean.c
index 8229f7e..0371010 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -615,7 +615,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 				nr += chosen[i];
 		}
 
-		result = xcalloc(nr + 1, sizeof(int));
+		result = xcalloc(st_add(nr, 1), sizeof(int));
 		for (i = 0; i < stuff->nr && j < nr; i++) {
 			if (chosen[i])
 				result[j++] = i;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..373a89d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1110,7 +1110,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 	if (argc > 0) {
 		int j = 0;
 		int i;
-		refs = xcalloc(argc + 1, sizeof(const char *));
+		refs = xcalloc(st_add(argc, 1), sizeof(const char *));
 		for (i = 0; i < argc; i++) {
 			if (!strcmp(argv[i], "tag")) {
 				i++;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a60bcfa..193908a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1744,9 +1744,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
-	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
+	objects = xcalloc(st_add(nr_objects, 1), sizeof(struct object_entry));
 	if (show_stat)
-		obj_stat = xcalloc(nr_objects + 1, sizeof(struct object_stat));
+		obj_stat = xcalloc(st_add(nr_objects, 1), sizeof(struct object_stat));
 	ofs_deltas = xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
diff --git a/builtin/merge.c b/builtin/merge.c
index b98a348..101ffef 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -939,7 +939,7 @@ static int setup_with_upstream(const char ***argv)
 	if (!branch->merge_nr)
 		die(_("No default upstream defined for the current branch."));
 
-	args = xcalloc(branch->merge_nr + 1, sizeof(char *));
+	args = xcalloc(st_add(branch->merge_nr, 1), sizeof(char *));
 	for (i = 0; i < branch->merge_nr; i++) {
 		if (!branch->merge[i]->dst)
 			die(_("No remote-tracking branch for %s from %s"),
diff --git a/builtin/mv.c b/builtin/mv.c
index 9a9813a..aeae855 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -48,9 +48,9 @@ static const char **internal_copy_pathspec(const char *prefix,
 
 static const char *add_slash(const char *path)
 {
-	int len = strlen(path);
+	size_t len = strlen(path);
 	if (path[len - 1] != '/') {
-		char *with_slash = xmalloc(len + 2);
+		char *with_slash = xmalloc(st_add(len, 2));
 		memcpy(with_slash, path, len);
 		with_slash[len++] = '/';
 		with_slash[len] = 0;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3dc3868..c8e32b2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1372,7 +1372,7 @@ static struct command **queue_command(struct command **tail,
 
 	refname = line + 82;
 	reflen = linelen - 82;
-	cmd = xcalloc(1, sizeof(struct command) + reflen + 1);
+	cmd = xcalloc(1, st_add3(sizeof(struct command), reflen, 1));
 	hashcpy(cmd->old_sha1, old_sha1);
 	hashcpy(cmd->new_sha1, new_sha1);
 	memcpy(cmd->ref_name, refname, reflen);
diff --git a/combine-diff.c b/combine-diff.c
index be09a2b..0e1d4b0 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -189,11 +189,11 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	 *   - Else if we have NEW, insert newend lline into base and
 	 *   consume newend
 	 */
-	lcs = xcalloc(origbaselen + 1, sizeof(int*));
-	directions = xcalloc(origbaselen + 1, sizeof(enum coalesce_direction*));
+	lcs = xcalloc(st_add(origbaselen, 1), sizeof(int*));
+	directions = xcalloc(st_add(origbaselen, 1), sizeof(enum coalesce_direction*));
 	for (i = 0; i < origbaselen + 1; i++) {
-		lcs[i] = xcalloc(lennew + 1, sizeof(int));
-		directions[i] = xcalloc(lennew + 1, sizeof(enum coalesce_direction));
+		lcs[i] = xcalloc(st_add(lennew, 1), sizeof(int));
+		directions[i] = xcalloc(st_add(lennew, 1), sizeof(enum coalesce_direction));
 		directions[i][0] = BASE;
 	}
 	for (j = 1; j < lennew + 1; j++)
@@ -1111,7 +1111,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	if (result_size && result[result_size-1] != '\n')
 		cnt++; /* incomplete line */
 
-	sline = xcalloc(cnt+2, sizeof(*sline));
+	sline = xcalloc(st_add(cnt, 2), sizeof(*sline));
 	sline[0].bol = result;
 	for (lno = 0, cp = result; cp < result + result_size; cp++) {
 		if (*cp == '\n') {
@@ -1130,7 +1130,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	/* Even p_lno[cnt+1] is valid -- that is for the end line number
 	 * for deletion hunk at the end.
 	 */
-	sline[0].p_lno = xcalloc((cnt+2) * num_parent, sizeof(unsigned long));
+	sline[0].p_lno = xcalloc(st_mult(st_add(cnt, 2), num_parent), sizeof(unsigned long));
 	for (lno = 0; lno <= cnt; lno++)
 		sline[lno+1].p_lno = sline[lno].p_lno + num_parent;
 
@@ -1262,7 +1262,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 	struct diff_filespec *pool;
 
 	pair = xmalloc(sizeof(*pair));
-	pool = xcalloc(num_parent + 1, sizeof(struct diff_filespec));
+	pool = xcalloc(st_add(num_parent, 1), sizeof(struct diff_filespec));
 	pair->one = pool + 1;
 	pair->two = pool;
 
diff --git a/commit.c b/commit.c
index 31cd91f..3f4f371 100644
--- a/commit.c
+++ b/commit.c
@@ -147,7 +147,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 	if ((len + 1) % entry_size)
 		goto bad_graft_data;
 	i = (len + 1) / entry_size - 1;
-	graft = xmalloc(sizeof(*graft) + GIT_SHA1_RAWSZ * i);
+	graft = xmalloc(st_add(sizeof(*graft), st_mult(GIT_SHA1_RAWSZ, i)));
 	graft->nr_parent = i;
 	if (get_oid_hex(buf, &graft->oid))
 		goto bad_graft_data;
diff --git a/compat/mingw.c b/compat/mingw.c
index 7803f30..cfedcf9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -810,7 +810,7 @@ static const char *quote_arg(const char *arg)
 		return arg;
 
 	/* insert \ where necessary */
-	d = q = xmalloc(len+n+3);
+	d = q = xmalloc(st_add3(len, n, 3));
 	*d++ = '"';
 	while (*arg) {
 		if (*arg == '"')
@@ -1069,7 +1069,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
 			free(quoted);
 	}
 
-	wargs = xmalloc((2 * args.len + 1) * sizeof(wchar_t));
+	wargs = xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
 	xutftowcs(wargs, args.buf, 2 * args.len + 1);
 	strbuf_release(&args);
 
diff --git a/compat/qsort.c b/compat/qsort.c
index 9574d53..7d071af 100644
--- a/compat/qsort.c
+++ b/compat/qsort.c
@@ -47,7 +47,7 @@ static void msort_with_tmp(void *b, size_t n, size_t s,
 void git_qsort(void *b, size_t n, size_t s,
 	       int (*cmp)(const void *, const void *))
 {
-	const size_t size = n * s;
+	const size_t size = st_mult(n, s);
 	char buf[1024];
 
 	if (size < sizeof(buf)) {
diff --git a/compat/setenv.c b/compat/setenv.c
index fc1439a..7849f25 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -18,7 +18,7 @@ int gitsetenv(const char *name, const char *value, int replace)
 
 	namelen = strlen(name);
 	valuelen = strlen(value);
-	envstr = malloc((namelen + valuelen + 2));
+	envstr = malloc(st_add3(namelen, valuelen, 2));
 	if (!envstr) {
 		errno = ENOMEM;
 		return -1;
diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index d015e43..b905aea 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -32,7 +32,7 @@ void syslog(int priority, const char *fmt, ...)
 		return;
 	}
 
-	str = malloc(str_len + 1);
+	str = malloc(st_add(str_len, 1));
 	if (!str) {
 		warning("malloc failed: '%s'", strerror(errno));
 		return;
@@ -43,7 +43,7 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
 
 	while ((pos = strstr(str, "%1")) != NULL) {
-		str = realloc(str, ++str_len + 1);
+		str = realloc(str, st_add(++str_len, 1));
 		if (!str) {
 			warning("realloc failed: '%s'", strerror(errno));
 			return;
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7cf431d..4159748 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -53,7 +53,8 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 	int osz = 1 << orig->alloc_log2;
 	int sz = osz << 1;
 
-	new = xmalloc(sizeof(*orig) + sizeof(struct spanhash) * sz);
+	new = xmalloc(st_add(sizeof(*orig),
+			     st_mult(sizeof(struct spanhash), sz)));
 	new->alloc_log2 = orig->alloc_log2 + 1;
 	new->free = INITIAL_FREE(new->alloc_log2);
 	memset(new->data, 0, sizeof(struct spanhash) * sz);
@@ -130,7 +131,8 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 	int is_text = !diff_filespec_is_binary(one);
 
 	i = INITIAL_HASH_SIZE;
-	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
+	hash = xmalloc(st_add(sizeof(*hash),
+			      st_mult(sizeof(struct spanhash), 1<<i)));
 	hash->alloc_log2 = i;
 	hash->free = INITIAL_FREE(i);
 	memset(hash->data, 0, sizeof(struct spanhash) * (1<<i));
diff --git a/diffcore-rename.c b/diffcore-rename.c
index af1fe08..3b3c1ed 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -537,7 +537,7 @@ void diffcore_rename(struct diff_options *options)
 				rename_dst_nr * rename_src_nr, 50, 1);
 	}
 
-	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
+	mx = xcalloc(st_mult(num_create, NUM_CANDIDATE_PER_DST), sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two = rename_dst[i].two;
 		struct diff_score *m;
diff --git a/dir.c b/dir.c
index f06ebb7..2c91541 100644
--- a/dir.c
+++ b/dir.c
@@ -689,7 +689,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 			return 0;
 		}
 		if (buf[size-1] != '\n') {
-			buf = xrealloc(buf, size+1);
+			buf = xrealloc(buf, st_add(size, 1));
 			buf[size++] = '\n';
 		}
 	} else {
@@ -2488,7 +2488,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	next = data + len + 1;
 	if (next > rd->end)
 		return -1;
-	*untracked_ = untracked = xmalloc(sizeof(*untracked) + len);
+	*untracked_ = untracked = xmalloc(st_add(sizeof(*untracked), len));
 	memcpy(untracked, &ud, sizeof(ud));
 	memcpy(untracked->name, data, len + 1);
 	data = next;
diff --git a/fast-import.c b/fast-import.c
index a6467cb..3053bb8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -622,7 +622,7 @@ static void *pool_alloc(size_t len)
 			return xmalloc(len);
 		}
 		total_allocd += sizeof(struct mem_pool) + mem_pool_alloc;
-		p = xmalloc(sizeof(struct mem_pool) + mem_pool_alloc);
+		p = xmalloc(st_add(sizeof(struct mem_pool), mem_pool_alloc));
 		p->next_pool = mem_pool;
 		p->next_free = (char *) p->space;
 		p->end = p->next_free + mem_pool_alloc;
diff --git a/refs.c b/refs.c
index 2d86445..b0e6ece 100644
--- a/refs.c
+++ b/refs.c
@@ -906,7 +906,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
 			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
 
-		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
+		scanf_fmts = xmalloc(st_add(st_mult(nr_rules, sizeof(char *)), total_len));
 
 		offset = 0;
 		for (i = 0; i < nr_rules; i++) {
diff --git a/remote.c b/remote.c
index 25a960f..21e4ec3 100644
--- a/remote.c
+++ b/remote.c
@@ -931,7 +931,7 @@ static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
 		const char *name)
 {
 	size_t len = strlen(name);
-	struct ref *ref = xcalloc(1, sizeof(struct ref) + prefixlen + len + 1);
+	struct ref *ref = xcalloc(1, st_add4(sizeof(*ref), prefixlen, len, 1));
 	memcpy(ref->name, prefix, prefixlen);
 	memcpy(ref->name + prefixlen, name, len);
 	return ref;
@@ -948,9 +948,9 @@ struct ref *copy_ref(const struct ref *ref)
 	size_t len;
 	if (!ref)
 		return NULL;
-	len = strlen(ref->name);
-	cpy = xmalloc(sizeof(struct ref) + len + 1);
-	memcpy(cpy, ref, sizeof(struct ref) + len + 1);
+	len = st_add3(sizeof(struct ref), strlen(ref->name), 1);
+	cpy = xmalloc(len);
+	memcpy(cpy, ref, len);
 	cpy->next = NULL;
 	cpy->symref = xstrdup_or_null(ref->symref);
 	cpy->remote_status = xstrdup_or_null(ref->remote_status);
diff --git a/revision.c b/revision.c
index f24ead5..d4ace60 100644
--- a/revision.c
+++ b/revision.c
@@ -540,7 +540,7 @@ struct treesame_state {
 static struct treesame_state *initialise_treesame(struct rev_info *revs, struct commit *commit)
 {
 	unsigned n = commit_list_count(commit->parents);
-	struct treesame_state *st = xcalloc(1, sizeof(*st) + n);
+	struct treesame_state *st = xcalloc(1, st_add(sizeof(*st), n));
 	st->nparents = n;
 	add_decoration(&revs->treesame, &commit->object, st);
 	return st;
diff --git a/sha1_file.c b/sha1_file.c
index 2f1c6d3..0251700 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -253,7 +253,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 {
 	struct alternate_object_database *ent;
 	struct alternate_object_database *alt;
-	int pfxlen, entlen;
+	size_t pfxlen, entlen;
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
@@ -273,8 +273,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pfxlen && pathbuf.buf[pfxlen-1] == '/')
 		pfxlen -= 1;
 
-	entlen = pfxlen + 43; /* '/' + 2 hex + '/' + 38 hex + NUL */
-	ent = xmalloc(sizeof(*ent) + entlen);
+	entlen = st_add(pfxlen, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
+	ent = xmalloc(st_add(sizeof(*ent), entlen));
 	memcpy(ent->base, pathbuf.buf, pfxlen);
 	strbuf_release(&pathbuf);
 
@@ -1134,7 +1134,7 @@ unsigned char *use_pack(struct packed_git *p,
 
 static struct packed_git *alloc_packed_git(int extra)
 {
-	struct packed_git *p = xmalloc(sizeof(*p) + extra);
+	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
 	memset(p, 0, sizeof(*p));
 	p->pack_fd = -1;
 	return p;
@@ -1168,7 +1168,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	 * ".pack" is long enough to hold any suffix we're adding (and
 	 * the use xsnprintf double-checks that)
 	 */
-	alloc = path_len + strlen(".pack") + 1;
+	alloc = st_add3(path_len, strlen(".pack"), 1);
 	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
 
@@ -1196,7 +1196,7 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
 	const char *path = sha1_pack_name(sha1);
-	int alloc = strlen(path) + 1;
+	size_t alloc = st_add(strlen(path), 1);
 	struct packed_git *p = alloc_packed_git(alloc);
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
@@ -1413,10 +1413,12 @@ static void mark_bad_packed_object(struct packed_git *p,
 {
 	unsigned i;
 	for (i = 0; i < p->num_bad_objects; i++)
-		if (!hashcmp(sha1, p->bad_object_sha1 + 20 * i))
+		if (!hashcmp(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
 			return;
-	p->bad_object_sha1 = xrealloc(p->bad_object_sha1, 20 * (p->num_bad_objects + 1));
-	hashcpy(p->bad_object_sha1 + 20 * p->num_bad_objects, sha1);
+	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
+				      st_mult(GIT_SHA1_RAWSZ,
+					      st_add(p->num_bad_objects, 1)));
+	hashcpy(p->bad_object_sha1 + GIT_SHA1_RAWSZ * p->num_bad_objects, sha1);
 	p->num_bad_objects++;
 }
 
diff --git a/sha1_name.c b/sha1_name.c
index 89918ca..d14346c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -87,9 +87,8 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 		 * object databases including our own.
 		 */
 		const char *objdir = get_object_directory();
-		int objdir_len = strlen(objdir);
-		int entlen = objdir_len + 43;
-		fakeent = xmalloc(sizeof(*fakeent) + entlen);
+		size_t objdir_len = strlen(objdir);
+		fakeent = xmalloc(st_add3(sizeof(*fakeent), objdir_len, 43));
 		memcpy(fakeent->base, objdir, objdir_len);
 		fakeent->name = fakeent->base + objdir_len + 1;
 		fakeent->name[-1] = '/';
diff --git a/shallow.c b/shallow.c
index 71163bf..4d554ca 100644
--- a/shallow.c
+++ b/shallow.c
@@ -389,7 +389,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	unsigned int i, nr;
 	struct commit_list *head = NULL;
 	int bitmap_nr = (info->nr_bits + 31) / 32;
-	int bitmap_size = bitmap_nr * sizeof(uint32_t);
+	size_t bitmap_size = st_mult(bitmap_nr, sizeof(uint32_t));
 	uint32_t *tmp = xmalloc(bitmap_size); /* to be freed before return */
 	uint32_t *bitmap = paint_alloc(info);
 	struct commit *c = lookup_commit_reference_gently(sha1, 1);
diff --git a/submodule.c b/submodule.c
index b83939c..ac61c65 100644
--- a/submodule.c
+++ b/submodule.c
@@ -123,7 +123,7 @@ static int add_submodule_odb(const char *path)
 	struct strbuf objects_directory = STRBUF_INIT;
 	struct alternate_object_database *alt_odb;
 	int ret = 0;
-	int alloc;
+	size_t alloc;
 
 	strbuf_git_path_submodule(&objects_directory, path, "objects/");
 	if (!is_directory(objects_directory.buf)) {
@@ -138,8 +138,8 @@ static int add_submodule_odb(const char *path)
 					objects_directory.len))
 			goto done;
 
-	alloc = objects_directory.len + 42; /* for "12/345..." sha1 */
-	alt_odb = xmalloc(sizeof(*alt_odb) + alloc);
+	alloc = st_add(objects_directory.len, 42); /* for "12/345..." sha1 */
+	alt_odb = xmalloc(st_add(sizeof(*alt_odb), alloc));
 	alt_odb->next = alt_odb_list;
 	xsnprintf(alt_odb->base, alloc, "%s", objects_directory.buf);
 	alt_odb->name = alt_odb->base + objects_directory.len;
-- 
2.7.2.645.g4e1306c
