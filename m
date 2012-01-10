From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Tue, 10 Jan 2012 21:43:53 +0530
Message-ID: <1326212039-13806-3-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 17:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeMa-00059f-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab2AJQPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:15:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47391 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2AJQPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:15:44 -0500
Received: by iabz25 with SMTP id z25so1076194iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9KtbNZAX95KKN8yaXt7cIlboXjB0fE2CqftKZvjaJ1o=;
        b=BihS7sD7N6/wSOIU16hSDocBADRKs5LeauIeRHGuiRLIfevgdJfweBvFKUsUMuhAMJ
         +57/MVpaMT/SmwUELCf++XDtA7O9pDJJWK1nVdvbYZaL5KAla2dvFNSSPb8ZDk9tJ2Ho
         pLQcOGStLMpk5YvugcJCH+jg1et3sydTibCEE=
Received: by 10.42.151.68 with SMTP id d4mr22620464icw.36.1326212144365;
        Tue, 10 Jan 2012 08:15:44 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.15.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:15:43 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188258>

Currently, 'git cherry-pick' fills up the '.git/sequencer/todo'
instruction sheet with "pick" actions, while 'git revert' fills it up
with "revert" actions.  Inspired by the way 'rebase -i' works, we
would like to permit mixing arbitrary actions in the same instruction
sheet.  To do this, we first have to decouple the notion of an action
in the instruction sheet from builtin commands.  While a future
instruction sheet would look like:

  pickle next~4
  action3 b74fea
  revert rr/moo^2~34

the actions "pickle", "action3" and "revert" need not necessarily
correspond to the specific builtins.  Introduce a "replay_command",
and replace instances of "replay_action" with "replay_command"
everywhere except in parse_insn_line(), the function that parses the
instruction sheet.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   63 ++++++++++++++++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 2739405..9bca9c7 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -44,6 +44,11 @@ enum replay_action {
 	REPLAY_PICK
 };
 
+enum replay_command {
+	REPLAY_CMD_REVERT,
+	REPLAY_CMD_CHERRY_PICK
+};
+
 enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
@@ -52,7 +57,7 @@ enum replay_subcommand {
 };
 
 struct replay_opts {
-	enum replay_action action;
+	enum replay_command command;
 	enum replay_subcommand subcommand;
 
 	/* Boolean options */
@@ -76,16 +81,16 @@ struct replay_opts {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-static const char *action_name(const struct replay_opts *opts)
+static const char *command_name(struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	return opts->command == REPLAY_CMD_REVERT ? "revert" : "cherry-pick";
 }
 
 static char *get_encoding(const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
+	return opts->command == REPLAY_CMD_REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
@@ -142,7 +147,7 @@ static void verify_opt_mutually_compatible(const char *me, ...)
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
-	const char *me = action_name(opts);
+	const char *me = command_name(opts);
 	int remove_state = 0;
 	int contin = 0;
 	int rollback = 0;
@@ -164,7 +169,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == REPLAY_PICK) {
+	if (opts->command == REPLAY_CMD_CHERRY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -375,10 +380,10 @@ static struct tree *empty_tree(void)
 static int error_dirty_index(struct replay_opts *opts)
 {
 	if (read_cache_unmerged())
-		return error_resolve_conflict(action_name(opts));
+		return error_resolve_conflict(command_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == REPLAY_PICK)
+	if (opts->command == REPLAY_CMD_CHERRY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -434,7 +439,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    (write_cache(index_fd, active_cache, active_nr) ||
 	     commit_locked_index(&index_lock)))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), action_name(opts));
+		die(_("%s: Unable to write new index file"), command_name(opts));
 	rollback_lock_file(&index_lock);
 
 	if (!clean) {
@@ -542,7 +547,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
 		return error(_("%s: cannot parse parent commit %s"),
-			action_name(opts), sha1_to_hex(parent->object.sha1));
+			command_name(opts), sha1_to_hex(parent->object.sha1));
 
 	if (get_message(commit, &msg) != 0)
 		return error(_("Cannot get commit message for %s"),
@@ -557,7 +562,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REPLAY_REVERT) {
+	if (opts->command == REPLAY_CMD_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -598,7 +603,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->command == REPLAY_CMD_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -622,13 +627,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
+	if (opts->command == REPLAY_CMD_CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
 		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
+	if (opts->command == REPLAY_CMD_REVERT && ((opts->no_commit && res == 0) || res == 1))
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->action == REPLAY_REVERT
+		error(opts->command == REPLAY_CMD_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -648,7 +653,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 static void prepare_revs(struct replay_opts *opts)
 {
-	if (opts->action != REPLAY_REVERT)
+	if (opts->command != REPLAY_CMD_REVERT)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
@@ -663,12 +668,13 @@ static void read_and_refresh_cache(struct replay_opts *opts)
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), action_name(opts));
+		die(_("git %s: failed to read the index"), command_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed) {
 		if (write_index(&the_index, index_fd) ||
 		    commit_locked_index(&index_lock))
-			die(_("git %s: failed to refresh the index"), action_name(opts));
+			die(_("git %s: failed to refresh the index"),
+				command_name(opts));
 	}
 	rollback_lock_file(&index_lock);
 }
@@ -705,7 +711,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 {
 	struct commit_list *cur = NULL;
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
+	const char *action_str = opts->command == REPLAY_CMD_REVERT ? "revert" : "pick";
 	const char *subject;
 	int subject_len;
 
@@ -750,10 +756,11 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	 * Verify that the action matches up with the one in
 	 * opts; we don't support arbitrary instructions
 	 */
-	if (action != opts->action) {
-		const char *action_str;
-		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
-		error(_("Cannot %s during a %s"), action_str, action_name(opts));
+	if ((action == REPLAY_PICK && opts->command == REPLAY_CMD_REVERT) ||
+		(action == REPLAY_REVERT && opts->command == REPLAY_CMD_CHERRY_PICK)) {
+		error(_("Cannot %s during a %s"),
+			action == REPLAY_REVERT ? "revert" : "pick",
+			command_name(opts));
 		return NULL;
 	}
 
@@ -1015,7 +1022,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	struct commit_list *cur;
 	int res;
 
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
@@ -1070,7 +1077,7 @@ static int sequencer_continue(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
-	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
+	setenv(GIT_REFLOG_ACTION, command_name(opts), 0);
 	return do_pick_commit(cmit, opts);
 }
 
@@ -1128,7 +1135,7 @@ static int pick_revisions(struct replay_opts *opts)
 	if (create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REPLAY_REVERT)
+		if (opts->command == REPLAY_CMD_REVERT)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
@@ -1145,7 +1152,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REPLAY_REVERT;
+	opts.command = REPLAY_CMD_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1160,7 +1167,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = REPLAY_PICK;
+	opts.command = REPLAY_CMD_CHERRY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
-- 
1.7.8.2
