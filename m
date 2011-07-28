From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 13/18] revert: Introduce --reset to remove sequencer state
Date: Thu, 28 Jul 2011 22:22:26 +0530
Message-ID: <1311871951-3497-14-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 19:03:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTzg-0008LG-Ah
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab1G1RD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 13:03:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54896 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab1G1RD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 13:03:26 -0400
Received: by mail-gy0-f174.google.com with SMTP id 3so1958339gyh.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZuCu1OWLe2/nGaHrNxcaNPEdTndSPy/zPh7PNqrzTsE=;
        b=DCe0auBWyrex4ysAaaMg4acOf7Fo8DYF8twVGrGoHWfsyQ18kCs2xk9T2t0F1dghmI
         6B8qvL3ksnjKTis0TVq63TWd0HG0F0wRBgrTNIl0iWuLeLdE2XKDO/NGfKu60R1y10RV
         KVvqN+67l6YQj27byoJSU+IhiV1e4c2w5FACU=
Received: by 10.42.157.131 with SMTP id d3mr155487icx.424.1311872193261;
        Thu, 28 Jul 2011 09:56:33 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178101>

To explicitly remove the sequencer state for a fresh cherry-pick or
revert invocation, introduce a new subcommand called "--reset" to
remove the sequencer state.

Take the opportunity to publicly expose the sequencer paths, and a
generic function called "remove_sequencer_state" that various git
programs can use to remove the sequencer state in a uniform manner;
"git reset" uses it later in this series.  Introducing this public API
is also in line with our long-term goal of eventually factoring out
functions from revert.c into a generic commit sequencer.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt |    5 +++
 Documentation/git-revert.txt      |    5 +++
 Documentation/sequencer.txt       |    4 ++
 Makefile                          |    2 +
 builtin/revert.c                  |   63 +++++++++++++++++++++++++------------
 sequencer.c                       |   19 +++++++++++
 sequencer.h                       |   20 ++++++++++++
 t/t3510-cherry-pick-sequence.sh   |   18 +++++++++-
 8 files changed, 114 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/sequencer.txt
 create mode 100644 sequencer.c
 create mode 100644 sequencer.h

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 6c9c2cb..12a85ba 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
+'git cherry-pick' --reset
 
 DESCRIPTION
 -----------
@@ -110,6 +111,10 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+SEQUENCER SUBCOMMANDS
+---------------------
+include::sequencer.txt[]
+
 EXAMPLES
 --------
 git cherry-pick master::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 3d0a7d1..31c85b4 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' --reset
 
 DESCRIPTION
 -----------
@@ -91,6 +92,10 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+SEQUENCER SUBCOMMANDS
+---------------------
+include::sequencer.txt[]
+
 EXAMPLES
 --------
 git revert HEAD~3::
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
new file mode 100644
index 0000000..16ce88c
--- /dev/null
+++ b/Documentation/sequencer.txt
@@ -0,0 +1,4 @@
+--reset::
+	Forget about the current operation in progress.  Can be used
+	to clear the sequencer state after a failed cherry-pick or
+	revert.
diff --git a/Makefile b/Makefile
index 4ed7996..afd7673 100644
--- a/Makefile
+++ b/Makefile
@@ -554,6 +554,7 @@ LIB_H += rerere.h
 LIB_H += resolve-undo.h
 LIB_H += revision.h
 LIB_H += run-command.h
+LIB_H += sequencer.h
 LIB_H += sha1-array.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
@@ -658,6 +659,7 @@ LIB_OBJS += revision.o
 LIB_OBJS += run-command.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
+LIB_OBJS += sequencer.o
 LIB_OBJS += sha1-array.o
 LIB_OBJS += sha1-lookup.o
 LIB_OBJS += sha1_file.o
diff --git a/builtin/revert.c b/builtin/revert.c
index 14259db..70b9f65 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -14,6 +14,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "dir.h"
+#include "sequencer.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -28,18 +29,22 @@
 
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
+	"git revert <subcommand>",
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
 	"git cherry-pick [options] <commit-ish>",
+	"git cherry-pick <subcommand>",
 	NULL
 };
 
 enum replay_action { REVERT, CHERRY_PICK };
+enum replay_subcommand { REPLAY_NONE, REPLAY_RESET };
 
 struct replay_opts {
 	enum replay_action action;
+	enum replay_subcommand subcommand;
 
 	/* Boolean options */
 	int edit;
@@ -61,11 +66,6 @@ struct replay_opts {
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-#define SEQ_DIR         "sequencer"
-#define SEQ_HEAD_FILE   "sequencer/head"
-#define SEQ_TODO_FILE   "sequencer/todo"
-#define SEQ_OPTS_FILE   "sequencer/opts"
-
 static const char *action_name(const struct replay_opts *opts)
 {
 	return opts->action == REVERT ? "revert" : "cherry-pick";
@@ -113,7 +113,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	int noop;
+	int reset = 0;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "reset", &reset, "forget the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -142,7 +144,27 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
-	if (opts->commit_argc < 2)
+
+	/* Set the subcommand */
+	if (reset)
+		opts->subcommand = REPLAY_RESET;
+	else
+		opts->subcommand = REPLAY_NONE;
+
+	/* Check for incompatible command line arguments */
+	if (opts->subcommand == REPLAY_RESET) {
+		verify_opt_compatible(me, "--reset",
+				"--no-commit", opts->no_commit,
+				"--signoff", opts->signoff,
+				"--mainline", opts->mainline,
+				"--strategy", opts->strategy ? 1 : 0,
+				"--strategy-option", opts->xopts ? 1 : 0,
+				"-x", opts->record_origin,
+				"--ff", opts->allow_ff,
+				NULL);
+	}
+
+	else if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	if (opts->allow_ff)
@@ -731,7 +753,6 @@ static void save_opts(struct replay_opts *opts)
 
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct commit_list *cur;
 	int res;
 
@@ -752,9 +773,7 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s", git_path(SEQ_DIR));
-	remove_dir_recursively(&buf, 0);
+	remove_sequencer_state(1);
 	return 0;
 }
 
@@ -765,17 +784,21 @@ static int pick_revisions(struct replay_opts *opts)
 
 	read_and_refresh_cache(opts);
 
-	walk_revs_populate_todo(&todo_list, opts);
-	create_seq_dir();
-	if (get_sha1("HEAD", sha1)) {
-		if (opts->action == REVERT)
-			die(_("Can't revert as initial commit"));
-		die(_("Can't cherry-pick into empty head"));
-	} else
+	if (opts->subcommand == REPLAY_RESET) {
+		remove_sequencer_state(1);
+		return 0;
+	} else {
+		/* Start a new cherry-pick/ revert sequence */
+		walk_revs_populate_todo(&todo_list, opts);
+		create_seq_dir();
+		if (get_sha1("HEAD", sha1)) {
+			if (opts->action == REVERT)
+				die(_("Can't revert as initial commit"));
+			die(_("Can't cherry-pick into empty head"));
+		}
 		save_head(sha1_to_hex(sha1));
-	save_opts(opts);
-	save_todo(todo_list, opts);
-
+		save_opts(opts);
+	}
 	return pick_commits(todo_list, opts);
 }
 
diff --git a/sequencer.c b/sequencer.c
new file mode 100644
index 0000000..bc2c046
--- /dev/null
+++ b/sequencer.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+#include "sequencer.h"
+#include "strbuf.h"
+#include "dir.h"
+
+void remove_sequencer_state(int aggressive)
+{
+	struct strbuf seq_dir = STRBUF_INIT;
+	struct strbuf seq_old_dir = STRBUF_INIT;
+
+	strbuf_addf(&seq_dir, "%s", git_path(SEQ_DIR));
+	strbuf_addf(&seq_old_dir, "%s", git_path(SEQ_OLD_DIR));
+	remove_dir_recursively(&seq_old_dir, 0);
+	rename(git_path(SEQ_DIR), git_path(SEQ_OLD_DIR));
+	if (aggressive)
+		remove_dir_recursively(&seq_old_dir, 0);
+	strbuf_release(&seq_dir);
+	strbuf_release(&seq_old_dir);
+}
diff --git a/sequencer.h b/sequencer.h
new file mode 100644
index 0000000..905d295
--- /dev/null
+++ b/sequencer.h
@@ -0,0 +1,20 @@
+#ifndef SEQUENCER_H
+#define SEQUENCER_H
+
+#define SEQ_DIR		"sequencer"
+#define SEQ_OLD_DIR	"sequencer-old"
+#define SEQ_HEAD_FILE	"sequencer/head"
+#define SEQ_TODO_FILE	"sequencer/todo"
+#define SEQ_OPTS_FILE	"sequencer/opts"
+
+/*
+ * Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
+ * any errors.  Intended to be used by 'git reset'.
+ *
+ * With the aggressive flag, it additionally removes SEQ_OLD_DIR,
+ * ignoring any errors.  Inteded to be used by the sequencer's
+ * '--reset' subcommand.
+ */
+void remove_sequencer_state(int aggressive);
+
+#endif
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index f3fab7d..49df209 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -40,7 +40,7 @@ test_expect_success 'cherry-pick persists data on failure' '
 '
 
 test_expect_success 'cherry-pick persists opts correctly' '
-	rm -rf .git/sequencer &&
+	git cherry-pick --reset &&
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
@@ -65,10 +65,24 @@ test_expect_success 'cherry-pick persists opts correctly' '
 '
 
 test_expect_success 'cherry-pick cleans up sequencer state upon success' '
-	rm -rf .git/sequencer &&
+	git cherry-pick --reset &&
 	pristine_detach initial &&
 	git cherry-pick initial..picked &&
 	test_path_is_missing .git/sequencer
 '
 
+test_expect_success '--reset does not complain when no cherry-pick is in progress' '
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	git cherry-pick --reset
+'
+
+test_expect_success '--reset cleans up sequencer state' '
+	git cherry-pick --reset &&
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --reset &&
+	test_path_is_missing .git/sequencer
+'
+
 test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
