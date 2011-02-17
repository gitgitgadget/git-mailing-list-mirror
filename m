From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 4/4] Teach commit about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 23:18:45 -0500
Message-ID: <1297916325-89688-5-git-send-email-jaysoffian@gmail.com>
References: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 05:19:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpvLA-0007tY-8O
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 05:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab1BQETU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 23:19:20 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49724 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab1BQETR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 23:19:17 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so2060916qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 20:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=w3VhbDIVEWNtELxfOjHgRq+pDYpayjz8RDMhTyEWyhI=;
        b=LZfUrieNLqe5UQGzP+knILyjKG/eh52rAoB9HXEXQuG7inF248dTNtBxdBeETSkSIs
         f9UbGeGfwFB0NrQFqbyVHkUhYQENT/18i/eyqnHqYnpNBjOurKnQg2uD0YLrN3bdOoFt
         GJpGbSIelvQiNdHjs36YG4bD8srJHHVY3vtQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v9i0UMdkTcRq4nSWLmkdH/aFbLe0zBcBI990AsvA9WQdF9tF2A1G3X7xN/FiPJqU2G
         ixYQE2dJjnkBhCCABwCXVhS2LFRkM2w3vapDT9l+5wOOq+R7K4z9seuuxxYqUizq1EcX
         jRl0JG5dRIzSVv370lFtXuQaTzqjC7i9Y64Io=
Received: by 10.224.20.2 with SMTP id d2mr1840466qab.300.1297916352066;
        Wed, 16 Feb 2011 20:19:12 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id e29sm416597qck.3.2011.02.16.20.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 20:19:10 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.g7fe09
In-Reply-To: <1297916325-89688-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167035>

Previously the user was advised to use commit -c CHERRY_PICK_HEAD after
a conflicting cherry-pick. While this would preserve the original
commit's authorship, it would sadly discard cherry-pick's carefully
crafted MERGE_MSG (which contains the list of conflicts as well as the
original commit-id in the case of cherry-pick -x).

On the other hand, if a bare 'commit' were performed, it would preserve
the MERGE_MSG while resetting the authorship.

In other words, there was no way to simultaneously take the authorship
from CHERRY_PICK_HEAD and the commit message from MERGE_MSG.

This change fixes that situation. A bare 'commit' will now take the
authorship from CHERRY_PICK_HEAD and the commit message from MERGE_MSG.
If the user wishes to reset authorship, that must now be done explicitly
via --reset-author.

A side-benefit of passing commit authorship along this way is that we
can eliminate redundant authorship parsing code from revert.c.

(Also removed an unused include from revert.c)

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Incorporates feedback from:
 - http://article.gmane.org/gmane.comp.version-control.git/167000
 - http://article.gmane.org/gmane.comp.version-control.git/167015

 Documentation/git-commit.txt    |    7 +-
 builtin/commit.c                |  155 ++++++++++++++++++++++++++++-----------
 builtin/revert.c                |   56 +--------------
 t/t3507-cherry-pick-conflict.sh |    2 +-
 t/t7509-commit.sh               |   29 +++++++
 wt-status.c                     |    4 +-
 wt-status.h                     |    9 ++-
 7 files changed, 158 insertions(+), 104 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b586c0f..fd6a1f7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -84,9 +84,10 @@ OPTIONS
 	linkgit:git-rebase[1] for details.
 
 --reset-author::
-	When used with -C/-c/--amend options, declare that the
-	authorship of the resulting commit now belongs of the committer.
-	This also renews the author timestamp.
+	When used with -C/-c/--amend options, or when committing after a
+	a conflicting cherry-pick, declare that the authorship of the
+	resulting commit now belongs of the committer. This also renews
+	the author timestamp.
 
 --short::
 	When doing a dry-run, give the output in the short-format. See
diff --git a/builtin/commit.c b/builtin/commit.c
index 5b32743..af750df 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -54,6 +54,13 @@ static const char empty_amend_advice[] =
 "it empty. You can repeat your command with --allow-empty, or you can\n"
 "remove the commit entirely with \"git reset HEAD^\".\n";
 
+static const char empty_cherry_pick_advice[] =
+"The most recent cherry-pick is empty. If you wish to commit it, use:\n"
+"\n"
+"    git commit --allow-empty\n"
+"\n"
+"Otherwise, please remove the file %s\n";
+
 static const char commit_editmsg[] = "COMMIT_EDITMSG";
 static const char cherry_pick_head[] = "CHERRY_PICK_HEAD";
 static const char merge_head[] = "MERGE_HEAD";
@@ -63,7 +70,7 @@ static const char squash_msg[] = "SQUASH_MSG";
 
 static unsigned char head_sha1[20];
 
-static char *use_message_buffer;
+static const char *use_message_buffer;
 static struct lock_file index_lock; /* real index */
 static struct lock_file false_lock; /* used only for partial commits */
 static enum {
@@ -74,6 +81,11 @@ static enum {
 
 static const char *logfile, *force_author;
 static const char *template_file;
+/*
+ * The _message variables are commit names from which to take
+ * the commit message and/or authorship.
+ */
+static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
@@ -94,7 +106,8 @@ static enum {
 } cleanup_mode;
 static char *cleanup_arg;
 
-static int use_editor = 1, initial_commit, in_merge, include_status = 1;
+static enum commit_whence whence;
+static int use_editor = 1, initial_commit, include_status = 1;
 static int show_ignored_in_status;
 static const char *only_include_assumed;
 static struct strbuf message;
@@ -169,6 +182,36 @@ static struct option builtin_commit_options[] = {
 	OPT_END()
 };
 
+static void determine_whence(struct wt_status *s)
+{
+	if (file_exists(git_path(merge_head)))
+		whence = FROM_MERGE;
+	else if (file_exists(git_path(cherry_pick_head)))
+		whence = FROM_CHERRY_PICK;
+	else
+		whence = FROM_COMMIT;
+	if (s)
+		s->whence = whence;
+}
+
+static const char *whence_s(void)
+{
+	char *s = "";
+
+	switch (whence) {
+	case FROM_COMMIT:
+		break;
+	case FROM_MERGE:
+		s = "merge";
+		break;
+	case FROM_CHERRY_PICK:
+		s = "cherry-pick";
+		break;
+	}
+
+	return s;
+}
+
 static void rollback_index_files(void)
 {
 	switch (commit_style) {
@@ -384,8 +427,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 */
 	commit_style = COMMIT_PARTIAL;
 
-	if (in_merge)
-		die("cannot do a partial commit during a merge.");
+	if (whence != FROM_COMMIT)
+		die("cannot do a partial commit during a %s.", whence_s());
 
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings = 1;
@@ -475,18 +518,18 @@ static void determine_author_info(struct strbuf *author_ident)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (use_message && !renew_authorship) {
+	if (author_message) {
 		const char *a, *lb, *rb, *eol;
 
-		a = strstr(use_message_buffer, "\nauthor ");
+		a = strstr(author_message_buffer, "\nauthor ");
 		if (!a)
-			die("invalid commit: %s", use_message);
+			die("invalid commit: %s", author_message);
 
 		lb = strchrnul(a + strlen("\nauthor "), '<');
 		rb = strchrnul(lb, '>');
 		eol = strchrnul(rb, '\n');
 		if (!*lb || !*rb || !*eol)
-			die("invalid commit: %s", use_message);
+			die("invalid commit: %s", author_message);
 
 		if (lb == a + strlen("\nauthor "))
 			/* \nauthor <foo@example.com> */
@@ -647,11 +690,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	/*
-	 * This final case does not modify the template message,
-	 * it just sets the argument to the prepare-commit-msg hook.
+	 * The remaining cases don't modify the template message, but
+	 * just set the argument(s) to the prepare-commit-msg hook.
 	 */
-	else if (in_merge)
+	else if (whence == FROM_MERGE)
 		hook_arg1 = "merge";
+	else if (whence == FROM_CHERRY_PICK) {
+		hook_arg1 = "commit";
+		hook_arg2 = cherry_pick_head;
+	}
 
 	if (squash_message) {
 		/*
@@ -700,16 +747,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	strbuf_addstr(&committer_ident, git_committer_info(0));
 	if (use_editor && include_status) {
 		char *ai_tmp, *ci_tmp;
-		if (in_merge)
+		if (whence != FROM_COMMIT)
 			fprintf(fp,
 				"#\n"
-				"# It looks like you may be committing a MERGE.\n"
+				"# It looks like you may be committing a %s.\n"
 				"# If this is not correct, please remove the file\n"
 				"#	%s\n"
 				"# and try again.\n"
 				"#\n",
-				git_path(merge_head));
-
+				whence_s(),
+				git_path(whence == FROM_MERGE
+					 ? merge_head
+					 : cherry_pick_head));
 		fprintf(fp,
 			"\n"
 			"# Please enter the commit message for your changes.");
@@ -772,11 +821,19 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	fclose(fp);
 
-	if (!commitable && !in_merge && !allow_empty &&
+	/*
+	 * Reject an attempt to record a non-merge empty commit without
+	 * explicit --allow-empty. In the cherry-pick case, it may be
+	 * empty due to conflict resolution, which the user should okay.
+	 */
+	if (!commitable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(empty_amend_advice, stderr);
+		else if (whence == FROM_CHERRY_PICK)
+			fprintf(stderr, empty_cherry_pick_advice,
+				git_path(cherry_pick_head));
 		return 0;
 	}
 
@@ -904,6 +961,28 @@ static void handle_untracked_files_arg(struct wt_status *s)
 		die("Invalid untracked files mode '%s'", untracked_files_arg);
 }
 
+static const char *read_commit_message(const char *name)
+{
+	const char *out_enc, *out;
+	struct commit *commit;
+
+	commit = lookup_commit_reference_by_name(name);
+	if (!commit)
+		die("could not lookup commit %s", name);
+	out_enc = get_commit_output_encoding();
+	out = logmsg_reencode(commit, out_enc);
+
+	/*
+	 * If we failed to reencode the buffer, just copy it
+	 * byte for byte so the user can try to fix it up.
+	 * This also handles the case where input and output
+	 * encodings are identical.
+	 */
+	if (out == NULL)
+		out = xstrdup(commit->buffer);
+	return out;
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[],
 				      const char *prefix,
@@ -933,8 +1012,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	/* Sanity check options */
 	if (amend && initial_commit)
 		die("You have nothing to amend.");
-	if (amend && in_merge)
-		die("You are in the middle of a merge -- cannot amend.");
+	if (amend && whence != FROM_COMMIT)
+		die("You are in the middle of a %s -- cannot amend.", whence_s());
 	if (fixup_message && squash_message)
 		die("Options --squash and --fixup cannot be used together");
 	if (use_message)
@@ -953,26 +1032,18 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_message = edit_message;
 	if (amend && !use_message && !fixup_message)
 		use_message = "HEAD";
-	if (!use_message && renew_authorship)
+	if (!use_message && whence != FROM_CHERRY_PICK && renew_authorship)
 		die("--reset-author can be used only with -C, -c or --amend.");
 	if (use_message) {
-		const char *out_enc;
-		struct commit *commit;
-
-		commit = lookup_commit_reference_by_name(use_message);
-		if (!commit)
-			die("could not lookup commit %s", use_message);
-		out_enc = get_commit_output_encoding();
-		use_message_buffer = logmsg_reencode(commit, out_enc);
-
-		/*
-		 * If we failed to reencode the buffer, just copy it
-		 * byte for byte so the user can try to fix it up.
-		 * This also handles the case where input and output
-		 * encodings are identical.
-		 */
-		if (use_message_buffer == NULL)
-			use_message_buffer = xstrdup(commit->buffer);
+		use_message_buffer = read_commit_message(use_message);
+		if (!renew_authorship) {
+			author_message = use_message;
+			author_message_buffer = use_message_buffer;
+		}
+	}
+	if (whence == FROM_CHERRY_PICK && !renew_authorship) {
+		author_message = cherry_pick_head;
+		author_message_buffer = read_commit_message(author_message);
 	}
 
 	if (!!also + !!only + !!all + !!interactive > 1)
@@ -1123,7 +1194,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	wt_status_prepare(&s);
 	gitmodules_config();
 	git_config(git_status_config, &s);
-	in_merge = file_exists(git_path(merge_head));
+	determine_whence(&s);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
@@ -1146,7 +1217,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	}
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
-	s.in_merge = in_merge;
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	wt_status_collect(&s);
 
@@ -1308,8 +1378,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	wt_status_prepare(&s);
 	git_config(git_commit_config, &s);
-	in_merge = file_exists(git_path(merge_head));
-	s.in_merge = in_merge;
+	determine_whence(&s);
 
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
@@ -1346,7 +1415,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 		for (c = commit->parents; c; c = c->next)
 			pptr = &commit_list_insert(c->item, pptr)->next;
-	} else if (in_merge) {
+	} else if (whence == FROM_MERGE) {
 		struct strbuf m = STRBUF_INIT;
 		FILE *fp;
 
@@ -1375,7 +1444,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			parents = reduce_heads(parents);
 	} else {
 		if (!reflog_msg)
-			reflog_msg = "commit";
+			reflog_msg = (whence == FROM_CHERRY_PICK)
+					? "commit (cherry-pick)"
+					: "commit";
 		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
 
diff --git a/builtin/revert.c b/builtin/revert.c
index fbb465a..2ecc6e1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -3,7 +3,6 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
-#include "wt-status.h"
 #include "run-command.h"
 #include "exec_cmd.h"
 #include "utf8.h"
@@ -198,56 +197,6 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
 	strbuf_addstr(msgbuf, p);
 }
 
-static void set_author_ident_env(const char *message)
-{
-	const char *p = message;
-	if (!p)
-		die ("Could not read commit message of %s",
-				sha1_to_hex(commit->object.sha1));
-	while (*p && *p != '\n') {
-		const char *eol;
-
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
-		if (!prefixcmp(p, "author ")) {
-			char *line, *pend, *email, *timestamp;
-
-			p += 7;
-			line = xmemdupz(p, eol - p);
-			email = strchr(line, '<');
-			if (!email)
-				die ("Could not extract author email from %s",
-					sha1_to_hex(commit->object.sha1));
-			if (email == line)
-				pend = line;
-			else
-				for (pend = email; pend != line + 1 &&
-						isspace(pend[-1]); pend--);
-					; /* do nothing */
-			*pend = '\0';
-			email++;
-			timestamp = strchr(email, '>');
-			if (!timestamp)
-				die ("Could not extract author time from %s",
-					sha1_to_hex(commit->object.sha1));
-			*timestamp = '\0';
-			for (timestamp++; *timestamp && isspace(*timestamp);
-					timestamp++)
-				; /* do nothing */
-			setenv("GIT_AUTHOR_NAME", line, 1);
-			setenv("GIT_AUTHOR_EMAIL", email, 1);
-			setenv("GIT_AUTHOR_DATE", timestamp, 1);
-			free(line);
-			return;
-		}
-		p = eol;
-		if (*p == '\n')
-			p++;
-	}
-	die ("No author information found in %s",
-			sha1_to_hex(commit->object.sha1));
-}
-
 static void write_cherry_pick_head(void)
 {
 	int fd;
@@ -290,9 +239,7 @@ static void print_advice(void)
 
 	advise("after resolving the conflicts, mark the corrected paths");
 	advise("with 'git add <paths>' or 'git rm <paths>'");
-
-	if (action == CHERRY_PICK)
-		advise("and commit the result with 'git commit -c CHERRY_PICK_HEAD'");
+	advise("and commit the result with 'git commit'");
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
@@ -518,7 +465,6 @@ static int do_pick_commit(void)
 		base_label = msg.parent_label;
 		next = commit;
 		next_label = msg.label;
-		set_author_ident_env(msg.message);
 		add_message_to_msg(&msgbuf, msg.message);
 		if (no_replay) {
 			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index ea52720..3e8d177 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -57,7 +57,7 @@ test_expect_success 'advice from failed cherry-pick' "
 	error: could not apply \$picked... picked
 	hint: after resolving the conflicts, mark the corrected paths
 	hint: with 'git add <paths>' or 'git rm <paths>'
-	hint: and commit the result with 'git commit -c CHERRY_PICK_HEAD'
+	hint: and commit the result with 'git commit'
 	EOF
 	test_must_fail git cherry-pick picked 2>actual &&
 
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index 77b6920..b61fd3c 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -157,4 +157,33 @@ test_expect_success '--reset-author should be rejected without -c/-C/--amend' '
 	test_must_fail git commit -a --reset-author -m done
 '
 
+test_expect_success 'commit respects CHERRY_PICK_HEAD and MERGE_MSG' '
+	echo "cherry-pick 1a" >>foo &&
+	test_tick &&
+	git commit -am "cherry-pick 1" --author="Cherry <cherry@pick.er>" &&
+	git tag cherry-pick-head &&
+	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	echo "This is a MERGE_MSG" >.git/MERGE_MSG &&
+	echo "cherry-pick 1b" >>foo &&
+	test_tick &&
+	git commit -a &&
+	author_header cherry-pick-head >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual &&
+
+	echo "This is a MERGE_MSG" >expect &&
+	message_body HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--reset-author with CHERRY_PICK_HEAD' '
+	git rev-parse cherry-pick-head >.git/CHERRY_PICK_HEAD &&
+	echo "cherry-pick 2" >>foo &&
+	test_tick &&
+	git commit -am "cherry-pick 2" --reset-author &&
+	echo "author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE" >expect &&
+	author_header HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 123582b..fbaaf54 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -60,7 +60,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
 	if (!advice_status_hints)
 		return;
-	if (s->in_merge)
+	if (s->whence != FROM_COMMIT)
 		;
 	else if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
@@ -77,7 +77,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
 	if (!advice_status_hints)
 		return;
-	if (s->in_merge)
+	if (s->whence != FROM_COMMIT)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
diff --git a/wt-status.h b/wt-status.h
index 20b17cf..cec482a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -24,6 +24,13 @@ enum untracked_status_type {
 	SHOW_ALL_UNTRACKED_FILES
 };
 
+/* from where does this commit originate */
+enum commit_whence {
+	FROM_COMMIT,     /* normal */
+	FROM_MERGE,      /* commit came from merge */
+	FROM_CHERRY_PICK /* commit came from cherry-pick */
+};
+
 struct wt_status_change_data {
 	int worktree_status;
 	int index_status;
@@ -40,7 +47,7 @@ struct wt_status {
 	const char **pathspec;
 	int verbose;
 	int amend;
-	int in_merge;
+	enum commit_whence whence;
 	int nowarn;
 	int use_color;
 	int relative_paths;
-- 
1.7.4.1.30.g7fe09
