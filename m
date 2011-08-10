From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] sequencer.h: Move data structures
Date: Wed, 10 Aug 2011 15:25:48 +0530
Message-ID: <1312970151-18906-3-git-send-email-artagnon@gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 10 11:59:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qr5Z9-0001mb-AE
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 11:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab1HJJ7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 05:59:05 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61802 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1HJJ7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 05:59:03 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1583833pzk.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ch3zD8yQPXhT+3USvMrR8Mlme7NRw9gdYWcHLBI7TVU=;
        b=Zk8cGEohG/tfYYu4c1Mf00UFbAhC6ezkW9rhJExG25b/a8jCQxTkVzdxXSHMQvrjwb
         b/jlVeKTwttNLhSIf3Yj9UVTZSE0RHDFni6dTpmI79E03wsobAZCVUsJt+RXiiL4ce84
         3JVSfgYq2NNb47LQj2UVYqIITnKx0bk/9JVT0=
Received: by 10.142.152.34 with SMTP id z34mr7690551wfd.209.1312970343218;
        Wed, 10 Aug 2011 02:59:03 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id s7sm725394pbj.69.2011.08.10.02.58.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 02:59:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179059>

Prepare to move more stuff into generalized sequencer.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   55 ++++++++++++++---------------------------------------
 sequencer.h      |   25 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a548a14..81502d4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,43 +39,18 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
-
-struct replay_opts {
-	enum replay_action action;
-	enum replay_subcommand subcommand;
-
-	/* Boolean options */
-	int edit;
-	int record_origin;
-	int no_commit;
-	int signoff;
-	int allow_ff;
-	int allow_rerere_auto;
-
-	int mainline;
-	int commit_argc;
-	const char **commit_argv;
-
-	/* Merge strategy */
-	const char *strategy;
-	const char **xopts;
-	size_t xopts_nr, xopts_alloc;
-};
-
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
 }
 
 static char *get_encoding(const char *message);
 
 static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 {
-	return opts->action == REVERT ? revert_usage : cherry_pick_usage;
+	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
 static int option_parse_x(const struct option *opt,
@@ -154,7 +129,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -353,7 +328,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -532,7 +507,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (opts->action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -575,7 +550,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			write_cherry_pick_head(commit);
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -594,7 +569,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	if (res) {
-		error(opts->action == REVERT
+		error(opts->action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -618,7 +593,7 @@ static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		revs->reverse = 1;
 
 	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
@@ -680,7 +655,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	struct commit_list *cur = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
@@ -700,11 +675,11 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 	char *p, *q;
 
 	if (!prefixcmp(start, "pick ")) {
-		action = CHERRY_PICK;
+		action = REPLAY_PICK;
 		insn_len = strlen("pick");
 		p = start + insn_len + 1;
 	} else if (!prefixcmp(start, "revert ")) {
-		action = REVERT;
+		action = REPLAY_REVERT;
 		insn_len = strlen("revert");
 		p = start + insn_len + 1;
 	} else
@@ -723,7 +698,7 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
 	 */
 	if (action != opts->action) {
 		const char *action_str;
-		action_str = action == REVERT ? "revert" : "cherry-pick";
+		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
 		error(_("Cannot %s during a %s"), action_str, action_name(opts));
 		return NULL;
 	}
@@ -989,7 +964,7 @@ static int pick_revisions(struct replay_opts *opts)
 			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
-			if (opts->action == REVERT)
+			if (opts->action == REPLAY_REVERT)
 				return error(_("Can't revert as initial commit"));
 			return error(_("Can't cherry-pick into empty head"));
 		}
@@ -1009,7 +984,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1024,7 +999,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = CHERRY_PICK;
+	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
diff --git a/sequencer.h b/sequencer.h
index 905d295..0b5d94e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -7,6 +7,31 @@
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
+enum replay_action { REPLAY_REVERT, REPLAY_PICK };
+enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
+
+struct replay_opts {
+	enum replay_action action;
+	enum replay_subcommand subcommand;
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
+
 /*
  * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset'.
-- 
1.7.6.351.gb35ac.dirty
