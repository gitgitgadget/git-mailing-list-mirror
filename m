From: Jeff King <peff@peff.net>
Subject: [PATCH 17/17] memoize common git-path "constant" files
Date: Mon, 10 Aug 2015 05:38:57 -0400
Message-ID: <20150810093857.GQ30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:39:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjXz-00062J-HG
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbbHJJjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:39:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:42868 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753627AbbHJJjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:39:03 -0400
Received: (qmail 31123 invoked by uid 102); 10 Aug 2015 09:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:39:03 -0500
Received: (qmail 3305 invoked by uid 107); 10 Aug 2015 09:39:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:39:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:38:57 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275583>

One of the most common uses of git_path() is to pass a
constant, like git_path("MERGE_MSG"). This has two
drawbacks:

  1. The return value is a static buffer, and the lifetime
     is dependent on other calls to git_path, etc.

  2. There's no compile-time checking of the pathname. This
     is OK for a one-off (after all, we have to spell it
     correctly at least once), but many of these constant
     strings appear throughout the code.

This patch introduces a series of functions to "memoize"
these strings, which are essentially globals for the
lifetime of the program. We compute the value once, take
ownership of the buffer, and return the cached value for
subsequent calls.  cache.h provides a helper macro for
defining these functions as one-liners, and defines a few
common ones for global use.

Using a macro is a little bit gross, but it does nicely
document the purpose of the functions. If we need to touch
them all later (e.g., because we learned how to change the
git_dir variable at runtime, and need to invalidate all of
the stored values), it will be much easier to have the
complete list.

Note that the shared-global functions have separate, manual
declarations. We could do something clever with the macros
(e.g., expand it to a declaration in some places, and a
declaration _and_ a definition in path.c). But there aren't
that many, and it's probably better to stay away from
too-magical macros.

Likewise, if we abandon the C preprocessor in favor of
generating these with a script, we could get much fancier.
E.g., normalizing "FOO/BAR-BAZ" into "git_path_foo_bar_baz".
But the small amount of saved typing is probably not worth
the resulting confusion to readers who want to grep for the
function's definition.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is probably the most contentious, as it has very far-reaching
effects. But it really reduces the number of sites that need audited by
quite a lot.

 attr.c                                 |  4 +-
 bisect.c                               |  7 ++-
 branch.c                               | 14 +++---
 builtin/blame.c                        |  7 ++-
 builtin/commit.c                       | 32 ++++++-------
 builtin/fetch.c                        |  4 +-
 builtin/merge.c                        | 30 ++++++------
 builtin/reset.c                        |  2 +-
 cache.h                                | 26 ++++++++++
 contrib/examples/builtin-fetch--tool.c |  4 +-
 dir.c                                  |  4 +-
 fetch-pack.c                           |  2 +-
 path.c                                 | 10 ++++
 rerere.c                               | 19 ++++----
 sequencer.c                            | 87 ++++++++++++++++------------------
 shallow.c                              | 10 ++--
 wt-status.c                            |  8 ++--
 17 files changed, 151 insertions(+), 119 deletions(-)

diff --git a/attr.c b/attr.c
index 8f2ac6c..086c08d 100644
--- a/attr.c
+++ b/attr.c
@@ -490,6 +490,8 @@ static int git_attr_system(void)
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
 
+static GIT_PATH_FUNC(git_path_info_attributes, INFOATTRIBUTES_FILE)
+
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
@@ -531,7 +533,7 @@ static void bootstrap_attr_stack(void)
 		debug_push(elem);
 	}
 
-	elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+	elem = read_attr_from_file(git_path_info_attributes(), 1);
 	if (!elem)
 		elem = xcalloc(1, sizeof(*elem));
 	elem->origin = NULL;
diff --git a/bisect.c b/bisect.c
index 03d5cd9..7a6498c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -420,10 +420,13 @@ static int read_bisect_refs(void)
 	return for_each_ref_in("refs/bisect/", register_ref, NULL);
 }
 
+static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+
 static void read_bisect_paths(struct argv_array *array)
 {
 	struct strbuf str = STRBUF_INIT;
-	const char *filename = git_path("BISECT_NAMES");
+	const char *filename = git_path_bisect_names();
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp)
@@ -644,7 +647,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 
 static int is_expected_rev(const struct object_id *oid)
 {
-	const char *filename = git_path("BISECT_EXPECTED_REV");
+	const char *filename = git_path_bisect_expected_rev();
 	struct stat st;
 	struct strbuf str = STRBUF_INIT;
 	FILE *fp;
diff --git a/branch.c b/branch.c
index b002435..e283683 100644
--- a/branch.c
+++ b/branch.c
@@ -302,11 +302,11 @@ void create_branch(const char *head,
 
 void remove_branch_state(void)
 {
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("REVERT_HEAD"));
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_RR"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
-	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path_cherry_pick_head());
+	unlink(git_path_revert_head());
+	unlink(git_path_merge_head());
+	unlink(git_path_merge_rr());
+	unlink(git_path_merge_msg());
+	unlink(git_path_merge_mode());
+	unlink(git_path_squash_msg());
 }
diff --git a/builtin/blame.c b/builtin/blame.c
index 04e4864..4db01c1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2227,20 +2227,19 @@ static struct commit_list **append_parent(struct commit_list **tail, const unsig
 static void append_merge_parents(struct commit_list **tail)
 {
 	int merge_head;
-	const char *merge_head_file = git_path("MERGE_HEAD");
 	struct strbuf line = STRBUF_INIT;
 
-	merge_head = open(merge_head_file, O_RDONLY);
+	merge_head = open(git_path_merge_head(), O_RDONLY);
 	if (merge_head < 0) {
 		if (errno == ENOENT)
 			return;
-		die("cannot open '%s' for reading", merge_head_file);
+		die("cannot open '%s' for reading", git_path_merge_head());
 	}
 
 	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
 		unsigned char sha1[20];
 		if (line.len < 40 || get_sha1_hex(line.buf, sha1))
-			die("unknown line in '%s': %s", merge_head_file, line.buf);
+			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
 		tail = append_parent(tail, sha1);
 	}
 	close(merge_head);
diff --git a/builtin/commit.c b/builtin/commit.c
index 7314f33..4cbd5ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -166,9 +166,9 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 
 static void determine_whence(struct wt_status *s)
 {
-	if (file_exists(git_path("MERGE_HEAD")))
+	if (file_exists(git_path_merge_head()))
 		whence = FROM_MERGE;
-	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	else if (file_exists(git_path_cherry_pick_head())) {
 		whence = FROM_CHERRY_PICK;
 		if (file_exists(git_path(SEQ_DIR)))
 			sequencer_in_use = 1;
@@ -725,12 +725,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 = "message";
-	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
+	} else if (!stat(git_path_merge_msg(), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
 		hook_arg1 = "merge";
-	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
+	} else if (!stat(git_path_squash_msg(), &statbuf)) {
+		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
 		hook_arg1 = "squash";
 	} else if (template_file) {
@@ -1684,10 +1684,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = "commit (merge)";
 		pptr = &commit_list_insert(current_head, pptr)->next;
-		fp = fopen(git_path("MERGE_HEAD"), "r");
+		fp = fopen(git_path_merge_head(), "r");
 		if (fp == NULL)
 			die_errno(_("could not open '%s' for reading"),
-				  git_path("MERGE_HEAD"));
+				  git_path_merge_head());
 		while (strbuf_getline(&m, fp, '\n') != EOF) {
 			struct commit *parent;
 
@@ -1698,8 +1698,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		}
 		fclose(fp);
 		strbuf_release(&m);
-		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
-			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
+		if (!stat(git_path_merge_mode(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_merge_mode(), 0) < 0)
 				die_errno(_("could not read MERGE_MODE"));
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward = 0;
@@ -1775,12 +1775,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 	ref_transaction_free(transaction);
 
-	unlink(git_path("CHERRY_PICK_HEAD"));
-	unlink(git_path("REVERT_HEAD"));
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
-	unlink(git_path("SQUASH_MSG"));
+	unlink(git_path_cherry_pick_head());
+	unlink(git_path_revert_head());
+	unlink(git_path_merge_head());
+	unlink(git_path_merge_msg());
+	unlink(git_path_merge_mode());
+	unlink(git_path_squash_msg());
 
 	if (commit_index_files())
 		die (_("Repository has been updated, but unable to write\n"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 34b6f5e..df16d0a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -591,7 +591,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
+	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
 
 	fp = fopen(filename, "a");
@@ -834,7 +834,7 @@ static void check_not_current_branch(struct ref *ref_map)
 
 static int truncate_fetch_head(void)
 {
-	const char *filename = git_path("FETCH_HEAD");
+	const char *filename = git_path_fetch_head();
 	FILE *fp = fopen(filename, "w");
 
 	if (!fp)
diff --git a/builtin/merge.c b/builtin/merge.c
index 85c54dc..a0edaca 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -231,9 +231,9 @@ static struct option builtin_merge_options[] = {
 /* Cleans up metadata that is uninteresting after a succeeded merge. */
 static void drop_save(void)
 {
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("MERGE_MODE"));
+	unlink(git_path_merge_head());
+	unlink(git_path_merge_msg());
+	unlink(git_path_merge_mode());
 }
 
 static int save_state(unsigned char *stash)
@@ -338,7 +338,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 	struct pretty_print_context ctx = {0};
 
 	printf(_("Squash commit -- not updating HEAD\n"));
-	filename = git_path("SQUASH_MSG");
+	filename = git_path_squash_msg();
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not write to '%s'"), filename);
@@ -754,7 +754,7 @@ static void add_strategies(const char *string, unsigned attr)
 
 static void write_merge_msg(struct strbuf *msg)
 {
-	const char *filename = git_path("MERGE_MSG");
+	const char *filename = git_path_merge_msg();
 	int fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"),
@@ -766,7 +766,7 @@ static void write_merge_msg(struct strbuf *msg)
 
 static void read_merge_msg(struct strbuf *msg)
 {
-	const char *filename = git_path("MERGE_MSG");
+	const char *filename = git_path_merge_msg();
 	strbuf_reset(msg);
 	if (strbuf_read_file(msg, filename, 0) < 0)
 		die_errno(_("Could not read from '%s'"), filename);
@@ -799,10 +799,10 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	write_merge_msg(&msg);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
-			    git_path("MERGE_MSG"), "merge", NULL))
+			    git_path_merge_msg(), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
-		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
+		if (launch_editor(git_path_merge_msg(), NULL, NULL))
 			abort_commit(remoteheads, NULL);
 	}
 	read_merge_msg(&msg);
@@ -865,7 +865,7 @@ static int suggest_conflicts(void)
 	FILE *fp;
 	struct strbuf msgbuf = STRBUF_INIT;
 
-	filename = git_path("MERGE_MSG");
+	filename = git_path_merge_msg();
 	fp = fopen(filename, "a");
 	if (!fp)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -967,7 +967,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 		}
 		strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
 	}
-	filename = git_path("MERGE_HEAD");
+	filename = git_path_merge_head();
 	fd = open(filename, O_WRONLY | O_CREAT, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -977,7 +977,7 @@ static void write_merge_state(struct commit_list *remoteheads)
 	strbuf_addch(&merge_msg, '\n');
 	write_merge_msg(&merge_msg);
 
-	filename = git_path("MERGE_MODE");
+	filename = git_path_merge_mode();
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
@@ -1070,7 +1070,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 	if (!merge_names)
 		merge_names = &fetch_head_file;
 
-	filename = git_path("FETCH_HEAD");
+	filename = git_path_fetch_head();
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
 		die_errno(_("could not open '%s' for reading"), filename);
@@ -1204,7 +1204,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		int nargc = 2;
 		const char *nargv[] = {"reset", "--merge", NULL};
 
-		if (!file_exists(git_path("MERGE_HEAD")))
+		if (!file_exists(git_path_merge_head()))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
 
 		/* Invoke 'git reset --merge' */
@@ -1215,7 +1215,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (read_cache_unmerged())
 		die_resolve_conflict("merge");
 
-	if (file_exists(git_path("MERGE_HEAD"))) {
+	if (file_exists(git_path_merge_head())) {
 		/*
 		 * There is no unmerged entry, don't advise 'git
 		 * add/rm <file>', just 'git commit'.
@@ -1226,7 +1226,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		else
 			die(_("You have not concluded your merge (MERGE_HEAD exists)."));
 	}
-	if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
+	if (file_exists(git_path_cherry_pick_head())) {
 		if (advice_resolve_conflict)
 			die(_("You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 			    "Please, commit your changes before you merge."));
diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..c503e75 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -36,7 +36,7 @@ static const char *reset_type_names[] = {
 
 static inline int is_merge(void)
 {
-	return !access(git_path("MERGE_HEAD"), F_OK);
+	return !access(git_path_merge_head(), F_OK);
 }
 
 static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
diff --git a/cache.h b/cache.h
index 7a4fa90..402521e 100644
--- a/cache.h
+++ b/cache.h
@@ -736,6 +736,32 @@ extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 extern void report_linked_checkout_garbage(void);
 
 /*
+ * You can define a static memoized git path like:
+ *
+ *    static GIT_PATH_FUNC(git_path_foo, "FOO");
+ *
+ * or use one of the global ones below.
+ */
+#define GIT_PATH_FUNC(func, filename) \
+	const char *func(void) \
+	{ \
+		static char *ret; \
+		if (!ret) \
+			ret = git_pathdup(filename); \
+		return ret; \
+	}
+
+const char *git_path_cherry_pick_head(void);
+const char *git_path_revert_head(void);
+const char *git_path_squash_msg(void);
+const char *git_path_merge_msg(void);
+const char *git_path_merge_rr(void);
+const char *git_path_merge_mode(void);
+const char *git_path_merge_head(void);
+const char *git_path_fetch_head(void);
+const char *git_path_shallow(void);
+
+/*
  * Return the name of the file in the local object database that would
  * be used to store a loose object with the specified sha1.  The
  * return value is a pointer to a statically allocated buffer that is
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index ee19166..a3eb19d 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -516,7 +516,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 
 		if (argc != 8)
 			return error("append-fetch-head takes 6 args");
-		filename = git_path("FETCH_HEAD");
+		filename = git_path_fetch_head();
 		fp = fopen(filename, "a");
 		if (!fp)
 			return error("cannot open %s: %s", filename, strerror(errno));
@@ -534,7 +534,7 @@ int cmd_fetch__tool(int argc, const char **argv, const char *prefix)
 
 		if (argc != 5)
 			return error("fetch-native-store takes 3 args");
-		filename = git_path("FETCH_HEAD");
+		filename = git_path_fetch_head();
 		fp = fopen(filename, "a");
 		if (!fp)
 			return error("cannot open %s: %s", filename, strerror(errno));
diff --git a/dir.c b/dir.c
index 1d42811..1ac8d5d 100644
--- a/dir.c
+++ b/dir.c
@@ -2185,6 +2185,8 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 	return remove_dir_recurse(path, flag, NULL);
 }
 
+static GIT_PATH_FUNC(git_path_info_exclude, "info/exclude")
+
 void setup_standard_excludes(struct dir_struct *dir)
 {
 	const char *path;
@@ -2199,7 +2201,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 					 dir->untracked ? &dir->ss_excludes_file : NULL);
 
 	/* per repository user preference */
-	path = git_path("info/exclude");
+	path = git_path_info_exclude();
 	if (!access_or_warn(path, R_OK, 0))
 		add_excludes_from_file_1(dir, path,
 					 dir->untracked ? &dir->ss_info_exclude : NULL);
diff --git a/fetch-pack.c b/fetch-pack.c
index a136772..820251a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -948,7 +948,7 @@ static void update_shallow(struct fetch_pack_args *args,
 
 	if (args->depth > 0 && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
-			unlink_or_warn(git_path("shallow"));
+			unlink_or_warn(git_path_shallow());
 			rollback_lock_file(&shallow_lock);
 		} else
 			commit_lock_file(&shallow_lock);
diff --git a/path.c b/path.c
index 94d7ec2..95acbaf 100644
--- a/path.c
+++ b/path.c
@@ -933,3 +933,13 @@ char *xdg_config_home(const char *filename)
 		return mkpathdup("%s/.config/git/%s", home, filename);
 	return NULL;
 }
+
+GIT_PATH_FUNC(git_path_cherry_pick_head, "CHERRY_PICK_HEAD")
+GIT_PATH_FUNC(git_path_revert_head, "REVERT_HEAD")
+GIT_PATH_FUNC(git_path_squash_msg, "SQUASH_MSG")
+GIT_PATH_FUNC(git_path_merge_msg, "MERGE_MSG")
+GIT_PATH_FUNC(git_path_merge_rr, "MERGE_RR")
+GIT_PATH_FUNC(git_path_merge_mode, "MERGE_MODE")
+GIT_PATH_FUNC(git_path_merge_head, "MERGE_HEAD")
+GIT_PATH_FUNC(git_path_fetch_head, "FETCH_HEAD")
+GIT_PATH_FUNC(git_path_shallow, "shallow")
diff --git a/rerere.c b/rerere.c
index 94aea9a..6a517aa 100644
--- a/rerere.c
+++ b/rerere.c
@@ -20,8 +20,6 @@ static int rerere_enabled = -1;
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
 
-static char *merge_rr_path;
-
 const char *rerere_path(const char *hex, const char *file)
 {
 	return git_path("rr-cache/%s/%s", hex, file);
@@ -37,7 +35,7 @@ static void read_rr(struct string_list *rr)
 {
 	unsigned char sha1[20];
 	char buf[PATH_MAX];
-	FILE *in = fopen(merge_rr_path, "r");
+	FILE *in = fopen(git_path_merge_rr(), "r");
 	if (!in)
 		return;
 	while (fread(buf, 40, 1, in) == 1) {
@@ -577,21 +575,21 @@ static void git_rerere_config(void)
 	git_config(git_default_config, NULL);
 }
 
+static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
+
 static int is_rerere_enabled(void)
 {
-	const char *rr_cache;
 	int rr_cache_exists;
 
 	if (!rerere_enabled)
 		return 0;
 
-	rr_cache = git_path("rr-cache");
-	rr_cache_exists = is_directory(rr_cache);
+	rr_cache_exists = is_directory(git_path_rr_cache());
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
-	if (!rr_cache_exists && mkdir_in_gitdir(rr_cache))
-		die("Could not create directory %s", rr_cache);
+	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
+		die("Could not create directory %s", git_path_rr_cache());
 	return 1;
 }
 
@@ -605,8 +603,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	merge_rr_path = git_pathdup("MERGE_RR");
-	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
+	fd = hold_lock_file_for_update(&write_lock, git_path_merge_rr(),
 				       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
 	return fd;
@@ -741,5 +738,5 @@ void rerere_clear(struct string_list *merge_rr)
 		if (!has_rerere_resolution(name))
 			unlink_rr_item(name);
 	}
-	unlink_or_warn(git_path("MERGE_RR"));
+	unlink_or_warn(git_path_merge_rr());
 }
diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..147adfa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,6 +21,11 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
+static GIT_PATH_FUNC(git_path_todo_file, SEQ_TODO_FILE)
+static GIT_PATH_FUNC(git_path_opts_file, SEQ_OPTS_FILE)
+static GIT_PATH_FUNC(git_path_seq_dir, SEQ_DIR)
+static GIT_PATH_FUNC(git_path_head_file, SEQ_HEAD_FILE)
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -186,7 +191,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path("CHERRY_PICK_HEAD"));
+		unlink(git_path_cherry_pick_head());
 		return;
 	}
 
@@ -467,7 +472,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
-	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, allow;
 
@@ -537,8 +541,6 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * reverse of it if we are revert.
 	 */
 
-	defmsg = git_pathdup("MERGE_MSG");
-
 	if (opts->action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
@@ -585,12 +587,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
-		write_message(&msgbuf, defmsg);
+		write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		write_message(&msgbuf, defmsg);
+		write_message(&msgbuf, git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
@@ -628,11 +630,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(defmsg, opts, allow);
+		res = run_git_commit(git_path_merge_msg(), opts, allow);
 
 leave:
 	free_message(commit, &msg);
-	free(defmsg);
 
 	return res;
 }
@@ -756,24 +757,23 @@ static int parse_insn_buffer(char *buf, struct commit_list **todo_list,
 static void read_populate_todo(struct commit_list **todo_list,
 			struct replay_opts *opts)
 {
-	const char *todo_file = git_path(SEQ_TODO_FILE);
 	struct strbuf buf = STRBUF_INIT;
 	int fd, res;
 
-	fd = open(todo_file, O_RDONLY);
+	fd = open(git_path_todo_file(), O_RDONLY);
 	if (fd < 0)
-		die_errno(_("Could not open %s"), todo_file);
+		die_errno(_("Could not open %s"), git_path_todo_file());
 	if (strbuf_read(&buf, fd, 0) < 0) {
 		close(fd);
 		strbuf_release(&buf);
-		die(_("Could not read %s."), todo_file);
+		die(_("Could not read %s."), git_path_todo_file());
 	}
 	close(fd);
 
 	res = parse_insn_buffer(buf.buf, todo_list, opts);
 	strbuf_release(&buf);
 	if (res)
-		die(_("Unusable instruction sheet: %s"), todo_file);
+		die(_("Unusable instruction sheet: %s"), git_path_todo_file());
 }
 
 static int populate_opts_cb(const char *key, const char *value, void *data)
@@ -813,12 +813,10 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static void read_populate_opts(struct replay_opts **opts_ptr)
 {
-	const char *opts_file = git_path(SEQ_OPTS_FILE);
-
-	if (!file_exists(opts_file))
+	if (!file_exists(git_path_opts_file()))
 		return;
-	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
-		die(_("Malformed options sheet: %s"), opts_file);
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts_ptr) < 0)
+		die(_("Malformed options sheet: %s"), git_path_opts_file());
 }
 
 static void walk_revs_populate_todo(struct commit_list **todo_list,
@@ -836,31 +834,29 @@ static void walk_revs_populate_todo(struct commit_list **todo_list,
 
 static int create_seq_dir(void)
 {
-	const char *seq_dir = git_path(SEQ_DIR);
-
-	if (file_exists(seq_dir)) {
+	if (file_exists(git_path_seq_dir())) {
 		error(_("a cherry-pick or revert is already in progress"));
 		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
 		return -1;
 	}
-	else if (mkdir(seq_dir, 0777) < 0)
-		die_errno(_("Could not create sequencer directory %s"), seq_dir);
+	else if (mkdir(git_path_seq_dir(), 0777) < 0)
+		die_errno(_("Could not create sequencer directory %s"),
+			  git_path_seq_dir());
 	return 0;
 }
 
 static void save_head(const char *head)
 {
-	const char *head_file = git_path(SEQ_HEAD_FILE);
 	static struct lock_file head_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), LOCK_DIE_ON_ERROR);
 	strbuf_addf(&buf, "%s\n", head);
 	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s"), head_file);
+		die_errno(_("Could not write to %s"), git_path_head_file());
 	if (commit_lock_file(&head_lock) < 0)
-		die(_("Error wrapping up %s."), head_file);
+		die(_("Error wrapping up %s."), git_path_head_file());
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
@@ -877,8 +873,8 @@ static int rollback_single_pick(void)
 {
 	unsigned char head_sha1[20];
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (!file_exists(git_path_cherry_pick_head()) &&
+	    !file_exists(git_path_revert_head()))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, head_sha1, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -889,13 +885,11 @@ static int rollback_single_pick(void)
 
 static int sequencer_rollback(struct replay_opts *opts)
 {
-	const char *filename;
 	FILE *f;
 	unsigned char sha1[20];
 	struct strbuf buf = STRBUF_INIT;
 
-	filename = git_path(SEQ_HEAD_FILE);
-	f = fopen(filename, "r");
+	f = fopen(git_path_head_file(), "r");
 	if (!f && errno == ENOENT) {
 		/*
 		 * There is no multiple-cherry-pick in progress.
@@ -905,18 +899,18 @@ static int sequencer_rollback(struct replay_opts *opts)
 		return rollback_single_pick();
 	}
 	if (!f)
-		return error(_("cannot open %s: %s"), filename,
+		return error(_("cannot open %s: %s"), git_path_head_file(),
 						strerror(errno));
 	if (strbuf_getline(&buf, f, '\n')) {
-		error(_("cannot read %s: %s"), filename, ferror(f) ?
-			strerror(errno) : _("unexpected end of file"));
+		error(_("cannot read %s: %s"), git_path_head_file(),
+		      ferror(f) ?  strerror(errno) : _("unexpected end of file"));
 		fclose(f);
 		goto fail;
 	}
 	fclose(f);
 	if (get_sha1_hex(buf.buf, sha1) || buf.buf[40] != '\0') {
 		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
-			filename);
+			git_path_head_file());
 		goto fail;
 	}
 	if (reset_for_rollback(sha1))
@@ -931,28 +925,27 @@ fail:
 
 static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	const char *todo_file = git_path(SEQ_TODO_FILE);
 	static struct lock_file todo_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&todo_lock, todo_file, LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), LOCK_DIE_ON_ERROR);
 	if (format_todo(&buf, todo_list, opts) < 0)
-		die(_("Could not format %s."), todo_file);
+		die(_("Could not format %s."), git_path_todo_file());
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
-		die_errno(_("Could not write to %s"), todo_file);
+		die_errno(_("Could not write to %s"), git_path_todo_file());
 	}
 	if (commit_lock_file(&todo_lock) < 0) {
 		strbuf_release(&buf);
-		die(_("Error wrapping up %s."), todo_file);
+		die(_("Error wrapping up %s."), git_path_todo_file());
 	}
 	strbuf_release(&buf);
 }
 
 static void save_opts(struct replay_opts *opts)
 {
-	const char *opts_file = git_path(SEQ_OPTS_FILE);
+	const char *opts_file = git_path_opts_file();
 
 	if (opts->no_commit)
 		git_config_set_in_file(opts_file, "options.no-commit", "true");
@@ -1013,8 +1006,8 @@ static int continue_single_pick(void)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
-	    !file_exists(git_path("REVERT_HEAD")))
+	if (!file_exists(git_path_cherry_pick_head()) &&
+	    !file_exists(git_path_revert_head()))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -1023,14 +1016,14 @@ static int sequencer_continue(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
 
-	if (!file_exists(git_path(SEQ_TODO_FILE)))
+	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
 
 	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
-	    file_exists(git_path("REVERT_HEAD"))) {
+	if (file_exists(git_path_cherry_pick_head()) ||
+	    file_exists(git_path_revert_head())) {
 		int ret = continue_single_pick();
 		if (ret)
 			return ret;
diff --git a/shallow.c b/shallow.c
index 257d811..4ded4a8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -48,7 +48,7 @@ int is_repository_shallow(void)
 		return is_shallow;
 
 	if (!path)
-		path = git_path("shallow");
+		path = git_path_shallow();
 	/*
 	 * fetch-pack sets '--shallow-file ""' as an indicator that no
 	 * shallow file should be used. We could just open it and it
@@ -142,7 +142,7 @@ static void check_shallow_file_for_update(void)
 	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (!stat_validity_check(&shallow_stat, git_path("shallow")))
+	if (!stat_validity_check(&shallow_stat, git_path_shallow()))
 		die("shallow file has changed since we read it");
 }
 
@@ -261,7 +261,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(shallow_lock, git_path("shallow"),
+	fd = hold_lock_file_for_update(shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update();
 	if (write_shallow_commits(&sb, 0, extra)) {
@@ -308,7 +308,7 @@ void prune_shallow(int show_only)
 		strbuf_release(&sb);
 		return;
 	}
-	fd = hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
+	fd = hold_lock_file_for_update(&shallow_lock, git_path_shallow(),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update();
 	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
@@ -317,7 +317,7 @@ void prune_shallow(int show_only)
 				  shallow_lock.filename.buf);
 		commit_lock_file(&shallow_lock);
 	} else {
-		unlink(git_path("shallow"));
+		unlink(git_path_shallow());
 		rollback_lock_file(&shallow_lock);
 	}
 	strbuf_release(&sb);
diff --git a/wt-status.c b/wt-status.c
index 04e01e4..717fd48 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1171,7 +1171,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path("MERGE_MSG"), &st)) {
+	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(), &st)) {
 		print_rebase_state(s, state, color);
 		if (s->hints)
 			status_printf_ln(s, color,
@@ -1368,7 +1368,7 @@ void wt_status_get_state(struct wt_status_state *state,
 	struct stat st;
 	unsigned char sha1[20];
 
-	if (!stat(git_path("MERGE_HEAD"), &st)) {
+	if (!stat(git_path_merge_head(), &st)) {
 		state->merge_in_progress = 1;
 	} else if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
@@ -1387,7 +1387,7 @@ void wt_status_get_state(struct wt_status_state *state,
 			state->rebase_in_progress = 1;
 		state->branch = read_and_strip_branch("rebase-merge/head-name");
 		state->onto = read_and_strip_branch("rebase-merge/onto");
-	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st) &&
+	} else if (!stat(git_path_cherry_pick_head(), &st) &&
 			!get_sha1("CHERRY_PICK_HEAD", sha1)) {
 		state->cherry_pick_in_progress = 1;
 		hashcpy(state->cherry_pick_head_sha1, sha1);
@@ -1396,7 +1396,7 @@ void wt_status_get_state(struct wt_status_state *state,
 		state->bisect_in_progress = 1;
 		state->branch = read_and_strip_branch("BISECT_START");
 	}
-	if (!stat(git_path("REVERT_HEAD"), &st) &&
+	if (!stat(git_path_revert_head(), &st) &&
 	    !get_sha1("REVERT_HEAD", sha1)) {
 		state->revert_in_progress = 1;
 		hashcpy(state->revert_head_sha1, sha1);
-- 
2.5.0.414.g670f2a4
