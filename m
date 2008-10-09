From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [RFC PATCH 2/2] Replace calls to strbuf_init(&foo, 0) with static
 STRBUF_INIT initializer
Date: Thu, 09 Oct 2008 14:12:12 -0500
Message-ID: <UUi8gSMV6CruoYIkVNOQZ4FNzsbqZcSNu6jdYH8GqIo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko0wz-0000g8-O8
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 21:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYJITMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbYJITMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 15:12:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57135 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbYJITMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 15:12:13 -0400
Received: by mail.nrlssc.navy.mil id m99JCC2n025107; Thu, 9 Oct 2008 14:12:12 -0500
X-OriginalArrivalTime: 09 Oct 2008 19:12:12.0775 (UTC) FILETIME=[EF4C8F70:01C92A42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97876>

Many call sites use strbuf_init(&foo, 0) to initialize local strbuf variable
"foo" which has not been accessed since its declaration. These can be
replaced with a static initialization using the STRBUF_INIT macro which is
just as readable, saves a function call, and takes up fewer lines.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This does the same thing for strbuf_init() that the last one did for memset().

comments?

-brandon


 archive-tar.c            |    7 ++-----
 archive.c                |    6 ++----
 builtin-apply.c          |   26 ++++++++------------------
 builtin-blame.c          |    3 +--
 builtin-branch.c         |    3 +--
 builtin-cat-file.c       |    3 +--
 builtin-checkout-index.c |    4 +---
 builtin-checkout.c       |   12 ++++--------
 builtin-clean.c          |    6 ++----
 builtin-clone.c          |    9 +++------
 builtin-commit.c         |   15 +++++----------
 builtin-fetch--tool.c    |    3 +--
 builtin-fmt-merge-msg.c  |    4 +---
 builtin-help.c           |    4 +---
 builtin-log.c            |   13 ++++---------
 builtin-merge.c          |   27 +++++++++------------------
 builtin-remote.c         |    8 ++------
 builtin-rev-list.c       |    3 +--
 builtin-rev-parse.c      |    4 +---
 builtin-show-branch.c    |    3 +--
 builtin-stripspace.c     |    3 +--
 builtin-tag.c            |    3 +--
 builtin-update-index.c   |   10 +++-------
 combine-diff.c           |    3 +--
 config.c                 |    6 ++----
 convert.c                |    3 +--
 diff.c                   |   15 +++++----------
 editor.c                 |    3 +--
 exec_cmd.c               |    4 +---
 fsck.c                   |    3 +--
 git.c                    |    3 +--
 graph.c                  |   13 ++++---------
 hash-object.c            |    4 +---
 imap-send.c              |    3 +--
 log-tree.c               |    3 +--
 merge-recursive.c        |    3 +--
 mktag.c                  |    3 +--
 mktree.c                 |    6 ++----
 pretty.c                 |    3 +--
 read-cache.c             |    3 +--
 remote.c                 |    3 +--
 rerere.c                 |    4 +---
 sha1_file.c              |    6 ++----
 walker.c                 |    3 +--
 ws.c                     |    3 +--
 wt-status.c              |   11 +++--------
 xdiff-interface.c        |    3 +--
 47 files changed, 92 insertions(+), 201 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e3170fb..ca0a12c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -124,11 +124,9 @@ static int write_tar_entry(struct archiver_args *args,
 		unsigned int mode, void *buffer, unsigned long size)
 {
 	struct ustar_header header = { { 0, }, };
-	struct strbuf ext_header;
+	struct strbuf ext_header = STRBUF_INIT;
 	int err = 0;
 
-	strbuf_init(&ext_header, 0);
-
 	if (!sha1) {
 		*header.typeflag = TYPEFLAG_GLOBAL_HEADER;
 		mode = 0100666;
@@ -210,10 +208,9 @@ static int write_tar_entry(struct archiver_args *args,
 static int write_global_extended_header(struct archiver_args *args)
 {
 	const unsigned char *sha1 = args->commit_sha1;
-	struct strbuf ext_header;
+	struct strbuf ext_header = STRBUF_INIT;
 	int err;
 
-	strbuf_init(&ext_header, 0);
 	strbuf_append_ext_header(&ext_header, "comment", sha1_to_hex(sha1), 40);
 	err = write_tar_entry(args, NULL, NULL, 0, 0, ext_header.buf,
 			ext_header.len);
diff --git a/archive.c b/archive.c
index 44ab008..849eed5 100644
--- a/archive.c
+++ b/archive.c
@@ -29,11 +29,10 @@ static void format_subst(const struct commit *commit,
                          struct strbuf *buf)
 {
 	char *to_free = NULL;
-	struct strbuf fmt;
+	struct strbuf fmt = STRBUF_INIT;
 
 	if (src == buf->buf)
 		to_free = strbuf_detach(buf, NULL);
-	strbuf_init(&fmt, 0);
 	for (;;) {
 		const char *b, *c;
 
@@ -65,10 +64,9 @@ static void *sha1_file_to_archive(const char *path, const unsigned char *sha1,
 
 	buffer = read_sha1_file(sha1, type, sizep);
 	if (buffer && S_ISREG(mode)) {
-		struct strbuf buf;
+		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
 
-		strbuf_init(&buf, 0);
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(path, buf.buf, buf.len, &buf);
 		if (commit)
diff --git a/builtin-apply.c b/builtin-apply.c
index 945616e..72da0b0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -321,13 +321,12 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 	const char *start = line;
 
 	if (*line == '"') {
-		struct strbuf name;
+		struct strbuf name = STRBUF_INIT;
 
 		/*
 		 * Proposed "new-style" GNU patch/diff format; see
 		 * http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2
 		 */
-		strbuf_init(&name, 0);
 		if (!unquote_c_style(&name, line, NULL)) {
 			char *cp;
 
@@ -675,11 +674,8 @@ static char *git_header_name(char *line, int llen)
 
 	if (*line == '"') {
 		const char *cp;
-		struct strbuf first;
-		struct strbuf sp;
-
-		strbuf_init(&first, 0);
-		strbuf_init(&sp, 0);
+		struct strbuf first = STRBUF_INIT;
+		struct strbuf sp = STRBUF_INIT;
 
 		if (unquote_c_style(&first, line, &second))
 			goto free_and_fail1;
@@ -741,10 +737,9 @@ static char *git_header_name(char *line, int llen)
 	 */
 	for (second = name; second < line + llen; second++) {
 		if (*second == '"') {
-			struct strbuf sp;
+			struct strbuf sp = STRBUF_INIT;
 			const char *np;
 
-			strbuf_init(&sp, 0);
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
@@ -1506,11 +1501,10 @@ static const char minuses[]=
 
 static void show_stats(struct patch *patch)
 {
-	struct strbuf qname;
+	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
 	int max, add, del;
 
-	strbuf_init(&qname, 0);
 	quote_c_style(cp, &qname, NULL, 0);
 
 	/*
@@ -2288,14 +2282,12 @@ static void add_to_fn_table(struct patch *patch)
 
 static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *ce)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	struct image image;
 	size_t len;
 	char *img;
 	struct patch *tpatch;
 
-	strbuf_init(&buf, 0);
-
 	if (!(patch->is_copy || patch->is_rename) &&
 	    ((tpatch = in_fn_table(patch->old_name)) != NULL)) {
 		if (tpatch == (struct patch *) -1) {
@@ -2775,7 +2767,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
 	int fd;
-	struct strbuf nbuf;
+	struct strbuf nbuf = STRBUF_INIT;
 
 	if (S_ISGITLINK(mode)) {
 		struct stat st;
@@ -2794,7 +2786,6 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 	if (fd < 0)
 		return -1;
 
-	strbuf_init(&nbuf, 0);
 	if (convert_to_working_tree(path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
@@ -3056,13 +3047,12 @@ static void prefix_patches(struct patch *p)
 static int apply_patch(int fd, const char *filename, int options)
 {
 	size_t offset;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
 	/* FIXME - memory leak when using multiple patch files as inputs */
 	memset(&fn_table, 0, sizeof(struct string_list));
-	strbuf_init(&buf, 0);
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
 	offset = 0;
diff --git a/builtin-blame.c b/builtin-blame.c
index 93d2daf..a94b335 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2060,7 +2060,7 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	struct commit *commit;
 	struct origin *origin;
 	unsigned char head_sha1[20];
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	const char *ident;
 	time_t now;
 	int size, len;
@@ -2080,7 +2080,6 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 
 	origin = make_origin(commit, path);
 
-	strbuf_init(&buf, 0);
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
 		const char *read_from;
diff --git a/builtin-branch.c b/builtin-branch.c
index 6e2c614..bb49827 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -334,11 +334,10 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 
 	if (verbose) {
-		struct strbuf subject;
+		struct strbuf subject = STRBUF_INIT;
 		const char *sub = " **** invalid ref ****";
 		char stat[128];
 
-		strbuf_init(&subject, 0);
 		stat[0] = '\0';
 
 		commit = item->commit;
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 3fba6b9..30d00a6 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -189,9 +189,8 @@ static int batch_one_object(const char *obj_name, int print_contents)
 
 static int batch_objects(int print_contents)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_init(&buf, 0);
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
 		int error = batch_one_object(buf.buf, print_contents);
 		if (error)
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 55b7aaf..4ba2702 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -268,13 +268,11 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_from_stdin) {
-		struct strbuf buf, nbuf;
+		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
 		if (all)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
-		strbuf_init(&buf, 0);
-		strbuf_init(&nbuf, 0);
 		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 			const char *p;
 			if (line_termination && buf.buf[0] == '"') {
diff --git a/builtin-checkout.c b/builtin-checkout.c
index f167a98..03b9b53 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -308,8 +308,7 @@ static void show_local_changes(struct object *head)
 
 static void describe_detached_head(char *msg, struct commit *commit)
 {
-	struct strbuf sb;
-	strbuf_init(&sb, 0);
+	struct strbuf sb = STRBUF_INIT;
 	parse_commit(commit);
 	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, 0, NULL, NULL, 0, 0);
 	fprintf(stderr, "%s %s... %s\n", msg,
@@ -357,8 +356,7 @@ struct branch_info {
 
 static void setup_branch_path(struct branch_info *branch)
 {
-	struct strbuf buf;
-	strbuf_init(&buf, 0);
+	struct strbuf buf = STRBUF_INIT;
 	strbuf_addstr(&buf, "refs/heads/");
 	strbuf_addstr(&buf, branch->name);
 	branch->path = strbuf_detach(&buf, NULL);
@@ -480,7 +478,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 				   struct branch_info *old,
 				   struct branch_info *new)
 {
-	struct strbuf msg;
+	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
 	if (opts->new_branch) {
 		create_branch(old->name, opts->new_branch, new->name, 0,
@@ -489,7 +487,6 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		setup_branch_path(new);
 	}
 
-	strbuf_init(&msg, 0);
 	old_desc = old->name;
 	if (!old_desc)
 		old_desc = sha1_to_hex(old->commit->object.sha1);
@@ -731,8 +728,7 @@ no_reference:
 	}
 
 	if (opts.new_branch) {
-		struct strbuf buf;
-		strbuf_init(&buf, 0);
+		struct strbuf buf = STRBUF_INIT;
 		strbuf_addstr(&buf, "refs/heads/");
 		strbuf_addstr(&buf, opts.new_branch);
 		if (!get_sha1(buf.buf, rev))
diff --git a/builtin-clean.c b/builtin-clean.c
index 357d398..d998394 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -31,11 +31,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int i;
 	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
 	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
-	struct strbuf directory;
+	struct strbuf directory = STRBUF_INIT;
 	struct dir_struct dir = { 0, };
 	const char *path, *base;
 	static const char **pathspec;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -58,7 +58,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
-	strbuf_init(&buf, 0);
 	if (ignored_only)
 		dir.show_ignored = 1;
 
@@ -87,7 +86,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (baselen)
 		path = base = xmemdupz(*pathspec, baselen);
 	read_directory(&dir, path, base, baselen, pathspec);
-	strbuf_init(&directory, 0);
 
 	if (pathspec)
 		seen = xmalloc(argc > 0 ? argc : 1);
diff --git a/builtin-clone.c b/builtin-clone.c
index d1d5fe8..964d40d 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -264,10 +264,9 @@ pid_t junk_pid;
 
 static void remove_junk(void)
 {
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 	if (getpid() != junk_pid)
 		return;
-	strbuf_init(&sb, 0);
 	if (junk_git_dir) {
 		strbuf_addstr(&sb, junk_git_dir);
 		remove_dir_recursively(&sb, 0);
@@ -354,7 +353,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	char *path, *dir;
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
 	char branch_top[256], key[256], value[256];
-	struct strbuf reflog_msg;
+	struct strbuf reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	char *src_ref_prefix = "refs/heads/";
 
@@ -404,7 +403,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!stat(dir, &buf))
 		die("destination directory '%s' already exists.", dir);
 
-	strbuf_init(&reflog_msg, 0);
 	strbuf_addf(&reflog_msg, "clone: from %s", repo);
 
 	if (option_bare)
@@ -526,7 +524,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		create_symref("HEAD", head_points_at->name, NULL);
 
 		if (!option_bare) {
-			struct strbuf head_ref;
+			struct strbuf head_ref = STRBUF_INIT;
 			const char *head = head_points_at->name;
 
 			if (!prefixcmp(head, "refs/heads/"))
@@ -539,7 +537,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				   head_points_at->old_sha1,
 				   NULL, 0, DIE_ON_ERR);
 
-			strbuf_init(&head_ref, 0);
 			strbuf_addstr(&head_ref, branch_top);
 			strbuf_addstr(&head_ref, "HEAD");
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 69d8492..d079293 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -445,7 +445,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 {
 	struct stat statbuf;
 	int commitable, saved_color_setting;
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 	char *buffer;
 	FILE *fp;
 	const char *hook_arg1 = NULL;
@@ -455,7 +455,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
 
-	strbuf_init(&sb, 0);
 	if (message.len) {
 		strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
@@ -508,10 +507,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		stripspace(&sb, 0);
 
 	if (signoff) {
-		struct strbuf sob;
+		struct strbuf sob = STRBUF_INIT;
 		int i;
 
-		strbuf_init(&sob, 0);
 		strbuf_addstr(&sob, sign_off_header);
 		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
 					     getenv("GIT_COMMITTER_EMAIL")));
@@ -669,7 +667,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
  */
 static int message_is_empty(struct strbuf *sb)
 {
-	struct strbuf tmpl;
+	struct strbuf tmpl = STRBUF_INIT;
 	const char *nl;
 	int eol, i, start = 0;
 
@@ -677,7 +675,6 @@ static int message_is_empty(struct strbuf *sb)
 		return 0;
 
 	/* See if the template is just a prefix of the message. */
-	strbuf_init(&tmpl, 0);
 	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
 		stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
 		if (start + tmpl.len <= sb->len &&
@@ -928,7 +925,7 @@ static const char commit_utf8_warn[] =
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
@@ -963,12 +960,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		for (c = commit->parents; c; c = c->next)
 			pptr = &commit_list_insert(c->item, pptr)->next;
 	} else if (in_merge) {
-		struct strbuf m;
+		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
 
 		reflog_msg = "commit (merge)";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
-		strbuf_init(&m, 0);
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
 			die("could not open %s for reading: %s",
@@ -988,7 +984,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	parents = reduce_heads(parents);
 
 	/* Finally, get the commit message */
-	strbuf_init(&sb, 0);
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
 		die("could not read commit message");
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 7460ab7..469b07e 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -5,8 +5,7 @@
 
 static char *get_stdin(void)
 {
-	struct strbuf buf;
-	strbuf_init(&buf, 0);
+	struct strbuf buf = STRBUF_INIT;
 	if (strbuf_read(&buf, 0, 1024) < 0) {
 		die("error reading standard input: %s", strerror(errno));
 	}
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index df02ba7..1f39667 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -348,7 +348,7 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	FILE *in = stdin;
-	struct strbuf input, output;
+	struct strbuf input = STRBUF_INIT, output = STRBUF_INIT;
 	int ret;
 
 	git_config(fmt_merge_msg_config, NULL);
@@ -379,10 +379,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage(fmt_merge_msg_usage);
 
-	strbuf_init(&input, 0);
 	if (strbuf_read(&input, fileno(in), 0) < 0)
 		die("could not read input file %s", strerror(errno));
-	strbuf_init(&output, 0);
 
 	ret = fmt_merge_msg(merge_summary, &input, &output);
 	if (ret)
diff --git a/builtin-help.c b/builtin-help.c
index cb97f52..783f3a8 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -321,11 +321,9 @@ static const char *cmd_to_page(const char *git_cmd)
 
 static void setup_man_path(void)
 {
-	struct strbuf new_path;
+	struct strbuf new_path = STRBUF_INIT;
 	const char *old_path = getenv("MANPATH");
 
-	strbuf_init(&new_path, 0);
-
 	/* We should always put ':' after our path. If there is no
 	 * old_path, the ':' at the end will let 'man' to try
 	 * system-wide paths after ours to find the manual page. If
diff --git a/builtin-log.c b/builtin-log.c
index 4f4b15d..a5122f5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -627,10 +627,9 @@ static void gen_message_id(struct rev_info *info, char *base)
 	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
 	const char *email_start = strrchr(committer, '<');
 	const char *email_end = strrchr(committer, '>');
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	if (!email_start || !email_end || email_start > email_end - 1)
 		die("Could not extract email from committer identity.");
-	strbuf_init(&buf, 0);
 	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
 		    (unsigned long) time(NULL),
 		    (int)(email_end - email_start - 1), email_start + 1);
@@ -649,7 +648,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	const char *msg;
 	const char *extra_headers = rev->extra_headers;
 	struct shortlog log;
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "utf-8";
 	struct diff_options opts;
@@ -670,7 +669,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	committer = git_committer_info(0);
 
 	msg = body;
-	strbuf_init(&sb, 0);
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
@@ -752,7 +750,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
@@ -860,8 +858,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 	argc = j;
 
-	strbuf_init(&buf, 0);
-
 	for (i = 0; i < extra_hdr_nr; i++) {
 		strbuf_addstr(&buf, extra_hdr[i]);
 		strbuf_addch(&buf, '\n');
@@ -1138,8 +1134,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			sign = '-';
 
 		if (verbose) {
-			struct strbuf buf;
-			strbuf_init(&buf, 0);
+			struct strbuf buf = STRBUF_INIT;
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 			                    &buf, 0, NULL, NULL, 0, 0);
 			printf("%c %s %s\n", sign,
diff --git a/builtin-merge.c b/builtin-merge.c
index ef96078..fec88b7 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -224,7 +224,7 @@ static void reset_hard(unsigned const char *sha1, int verbose)
 
 static void restore_state(void)
 {
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_sha1(stash))
@@ -232,7 +232,6 @@ static void restore_state(void)
 
 	reset_hard(head, 1);
 
-	strbuf_init(&sb, 0);
 	args[2] = sha1_to_hex(stash);
 
 	/*
@@ -256,7 +255,7 @@ static void squash_message(void)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	struct strbuf out;
+	struct strbuf out = STRBUF_INIT;
 	struct commit_list *j;
 	int fd;
 
@@ -280,7 +279,6 @@ static void squash_message(void)
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
-	strbuf_init(&out, 0);
 	strbuf_addstr(&out, "Squashed commit of the following:\n");
 	while ((commit = get_revision(&rev)) != NULL) {
 		strbuf_addch(&out, '\n');
@@ -324,9 +322,8 @@ static int run_hook(const char *name)
 
 static void finish(const unsigned char *new_head, const char *msg)
 {
-	struct strbuf reflog_message;
+	struct strbuf reflog_message = STRBUF_INIT;
 
-	strbuf_init(&reflog_message, 0);
 	if (!msg)
 		strbuf_addstr(&reflog_message, getenv("GIT_REFLOG_ACTION"));
 	else {
@@ -377,7 +374,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct object *remote_head;
 	unsigned char branch_head[20] = { 0, }, buf_sha[20];
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	const char *ptr;
 	int len, early;
 
@@ -385,7 +382,6 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!remote_head)
 		die("'%s' does not point to a commit", remote);
 
-	strbuf_init(&buf, 0);
 	strbuf_addstr(&buf, "refs/heads/");
 	strbuf_addstr(&buf, remote);
 	resolve_ref(buf.buf, branch_head, 0, 0);
@@ -440,10 +436,9 @@ static void merge_name(const char *remote, struct strbuf *msg)
 	if (!strcmp(remote, "FETCH_HEAD") &&
 			!access(git_path("FETCH_HEAD"), R_OK)) {
 		FILE *fp;
-		struct strbuf line;
+		struct strbuf line = STRBUF_INIT;
 		char *ptr;
 
-		strbuf_init(&line, 0);
 		fp = fopen(git_path("FETCH_HEAD"), "r");
 		if (!fp)
 			die("could not open %s for reading: %s",
@@ -540,7 +535,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	const char **args;
 	int i = 0, ret;
 	struct commit_list *j;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean;
@@ -577,7 +572,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else {
 		args = xmalloc((4 + commit_list_count(common) +
 					commit_list_count(remoteheads)) * sizeof(char *));
-		strbuf_init(&buf, 0);
 		strbuf_addf(&buf, "merge-%s", strategy);
 		args[i++] = buf.buf;
 		for (j = common; j; j = j->next)
@@ -827,7 +821,7 @@ static int evaluate_result(void)
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	const char *head_arg;
 	int flag, head_invalid = 0, i;
 	int best_cnt = -1, merge_was_ok = 0, automerge_was_ok = 0;
@@ -876,7 +870,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Traditional format never would have "-m" so it is an
 	 * additional safety measure to check for it.
 	 */
-	strbuf_init(&buf, 0);
 
 	if (!have_message && is_old_style_invocation(argc, argv)) {
 		strbuf_addstr(&merge_msg, argv[0]);
@@ -906,7 +899,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		reset_hard(remote_head->sha1, 0);
 		return 0;
 	} else {
-		struct strbuf msg;
+		struct strbuf msg = STRBUF_INIT;
 
 		/* We are invoked directly as the first-class UI. */
 		head_arg = "HEAD";
@@ -919,7 +912,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * codepath so we discard the error in this
 		 * loop.
 		 */
-		strbuf_init(&msg, 0);
 		for (i = 0; i < argc; i++)
 			merge_name(argv[i], &msg);
 		fmt_merge_msg(option_log, &msg, &merge_msg);
@@ -994,7 +986,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			!common->next &&
 			!hashcmp(common->item->object.sha1, head)) {
 		/* Again the most common case of merging one remote. */
-		struct strbuf msg;
+		struct strbuf msg = STRBUF_INIT;
 		struct object *o;
 		char hex[41];
 
@@ -1004,7 +996,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			hex,
 			find_unique_abbrev(remoteheads->item->object.sha1,
 			DEFAULT_ABBREV));
-		strbuf_init(&msg, 0);
 		strbuf_addstr(&msg, "Fast forward");
 		if (have_message)
 			strbuf_addstr(&msg,
diff --git a/builtin-remote.c b/builtin-remote.c
index 883e6d4..a4cc0fa 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -54,7 +54,7 @@ static int add(int argc, const char **argv)
 	struct string_list track = { NULL, 0, 0 };
 	const char *master = NULL;
 	struct remote *remote;
-	struct strbuf buf, buf2;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	const char *name, *url;
 	int i;
 
@@ -81,9 +81,6 @@ static int add(int argc, const char **argv)
 			remote->fetch_refspec_nr))
 		die("remote %s already exists.", name);
 
-	strbuf_init(&buf, 0);
-	strbuf_init(&buf2, 0);
-
 	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
 	if (!valid_fetch_refspec(buf2.buf))
 		die("'%s' is not a valid remote name", name);
@@ -350,7 +347,7 @@ static int rm(int argc, const char **argv)
 		OPT_END()
 	};
 	struct remote *remote;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	struct known_remotes known_remotes = { NULL, NULL };
 	struct string_list branches = { NULL, 0, 0, 1 };
 	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
@@ -366,7 +363,6 @@ static int rm(int argc, const char **argv)
 	known_remotes.to_delete = remote;
 	for_each_remote(add_known_remote, &known_remotes);
 
-	strbuf_init(&buf, 0);
 	strbuf_addf(&buf, "remote.%s", remote->name);
 	if (git_config_rename_section(buf.buf, NULL) < 1)
 		return error("Could not remove config section '%s'", buf.buf);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index facaff2..06cdeb7 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -107,8 +107,7 @@ static void show_commit(struct commit *commit)
 		putchar('\n');
 
 	if (revs.verbose_header && commit->buffer) {
-		struct strbuf buf;
-		strbuf_init(&buf, 0);
+		struct strbuf buf = STRBUF_INIT;
 		pretty_print_commit(revs.commit_format, commit,
 				    &buf, revs.abbrev, NULL, NULL,
 				    revs.date_mode, 0);
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 9aa049e..81d5a6f 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -307,19 +307,17 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	struct strbuf sb, parsed;
+	struct strbuf sb = STRBUF_INIT, parsed = STRBUF_INIT;
 	const char **usage = NULL;
 	struct option *opts = NULL;
 	int onb = 0, osz = 0, unb = 0, usz = 0;
 
-	strbuf_init(&parsed, 0);
 	strbuf_addstr(&parsed, "set --");
 	argc = parse_options(argc, argv, parseopt_opts, parseopt_usage,
 	                     PARSE_OPT_KEEP_DASHDASH);
 	if (argc < 1 || strcmp(argv[0], "--"))
 		usage_with_options(parseopt_usage, parseopt_opts);
 
-	strbuf_init(&sb, 0);
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
 		if (strbuf_getline(&sb, stdin, '\n') == EOF)
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 233eed4..306b850 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -259,11 +259,10 @@ static void join_revs(struct commit_list **list_p,
 
 static void show_one_commit(struct commit *commit, int no_name)
 {
-	struct strbuf pretty;
+	struct strbuf pretty = STRBUF_INIT;
 	const char *pretty_str = "(unavailable)";
 	struct commit_name *name = commit->util;
 
-	strbuf_init(&pretty, 0);
 	if (commit->object.parsed) {
 		pretty_print_commit(CMIT_FMT_ONELINE, commit,
 				    &pretty, 0, NULL, NULL, 0, 0);
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index c0b2130..d6e3896 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -70,14 +70,13 @@ void stripspace(struct strbuf *sb, int skip_comments)
 
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	int strip_comments = 0;
 
 	if (argc > 1 && (!strcmp(argv[1], "-s") ||
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments = 1;
 
-	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die("could not read the input");
 
diff --git a/builtin-tag.c b/builtin-tag.c
index 084970b..75f6d65 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -337,7 +337,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	unsigned char object[20], prev[20];
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
@@ -387,7 +387,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (verify)
 		return for_each_tag_name(argv, verify_tag);
 
-	strbuf_init(&buf, 0);
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
 			die("only one -F or -m option is allowed.");
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 417f972..1270836 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -297,11 +297,9 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 
 static void read_index_info(int line_termination)
 {
-	struct strbuf buf;
-	struct strbuf uq;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf uq = STRBUF_INIT;
 
-	strbuf_init(&buf, 0);
-	strbuf_init(&uq, 0);
 	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
@@ -717,10 +715,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			free((char*)p);
 	}
 	if (read_from_stdin) {
-		struct strbuf buf, nbuf;
+		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-		strbuf_init(&buf, 0);
-		strbuf_init(&nbuf, 0);
 		setup_work_tree();
 		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 			const char *p;
diff --git a/combine-diff.c b/combine-diff.c
index 42f28bc..c48ece4 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -740,9 +740,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 			/* If not a fake symlink, apply filters, e.g. autocrlf */
 			if (is_file) {
-				struct strbuf buf;
+				struct strbuf buf = STRBUF_INIT;
 
-				strbuf_init(&buf, 0);
 				if (convert_to_git(elem->path, result, len, &buf, safe_crlf)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
diff --git a/config.c b/config.c
index 18d305c..b8d289d 100644
--- a/config.c
+++ b/config.c
@@ -753,9 +753,8 @@ static int store_write_section(int fd, const char* key)
 {
 	const char *dot;
 	int i, success;
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 
-	strbuf_init(&sb, 0);
 	dot = memchr(key, '.', store.baselen);
 	if (dot) {
 		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
@@ -780,7 +779,7 @@ static int store_write_pair(int fd, const char* key, const char* value)
 	int i, success;
 	int length = strlen(key + store.baselen + 1);
 	const char *quote = "";
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 
 	/*
 	 * Check to see if the value needs to be surrounded with a dq pair.
@@ -797,7 +796,6 @@ static int store_write_pair(int fd, const char* key, const char* value)
 	if (i && value[i - 1] == ' ')
 		quote = "\"";
 
-	strbuf_init(&sb, 0);
 	strbuf_addf(&sb, "\t%.*s = %s",
 		    length, key + store.baselen + 1, quote);
 
diff --git a/convert.c b/convert.c
index a2655bd..00b3a89 100644
--- a/convert.c
+++ b/convert.c
@@ -280,7 +280,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	 * (child --> cmd) --> us
 	 */
 	int ret = 1;
-	struct strbuf nbuf;
+	struct strbuf nbuf = STRBUF_INIT;
 	struct async async = { 0, };
 	struct filter_params params;
 
@@ -297,7 +297,6 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (start_async(&async))
 		return 0;	/* error was already reported */
 
-	strbuf_init(&nbuf, 0);
 	if (strbuf_read(&nbuf, async.out, len) < 0) {
 		error("read from external filter %s failed", cmd);
 		ret = 0;
diff --git a/diff.c b/diff.c
index 5b8e64d..321218c 100644
--- a/diff.c
+++ b/diff.c
@@ -217,9 +217,8 @@ static char *quote_two(const char *one, const char *two)
 {
 	int need_one = quote_c_style(one, NULL, NULL, 1);
 	int need_two = quote_c_style(two, NULL, NULL, 1);
-	struct strbuf res;
+	struct strbuf res = STRBUF_INIT;
 
-	strbuf_init(&res, 0);
 	if (need_one + need_two) {
 		strbuf_addch(&res, '"');
 		quote_c_style(one, &res, NULL, 1);
@@ -682,7 +681,7 @@ static char *pprint_rename(const char *a, const char *b)
 {
 	const char *old = a;
 	const char *new = b;
-	struct strbuf name;
+	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
 	int len_a = strlen(a);
 	int len_b = strlen(b);
@@ -690,7 +689,6 @@ static char *pprint_rename(const char *a, const char *b)
 	int qlen_a = quote_c_style(a, NULL, NULL, 0);
 	int qlen_b = quote_c_style(b, NULL, NULL, 0);
 
-	strbuf_init(&name, 0);
 	if (qlen_a || qlen_b) {
 		quote_c_style(a, &name, NULL, 0);
 		strbuf_addstr(&name, " => ");
@@ -833,8 +831,7 @@ static void fill_print_name(struct diffstat_file *file)
 		return;
 
 	if (!file->is_renamed) {
-		struct strbuf buf;
-		strbuf_init(&buf, 0);
+		struct strbuf buf = STRBUF_INIT;
 		if (quote_c_style(file->name, &buf, NULL, 0)) {
 			pname = strbuf_detach(&buf, NULL);
 		} else {
@@ -1803,10 +1800,9 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 
 static int populate_from_stdin(struct diff_filespec *s)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	size_t size = 0;
 
-	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, 0, 0) < 0)
 		return error("error while reading from stdin %s",
 				     strerror(errno));
@@ -1858,7 +1854,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 
 	if (!s->sha1_valid ||
 	    reuse_worktree_file(s->path, s->sha1, 0)) {
-		struct strbuf buf;
+		struct strbuf buf = STRBUF_INIT;
 		struct stat st;
 		int fd;
 
@@ -1901,7 +1897,6 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		/*
 		 * Convert from working tree format to canonical git format
 		 */
-		strbuf_init(&buf, 0);
 		if (convert_to_git(s->path, s->data, s->size, &buf, safe_crlf)) {
 			size_t size = 0;
 			munmap(s->data, s->size);
diff --git a/editor.c b/editor.c
index eebc3e9..4d469d0 100644
--- a/editor.c
+++ b/editor.c
@@ -26,9 +26,8 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		int i = 0;
 		int failed;
 		const char *args[6];
-		struct strbuf arg0;
+		struct strbuf arg0 = STRBUF_INIT;
 
-		strbuf_init(&arg0, 0);
 		if (strcspn(editor, "$ \t'") != len) {
 			/* there are specials */
 			strbuf_addf(&arg0, "%s \"$@\"", editor);
diff --git a/exec_cmd.c b/exec_cmd.c
index ce6741e..cdd35f9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -59,9 +59,7 @@ static void add_path(struct strbuf *out, const char *path)
 void setup_path(void)
 {
 	const char *old_path = getenv("PATH");
-	struct strbuf new_path;
-
-	strbuf_init(&new_path, 0);
+	struct strbuf new_path = STRBUF_INIT;
 
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
diff --git a/fsck.c b/fsck.c
index 797e317..0cf5f01 100644
--- a/fsck.c
+++ b/fsck.c
@@ -307,9 +307,8 @@ int fsck_error_function(struct object *obj, int type, const char *fmt, ...)
 {
 	va_list ap;
 	int len;
-	struct strbuf sb;
+	struct strbuf sb = STRBUF_INIT;
 
-	strbuf_init(&sb, 0);
 	strbuf_addf(&sb, "object %s:", obj->sha1?sha1_to_hex(obj->sha1):"(null)");
 
 	va_start(ap, fmt);
diff --git a/git.c b/git.c
index f4b0cf6..89feb0b 100644
--- a/git.c
+++ b/git.c
@@ -389,10 +389,9 @@ static void handle_internal_command(int argc, const char **argv)
 
 static void execv_dashed_external(const char **argv)
 {
-	struct strbuf cmd;
+	struct strbuf cmd = STRBUF_INIT;
 	const char *tmp;
 
-	strbuf_init(&cmd, 0);
 	strbuf_addf(&cmd, "git-%s", argv[0]);
 
 	/*
diff --git a/graph.c b/graph.c
index 5f82170..162a516 100644
--- a/graph.c
+++ b/graph.c
@@ -1010,14 +1010,12 @@ int graph_is_commit_finished(struct git_graph const *graph)
 
 void graph_show_commit(struct git_graph *graph)
 {
-	struct strbuf msgbuf;
+	struct strbuf msgbuf = STRBUF_INIT;
 	int shown_commit_line = 0;
 
 	if (!graph)
 		return;
 
-	strbuf_init(&msgbuf, 0);
-
 	while (!shown_commit_line) {
 		shown_commit_line = graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
@@ -1031,12 +1029,11 @@ void graph_show_commit(struct git_graph *graph)
 
 void graph_show_oneline(struct git_graph *graph)
 {
-	struct strbuf msgbuf;
+	struct strbuf msgbuf = STRBUF_INIT;
 
 	if (!graph)
 		return;
 
-	strbuf_init(&msgbuf, 0);
 	graph_next_line(graph, &msgbuf);
 	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
 	strbuf_release(&msgbuf);
@@ -1044,12 +1041,11 @@ void graph_show_oneline(struct git_graph *graph)
 
 void graph_show_padding(struct git_graph *graph)
 {
-	struct strbuf msgbuf;
+	struct strbuf msgbuf = STRBUF_INIT;
 
 	if (!graph)
 		return;
 
-	strbuf_init(&msgbuf, 0);
 	graph_padding_line(graph, &msgbuf);
 	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
 	strbuf_release(&msgbuf);
@@ -1057,7 +1053,7 @@ void graph_show_padding(struct git_graph *graph)
 
 int graph_show_remainder(struct git_graph *graph)
 {
-	struct strbuf msgbuf;
+	struct strbuf msgbuf = STRBUF_INIT;
 	int shown = 0;
 
 	if (!graph)
@@ -1066,7 +1062,6 @@ int graph_show_remainder(struct git_graph *graph)
 	if (graph_is_commit_finished(graph))
 		return 0;
 
-	strbuf_init(&msgbuf, 0);
 	for (;;) {
 		graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
diff --git a/hash-object.c b/hash-object.c
index a4d127c..20937ff 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -34,10 +34,8 @@ static void hash_object(const char *path, const char *type, int write_object,
 
 static void hash_stdin_paths(const char *type, int write_objects)
 {
-	struct strbuf buf, nbuf;
+	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-	strbuf_init(&buf, 0);
-	strbuf_init(&nbuf, 0);
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
diff --git a/imap-send.c b/imap-send.c
index 700c332..fc0aeb5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1263,10 +1263,9 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data, int *uid)
 
 static int read_message(FILE *f, struct msg_data *msg)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 
 	memset(msg, 0, sizeof(*msg));
-	strbuf_init(&buf, 0);
 
 	do {
 		if (strbuf_fread(&buf, CHUNKSIZE, f) <= 0)
diff --git a/log-tree.c b/log-tree.c
index 2c1f3e6..cec3c06 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -252,7 +252,7 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 
 void show_log(struct rev_info *opt)
 {
-	struct strbuf msgbuf;
+	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
@@ -381,7 +381,6 @@ void show_log(struct rev_info *opt)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	strbuf_init(&msgbuf, 0);
 	if (need_8bit_cte >= 0)
 		need_8bit_cte = has_non_ascii(opt->add_signoff);
 	pretty_print_commit(opt->commit_format, commit, &msgbuf,
diff --git a/merge-recursive.c b/merge-recursive.c
index 4358ecf..96f7334 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -497,8 +497,7 @@ static void update_file_flags(struct merge_options *o,
 		if (type != OBJ_BLOB)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 		if (S_ISREG(mode)) {
-			struct strbuf strbuf;
-			strbuf_init(&strbuf, 0);
+			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(path, buf, size, &strbuf)) {
 				free(buf);
 				size = strbuf.len;
diff --git a/mktag.c b/mktag.c
index 0b34341..ba3d495 100644
--- a/mktag.c
+++ b/mktag.c
@@ -153,7 +153,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 int main(int argc, char **argv)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
@@ -161,7 +161,6 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 
-	strbuf_init(&buf, 0);
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die("could not read from stdin");
 	}
diff --git a/mktree.c b/mktree.c
index e0da110..514fd9b 100644
--- a/mktree.c
+++ b/mktree.c
@@ -65,8 +65,8 @@ static const char mktree_usage[] = "git-mktree [-z]";
 
 int main(int ac, char **av)
 {
-	struct strbuf sb;
-	struct strbuf p_uq;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf p_uq = STRBUF_INIT;
 	unsigned char sha1[20];
 	int line_termination = '\n';
 
@@ -82,8 +82,6 @@ int main(int ac, char **av)
 		av++;
 	}
 
-	strbuf_init(&sb, 0);
-	strbuf_init(&p_uq, 0);
 	while (strbuf_getline(&sb, stdin, line_termination) != EOF) {
 		char *ptr, *ntr;
 		unsigned mode;
diff --git a/pretty.c b/pretty.c
index fd6924a..9e125ef 100644
--- a/pretty.c
+++ b/pretty.c
@@ -234,7 +234,7 @@ static char *get_header(const struct commit *commit, const char *key)
 
 static char *replace_encoding_header(char *buf, const char *encoding)
 {
-	struct strbuf tmp;
+	struct strbuf tmp = STRBUF_INIT;
 	size_t start, len;
 	char *cp = buf;
 
@@ -250,7 +250,6 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 		return buf; /* should not happen but be defensive */
 	len = cp + 1 - (buf + start);
 
-	strbuf_init(&tmp, 0);
 	strbuf_attach(&tmp, buf, strlen(buf), strlen(buf) + 1);
 	if (is_encoding_utf8(encoding)) {
 		/* we have re-coded to UTF-8; drop the header */
diff --git a/read-cache.c b/read-cache.c
index 901064b..7dfdda6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1446,9 +1446,8 @@ int write_index(const struct index_state *istate, int newfd)
 
 	/* Write extension data here */
 	if (istate->cache_tree) {
-		struct strbuf sb;
+		struct strbuf sb = STRBUF_INIT;
 
-		strbuf_init(&sb, 0);
 		cache_tree_write(&sb, istate->cache_tree);
 		err = write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sb.len) < 0
 			|| ce_write(&c, newfd, sb.buf, sb.len) < 0;
diff --git a/remote.c b/remote.c
index a2d7ab1..d5efadd 100644
--- a/remote.c
+++ b/remote.c
@@ -245,7 +245,7 @@ static void read_branches_file(struct remote *remote)
 {
 	const char *slash = strchr(remote->name, '/');
 	char *frag;
-	struct strbuf branch;
+	struct strbuf branch = STRBUF_INIT;
 	int n = slash ? slash - remote->name : 1000;
 	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
@@ -283,7 +283,6 @@ static void read_branches_file(struct remote *remote)
 	 * #branch specified.  The "master" (or specified) branch is
 	 * fetched and stored in the local branch of the same name.
 	 */
-	strbuf_init(&branch, 0);
 	frag = strchr(p, '#');
 	if (frag) {
 		*(frag++) = '\0';
diff --git a/rerere.c b/rerere.c
index 121f911..5bb5316 100644
--- a/rerere.c
+++ b/rerere.c
@@ -79,7 +79,7 @@ static int handle_file(const char *path,
 	enum {
 		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL,
 	} hunk = RR_CONTEXT;
-	struct strbuf one, two;
+	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	FILE *f = fopen(path, "r");
 	FILE *out = NULL;
 
@@ -97,8 +97,6 @@ static int handle_file(const char *path,
 	if (sha1)
 		git_SHA1_Init(&ctx);
 
-	strbuf_init(&one, 0);
-	strbuf_init(&two,  0);
 	while (fgets(buf, sizeof(buf), f)) {
 		if (!prefixcmp(buf, "<<<<<<< ")) {
 			if (hunk != RR_CONTEXT)
diff --git a/sha1_file.c b/sha1_file.c
index 00049b5..4b9ce6d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2385,8 +2385,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	 * Convert blobs to git internal format
 	 */
 	if ((type == OBJ_BLOB) && path) {
-		struct strbuf nbuf;
-		strbuf_init(&nbuf, 0);
+		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(path, buf, size, &nbuf,
 		                   write_object ? safe_crlf : 0)) {
 			buf = strbuf_detach(&nbuf, &size);
@@ -2410,8 +2409,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
 	size_t size = xsize_t(st->st_size);
 
 	if (!S_ISREG(st->st_mode)) {
-		struct strbuf sbuf;
-		strbuf_init(&sbuf, 0);
+		struct strbuf sbuf = STRBUF_INIT;
 		if (strbuf_read(&sbuf, fd, 4096) >= 0)
 			ret = index_mem(sha1, sbuf.buf, sbuf.len, write_object,
 					type, path);
diff --git a/walker.c b/walker.c
index 0e68ee6..6b4cf70 100644
--- a/walker.c
+++ b/walker.c
@@ -215,9 +215,8 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 int walker_targets_stdin(char ***target, const char ***write_ref)
 {
 	int targets = 0, targets_alloc = 0;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	*target = NULL; *write_ref = NULL;
-	strbuf_init(&buf, 0);
 	while (1) {
 		char *rf_one = NULL;
 		char *tg_one;
diff --git a/ws.c b/ws.c
index 7a7ff13..b1efcd9 100644
--- a/ws.c
+++ b/ws.c
@@ -99,8 +99,7 @@ unsigned whitespace_rule(const char *pathname)
 /* The returned string should be freed by the caller. */
 char *whitespace_error_string(unsigned ws)
 {
-	struct strbuf err;
-	strbuf_init(&err, 0);
+	struct strbuf err = STRBUF_INIT;
 	if (ws & WS_TRAILING_SPACE)
 		strbuf_addstr(&err, "trailing whitespace");
 	if (ws & WS_SPACE_BEFORE_TAB) {
diff --git a/wt-status.c b/wt-status.c
index ad8aac5..d617967 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -103,10 +103,8 @@ static void wt_status_print_filepair(struct wt_status *s,
 {
 	const char *c = color(t);
 	const char *one, *two;
-	struct strbuf onebuf, twobuf;
+	struct strbuf onebuf = STRBUF_INIT, twobuf = STRBUF_INIT;
 
-	strbuf_init(&onebuf, 0);
-	strbuf_init(&twobuf, 0);
 	one = quote_path(p->one->path, -1, &onebuf, s->prefix);
 	two = quote_path(p->two->path, -1, &twobuf, s->prefix);
 
@@ -190,9 +188,8 @@ static void wt_status_print_changed_cb(struct diff_queue_struct *q,
 static void wt_status_print_initial(struct wt_status *s)
 {
 	int i;
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 
-	strbuf_init(&buf, 0);
 	if (active_nr) {
 		s->commitable = 1;
 		wt_status_print_cached_header(s);
@@ -267,9 +264,7 @@ static void wt_status_print_untracked(struct wt_status *s)
 	struct dir_struct dir = { 0, };
 	int i;
 	int shown_header = 0;
-	struct strbuf buf;
-
-	strbuf_init(&buf, 0);
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!s->untracked) {
 		dir.show_other_directories = 1;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 662e604..99b143a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -140,13 +140,12 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
 {
 	int ret;
-	struct xdiff_emit_state state = { 0, };
+	struct xdiff_emit_state state = { 0, 0, STRBUF_INIT };
 
 	state.consume = fn;
 	state.consume_callback_data = consume_callback_data;
 	xecb->outf = xdiff_outf;
 	xecb->priv = &state;
-	strbuf_init(&state.remainder, 0);
 	ret = xdi_diff(mf1, mf2, xpp, xecfg, xecb);
 	strbuf_release(&state.remainder);
 	return ret;
-- 
1.6.0.2.468.gd5b83
