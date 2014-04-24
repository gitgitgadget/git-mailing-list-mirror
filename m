From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 04/12] revert/cherry-pick: add --skip option
Date: Wed, 23 Apr 2014 21:44:43 -0500
Message-ID: <1398307491-21314-5-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9p8-0007UD-Gr
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbaDXCzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:36 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51718 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaDXCzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:33 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so2006053obc.39
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aaYN5ZCscpVQEMWSDIbLe7QUNvIR5v+kKUl6LUAg5xs=;
        b=Vs6+AcKVQmNqnVtfH8zn928zoFHnK6yk4D5n3wj7pcXzE9xxgwjyp9kbmwop0fVMdx
         PqiLPyF8pduUGNVLXCK0eGM0cxGnc+6QAxwiCeBtHinl9ATYB3G39QpjeoqtauK7pJzp
         bzYxTB+U3dHGIOjad3i1Tcn3cagHRM76WckbhC2EdMfcDzJPHm3dyAlc87cdUHLvBVNn
         fLBH58bxrpdTPzyzOvhLKvgjOm5rppyhTRzoIxK8BX0vAELQ1PF3QGass04N8CE+/eD2
         IT4kXnz/7C1OPT1KnxRw2gVi8ez4pEnTwC85/oibC/D7Qm1OuGI6KtGK88icCVTobKRd
         oz7w==
X-Received: by 10.60.132.12 with SMTP id oq12mr41074450oeb.42.1398308132363;
        Wed, 23 Apr 2014 19:55:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm11816947oeb.10.2014.04.23.19.55.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246918>

Akin to 'am --skip' and 'rebase --skip'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt |  1 +
 Documentation/git-revert.txt      |  1 +
 Documentation/sequencer.txt       |  3 +++
 builtin/revert.c                  |  6 ++++++
 sequencer.c                       | 24 ++++++++++++++++++++++++
 sequencer.h                       |  3 ++-
 t/t3510-cherry-pick-sequence.sh   | 12 ++++++++++++
 7 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index da0bd81..d95c63c 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git cherry-pick' [-q] [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 'git cherry-pick' --continue
+'git cherry-pick' --skip
 'git cherry-pick' --quit
 'git cherry-pick' --abort
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 2b51136..14bd299 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git revert' [-q] [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
 'git revert' --continue
+'git revert' --skip
 'git revert' --quit
 'git revert' --abort
 
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 5747f44..df2d355 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -3,6 +3,9 @@
 	'.git/sequencer'.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
 
+--skip::
+	Skip the current commit, and then continue.
+
 --quit::
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
diff --git a/builtin/revert.c b/builtin/revert.c
index c8149ca..54fba63 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -76,11 +76,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	int cmd = 0;
+
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_CMDMODE(0, "quit", &cmd, N_("end revert or cherry-pick sequence"), 'q'),
 		OPT_CMDMODE(0, "continue", &cmd, N_("resume revert or cherry-pick sequence"), 'c'),
 		OPT_CMDMODE(0, "abort", &cmd, N_("cancel revert or cherry-pick sequence"), 'a'),
+		OPT_CMDMODE(0, "skip", &cmd, N_("skip current commit in the sequence"), 's'),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
@@ -128,6 +130,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->subcommand = REPLAY_CONTINUE;
 	else if (cmd == 'a')
 		opts->subcommand = REPLAY_ROLLBACK;
+	else if (cmd == 's')
+		opts->subcommand = REPLAY_SKIP;
 	else
 		opts->subcommand = REPLAY_NONE;
 
@@ -138,6 +142,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			this_operation = "--quit";
 		else if (opts->subcommand == REPLAY_CONTINUE)
 			this_operation = "--continue";
+		else if (opts->subcommand == REPLAY_SKIP)
+			this_operation = "--skip";
 		else {
 			assert(opts->subcommand == REPLAY_ROLLBACK);
 			this_operation = "--abort";
diff --git a/sequencer.c b/sequencer.c
index e8239ac..c01ad08 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1057,6 +1057,28 @@ static int sequencer_continue(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
+static int sequencer_skip(struct replay_opts *opts)
+{
+	const char *argv[4]; /* reset --hard HEAD + NULL */
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	int ret;
+
+	if (setup_rerere(&merge_rr, 0) >= 0) {
+		rerere_clear(&merge_rr);
+		string_list_clear(&merge_rr, 1);
+	}
+
+	argv[0] = "reset";
+	argv[1] = "--hard";
+	argv[2] = "HEAD";
+	argv[3] = NULL;
+	ret = run_command_v_opt(argv, RUN_GIT_CMD);
+	if (ret)
+		return ret;
+
+	return sequencer_continue(opts);
+}
+
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
@@ -1087,6 +1109,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
 		return sequencer_continue(opts);
+	if (opts->subcommand == REPLAY_SKIP)
+		return sequencer_skip(opts);
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		unsigned char sha1[20];
diff --git a/sequencer.h b/sequencer.h
index d37c003..74d592a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -17,7 +17,8 @@ enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
 	REPLAY_CONTINUE,
-	REPLAY_ROLLBACK
+	REPLAY_ROLLBACK,
+	REPLAY_SKIP
 };
 
 struct replay_opts {
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 33c5512..c43c327 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -511,4 +511,16 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'skip' '
+	pristine_detach conflicting &&
+	test_must_fail git cherry-pick initial..picked &&
+
+	git checkout HEAD -- unrelated &&
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --skip &&
+
+	git rev-list initial..HEAD >commits &&
+	test_line_count = 3 commits
+'
+
 test_done
-- 
1.9.2+fc1.2.gfbaae8c
