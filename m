From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [RFC PATCH 1/2] Replace memset(0) with static initialization where
 possible
Date: Thu, 09 Oct 2008 14:09:16 -0500
Message-ID: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko0uC-0007pW-DM
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbYJITJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 15:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbYJITJW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 15:09:22 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33084 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbYJITJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 15:09:18 -0400
Received: by mail.nrlssc.navy.mil id m99J9GqO024228; Thu, 9 Oct 2008 14:09:17 -0500
X-OriginalArrivalTime: 09 Oct 2008 19:09:17.0034 (UTC) FILETIME=[868C9CA0:01C92A42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97875>

Many call sites use memset to initialize a local variable which has not
been accessed since its declaration. This call to memset is unnecessary
(even though it may not evaluate to an actual function call). Replacing
these calls with static initialization may be optimal on some platforms
and increases readability in many cases.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Is there interest in a patch like this?

"Possible" benefits:

  1) more concise, so it improves readability in most cases
  2) gives compiler more flexibility when optimizing

Drawbacks:

  1) many lines touched for no functional change
  2) other?


Most of these changes boil down to something of the from:

   some_struct foo;
   memset(&foo, 0, sizeof(foo));

to

   some_struct foo = { 0, };

where the declaration and the memset have very little code separating
them and are contained in the same hunk. A few are separated by more
code and are in different hunks, but it is straight-forward to check
those cases.

-brandon


 archive-tar.c            |    3 +--
 archive-zip.c            |    3 +--
 branch.c                 |    3 +--
 builtin-apply.c          |   10 +++-------
 builtin-blame.c          |    9 +++------
 builtin-branch.c         |    3 +--
 builtin-bundle.c         |    3 +--
 builtin-checkout.c       |   23 ++++++++---------------
 builtin-clean.c          |    3 +--
 builtin-clone.c          |    3 +--
 builtin-commit.c         |    9 +++------
 builtin-fetch-pack.c     |    6 ++----
 builtin-fetch.c          |    3 +--
 builtin-for-each-ref.c   |    3 +--
 builtin-gc.c             |    3 +--
 builtin-grep.c           |    3 +--
 builtin-help.c           |    3 +--
 builtin-log.c            |    3 +--
 builtin-ls-files.c       |    3 +--
 builtin-merge.c          |   28 +++++++++-------------------
 builtin-pack-objects.c   |   10 +++-------
 builtin-read-tree.c      |    3 +--
 builtin-receive-pack.c   |    9 +++------
 builtin-reflog.c         |   20 ++++++--------------
 builtin-remote.c         |   15 +++++----------
 builtin-rerere.c         |    3 +--
 builtin-reset.c          |    3 +--
 builtin-send-pack.c      |    6 ++----
 builtin-tag.c            |    3 +--
 builtin-unpack-objects.c |    4 +---
 builtin-verify-tag.c     |    3 +--
 bundle.c                 |    9 +++------
 combine-diff.c           |    6 ++----
 connect.c                |    6 ++----
 convert.c                |    6 ++----
 daemon.c                 |   12 ++++--------
 date.c                   |    3 +--
 diff-lib.c               |    6 ++----
 diff.c                   |   30 ++++++++++--------------------
 fast-import.c            |    6 ++----
 help.c                   |    4 +---
 http-push.c              |    3 +--
 imap-send.c              |    7 ++-----
 index-pack.c             |    9 +++------
 ll-merge.c               |    6 ++----
 merge-file.c             |    6 ++----
 merge-index.c            |    3 +--
 merge-recursive.c        |    3 +--
 merge-tree.c             |    3 +--
 pack-refs.c              |    3 +--
 pretty.c                 |    3 +--
 progress.c               |    3 +--
 sha1_file.c              |    9 +++------
 transport.c              |   16 +++++-----------
 unpack-trees.c           |    3 +--
 upload-pack.c            |    3 +--
 wt-status.c              |    6 ++----
 xdiff-interface.c        |    3 +--
 58 files changed, 125 insertions(+), 258 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 1302961..e3170fb 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -123,11 +123,10 @@ static int write_tar_entry(struct archiver_args *args,
 		const unsigned char *sha1, const char *path, size_t pathlen,
 		unsigned int mode, void *buffer, unsigned long size)
 {
-	struct ustar_header header;
+	struct ustar_header header = { { 0, }, };
 	struct strbuf ext_header;
 	int err = 0;
 
-	memset(&header, 0, sizeof(header));
 	strbuf_init(&ext_header, 0);
 
 	if (!sha1) {
diff --git a/archive-zip.c b/archive-zip.c
index cf28504..6196e5f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -90,12 +90,11 @@ static void copy_le32(unsigned char *dest, unsigned int n)
 static void *zlib_deflate(void *data, unsigned long size,
 		int compression_level, unsigned long *compressed_size)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	unsigned long maxsize;
 	void *buffer;
 	int result;
 
-	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, compression_level);
 	maxsize = deflateBound(&stream, size);
 	buffer = xmalloc(maxsize);
diff --git a/branch.c b/branch.c
index b1e59f2..057f0a3 100644
--- a/branch.c
+++ b/branch.c
@@ -56,13 +56,12 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
                           enum branch_track track)
 {
 	char key[1024];
-	struct tracking tracking;
+	struct tracking tracking = { { 0, }, };
 
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
 		return error("Tracking not set up: name too long: %s",
 				new_ref);
 
-	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking))
 		return 1;
diff --git a/builtin-apply.c b/builtin-apply.c
index 342f2fe..945616e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1241,12 +1241,10 @@ static inline int metadata_changes(struct patch *patch)
 static char *inflate_it(const void *data, unsigned long size,
 			unsigned long inflated_size)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	void *out;
 	int st;
 
-	memset(&stream, 0, sizeof(stream));
-
 	stream.next_in = (unsigned char *)data;
 	stream.avail_in = size;
 	stream.next_out = out = xmalloc(inflated_size);
@@ -1891,11 +1889,9 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	int new_blank_lines_at_end = 0;
 	unsigned long leading, trailing;
 	int pos, applied_pos;
-	struct image preimage;
-	struct image postimage;
+	struct image preimage = { 0, };
+	struct image postimage = { 0, };
 
-	memset(&preimage, 0, sizeof(preimage));
-	memset(&postimage, 0, sizeof(postimage));
 	oldlines = xmalloc(size);
 	newlines = xmalloc(size);
 
diff --git a/builtin-blame.c b/builtin-blame.c
index df53759..93d2daf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -518,15 +518,13 @@ static void process_u_diff(void *state_, char *line, unsigned long len)
 static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 				    int context)
 {
-	struct blame_diff_state state;
+	struct blame_diff_state state = { 0, };
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = { 0, };
 	xdemitcb_t ecb;
 
 	xpp.flags = xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
-	memset(&state, 0, sizeof(state));
 	state.ret = xmalloc(sizeof(struct patch));
 	state.ret->chunks = NULL;
 	state.ret->num = 0;
@@ -2279,7 +2277,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const char *path;
-	struct scoreboard sb;
+	struct scoreboard sb = { 0, };
 	struct origin *o;
 	struct blame_entry *ent;
 	long dashdash_pos, bottom, top, lno;
@@ -2405,7 +2403,6 @@ parse_done:
 	}
 
 	setup_revisions(argc, argv, &revs, NULL);
-	memset(&sb, 0, sizeof(sb));
 
 	sb.revs = &revs;
 	if (!reverse)
diff --git a/builtin-branch.c b/builtin-branch.c
index b1a2ad7..6e2c614 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -379,10 +379,9 @@ static int calc_maxwidth(struct ref_list *refs)
 static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
 {
 	int i;
-	struct ref_list ref_list;
+	struct ref_list ref_list = { { 0, }, };
 	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
 
-	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9b58152..fa2b6e6 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -13,7 +13,7 @@ static const char *bundle_usage="git bundle (create <bundle> <git rev-list args>
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
-	struct bundle_header header;
+	struct bundle_header header = { { 0, }, };
 	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd = -1;
@@ -33,7 +33,6 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		bundle_file = buffer;
 	}
 
-	memset(&header, 0, sizeof(header));
 	if (strcmp(cmd, "create") && (bundle_fd =
 				read_bundle_header(bundle_file, &header)) < 0)
 		return 1;
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 3762f71..f167a98 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -38,14 +38,13 @@ struct checkout_opts {
 static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
-	struct child_process proc;
+	struct child_process proc = { 0, };
 	const char *name = git_path("hooks/post-checkout");
 	const char *argv[5];
 
 	if (access(name, X_OK) < 0)
 		return 0;
 
-	memset(&proc, 0, sizeof(proc));
 	argv[0] = name;
 	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
 	argv[2] = xstrdup(sha1_to_hex(new->object.sha1));
@@ -216,7 +215,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 			  struct checkout_opts *opts)
 {
 	int pos;
-	struct checkout state;
+	struct checkout state = { 0, };
 	static char *ps_matched;
 	unsigned char rev[20];
 	int flag;
@@ -268,7 +267,6 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		return 1;
 
 	/* Now we are committed to check them out */
-	memset(&state, 0, sizeof(state));
 	state.force = 1;
 	state.refresh_cache = 1;
 	for (pos = 0; pos < active_nr; pos++) {
@@ -321,10 +319,9 @@ static void describe_detached_head(char *msg, struct commit *commit)
 
 static int reset_tree(struct tree *tree, struct checkout_opts *o, int worktree)
 {
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 	struct tree_desc tree_desc;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.update = worktree;
 	opts.skip_unmerged = !worktree;
@@ -382,9 +379,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 	} else {
 		struct tree_desc trees[2];
 		struct tree *tree;
-		struct unpack_trees_options topts;
+		struct unpack_trees_options topts = { 0, };
 
-		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
 		topts.src_index = &the_index;
 		topts.dst_index = &the_index;
@@ -529,10 +525,10 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 {
 	int ret = 0;
-	struct branch_info old;
+	struct branch_info old = { 0, };
 	unsigned char rev[20];
 	int flag;
-	memset(&old, 0, sizeof(old));
+
 	old.path = resolve_ref("HEAD", rev, 0, &flag);
 	old.commit = lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF))
@@ -582,10 +578,10 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts opts = { 0, };
 	unsigned char rev[20];
 	const char *arg;
-	struct branch_info new;
+	struct branch_info new = { 0, };
 	struct tree *source_tree = NULL;
 	char *conflict_style = NULL;
 	struct option options[] = {
@@ -606,9 +602,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	};
 	int has_dash_dash;
 
-	memset(&opts, 0, sizeof(opts));
-	memset(&new, 0, sizeof(new));
-
 	git_config(git_checkout_config, NULL);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
diff --git a/builtin-clean.c b/builtin-clean.c
index 48bf29f..357d398 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -32,7 +32,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
 	struct strbuf directory;
-	struct dir_struct dir;
+	struct dir_struct dir = { 0, };
 	const char *path, *base;
 	static const char **pathspec;
 	struct strbuf buf;
@@ -59,7 +59,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
 	strbuf_init(&buf, 0);
-	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.show_ignored = 1;
 
diff --git a/builtin-clone.c b/builtin-clone.c
index 49d2eb9..d1d5fe8 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -572,7 +572,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (!option_no_checkout) {
 		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
-		struct unpack_trees_options opts;
+		struct unpack_trees_options opts = { 0, };
 		struct tree *tree;
 		struct tree_desc t;
 		int fd;
@@ -582,7 +582,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		fd = hold_locked_index(lock_file, 1);
 
-		memset(&opts, 0, sizeof opts);
 		opts.update = 1;
 		opts.merge = 1;
 		opts.fn = oneway_merge;
diff --git a/builtin-commit.c b/builtin-commit.c
index b920257..69d8492 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -192,7 +192,7 @@ static void add_remove_files(struct string_list *list)
 static void create_base_index(void)
 {
 	struct tree *tree;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 	struct tree_desc t;
 
 	if (initial_commit) {
@@ -200,7 +200,6 @@ static void create_base_index(void)
 		return;
 	}
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
@@ -220,7 +219,7 @@ static void create_base_index(void)
 static char *prepare_index(int argc, const char **argv, const char *prefix)
 {
 	int fd;
-	struct string_list partial;
+	struct string_list partial = { 0, };
 	const char **pathspec = NULL;
 
 	if (interactive) {
@@ -303,7 +302,6 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	if (file_exists(git_path("MERGE_HEAD")))
 		die("cannot do a partial commit during a merge.");
 
-	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings = 1;
 	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, pathspec))
 		exit(1);
@@ -361,7 +359,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 
 static int run_hook(const char *index_file, const char *name, ...)
 {
-	struct child_process hook;
+	struct child_process hook = { 0, };
 	const char *argv[10], *env[2];
 	char index[PATH_MAX];
 	va_list args;
@@ -384,7 +382,6 @@ static int run_hook(const char *index_file, const char *name, ...)
 	if (access(argv[0], X_OK) < 0)
 		return 0;
 
-	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index fa3c936..efd7a56 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -488,15 +488,14 @@ static int sideband_demux(int fd, void *data)
 
 static int get_pack(int xd[2], char **pack_lockfile)
 {
-	struct async demux;
+	struct async demux = { 0, };
 	const char *argv[20];
 	char keep_arg[256];
 	char hdr_arg[256];
 	const char **av;
 	int do_keep = args.keep_pack;
-	struct child_process cmd;
+	struct child_process cmd = { 0, };
 
-	memset(&demux, 0, sizeof(demux));
 	if (use_sideband) {
 		/* xd[] is talking with upload-pack; subprocess reads from
 		 * xd[0], spits out band#2 to stderr, and feeds us band#1
@@ -511,7 +510,6 @@ static int get_pack(int xd[2], char **pack_lockfile)
 	else
 		demux.out = xd[0];
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv = argv;
 	av = argv;
 	*hdr_arg = 0;
diff --git a/builtin-fetch.c b/builtin-fetch.c
index ee93d3a..16e04dd 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -404,7 +404,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
  */
 static int quickfetch(struct ref *ref_map)
 {
-	struct child_process revlist;
+	struct child_process revlist = { 0, };
 	struct ref *ref;
 	char **argv;
 	int i, err;
@@ -435,7 +435,6 @@ static int quickfetch(struct ref *ref_map)
 	argv[i++] = xstrdup("--all");
 	argv[i++] = NULL;
 
-	memset(&revlist, 0, sizeof(revlist));
 	revlist.argv = (const char**)argv;
 	revlist.git_cmd = 1;
 	revlist.no_stdin = 1;
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index fa6c1ed..ea60ec9 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -964,7 +964,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
 	struct refinfo **refs;
-	struct grab_ref_cbdata cbdata;
+	struct grab_ref_cbdata cbdata = { 0, };
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1000,7 +1000,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		sort = default_sort();
 	sort_atom_limit = used_atom_cnt;
 
-	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
 	for_each_ref(grab_single_ref, &cbdata);
 	refs = cbdata.grab_array;
diff --git a/builtin-gc.c b/builtin-gc.c
index 7af65bb..78e9bbd 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -157,7 +157,7 @@ static int too_many_packs(void)
 static int run_hook(void)
 {
 	const char *argv[2];
-	struct child_process hook;
+	struct child_process hook = { 0, };
 	int ret;
 
 	argv[0] = git_path("hooks/pre-auto-gc");
@@ -166,7 +166,6 @@ static int run_hook(void)
 	if (access(argv[0], X_OK) < 0)
 		return 0;
 
-	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
diff --git a/builtin-grep.c b/builtin-grep.c
index 3a51662..8ac09fb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -512,12 +512,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int hit = 0;
 	int cached = 0;
 	int seen_dashdash = 0;
-	struct grep_opt opt;
+	struct grep_opt opt = { 0, };
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
 	int i;
 
-	memset(&opt, 0, sizeof(opt));
 	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
 	opt.relative = 1;
 	opt.pathname = 1;
diff --git a/builtin-help.c b/builtin-help.c
index 64207cb..cb97f52 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -71,12 +71,11 @@ static const char *get_man_viewer_info(const char *name)
 static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
-	struct child_process ec_process;
+	struct child_process ec_process = { 0, };
 	const char *argv_ec[] = { "emacsclient", "--version", NULL };
 	int version;
 
 	/* emacsclient prints its version number on stderr */
-	memset(&ec_process, 0, sizeof(ec_process));
 	ec_process.argv = argv_ec;
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
diff --git a/builtin-log.c b/builtin-log.c
index fc5e4da..4f4b15d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -143,7 +143,7 @@ static void early_output(int signal)
 
 static void setup_early_output(struct rev_info *rev)
 {
-	struct sigaction sa;
+	struct sigaction sa = { { 0, }, };
 
 	/*
 	 * Set up the signal handler, minimally intrusively:
@@ -152,7 +152,6 @@ static void setup_early_output(struct rev_info *rev)
 	 * system dependencies and headers), and using
 	 * SA_RESTART.
 	 */
-	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = early_output;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_RESTART;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 068f424..45ca899 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -432,9 +432,8 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int exc_given = 0, require_work_tree = 0;
-	struct dir_struct dir;
+	struct dir_struct dir = { 0, };
 
-	memset(&dir, 0, sizeof(dir));
 	if (prefix)
 		prefix_offset = strlen(prefix);
 	git_config(git_default_config, NULL);
diff --git a/builtin-merge.c b/builtin-merge.c
index dcf8987..ef96078 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -91,10 +91,9 @@ static struct strategy *get_strategy(const char *name)
 			return &all_strategy[i];
 
 	if (!loaded) {
-		struct cmdnames not_strategies;
+		struct cmdnames not_strategies = { 0, };
 		loaded = 1;
 
-		memset(&not_strategies, 0, sizeof(struct cmdnames));
 		load_command_list("git-merge-", &main_cmds, &other_cmds);
 		for (i = 0; i < main_cmds.cnt; i++) {
 			int j, found = 0;
@@ -184,11 +183,10 @@ static void drop_save(void)
 static void save_state(void)
 {
 	int len;
-	struct child_process cp;
+	struct child_process cp = { 0, };
 	struct strbuf buffer = STRBUF_INIT;
 	const char *argv[] = {"stash", "create", NULL};
 
-	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
 	cp.out = -1;
 	cp.git_cmd = 1;
@@ -298,7 +296,7 @@ static void squash_message(void)
 
 static int run_hook(const char *name)
 {
-	struct child_process hook;
+	struct child_process hook = { 0, };
 	const char *argv[3], *env[2];
 	char index[PATH_MAX];
 
@@ -316,7 +314,6 @@ static int run_hook(const char *name)
 		argv[1] = "0";
 	argv[2] = NULL;
 
-	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
@@ -379,12 +376,11 @@ static void finish(const unsigned char *new_head, const char *msg)
 static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct object *remote_head;
-	unsigned char branch_head[20], buf_sha[20];
+	unsigned char branch_head[20] = { 0, }, buf_sha[20];
 	struct strbuf buf;
 	const char *ptr;
 	int len, early;
 
-	memset(branch_head, 0, sizeof(branch_head));
 	remote_head = peel_to_type(remote, 0, NULL, OBJ_COMMIT);
 	if (!remote_head)
 		die("'%s' does not point to a commit", remote);
@@ -503,9 +499,8 @@ static int read_tree_trivial(unsigned char *common, unsigned char *head,
 	int i, nr_trees = 0;
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct tree_desc t[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 2;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
@@ -630,21 +625,17 @@ static int count_unmerged_entries(void)
 
 static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 {
-	struct tree *trees[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
-	struct tree_desc t[MAX_UNPACK_TREES];
+	struct tree *trees[MAX_UNPACK_TREES] = { 0, };
+	struct unpack_trees_options opts = { 0, };
+	struct tree_desc t[MAX_UNPACK_TREES] = { { 0, }, };
 	int i, fd, nr_trees = 0;
-	struct dir_struct dir;
+	struct dir_struct dir = { 0, };
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	refresh_cache(REFRESH_QUIET);
 
 	fd = hold_locked_index(lock_file, 1);
 
-	memset(&trees, 0, sizeof(trees));
-	memset(&opts, 0, sizeof(opts));
-	memset(&t, 0, sizeof(t));
-	memset(&dir, 0, sizeof(dir));
 	dir.show_ignored = 1;
 	dir.exclude_per_dir = ".gitignore";
 	opts.dir = &dir;
@@ -706,7 +697,6 @@ static void add_strategies(const char *string, unsigned attr)
 	struct strategy *list = NULL;
 	int list_alloc = 0, list_nr = 0, i;
 
-	memset(&list, 0, sizeof(list));
 	split_merge_strategies(string, &list, &list_nr, &list_alloc);
 	if (list) {
 		for (i = 0; i < list_nr; i++)
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 59c30d1..c9b37c2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -128,11 +128,10 @@ static void *get_delta(struct object_entry *entry)
 
 static unsigned long do_compress(void **pptr, unsigned long size)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	void *in, *out;
 	unsigned long maxsize;
 
-	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, pack_compression_level);
 	maxsize = deflateBound(&stream, size);
 
@@ -189,11 +188,10 @@ static int check_pack_inflate(struct packed_git *p,
 		off_t len,
 		unsigned long expect)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	unsigned char fakebuf[4096], *in;
 	int st;
 
-	memset(&stream, 0, sizeof(stream));
 	inflateInit(&stream);
 	do {
 		in = use_pack(p, w_curs, offset, &stream.avail_in);
@@ -1896,11 +1894,9 @@ static int ofscmp(const void *a_, const void *b_)
 static void add_objects_in_unpacked_packs(struct rev_info *revs)
 {
 	struct packed_git *p;
-	struct in_pack in_pack;
+	struct in_pack in_pack = { 0, };
 	uint32_t i;
 
-	memset(&in_pack, 0, sizeof(in_pack));
-
 	for (p = packed_git; p; p = p->next) {
 		const unsigned char *sha1;
 		struct object *o;
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 0706c95..d518bc4 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -73,9 +73,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	int i, newfd, stage = 0;
 	unsigned char sha1[20];
 	struct tree_desc t[MAX_UNPACK_TREES];
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index 45e3cd9..2a26851 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -107,7 +107,7 @@ static int run_hook(const char *hook_name)
 {
 	static char buf[sizeof(commands->old_sha1) * 2 + PATH_MAX + 4];
 	struct command *cmd;
-	struct child_process proc;
+	struct child_process proc = { 0, };
 	const char *argv[2];
 	int have_input = 0, code;
 
@@ -122,7 +122,6 @@ static int run_hook(const char *hook_name)
 	argv[0] = hook_name;
 	argv[1] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
@@ -147,7 +146,7 @@ static int run_hook(const char *hook_name)
 static int run_update_hook(struct command *cmd)
 {
 	static const char update_hook[] = "hooks/update";
-	struct child_process proc;
+	struct child_process proc = { 0, };
 	const char *argv[5];
 
 	if (access(update_hook, X_OK) < 0)
@@ -159,7 +158,6 @@ static int run_update_hook(struct command *cmd)
 	argv[3] = sha1_to_hex(cmd->new_sha1);
 	argv[4] = NULL;
 
-	memset(&proc, 0, sizeof(proc));
 	proc.argv = argv;
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
@@ -407,7 +405,7 @@ static const char *unpack(void)
 		const char *keeper[7];
 		int s, status, i = 0;
 		char keep_arg[256];
-		struct child_process ip;
+		struct child_process ip = { 0, };
 
 		s = sprintf(keep_arg, "--keep=receive-pack %"PRIuMAX" on ", (uintmax_t) getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
@@ -421,7 +419,6 @@ static const char *unpack(void)
 		keeper[i++] = hdr_arg;
 		keeper[i++] = keep_arg;
 		keeper[i++] = NULL;
-		memset(&ip, 0, sizeof(ip));
 		ip.argv = keeper;
 		ip.out = -1;
 		ip.git_cmd = 1;
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 6b3667e..0bde849 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -98,8 +98,8 @@ static int tree_is_complete(const unsigned char *sha1)
 
 static int commit_is_complete(struct commit *commit)
 {
-	struct object_array study;
-	struct object_array found;
+	struct object_array study = { 0, };
+	struct object_array found = { 0, };
 	int is_incomplete = 0;
 	int i;
 
@@ -115,8 +115,6 @@ static int commit_is_complete(struct commit *commit)
 	 * If some of the objects that are needed to complete this
 	 * commit are missing, mark this commit as INCOMPLETE.
 	 */
-	memset(&study, 0, sizeof(study));
-	memset(&found, 0, sizeof(found));
 	add_object_array(&commit->object, NULL, &study);
 	add_object_array(&commit->object, NULL, &found);
 	commit->object.flags |= STUDYING;
@@ -263,13 +261,11 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
-	struct expire_reflog_cb cb;
+	struct expire_reflog_cb cb = { 0, };
 	struct ref_lock *lock;
 	char *log_file, *newlog_path = NULL;
 	int status = 0;
 
-	memset(&cb, 0, sizeof(cb));
-
 	/*
 	 * we take the lock for the ref itself to prevent it from
 	 * getting updated.
@@ -461,7 +457,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cb;
+	struct cmd_reflog_expire_cb cb = { { 0, }, };
 	unsigned long now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
@@ -470,7 +466,6 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 
 	save_commit_buffer = 0;
 	do_all = status = 0;
-	memset(&cb, 0, sizeof(cb));
 
 	if (!default_reflog_expire_unreachable)
 		default_reflog_expire_unreachable = now - 30 * 24 * 3600;
@@ -526,10 +521,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	}
 
 	if (do_all) {
-		struct collect_reflog_cb collected;
+		struct collect_reflog_cb collected = { 0, };
 		int i;
 
-		memset(&collected, 0, sizeof(collected));
 		for_each_reflog(collect_reflog, &collected);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
@@ -565,11 +559,9 @@ static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 {
-	struct cmd_reflog_expire_cb cb;
+	struct cmd_reflog_expire_cb cb = { { 0, }, };
 	int i, status = 0;
 
-	memset(&cb, 0, sizeof(cb));
-
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
diff --git a/builtin-remote.c b/builtin-remote.c
index 90a4e35..883e6d4 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -216,9 +216,8 @@ static int handle_one_branch(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
-	struct refspec refspec;
+	struct refspec refspec = { 0, };
 
-	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec)) {
 		struct string_list_item *item;
@@ -304,11 +303,10 @@ static int add_branch_for_removal(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
-	struct refspec refspec;
+	struct refspec refspec = { 0, };
 	struct string_list_item *item;
 	struct known_remote *kr;
 
-	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (remote_find_tracking(branches->remote, &refspec))
 		return 0;
@@ -451,9 +449,8 @@ static int append_ref_to_tracked_list(const char *refname,
 	const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
-	struct refspec refspec;
+	struct refspec refspec = { 0, };
 
-	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
 		string_list_append(abbrev_branch(refspec.src), &states->tracked);
@@ -469,14 +466,13 @@ static int show(int argc, const char **argv)
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
 		OPT_END()
 	};
-	struct ref_states states;
+	struct ref_states states = { 0, };
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
 	if (argc < 1)
 		return show_all();
 
-	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
 		int i;
 
@@ -545,14 +541,13 @@ static int prune(int argc, const char **argv)
 		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
-	struct ref_states states;
+	struct ref_states states = { 0, };
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
 	if (argc < 1)
 		usage_with_options(builtin_remote_usage, options);
 
-	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
 		int i;
 
diff --git a/builtin-rerere.c b/builtin-rerere.c
index dd4573f..45663f6 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -89,7 +89,7 @@ static int diff_two(const char *file1, const char *label1,
 		const char *file2, const char *label2)
 {
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = { 0, };
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 
@@ -99,7 +99,6 @@ static int diff_two(const char *file1, const char *label1,
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
 	xpp.flags = XDF_NEED_MINIMAL;
-	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	ecb.outf = outf;
 	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
diff --git a/builtin-reset.c b/builtin-reset.c
index 16e6bb2..fef9727 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -136,9 +136,8 @@ static int read_from_tree(const char *prefix, const char **argv,
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd, index_was_discarded = 0;
-	struct diff_options opt;
+	struct diff_options opt = { 0, };
 
-	memset(&opt, 0, sizeof(opt));
 	diff_tree_setup_paths(get_pathspec(prefix, (const char **)argv), &opt);
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 910db92..cb3f811 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -33,13 +33,12 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 		NULL,
 	};
-	struct child_process po;
+	struct child_process po = { 0, };
 	int i;
 	char buf[42];
 
 	if (args.use_thin_pack)
 		argv[4] = "--thin";
-	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
 	po.out = fd;
@@ -389,9 +388,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int expect_status_report = 0;
 	int flags = MATCH_REFS_NONE;
 	int ret;
-	struct extra_have_objects extra_have;
+	struct extra_have_objects extra_have = { 0, };
 
-	memset(&extra_have, 0, sizeof(extra_have));
 	if (args.send_all)
 		flags |= MATCH_REFS_ALL;
 	if (args.send_mirror)
diff --git a/builtin-tag.c b/builtin-tag.c
index f2853d0..084970b 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -145,7 +145,7 @@ static int verify_tag(const char *name, const char *ref,
 
 static int do_sign(struct strbuf *buffer)
 {
-	struct child_process gpg;
+	struct child_process gpg = { 0, };
 	const char *args[4];
 	char *bracket;
 	int len;
@@ -164,7 +164,6 @@ static int do_sign(struct strbuf *buffer)
 	 * because gpg exits without reading and then write gets SIGPIPE. */
 	signal(SIGPIPE, SIG_IGN);
 
-	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args;
 	gpg.in = -1;
 	gpg.out = -1;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9f4bdd3..8ae199d 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -90,11 +90,9 @@ static void use(int bytes)
 
 static void *get_data(unsigned long size)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	void *buf = xmalloc(size);
 
-	memset(&stream, 0, sizeof(stream));
-
 	stream.next_out = buf;
 	stream.avail_out = size;
 	stream.next_in = fill(1);
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 729a159..62aca43 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -18,7 +18,7 @@ static const char builtin_verify_tag_usage[] =
 
 static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 {
-	struct child_process gpg;
+	struct child_process gpg = { 0, };
 	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
 	char path[PATH_MAX], *eol;
 	size_t len;
@@ -42,7 +42,6 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	if (verbose)
 		write_in_full(1, buf, len);
 
-	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv = args_gpg;
 	gpg.in = -1;
 	args_gpg[2] = path;
diff --git a/bundle.c b/bundle.c
index 00b2aab..1e3d446 100644
--- a/bundle.c
+++ b/bundle.c
@@ -99,7 +99,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	struct ref_list *p = &header->prerequisites;
 	struct rev_info revs;
 	const char *argv[] = {NULL, "--all"};
-	struct object_array refs;
+	struct object_array refs = { 0, };
 	struct commit *commit;
 	int i, ret = 0, req_nr;
 	const char *message = "Repository lacks these prerequisite commits:";
@@ -122,7 +122,6 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
-	memset(&refs, 0, sizeof(struct object_array));
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
 		add_object_array(e->item, e->name, &refs);
@@ -179,7 +178,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 	char buffer[1024];
 	struct rev_info revs;
 	int read_from_stdin = 0;
-	struct child_process rls;
+	struct child_process rls = { 0, };
 	FILE *rls_fout;
 
 	bundle_to_stdout = !strcmp(path, "-");
@@ -201,7 +200,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 	argv_boundary[1] = "--boundary";
 	argv_boundary[2] = "--pretty=oneline";
 	argv_boundary[argc + 2] = NULL;
-	memset(&rls, 0, sizeof(rls));
 	rls.argv = argv_boundary;
 	rls.out = -1;
 	rls.git_cmd = 1;
@@ -354,11 +352,10 @@ int unbundle(struct bundle_header *header, int bundle_fd)
 {
 	const char *argv_index_pack[] = {"index-pack",
 		"--fix-thin", "--stdin", NULL};
-	struct child_process ip;
+	struct child_process ip = { 0, };
 
 	if (verify_bundle(header, 0))
 		return -1;
-	memset(&ip, 0, sizeof(ip));
 	ip.argv = argv_index_pack;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
diff --git a/combine-diff.c b/combine-diff.c
index de83c69..42f28bc 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -202,10 +202,10 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	unsigned int p_lno, lno;
 	unsigned long nmask = (1UL << n);
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = { 0, };
 	mmfile_t parent_file;
 	xdemitcb_t ecb;
-	struct combine_diff_state state;
+	struct combine_diff_state state = { 0, };
 	unsigned long sz;
 
 	if (!cnt)
@@ -214,8 +214,6 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	parent_file.ptr = grab_blob(parent, &sz);
 	parent_file.size = sz;
 	xpp.flags = XDF_NEED_MINIMAL;
-	memset(&xecfg, 0, sizeof(xecfg));
-	memset(&state, 0, sizeof(state));
 	state.nmask = nmask;
 	state.sline = sline;
 	state.lno = 1;
diff --git a/connect.c b/connect.c
index 67d2cd8..59bd865 100644
--- a/connect.c
+++ b/connect.c
@@ -198,7 +198,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	int sockfd = -1, saved_errno = 0;
 	char *colon, *end;
 	const char *port = STR(DEFAULT_GIT_PORT);
-	struct addrinfo hints, *ai0, *ai;
+	struct addrinfo hints = { 0, }, *ai0, *ai;
 	int gai;
 	int cnt = 0;
 
@@ -221,7 +221,6 @@ static int git_tcp_connect_sock(char *host, int flags)
 			port = "<none>";
 	}
 
-	memset(&hints, 0, sizeof(hints));
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
 
@@ -437,7 +436,7 @@ static void git_proxy_connect(int fd[2], char *host)
 	const char *port = STR(DEFAULT_GIT_PORT);
 	char *colon, *end;
 	const char *argv[4];
-	struct child_process proxy;
+	struct child_process proxy = { 0, };
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -460,7 +459,6 @@ static void git_proxy_connect(int fd[2], char *host)
 	argv[1] = host;
 	argv[2] = port;
 	argv[3] = NULL;
-	memset(&proxy, 0, sizeof(proxy));
 	proxy.argv = argv;
 	proxy.in = -1;
 	proxy.out = -1;
diff --git a/convert.c b/convert.c
index 78efed8..a2655bd 100644
--- a/convert.c
+++ b/convert.c
@@ -246,12 +246,11 @@ static int filter_buffer(int fd, void *data)
 	/*
 	 * Spawn cmd and feed the buffer contents through its stdin.
 	 */
-	struct child_process child_process;
+	struct child_process child_process = { 0, };
 	struct filter_params *params = (struct filter_params *)data;
 	int write_err, status;
 	const char *argv[] = { "sh", "-c", params->cmd, NULL };
 
-	memset(&child_process, 0, sizeof(child_process));
 	child_process.argv = argv;
 	child_process.in = -1;
 	child_process.out = fd;
@@ -282,13 +281,12 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	 */
 	int ret = 1;
 	struct strbuf nbuf;
-	struct async async;
+	struct async async = { 0, };
 	struct filter_params params;
 
 	if (!cmd)
 		return 0;
 
-	memset(&async, 0, sizeof(async));
 	async.proc = filter_buffer;
 	async.data = &params;
 	params.src = src;
diff --git a/daemon.c b/daemon.c
index 3e5582d..4e62821 100644
--- a/daemon.c
+++ b/daemon.c
@@ -462,12 +462,11 @@ static void fill_in_extra_table_entries(struct interp *itable)
 	 */
 #ifndef NO_IPV6
 	{
-		struct addrinfo hints;
+		struct addrinfo hints = { 0, };
 		struct addrinfo *ai, *ai0;
 		int gai;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
-		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
 		gai = getaddrinfo(interp_table[INTERP_SLOT_HOST].value, 0, &hints, &ai0);
@@ -489,14 +488,13 @@ static void fill_in_extra_table_entries(struct interp *itable)
 #else
 	{
 		struct hostent *hent;
-		struct sockaddr_in sa;
+		struct sockaddr_in sa = { 0, };
 		char **ap;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
 		hent = gethostbyname(interp_table[INTERP_SLOT_HOST].value);
 
 		ap = hent->h_addr_list;
-		memset(&sa, 0, sizeof sa);
 		sa.sin_family = hent->h_addrtype;
 		sa.sin_port = htons(0);
 		memcpy(&sa.sin_addr, *ap, hent->h_length);
@@ -722,12 +720,11 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	int socknum = 0, *socklist = NULL;
 	int maxfd = -1;
 	char pbuf[NI_MAXSERV];
-	struct addrinfo hints, *ai0, *ai;
+	struct addrinfo hints = { 0, }, *ai0, *ai;
 	int gai;
 	long flags;
 
 	sprintf(pbuf, "%d", listen_port);
-	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
@@ -793,11 +790,10 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 {
-	struct sockaddr_in sin;
+	struct sockaddr_in sin = { 0, };
 	int sockfd;
 	long flags;
 
-	memset(&sin, 0, sizeof sin);
 	sin.sin_family = AF_INET;
 	sin.sin_port = htons(listen_port);
 
diff --git a/date.c b/date.c
index 35a5257..a13d6e2 100644
--- a/date.c
+++ b/date.c
@@ -539,11 +539,10 @@ static int date_string(unsigned long date, int offset, char *buf, int len)
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
 int parse_date(const char *date, char *result, int maxlen)
 {
-	struct tm tm;
+	struct tm tm = { 0, };
 	int offset, tm_gmt;
 	time_t then;
 
-	memset(&tm, 0, sizeof(tm));
 	tm.tm_year = -1;
 	tm.tm_mon = -1;
 	tm.tm_mday = -1;
diff --git a/diff-lib.c b/diff-lib.c
index ae96c64..000f100 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -444,7 +444,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	struct object *ent;
 	struct tree *tree;
 	const char *tree_name;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 	struct tree_desc t;
 	struct oneway_unpack_data unpack_cb;
 
@@ -458,7 +458,6 @@ int run_diff_index(struct rev_info *revs, int cached)
 
 	unpack_cb.revs = revs;
 	unpack_cb.symcache[0] = '\0';
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
 	opts.merge = 1;
@@ -484,7 +483,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	int i;
 	struct cache_entry **dst;
 	struct cache_entry *last = NULL;
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 	struct tree_desc t;
 	struct oneway_unpack_data unpack_cb;
 
@@ -517,7 +516,6 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 
 	unpack_cb.revs = &revs;
 	unpack_cb.symcache[0] = '\0';
-	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
diff --git a/diff.c b/diff.c
index 02e948c..5b8e64d 100644
--- a/diff.c
+++ b/diff.c
@@ -466,12 +466,11 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 static void diff_words_show(struct diff_words_data *diff_words)
 {
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = { 0, };
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 	int i;
 
-	memset(&xecfg, 0, sizeof(xecfg));
 	minus.size = diff_words->minus.text.size;
 	minus.ptr = xmalloc(minus.size);
 	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
@@ -1270,9 +1269,8 @@ static unsigned char *deflate_it(char *data,
 {
 	int bound;
 	unsigned char *deflated;
-	z_stream stream;
+	z_stream stream = { 0, };
 
-	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
 	bound = deflateBound(&stream, size);
 	deflated = xmalloc(bound);
@@ -1569,17 +1567,15 @@ static void builtin_diff(const char *name_a,
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = { 0, };
 		xdemitcb_t ecb;
-		struct emit_callback ecbdata;
+		struct emit_callback ecbdata = { 0, };
 		const struct funcname_pattern_entry *pe;
 
 		pe = diff_funcname_pattern(one);
 		if (!pe)
 			pe = diff_funcname_pattern(two);
 
-		memset(&xecfg, 0, sizeof(xecfg));
-		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 		ecbdata.found_changesp = &o->found_changes;
@@ -1648,10 +1644,9 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	} else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = { 0, };
 		xdemitcb_t ecb;
 
-		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
 			      &xpp, &xecfg, &ecb);
@@ -1669,12 +1664,11 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 			      struct diff_options *o)
 {
 	mmfile_t mf1, mf2;
-	struct checkdiff_t data;
+	struct checkdiff_t data = { 0, };
 
 	if (!two)
 		return;
 
-	memset(&data, 0, sizeof(data));
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
 	data.o = o;
@@ -1694,10 +1688,9 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = { 0, };
 		xdemitcb_t ecb;
 
-		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = XDF_NEED_MINIMAL;
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
@@ -3129,22 +3122,20 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
 	git_SHA_CTX ctx;
-	struct patch_id_t data;
+	struct patch_id_t data = { 0, };
 	char buffer[PATH_MAX * 4 + 20];
 
 	git_SHA1_Init(&ctx);
-	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
 
 	for (i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = { 0, };
 		xdemitcb_t ecb;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p = q->queue[i];
 		int len1, len2;
 
-		memset(&xecfg, 0, sizeof(xecfg));
 		if (p->status == 0)
 			return error("internal diff status error");
 		if (p->status == DIFF_STATUS_UNKNOWN)
@@ -3274,9 +3265,8 @@ void diff_flush(struct diff_options *options)
 	}
 
 	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT)) {
-		struct diffstat_t diffstat;
+		struct diffstat_t diffstat = { 0, };
 
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/fast-import.c b/fast-import.c
index 3c035a5..0dbf329 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1034,7 +1034,7 @@ static int store_object(
 	unsigned char sha1[20];
 	unsigned long hdrlen, deltalen;
 	git_SHA_CTX c;
-	z_stream s;
+	z_stream s = { 0, };
 
 	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
@@ -1070,7 +1070,6 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	memset(&s, 0, sizeof(s));
 	deflateInit(&s, pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
@@ -1962,7 +1961,7 @@ static void file_change_cr(struct branch *b, int rename)
 	static struct strbuf s_uq = STRBUF_INIT;
 	static struct strbuf d_uq = STRBUF_INIT;
 	const char *endp;
-	struct tree_entry leaf;
+	struct tree_entry leaf = { 0, };
 
 	s = command_buf.buf + 2;
 	strbuf_reset(&s_uq);
@@ -1989,7 +1988,6 @@ static void file_change_cr(struct branch *b, int rename)
 		d = d_uq.buf;
 	}
 
-	memset(&leaf, 0, sizeof(leaf));
 	if (rename)
 		tree_content_remove(&b->branch_tree, s, &leaf);
 	else
diff --git a/help.c b/help.c
index fd87bb5..cb7d3e6 100644
--- a/help.c
+++ b/help.c
@@ -299,10 +299,8 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
-	struct cmdnames main_cmds, other_cmds;
+	struct cmdnames main_cmds = { 0, }, other_cmds = { 0, };
 
-	memset(&main_cmds, 0, sizeof(main_cmds));
-	memset(&other_cmds, 0, sizeof(main_cmds));
 	memset(&aliases, 0, sizeof(aliases));
 
 	git_config(git_unknown_cmd_config, NULL);
diff --git a/http-push.c b/http-push.c
index 42f4d78..1bddabd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -486,13 +486,12 @@ static void start_put(struct transfer_request *request)
 	unsigned long len;
 	int hdrlen;
 	ssize_t size;
-	z_stream stream;
+	z_stream stream = { 0, };
 
 	unpacked = read_sha1_file(request->obj->sha1, &type, &len);
 	hdrlen = sprintf(hdr, "%s %lu", typename(type), len) + 1;
 
 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
 	size = deflateBound(&stream, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
diff --git a/imap-send.c b/imap-send.c
index af7e08c..700c332 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -981,7 +981,7 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	struct imap *imap;
 	char *arg, *rsp;
 	struct hostent *he;
-	struct sockaddr_in addr;
+	struct sockaddr_in addr = { 0, };
 	int s, a[2], preauth;
 	pid_t pid;
 
@@ -1019,7 +1019,6 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 
 		imap_info("ok\n");
 	} else {
-		memset(&addr, 0, sizeof(addr));
 		addr.sin_port = htons(srvc->port);
 		addr.sin_family = AF_INET;
 
@@ -1154,15 +1153,13 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
-	struct imap_cmd_cb cb;
+	struct imap_cmd_cb cb = { 0, };
 	char *fmap, *buf;
 	const char *prefix, *box;
 	int ret, i, j, d, len, extra, nocr;
 	int start, sbreak = 0, ebreak = 0;
 	char flagstr[128], tuid[TUIDL * 2 + 1];
 
-	memset(&cb, 0, sizeof(cb));
-
 	fmap = data->data;
 	len = data->len;
 	nocr = !data->crlf;
diff --git a/index-pack.c b/index-pack.c
index 73860bf..90b2811 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -263,10 +263,9 @@ static void unlink_base_data(struct base_data *c)
 
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	void *buf = xmalloc(size);
 
-	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buf;
 	stream.avail_out = size;
 	stream.next_in = fill(1);
@@ -358,7 +357,7 @@ static void *get_data_from_pack(struct object_entry *obj)
 	unsigned long len = obj[1].idx.offset - from;
 	unsigned long rdy = 0;
 	unsigned char *src, *data;
-	z_stream stream;
+	z_stream stream = { 0, };
 	int st;
 
 	src = xmalloc(len);
@@ -373,7 +372,6 @@ static void *get_data_from_pack(struct object_entry *obj)
 		rdy += n;
 	} while (rdy < len);
 	data = xmalloc(obj->size);
-	memset(&stream, 0, sizeof(stream));
 	stream.next_out = data;
 	stream.avail_out = obj->size;
 	stream.next_in = src;
@@ -659,11 +657,10 @@ static void parse_pack_objects(unsigned char *sha1)
 
 static int write_compressed(struct sha1file *f, void *in, unsigned int size)
 {
-	z_stream stream;
+	z_stream stream = { 0, };
 	unsigned long maxsize;
 	void *out;
 
-	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
 	maxsize = deflateBound(&stream, size);
 	out = xmalloc(maxsize);
diff --git a/ll-merge.c b/ll-merge.c
index 4a71614..a81c89b 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -62,7 +62,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *src2, const char *name2,
 			int virtual_ancestor)
 {
-	xpparam_t xpp;
+	xpparam_t xpp = { 0, };
 	int style = 0;
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
@@ -77,7 +77,6 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       virtual_ancestor);
 	}
 
-	memset(&xpp, 0, sizeof(xpp));
 	if (git_xmerge_style >= 0)
 		style = git_xmerge_style;
 	return xdl_merge(orig,
@@ -175,7 +174,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 		{ "%A" },
 		{ "%B" },
 	};
-	struct child_process child;
+	struct child_process child = { 0, };
 	const char *args[20];
 	int status, fd, i;
 	struct stat st;
@@ -195,7 +194,6 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 
 	interpolate(cmdbuf, sizeof(cmdbuf), fn->cmdline, table, 3);
 
-	memset(&child, 0, sizeof(child));
 	child.argv = args;
 	args[0] = "sh";
 	args[1] = "-c";
diff --git a/merge-file.c b/merge-file.c
index 2a939c9..6e98470 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -27,10 +27,9 @@ static void free_mmfile(mmfile_t *f)
 static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
 {
 	mmbuffer_t res;
-	xpparam_t xpp;
+	xpparam_t xpp = { 0, };
 	int merge_status;
 
-	memset(&xpp, 0, sizeof(xpp));
 	merge_status = xdl_merge(base, our, ".our", their, ".their",
 		&xpp, XDL_MERGE_ZEALOUS, &res);
 
@@ -58,11 +57,10 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	unsigned long size = f1->size < f2->size ? f1->size : f2->size;
 	void *ptr = xmalloc(size);
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = { 0, };
 	xdemitcb_t ecb;
 
 	xpp.flags = XDF_NEED_MINIMAL;
-	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	xecfg.flags = XDL_EMIT_COMMON;
 	ecb.outf = common_outf;
diff --git a/merge-index.c b/merge-index.c
index 7827e87..881ab13 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -8,8 +8,7 @@ static int err;
 
 static void run_program(void)
 {
-	struct child_process child;
-	memset(&child, 0, sizeof(child));
+	struct child_process child = { 0, };
 	child.argv = arguments;
 	if (run_command(&child)) {
 		if (one_shot) {
diff --git a/merge-recursive.c b/merge-recursive.c
index 6bc3eac..4358ecf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -170,9 +170,8 @@ static int git_merge_trees(int index_only,
 {
 	int rc;
 	struct tree_desc t[3];
-	struct unpack_trees_options opts;
+	struct unpack_trees_options opts = { 0, };
 
-	memset(&opts, 0, sizeof(opts));
 	if (index_only)
 		opts.index_only = 1;
 	else
diff --git a/merge-tree.c b/merge-tree.c
index 2d1413e..71ab1be 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -102,11 +102,10 @@ static void show_diff(struct merge_list *entry)
 	unsigned long size;
 	mmfile_t src, dst;
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = { 0, };
 	xdemitcb_t ecb;
 
 	xpp.flags = XDF_NEED_MINIMAL;
-	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	ecb.outf = show_outf;
 	ecb.priv = NULL;
diff --git a/pack-refs.c b/pack-refs.c
index 848d311..cab2eaf 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -84,9 +84,8 @@ static struct lock_file packed;
 int pack_refs(unsigned int flags)
 {
 	int fd;
-	struct pack_refs_cb_data cbdata;
+	struct pack_refs_cb_data cbdata = { 0, };
 
-	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
 	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
diff --git a/pretty.c b/pretty.c
index 8beafa0..fd6924a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -626,9 +626,8 @@ void format_commit_message(const struct commit *commit,
 			   const void *format, struct strbuf *sb,
 			   enum date_mode dmode)
 {
-	struct format_commit_context context;
+	struct format_commit_context context = { 0, };
 
-	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.dmode = dmode;
 	strbuf_expand(sb, format, format_commit_item, &context);
diff --git a/progress.c b/progress.c
index 55a8687..7507dfe 100644
--- a/progress.c
+++ b/progress.c
@@ -44,12 +44,11 @@ static void progress_interval(int signum)
 
 static void set_progress_signal(void)
 {
-	struct sigaction sa;
+	struct sigaction sa = { { 0, }, };
 	struct itimerval v;
 
 	progress_update = 0;
 
-	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = progress_interval;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = SA_RESTART;
diff --git a/sha1_file.c b/sha1_file.c
index 7515987..00049b5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1297,10 +1297,9 @@ unsigned long get_size_from_delta(struct packed_git *p,
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
-	z_stream stream;
+	z_stream stream = { 0, };
 	int st;
 
-	memset(&stream, 0, sizeof(stream));
 	stream.next_out = delta_head;
 	stream.avail_out = sizeof(delta_head);
 
@@ -1511,12 +1510,11 @@ static void *unpack_compressed_entry(struct packed_git *p,
 				    unsigned long size)
 {
 	int st;
-	z_stream stream;
+	z_stream stream = { 0, };
 	unsigned char *buffer, *in;
 
 	buffer = xmalloc(size + 1);
 	buffer[size] = 0;
-	memset(&stream, 0, sizeof(stream));
 	stream.next_out = buffer;
 	stream.avail_out = size;
 
@@ -2252,7 +2250,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 {
 	int fd, size, ret;
 	unsigned char *compressed;
-	z_stream stream;
+	z_stream stream = { 0, };
 	char *filename;
 	static char tmpfile[PATH_MAX];
 
@@ -2266,7 +2264,6 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 	}
 
 	/* Set it up */
-	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
 	size = 8 + deflateBound(&stream, len+hdrlen);
 	compressed = xmalloc(size);
diff --git a/transport.c b/transport.c
index 5110c56..ccbb42b 100644
--- a/transport.c
+++ b/transport.c
@@ -41,14 +41,12 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 	struct {
 		char **entries;
 		int nr, alloc;
-	} list;
+	} list = { 0, };
 	int i, pathlen;
 
 	if (!dir)
 		return -1;
 
-	memset (&list, 0, sizeof(list));
-
 	while ((de = readdir(dir))) {
 		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
 				(de->d_name[1] == '.' &&
@@ -146,7 +144,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport)
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
 	struct ref dummy, *tail = &dummy;
-	struct child_process rsync;
+	struct child_process rsync = { 0, };
 	const char *args[5];
 	int temp_dir_len;
 
@@ -160,7 +158,6 @@ static struct ref *get_refs_via_rsync(struct transport *transport)
 	strbuf_addstr(&buf, transport->url);
 	strbuf_addstr(&buf, "/refs");
 
-	memset(&rsync, 0, sizeof(rsync));
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
@@ -206,14 +203,13 @@ static int fetch_objs_via_rsync(struct transport *transport,
 				int nr_objs, const struct ref **to_fetch)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct child_process rsync;
+	struct child_process rsync = { 0, };
 	const char *args[8];
 	int result;
 
 	strbuf_addstr(&buf, transport->url);
 	strbuf_addstr(&buf, "/objects/");
 
-	memset(&rsync, 0, sizeof(rsync));
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
@@ -281,7 +277,7 @@ static int rsync_transport_push(struct transport *transport,
 {
 	struct strbuf buf = STRBUF_INIT, temp_dir = STRBUF_INIT;
 	int result = 0, i;
-	struct child_process rsync;
+	struct child_process rsync = { 0, };
 	const char *args[10];
 
 	if (flags & TRANSPORT_PUSH_MIRROR)
@@ -292,7 +288,6 @@ static int rsync_transport_push(struct transport *transport,
 	strbuf_addstr(&buf, transport->url);
 	strbuf_addch(&buf, '/');
 
-	memset(&rsync, 0, sizeof(rsync));
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	i = 0;
@@ -632,11 +627,10 @@ static int fetch_refs_via_pack(struct transport *transport,
 	char **origh = xmalloc(nr_heads * sizeof(*origh));
 	const struct ref *refs;
 	char *dest = xstrdup(transport->url);
-	struct fetch_pack_args args;
+	struct fetch_pack_args args = { 0, };
 	int i;
 	struct ref *refs_tmp = NULL;
 
-	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->uploadpack;
 	args.keep_pack = data->keep;
 	args.lock_pack = 1;
diff --git a/unpack-trees.c b/unpack-trees.c
index e59d144..a9d6fe5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -495,7 +495,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 */
 	int namelen;
 	int pos, i;
-	struct dir_struct d;
+	struct dir_struct d = { 0, };
 	char *pathbuf;
 	int cnt = 0;
 	unsigned char sha1[20];
@@ -545,7 +545,6 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	memcpy(pathbuf, ce->name, namelen);
 	strcpy(pathbuf+namelen, "/");
 
-	memset(&d, 0, sizeof(d));
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..64cbb0a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -143,7 +143,7 @@ static int do_rev_list(int fd, void *create_full_pack)
 static void create_pack_file(void)
 {
 	struct async rev_list;
-	struct child_process pack_objects;
+	struct child_process pack_objects = { 0, };
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
 	char data[8193], progress[128];
 	char abort_msg[] = "aborting due to possible repository "
@@ -169,7 +169,6 @@ static void create_pack_file(void)
 		argv[arg++] = "--include-tag";
 	argv[arg++] = NULL;
 
-	memset(&pack_objects, 0, sizeof(pack_objects));
 	pack_objects.in = rev_list.out;	/* start_command closes it */
 	pack_objects.out = -1;
 	pack_objects.err = -1;
diff --git a/wt-status.c b/wt-status.c
index 7cf890f..ad8aac5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -235,7 +235,7 @@ static void wt_status_print_changed(struct wt_status *s)
 
 static void wt_status_print_submodule_summary(struct wt_status *s)
 {
-	struct child_process sm_summary;
+	struct child_process sm_summary = { 0, };
 	char summary_limit[64];
 	char index[PATH_MAX];
 	const char *env[] = { index, NULL };
@@ -253,7 +253,6 @@ static void wt_status_print_submodule_summary(struct wt_status *s)
 	sprintf(summary_limit, "%d", wt_status_submodule_summary);
 	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", s->index_file);
 
-	memset(&sm_summary, 0, sizeof(sm_summary));
 	sm_summary.argv = argv;
 	sm_summary.env = env;
 	sm_summary.git_cmd = 1;
@@ -265,13 +264,12 @@ static void wt_status_print_submodule_summary(struct wt_status *s)
 
 static void wt_status_print_untracked(struct wt_status *s)
 {
-	struct dir_struct dir;
+	struct dir_struct dir = { 0, };
 	int i;
 	int shown_header = 0;
 	struct strbuf buf;
 
 	strbuf_init(&buf, 0);
-	memset(&dir, 0, sizeof(dir));
 
 	if (!s->untracked) {
 		dir.show_other_directories = 1;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 8bab82e..662e604 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -140,9 +140,8 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
 {
 	int ret;
-	struct xdiff_emit_state state;
+	struct xdiff_emit_state state = { 0, };
 
-	memset(&state, 0, sizeof(state));
 	state.consume = fn;
 	state.consume_callback_data = consume_callback_data;
 	xecb->outf = xdiff_outf;
-- 
1.6.0.2.468.gd5b83
