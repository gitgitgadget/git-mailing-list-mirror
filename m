From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 00/45] Make git-am a builtin
Date: Mon, 20 Jul 2015 00:09:52 +0800
Message-ID: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:10:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrAx-0005t8-Jy
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbbGSQKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:10:47 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36297 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbGSQKp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:10:45 -0400
Received: by pdjr16 with SMTP id r16so91390858pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=1aqWuVoYzctcxZEf8DWNluHgrrmnIuAA/TJOMIrCHks=;
        b=ur1qIu12vYutDgxnruGq4uiwWT6ImrJuFowz6iBwMbs0vFnX585EryR4NHJSJJaYPe
         HL1n4uSjIUbAg+xbzIXKpvnxZRIHadEmyRTS/QZV1Yqty9F5XCuo9TtfLb2FM9DoJ7dt
         j6xkOt68FKbpgxMf4gm4B8/4+8Ln3W3Sb/485GeHLGZPgYXFCykE/43p+Ryuk66UWlb2
         RBlgOyqeLsnSiy2QbDkSKicifD3gugOw1bty4YHMf1IlAMNm9ijPq//gEfQ9TdNXKIJe
         VLMqWJl20fkrPWPyVoQv+ft1ECg0SPaDiwzAAJXOscx14ri+DivOuqdycIDAZrNFha9G
         jCOg==
X-Received: by 10.70.134.70 with SMTP id pi6mr49460111pdb.100.1437322245332;
        Sun, 19 Jul 2015 09:10:45 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.10.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:10:44 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274225>

This patch series depends on pt/pull-builtin.

This is a re-roll of [v5]. The changes are as follows:

* Compacted the struct am_state declaration, so there are no ugly newlines
  between every field.

* Removed unnecessary assert()s.

* Simplified "if (x) free(x)" to just free(x)

* Only alloc memory for lock_file just before calling hold_locked_index() to
  prevent memory leaks.

* Added a patch to re-implement 271440e (git-am: make it easier after fixing up
  an unapplicable patch., 2005-10-25).

Thanks Junio and Stefan for the reviews last round. Interdiff below.

Previous versions:

[WIP v1] http://thread.gmane.org/gmane.comp.version-control.git/270048
[WIP v2] http://thread.gmane.org/gmane.comp.version-control.git/271381
[WIP v3] http://thread.gmane.org/gmane.comp.version-control.git/271967
[v4] http://thread.gmane.org/gmane.comp.version-control.git/272876
[v5] http://thread.gmane.org/gmane.comp.version-control.git/273520

git-am is a commonly used command for applying a series of patches from a
mailbox to the current branch. Currently, it is implemented by the shell script
git-am.sh. However, compared to C, shell scripts have certain deficiencies:
they need to spawn a lot of processes, introduce a lot of dependencies and
cannot take advantage of git's internal caches.

This patch series rewrites git-am.sh into C builtin/am.c, and is part of my
GSoC project to rewrite git-pull and git-am into C builtins[1].

[1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1


Paul Tan (45):
  wrapper: implement xopen()
  wrapper: implement xfopen()
  builtin-am: implement skeletal builtin am
  builtin-am: implement patch queue mechanism
  builtin-am: split out mbox/maildir patches with git-mailsplit
  builtin-am: auto-detect mbox patches
  builtin-am: extract patch and commit info with git-mailinfo
  builtin-am: apply patch with git-apply
  builtin-am: implement committing applied patch
  builtin-am: refuse to apply patches if index is dirty
  builtin-am: implement --resolved/--continue
  builtin-am: don't parse mail when resuming
  builtin-am: implement --skip
  builtin-am: implement --abort
  builtin-am: reject patches when there's a session in progress
  builtin-am: implement -q/--quiet
  builtin-am: exit with user friendly message on failure
  builtin-am: implement -s/--signoff
  cache-tree: introduce write_index_as_tree()
  builtin-am: implement --3way, am.threeWay
  builtin-am: implement --rebasing mode
  builtin-am: bypass git-mailinfo when --rebasing
  builtin-am: handle stray state directory
  builtin-am: implement -u/--utf8
  builtin-am: implement -k/--keep, --keep-non-patch
  builtin-am: implement --[no-]message-id, am.messageid
  builtin-am: support --keep-cr, am.keepcr
  builtin-am: implement --[no-]scissors
  builtin-am: pass git-apply's options to git-apply
  builtin-am: implement --ignore-date
  builtin-am: implement --committer-date-is-author-date
  builtin-am: implement -S/--gpg-sign, commit.gpgsign
  builtin-am: invoke post-rewrite hook
  builtin-am: support automatic notes copying
  builtin-am: invoke applypatch-msg hook
  builtin-am: invoke pre-applypatch hook
  builtin-am: invoke post-applypatch hook
  builtin-am: rerere support
  builtin-am: support and auto-detect StGit patches
  builtin-am: support and auto-detect StGit series files
  builtin-am: support and auto-detect mercurial patches
  builtin-am: implement -i/--interactive
  builtin-am: implement legacy -b/--binary option
  builtin-am: check for valid committer ident
  builtin-am: remove redirection to git-am.sh

 Makefile                                |    2 +-
 builtin.h                               |    1 +
 builtin/am.c                            | 2320 +++++++++++++++++++++++++++++++
 cache-tree.c                            |   29 +-
 cache-tree.h                            |    1 +
 git-am.sh => contrib/examples/git-am.sh |    0
 git-compat-util.h                       |    2 +
 git.c                                   |    1 +
 wrapper.c                               |   56 +
 9 files changed, 2399 insertions(+), 13 deletions(-)
 create mode 100644 builtin/am.c
 rename git-am.sh => contrib/examples/git-am.sh (100%)

diff --git a/builtin/am.c b/builtin/am.c
index c548129..1116304 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -119,38 +119,21 @@ struct am_state {
 	/* number of digits in patch filename */
 	int prec;
 
+	/* various operating modes and command line options */
 	int interactive;
-
 	int threeway;
-
 	int quiet;
-
 	int append_signoff;
-
 	int utf8;
-
-	/* one of the enum keep_type values */
-	int keep;
-
-	/* pass -m flag to git-mailinfo */
+	int keep; /* enum keep_type */
 	int message_id;
-
-	/* one of the enum scissors_type values */
-	int scissors;
-
+	int scissors; /* enum scissors_type */
 	struct argv_array git_apply_opts;
-
-	/* override error message when patch failure occurs */
 	const char *resolvemsg;
-
 	int committer_date_is_author_date;
-
 	int ignore_date;
-
 	int allow_rerere_autoupdate;
-
 	const char *sign_commit;
-
 	int rebasing;
 };
 
@@ -188,21 +171,11 @@ static void am_state_init(struct am_state *state, const char *dir)
  */
 static void am_state_release(struct am_state *state)
 {
-	if (state->dir)
-		free(state->dir);
-
-	if (state->author_name)
-		free(state->author_name);
-
-	if (state->author_email)
-		free(state->author_email);
-
-	if (state->author_date)
-		free(state->author_date);
-
-	if (state->msg)
-		free(state->msg);
-
+	free(state->dir);
+	free(state->author_name);
+	free(state->author_email);
+	free(state->author_date);
+	free(state->msg);
 	argv_array_clear(&state->git_apply_opts);
 }
 
@@ -211,8 +184,6 @@ static void am_state_release(struct am_state *state)
  */
 static inline const char *am_path(const struct am_state *state, const char *path)
 {
-	assert(state->dir);
-	assert(path);
 	return mkpath("%s/%s", state->dir, path);
 }
 
@@ -373,10 +344,6 @@ static void write_author_script(const struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	assert(state->author_name);
-	assert(state->author_email);
-	assert(state->author_date);
-
 	strbuf_addstr(&sb, "GIT_AUTHOR_NAME=");
 	sq_quote_buf(&sb, state->author_name);
 	strbuf_addch(&sb, '\n');
@@ -424,8 +391,6 @@ static void write_commit_msg(const struct am_state *state)
 	int fd;
 	const char *filename = am_path(state, "final-commit");
 
-	assert(state->msg);
-
 	fd = xopen(filename, O_WRONLY | O_CREAT, 0666);
 	if (write_in_full(fd, state->msg, state->msg_len) < 0)
 		die_errno(_("could not write to %s"), filename);
@@ -1110,20 +1075,16 @@ static void am_next(struct am_state *state)
 {
 	unsigned char head[GIT_SHA1_RAWSZ];
 
-	if (state->author_name)
-		free(state->author_name);
+	free(state->author_name);
 	state->author_name = NULL;
 
-	if (state->author_email)
-		free(state->author_email);
+	free(state->author_email);
 	state->author_email = NULL;
 
-	if (state->author_date)
-		free(state->author_date);
+	free(state->author_date);
 	state->author_date = NULL;
 
-	if (state->msg)
-		free(state->msg);
+	free(state->msg);
 	state->msg = NULL;
 	state->msg_len = 0;
 
@@ -1160,13 +1121,12 @@ static const char *msgnum(const struct am_state *state)
  */
 static void refresh_and_write_cache(void)
 {
-	static struct lock_file lock_file;
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	hold_locked_index(&lock_file, 1);
+	hold_locked_index(lock_file, 1);
 	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write index file"));
-	rollback_lock_file(&lock_file);
 }
 
 /**
@@ -1714,6 +1674,21 @@ static void do_commit(const struct am_state *state)
 }
 
 /**
+ * Validates the am_state for resuming -- the "msg" and authorship fields must
+ * be filled up.
+ */
+static void validate_resume_state(const struct am_state *state)
+{
+	if (!state->msg)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "final-commit"));
+
+	if (!state->author_name || !state->author_email || !state->author_date)
+		die(_("cannot resume: %s does not exist."),
+			am_path(state, "author-script"));
+}
+
+/**
  * Interactively prompt the user on whether the current patch should be
  * applied.
  *
@@ -1774,8 +1749,12 @@ static int do_interactive(struct am_state *state)
 
 /**
  * Applies all queued mail.
+ *
+ * If `resume` is true, we are "resuming". The "msg" and authorship fields, as
+ * well as the state directory's "patch" file is used as-is for applying the
+ * patch and committing it.
  */
-static void am_run(struct am_state *state)
+static void am_run(struct am_state *state, int resume)
 {
 	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	struct strbuf sb = STRBUF_INIT;
@@ -1793,21 +1772,28 @@ static void am_run(struct am_state *state)
 
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
-		int apply_status, skip;
+		int apply_status;
 
 		if (!file_exists(mail))
 			goto next;
 
-		if (state->rebasing)
-			skip = parse_mail_rebase(state, mail);
-		else
-			skip = parse_mail(state, mail);
+		if (resume) {
+			validate_resume_state(state);
+			resume = 0;
+		} else {
+			int skip;
 
-		if (skip)
-			goto next; /* mail should be skipped */
+			if (state->rebasing)
+				skip = parse_mail_rebase(state, mail);
+			else
+				skip = parse_mail(state, mail);
+
+			if (skip)
+				goto next; /* mail should be skipped */
 
-		write_author_script(state);
-		write_commit_msg(state);
+			write_author_script(state);
+			write_commit_msg(state);
+		}
 
 		if (state->interactive && do_interactive(state))
 			goto next;
@@ -1880,13 +1866,7 @@ next:
  */
 static void am_resolve(struct am_state *state)
 {
-	if (!state->msg)
-		die(_("cannot resume: %s does not exist."),
-			am_path(state, "final-commit"));
-
-	if (!state->author_name || !state->author_email || !state->author_date)
-		die(_("cannot resume: %s does not exist."),
-			am_path(state, "author-script"));
+	validate_resume_state(state);
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
@@ -1915,7 +1895,7 @@ static void am_resolve(struct am_state *state)
 
 next:
 	am_next(state);
-	am_run(state);
+	am_run(state, 0);
 }
 
 /**
@@ -1925,13 +1905,14 @@ next:
  */
 static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 {
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file *lock_file;
 	struct unpack_trees_options opts;
 	struct tree_desc t[2];
 
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
 
+	lock_file = xcalloc(1, sizeof(struct lock_file));
 	hold_locked_index(lock_file, 1);
 
 	refresh_cache(REFRESH_QUIET);
@@ -1964,7 +1945,7 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
  */
 static int clean_index(const unsigned char *head, const unsigned char *remote)
 {
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file *lock_file;
 	struct tree *head_tree, *remote_tree, *index_tree;
 	unsigned char index[GIT_SHA1_RAWSZ];
 	struct pathspec pathspec;
@@ -1994,6 +1975,7 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 
 	memset(&pathspec, 0, sizeof(pathspec));
 
+	lock_file = xcalloc(1, sizeof(struct lock_file));
 	hold_locked_index(lock_file, 1);
 
 	if (read_tree(remote_tree, 0, &pathspec)) {
@@ -2040,7 +2022,7 @@ static void am_skip(struct am_state *state)
 		die(_("failed to clean index"));
 
 	am_next(state);
-	am_run(state);
+	am_run(state, 0);
 }
 
 /**
@@ -2136,6 +2118,7 @@ static int parse_opt_patchformat(const struct option *opt, const char *arg, int
 
 enum resume_mode {
 	RESUME_FALSE = 0,
+	RESUME_APPLY,
 	RESUME_RESOLVED,
 	RESUME_SKIP,
 	RESUME_ABORT
@@ -2271,6 +2254,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			die(_("previous rebase directory %s still exists but mbox given."),
 				state.dir);
 
+		if (resume == RESUME_FALSE)
+			resume = RESUME_APPLY;
+
 		am_load(&state);
 	} else {
 		struct argv_array paths = ARGV_ARRAY_INIT;
@@ -2310,7 +2296,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 
 	switch (resume) {
 	case RESUME_FALSE:
-		am_run(&state);
+		am_run(&state, 0);
+		break;
+	case RESUME_APPLY:
+		am_run(&state, 1);
 		break;
 	case RESUME_RESOLVED:
 		am_resolve(&state);

-- 
2.5.0.rc2.110.gb39b692
