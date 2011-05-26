From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/10] revert: Introduce struct to keep command-line options
Date: Thu, 26 May 2011 15:53:48 +0000
Message-ID: <1306425233-504-6-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 17:54:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPctS-0001ZT-G2
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033Ab1EZPye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:54:34 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44180 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606Ab1EZPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:54:05 -0400
Received: by mail-qy0-f181.google.com with SMTP id 14so475045qyg.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gRhy0AHMLPv+J0zb6rW35Ar6bsMxx5jE+qcXUk5jQyE=;
        b=avtytX6FfzuqHMQdTWw8pSW9vOw2ULIQLL9ioukJnRsF/1a3H8uH2+5PbWI1AgVYe/
         MwJUArd3zrTz9oxK+SvNUkdY4mzMsB3W50+4Yiufslavu5D8jq7GLE2ghQ6vXrEUIosx
         b4lLv7o4PrFySXKoUOv7GpwiC1worG7cWAy6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dBTHQV8myzW4MlBH3PH8OuHpah5OymS+wCn6yBywI0HvAFPM7Qk/3vT8ExLysb/cgv
         JYytrOX1BAkPD5KZTunDITxxti2UswjFllO9lK3ldDBvuL8eM8+Kt3KxGS+QkYwj/4a6
         soRuRuoGjo6MzgBYcEuuKfHPYzcVRYNhoIkwQ=
Received: by 10.229.141.70 with SMTP id l6mr742244qcu.30.1306425245463;
        Thu, 26 May 2011 08:54:05 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id j18sm513435qck.27.2011.05.26.08.54.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306425233-504-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174536>

The current code uses a set of file-scope static variables to tell the
cherry-pick/ revert machinery how to replay the changes, and
initializes them by parsing the command-line arguments.  In later
steps in this series, we would like to introduce an API function that
calls into this machinery directly and have a way to tell it what to
do.  Hence, introduce a structure to group these variables, so that
the API can take them as a single replay_options parameter.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |  174 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 97 insertions(+), 77 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e9b8533..cc2fa73 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -35,76 +35,88 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, record_origin, no_commit, mainline, signoff, allow_ff;
-static enum { REVERT, CHERRY_PICK } action;
-static int commit_argc;
-static const char **commit_argv;
-static int allow_rerere_auto;
-
 static const char *me;
 
-/* Merge strategy. */
-static const char *strategy;
-static const char **xopts;
-static size_t xopts_nr, xopts_alloc;
+struct replay_opts {
+	enum { REVERT, CHERRY_PICK } action;
+
+	/* Boolean options */
+	int edit;
+	int record_origin;
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
 
 static char *get_encoding(const char *message);
 
-static const char * const *revert_or_cherry_pick_usage(void)
+static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return action == REVERT ? revert_usage : cherry_pick_usage;
+	return opts->action == REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
 			  const char *arg, int unset)
 {
+	struct replay_opts **opts = opt->value;
+
 	if (unset)
 		return 0;
 
-	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
-	xopts[xopts_nr++] = xstrdup(arg);
+	ALLOC_GROW((*opts)->xopts, (*opts)->xopts_nr + 1, (*opts)->xopts_alloc);
+	(*opts)->xopts[(*opts)->xopts_nr++] = xstrdup(arg);
 	return 0;
 }
 
-static void parse_args(int argc, const char **argv)
+static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
-	const char * const * usage_str = revert_or_cherry_pick_usage();
+	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
-		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
-		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
+		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
+		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
-		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
-		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
-		OPT_CALLBACK('X', "strategy-option", &xopts, "option",
+		OPT_BOOLEAN('s', "signoff", &opts->signoff, "add Signed-off-by:"),
+		OPT_INTEGER('m', "mainline", &opts->mainline, "parent number"),
+		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
+		OPT_STRING(0, "strategy", &opts->strategy, "strategy", "merge strategy"),
+		OPT_CALLBACK('X', "strategy-option", &opts, "option",
 			"option for merge strategy", option_parse_x),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
 	};
 
-	if (action == CHERRY_PICK) {
+	if (opts->action == CHERRY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOLEAN('x', NULL, &record_origin, "append commit name"),
-			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
+			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
 			die(_("program error"));
 	}
 
-	commit_argc = parse_options(argc, argv, NULL, options, usage_str,
-				    PARSE_OPT_KEEP_ARGV0 |
-				    PARSE_OPT_KEEP_UNKNOWN);
-	if (commit_argc < 2)
+	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
+					PARSE_OPT_KEEP_ARGV0 |
+					PARSE_OPT_KEEP_UNKNOWN);
+	if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
-	commit_argv = argv;
+	opts->commit_argv = argv;
 }
 
 struct commit_message {
@@ -273,7 +285,8 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from)
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
 			      const char *base_label, const char *next_label,
-			      unsigned char *head, struct strbuf *msgbuf)
+			      unsigned char *head, struct strbuf *msgbuf,
+			      struct replay_opts *opts)
 {
 	struct merge_options o;
 	struct tree *result, *next_tree, *base_tree, *head_tree;
@@ -294,7 +307,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	next_tree = next ? next->tree : empty_tree();
 	base_tree = base ? base->tree : empty_tree();
 
-	for (xopt = xopts; xopt != xopts + xopts_nr; xopt++)
+	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
 
 	clean = merge_trees(&o,
@@ -334,7 +347,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
  */
-static int run_git_commit(const char *defmsg)
+static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 {
 	/* 6 is max possible length of our args array including NULL */
 	const char *args[6];
@@ -342,9 +355,9 @@ static int run_git_commit(const char *defmsg)
 
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
@@ -353,7 +366,7 @@ static int run_git_commit(const char *defmsg)
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
-static int do_pick_commit(struct commit *commit)
+static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -363,7 +376,7 @@ static int do_pick_commit(struct commit *commit)
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
 
-	if (no_commit) {
+	if (opts->no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
@@ -381,7 +394,7 @@ static int do_pick_commit(struct commit *commit)
 	discard_cache();
 
 	if (!commit->parents) {
-		if (action == REVERT)
+		if (opts->action == REVERT)
 			return error(_("Cannot revert a root commit"));
 		parent = NULL;
 	}
@@ -390,25 +403,25 @@ static int do_pick_commit(struct commit *commit)
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
-				sha1_to_hex(commit->object.sha1), mainline);
+				sha1_to_hex(commit->object.sha1), opts->mainline);
 		parent = p->item;
-	} else if (0 < mainline)
+	} else if (0 < opts->mainline)
 		return error(_("Mainline was specified but commit %s is not a merge."),
 			sha1_to_hex(commit->object.sha1));
 	else
 		parent = commit->parents->item;
 
-	if (allow_ff && parent && !hashcmp(parent->object.sha1, head))
+	if (opts->allow_ff && parent && !hashcmp(parent->object.sha1, head))
 		return fast_forward_to(commit->object.sha1, head);
 
 	if (parent && parse_commit(parent) < 0)
@@ -430,7 +443,7 @@ static int do_pick_commit(struct commit *commit)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (action == REVERT) {
+	if (opts->action == REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -456,18 +469,18 @@ static int do_pick_commit(struct commit *commit)
 		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
 		strbuf_addstr(&msgbuf, p);
 
-		if (record_origin) {
+		if (opts->record_origin) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-		if (!no_commit)
+		if (!opts->no_commit)
 			write_cherry_pick_head(sha1_to_hex(commit->object.sha1));
 	}
 
-	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
-					 head, &msgbuf);
+					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
 	} else {
 		struct commit_list *common = NULL;
@@ -477,23 +490,23 @@ static int do_pick_commit(struct commit *commit)
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(strategy, xopts_nr, xopts, common,
-					sha1_to_hex(head), remotes);
+		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+					common, sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
 
 	if (res) {
-		error(action == REVERT
+		error(opts->action == REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
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
@@ -502,18 +515,18 @@ static int do_pick_commit(struct commit *commit)
 	return res;
 }
 
-static void prepare_revs(struct rev_info *revs)
+static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 {
 	int argc;
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (action != REVERT)
+	if (opts->action != REVERT)
 		revs->reverse = 1;
 
-	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
+	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
 	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage());
+		usage(*revert_or_cherry_pick_usage(opts));
 
 	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
@@ -522,7 +535,7 @@ static void prepare_revs(struct rev_info *revs)
 		die(_("empty commit set passed"));
 }
 
-static void read_and_refresh_cache(const char *me)
+static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
@@ -537,33 +550,34 @@ static void read_and_refresh_cache(const char *me)
 	rollback_lock_file(&index_lock);
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv,
+				struct replay_opts *opts)
 {
 	struct rev_info revs;
 	struct commit *commit;
 
 	git_config(git_default_config, NULL);
-	me = action == REVERT ? "revert" : "cherry-pick";
+	me = opts->action == REVERT ? "revert" : "cherry-pick";
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
-		if (record_origin)
+		if (opts->record_origin)
 			die(_("cherry-pick --ff cannot be used with -x"));
-		if (edit)
+		if (opts->edit)
 			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
 
-	read_and_refresh_cache(me);
+	read_and_refresh_cache(me, opts);
 
-	prepare_revs(&revs);
+	prepare_revs(&revs, opts);
 
 	while ((commit = get_revision(&revs))) {
-		int res = do_pick_commit(commit);
+		int res = do_pick_commit(commit, opts);
 		if (res)
 			return res;
 	}
@@ -574,10 +588,13 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
 	int res;
+	struct replay_opts opts;
+
+	memset(&opts, 0, sizeof(struct replay_opts));
 	if (isatty(0))
-		edit = 1;
-	action = REVERT;
-	res = revert_or_cherry_pick(argc, argv);
+		opts.edit = 1;
+	opts.action = REVERT;
+	res = revert_or_cherry_pick(argc, argv, &opts);
 	if (res > 0)
 		/* Exit status from conflict */
 		return res;
@@ -590,8 +607,11 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	int res;
-	action = CHERRY_PICK;
-	res = revert_or_cherry_pick(argc, argv);
+	struct replay_opts opts;
+
+	memset(&opts, 0, sizeof(struct replay_opts));
+	opts.action = CHERRY_PICK;
+	res = revert_or_cherry_pick(argc, argv, &opts);
 	if (res > 0)
 		return res;
 	if (res < 0)
-- 
1.7.5.GIT
