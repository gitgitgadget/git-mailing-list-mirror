From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/8] revert: Introduce a struct to parse command-line options into
Date: Wed, 11 May 2011 13:30:17 +0530
Message-ID: <1305100822-20470-4-git-send-email-artagnon@gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 17:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBTd-00057p-PD
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 17:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab1EKPgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 11:36:55 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:2275 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab1EKPgw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 11:36:52 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="77408753"
Received: from smtp-in-1101.vdc.amazon.com ([10.146.54.37])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:00:56 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1101.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p4B80rb7009686;
	Wed, 11 May 2011 08:00:54 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 9522B754834; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173389>

The current code uses a set of file-scope static variables to tell the
cherry-pick/ revert machinery how to replay the changes, and
initializes them by parsing the command-line arguments.  In later
steps in this series, we would like to introduce an API function that
calls into this machinery directly and have a way to tell it what to
do.  Hence, introduce a structure to group these variables, so that
the API can take them as a single "replay_options" parameter.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I get the following warning from GCC: warning: useless storage class
 specifier in empty declaration (at the line where I've declared the
 replay_opts struct).  What is the correct way to fix this?

 Also, I'm not happy with the way I'm parsing xopts-related options
 from option_parse_x into global static variables, before actually
 putting it into the structure.  Is there a better way to do this?

 builtin/revert.c |  198 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 111 insertions(+), 87 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e5c3c6c..8550927 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -35,29 +35,42 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
-static enum { REVERT, CHERRY_PICK } action;
-static int commit_argc;
-static const char **commit_argv;
-static int allow_rerere_auto;
-
-
-/* Merge strategy. */
-static const char *strategy;
-static const char **xopts;
-static size_t xopts_nr, xopts_alloc;
+static struct replay_opts {
+	enum { REVERT, CHERRY_PICK } action;
+
+	/* Boolean options */
+	int edit;
+	int no_replay;
+	int no_commit;
+	int signoff;
+	int allow_ff;
+	int allow_rerere_auto;
+
+	int mainline;
+	int commit_argc;
+	const char **commit_argv;
+
+	/* Merge strategy */
+	const char *strategy;
+	const char **xopts;
+	size_t xopts_nr, xopts_alloc;
+};
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 static char *get_encoding(struct commit *commit, const char *message);
 
-static const char * const *revert_or_cherry_pick_usage(void)
+static const char *const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return action == REVERT ? revert_usage : cherry_pick_usage;
+	return opts->action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
+/* For option_parse_x */
+static const char **xopts;
+static size_t xopts_nr, xopts_alloc;
+
 static int option_parse_x(const struct option *opt,
-			  const char *arg, int unset)
+			const char *arg, int unset)
 {
 	if (unset)
 		return 0;
@@ -67,19 +80,18 @@ static int option_parse_x(const struct option *opt,
 	return 0;
 }
 
-static void parse_args(int argc, const char **argv)
+static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
-	const char * const * usage_str = revert_or_cherry_pick_usage();
+	const char *const *usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
-		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
-		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
-		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
-		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
-		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
+		OPT_BOOLEAN('n', "no-commit", &(opts->no_commit), "don't automatically commit"),
+		OPT_BOOLEAN('e', "edit", &(opts->edit), "edit the commit message"),
+		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
+		OPT_BOOLEAN('s', "signoff", &(opts->signoff), "add Signed-off-by:"),
+		OPT_INTEGER('m', "mainline", &(opts->mainline), "parent number"),
+		OPT_RERERE_AUTOUPDATE(&(opts->allow_rerere_auto)),
+		OPT_STRING(0, "strategy", &(opts->strategy), "strategy", "merge strategy"),
 		OPT_CALLBACK('X', "strategy-option", &xopts, "option",
 			"option for merge strategy", option_parse_x),
 		OPT_END(),
@@ -87,23 +99,29 @@ static void parse_args(int argc, const char **argv)
 		OPT_END(),
 	};
 
-	if (action == CHERRY_PICK) {
+	if (opts->action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &no_replay, "append commit name"),
-			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_BOOLEAN('x', NULL, &(opts->no_replay), "append commit name"),
+			OPT_BOOLEAN(0, "ff", &(opts->allow_ff), "allow fast-forward"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
 			die(_("program error"));
 	}
 
-	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
+	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 				    PARSE_OPT_KEEP_ARGV0 |
 				    PARSE_OPT_KEEP_UNKNOWN);
-	if (commit_argc < 2)
+
+	/* Fill in the opts struct from values set by option_parse_x */
+	opts->xopts = xopts;
+	opts->xopts_nr = xopts_nr;
+	opts->xopts_alloc = xopts_alloc;
+
+	if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
-	commit_argv = argv;
+	opts->commit_argv = argv;
 }
 
 struct commit_message {
@@ -311,15 +329,15 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-			      const char *base_label, const char *next_label,
-			      unsigned char *head, struct strbuf *msgbuf)
+			const char *base_label, const char *next_label,
+			unsigned char *head, struct strbuf *msgbuf,
+			struct replay_opts *opts)
 {
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
 	int clean, index_fd;
 	const char **xopt;
 	static struct lock_file index_lock;
-	const char *me = (action == REVERT ? "revert" : "cherry-pick");
 
 	index_fd = hold_locked_index(&index_lock, 1);
 
@@ -334,7 +352,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
-	for (xopt = xopts; xopt != xopts + xopts_nr; xopt++)
+	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
 
 	clean = merge_trees(&o,
@@ -346,7 +364,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 			commit_locked_index(&index_lock))) {
 		rollback_lock_file(&index_lock);
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		return error(_("%s: Unable to write new index file"), me);
+		return error(_("%s: Unable to write new index file"),
+			opts->action == REVERT ? "revert" : "cherry-pick");
 	}
 	rollback_lock_file(&index_lock);
 
@@ -376,7 +395,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-static int run_git_commit(const char *defmsg)
+static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 {
 	/* 6 is max possible length of our args array including NULL */
 	const char *args[6];
@@ -384,9 +403,9 @@ static int run_git_commit(const char *defmsg)
 
 	args[i++] = "commit";
 	args[i++] = "-n";
-	if (signoff)
+	if (opts->signoff)
 		args[i++] = "-s";
-	if (!edit) {
+	if (!opts->edit) {
 		args[i++] = "-F";
 		args[i++] = defmsg;
 	}
@@ -395,7 +414,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit)
+static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -403,10 +422,10 @@ static int do_pick_commit(struct commit *commit)
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
-	const char *me = (action == REVERT ? "revert" : "cherry-pick");
+	const char *me = (opts->action == REVERT ? "revert" : "cherry-pick");
 	int res;
 
-	if (no_commit) {
+	if (opts->no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
@@ -426,7 +445,7 @@ static int do_pick_commit(struct commit *commit)
 	discard_cache();
 
 	if (!commit->parents) {
-		if (action == REVERT)
+		if (opts->action == REVERT)
 			return error(_("Cannot revert a root commit"));
 		parent = NULL;
 	}
@@ -435,32 +454,31 @@ static int do_pick_commit(struct commit *commit)
 		int cnt;
 		struct commit_list *p;
 
-		if (!mainline)
+		if (!opts->mainline)
 			return error(_("Commit %s is a merge but no -m option was given."),
 				sha1_to_hex(commit->object.sha1));
 
 		for (cnt = 1, p = commit->parents;
-		     cnt != mainline && p;
+		     cnt != opts->mainline && p;
 		     cnt++)
 			p = p->next;
-		if (cnt != mainline || !p)
+		if (cnt != opts->mainline || !p)
 			return error(_("Commit %s does not have parent %d"),
-			    sha1_to_hex(commit->object.sha1), mainline);
+			    sha1_to_hex(commit->object.sha1), opts->mainline);
 		parent = p->item;
-	} else if (mainline > 0)
+	} else if (opts->mainline > 0)
 		return error(_("Mainline was specified but commit %s is not a merge."),
 		    sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
-	if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
+	if (opts->allow_ff && parent && !hashcmp(parent->object.sha1, head))
 		return fast_forward_to(commit->object.sha1, head);
 
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
-		return error(_("%s: cannot parse parent commit %s"),
-			action == REVERT ? "revert" : "cherry-pick",
+		return error(_("%s: cannot parse parent commit %s"), me,
 			sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, commit->buffer, &msg) != 0)
@@ -476,7 +494,7 @@ static int do_pick_commit(struct commit *commit)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (action == REVERT) {
+	if (opts->action == REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -497,12 +515,12 @@ static int do_pick_commit(struct commit *commit)
 		next = commit;
 		next_label = msg.label;
 		add_message_to_msg(commit, &msgbuf, msg.message);
-		if (no_replay) {
+		if (opts->no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-		if (!no_commit)
+		if (!opts->no_commit)
 			if ((res = write_cherry_pick_head(commit))) {
 				free_message(&msg);
 				free(defmsg);
@@ -510,9 +528,9 @@ static int do_pick_commit(struct commit *commit)
 			}
 	}
 
-	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
-					 head, &msgbuf);
+					head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
 	} else {
 		struct commit_list *common = NULL;
@@ -522,23 +540,23 @@ static int do_pick_commit(struct commit *commit)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(strategy, xopts_nr, xopts, common,
+		res = try_merge_command(opts->strategy, opts->xopts_nr,
+					opts->xopts, common,
 					sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
 
 	if (res) {
-		error(action == REVERT
-		      ? _("could not revert %s... %s")
-		      : _("could not apply %s... %s"),
-		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
-		      msg.subject);
+		error(_("could not %s %s... %s"),
+			opts->action == REVERT ? "revert" : "apply",
+			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+			msg.subject);
 		print_advice();
-		rerere(allow_rerere_auto);
+		rerere(opts->allow_rerere_auto);
 	} else {
-		if (!no_commit)
-			res = run_git_commit(defmsg);
+		if (!opts->no_commit)
+			res = run_git_commit(defmsg, opts);
 	}
 
 	free_message(&msg);
@@ -547,15 +565,15 @@ static int do_pick_commit(struct commit *commit)
 	return res;
 }
 
-static int prepare_revs(struct rev_info *revs)
+static int prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 {
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (action != REVERT)
+	if (opts->action != REVERT)
 		revs->reverse = 1;
 
-	if (setup_revisions(commit_argc, commit_argv, revs, NULL) > 1)
-		return error(_("usage: %s"), *revert_or_cherry_pick_usage());
+	if (setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL) > 1)
+		return error(_("usage: %s"), *revert_or_cherry_pick_usage(opts));
 
 	if (prepare_revision_walk(revs))
 		return error(_("revision walk setup failed"));
@@ -565,13 +583,12 @@ static int prepare_revs(struct rev_info *revs)
 	return 0;
 }
 
-static int read_and_refresh_cache(void)
+static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
-	const char *me;
+	const char *me = (opts->action == REVERT ? "revert" : "cherry-pick");
 
-	me = (action == REVERT ? "revert" : "cherry-pick");
 	if (read_index_preload(&the_index, NULL) < 0)
 		return error(_("%s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
@@ -586,7 +603,8 @@ static int read_and_refresh_cache(void)
 	return 0;
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv,
+				struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
@@ -594,27 +612,27 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	int res;
 
 	git_config(git_default_config, NULL);
-	me = (action == REVERT ? "revert" : "cherry-pick");
+	me = (opts->action == REVERT ? "revert" : "cherry-pick");
 	setenv(GIT_REFLOG_ACTION, me, 0);
-	parse_args(argc, argv);
+	parse_args(argc, argv, opts);
 
-	if (allow_ff) {
-		if (signoff)
+	if (opts->allow_ff) {
+		if (opts->signoff)
 			die(_("cherry-pick --ff cannot be used with --signoff"));
-		if (no_commit)
+		if (opts->no_commit)
 			die(_("cherry-pick --ff cannot be used with --no-commit"));
-		if (no_replay)
+		if (opts->no_replay)
 			die(_("cherry-pick --ff cannot be used with -x"));
-		if (edit)
+		if (opts->edit)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	if ((res = read_and_refresh_cache()) ||
-		(res = prepare_revs(&revs)))
+	if ((res = read_and_refresh_cache(opts)) ||
+		(res = prepare_revs(&revs, opts)))
 		return res;
 
 	while ((commit = get_revision(&revs)) &&
-		!(res = do_pick_commit(commit)))
+		!(res = do_pick_commit(commit, opts)))
 		;
 
 	return res;
@@ -622,14 +640,20 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
+	struct replay_opts opts;
+
+	memset(&opts, 0, sizeof(struct replay_opts));
 	if (isatty(0))
-		edit = 1;
-	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+		opts.edit = 1;
+	opts.action = REVERT;
+	return revert_or_cherry_pick(argc, argv, &opts);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	struct replay_opts opts;
+
+	memset(&opts, 0, sizeof(struct replay_opts));
+	opts.action = CHERRY_PICK;
+	return revert_or_cherry_pick(argc, argv, &opts);
 }
-- 
1.7.5.GIT
