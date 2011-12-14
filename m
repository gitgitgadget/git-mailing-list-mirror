From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/10] revert: move replay_action, replay_subcommand to header
Date: Wed, 14 Dec 2011 22:24:35 +0530
Message-ID: <1323881677-11117-9-git-send-email-artagnon@gmail.com>
References: <CALkWK0kbV2WFfGVrA9m_Uwd4J8+U9Yde9Wxb-OZE9Y8K+Ta_4A@mail.gmail.com>
 <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 17:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ras7D-0004kJ-O1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 17:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757635Ab1LNQzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 11:55:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53875 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab1LNQzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 11:55:17 -0500
Received: by mail-vw0-f46.google.com with SMTP id fc26so774122vbb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 08:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Sp5+wBzu+ob2pc72tryioDmrLcLSsvSrYHZLvG0byFM=;
        b=Ezmjk6ZBbOS6Lx3GpN8Fh2TcLO+gYmSlQDQEj3qztFxoUHQYVTn4QiKUXdOW55ifdw
         WiMCmVRgGwjIPyLIRu1ZzZjQAgfv/2pN4zxB8FO0kjbYYzmpTrEx94PgdnOQ4Lp9Tu5h
         xpbMEp/ANrNliRVPAaQ+BtS/KAjSPGZS97/Ds=
Received: by 10.52.117.162 with SMTP id kf2mr5377100vdb.43.1323881716505;
        Wed, 14 Dec 2011 08:55:16 -0800 (PST)
Received: from localhost.localdomain ([122.174.116.246])
        by mx.google.com with ESMTPS id ir2sm2963127vdb.9.2011.12.14.08.55.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 08:55:15 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323881677-11117-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187153>

In our vision to build a generalized sequencer, the revert builtin
will be left only with argument parsing work before calling into the
sequencer.  Since the enums replay_action and replay_subcommand have
nothing to do with this argument parsing, move them to sequencer.h.

However, REVERT and CHERRY_PICK are unsuitable variable names for
publicly exposing, as their purpose is unclear in the global context:
rename them to REPLAY_REVERT and REPLAY_PICK respectively.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   42 +++++++++++++++++-------------------------
 sequencer.h      |   12 ++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0a4b215..ed062ea 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -39,14 +39,6 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand {
-	REPLAY_NONE,
-	REPLAY_REMOVE_STATE,
-	REPLAY_CONTINUE,
-	REPLAY_ROLLBACK
-};
-
 struct replay_opts {
 	enum replay_action action;
 	enum replay_subcommand subcommand;
@@ -73,14 +65,14 @@ struct replay_opts {
 
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
@@ -159,7 +151,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 	};
 
-	if (opts->action == CHERRY_PICK) {
+	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
@@ -363,7 +355,7 @@ static int error_dirty_index(struct replay_opts *opts)
 		return error_resolve_conflict(action_name(opts));
 
 	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == CHERRY_PICK)
+	if (opts->action == REPLAY_PICK)
 		error(_("Your local changes would be overwritten by cherry-pick."));
 	else
 		error(_("Your local changes would be overwritten by revert."));
@@ -542,7 +534,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 
 	defmsg = git_pathdup("MERGE_MSG");
 
-	if (opts->action == REVERT) {
+	if (opts->action == REPLAY_REVERT) {
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -583,7 +575,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REVERT) {
+	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		write_message(&msgbuf, defmsg);
@@ -607,13 +599,13 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * However, if the merge did not even start, then we don't want to
 	 * write it at all.
 	 */
-	if (opts->action == CHERRY_PICK && !opts->no_commit && (res == 0 || res == 1))
+	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
 		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
-	if (opts->action == REVERT && ((opts->no_commit && res == 0) || res == 1))
+	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
 		write_cherry_pick_head(commit, "REVERT_HEAD");
 
 	if (res) {
-		error(opts->action == REVERT
+		error(opts->action == REPLAY_REVERT
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
@@ -637,7 +629,7 @@ static void prepare_revs(struct rev_info *revs, struct replay_opts *opts)
 
 	init_revisions(revs, NULL);
 	revs->no_walk = 1;
-	if (opts->action != REVERT)
+	if (opts->action != REPLAY_REVERT)
 		revs->reverse = 1;
 
 	argc = setup_revisions(opts->commit_argc, opts->commit_argv, revs, NULL);
@@ -698,7 +690,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 {
 	struct commit_list *cur = NULL;
 	const char *sha1_abbrev = NULL;
-	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *action_str = opts->action == REPLAY_REVERT ? "revert" : "pick";
 	const char *subject;
 	int subject_len;
 
@@ -719,10 +711,10 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	int saved, status, padding;
 
 	if (!prefixcmp(bol, "pick")) {
-		action = CHERRY_PICK;
+		action = REPLAY_PICK;
 		bol += strlen("pick");
 	} else if (!prefixcmp(bol, "revert")) {
-		action = REVERT;
+		action = REPLAY_REVERT;
 		bol += strlen("revert");
 	} else
 		return NULL;
@@ -745,7 +737,7 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	 */
 	if (action != opts->action) {
 		const char *action_str;
-		action_str = action == REVERT ? "revert" : "cherry-pick";
+		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
 		error(_("Cannot %s during a %s"), action_str, action_name(opts));
 		return NULL;
 	}
@@ -1080,7 +1072,7 @@ static int pick_revisions(struct replay_opts *opts)
 	if (create_seq_dir() < 0)
 		return -1;
 	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
+		if (opts->action == REPLAY_REVERT)
 			return error(_("Can't revert as initial commit"));
 		return error(_("Can't cherry-pick into empty head"));
 	}
@@ -1097,7 +1089,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
-	opts.action = REVERT;
+	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
@@ -1112,7 +1104,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	int res;
 
 	memset(&opts, 0, sizeof(opts));
-	opts.action = CHERRY_PICK;
+	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = pick_revisions(&opts);
diff --git a/sequencer.h b/sequencer.h
index f435fdb..9b1b94d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -7,6 +7,18 @@
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
+enum replay_action {
+	REPLAY_REVERT,
+	REPLAY_PICK
+};
+
+enum replay_subcommand {
+	REPLAY_NONE,
+	REPLAY_REMOVE_STATE,
+	REPLAY_CONTINUE,
+	REPLAY_ROLLBACK
+};
+
 /*
  * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset'.
-- 
1.7.4.1
