From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 04/28] revert/cherry-pick: add --skip option
Date: Fri, 30 Aug 2013 00:55:58 -0500
Message-ID: <1377842182-18724-5-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHlq-0007Bo-GA
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab3H3GBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:14 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:41260 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3H3GBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:10 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so1483448obc.35
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sV3qXXIyaO6rVDEAElRln2m0Dxduc7e3zEjEWr7dm3E=;
        b=gyXoiC0uCBe1IRd0xVQcEyn0sb1/f3svTXSBBWXun/IrovTmDkLC+CTYRNKvtif3Od
         Q9R1O6JMkQ22tyMdcS/7jtzJfu1zuBgzkTG9CrpU1VWn+KYwoMCtBnP6sU6rmTnxtNyG
         27O0DqYDAD22P8DidVdS4ynqpUrXnh4xA+ZXQRMALdHUXn1+xnd79CJ/slOpLRgDDjmH
         nBDk18J67nYuRB6ZNfhDR2d3rf37UKf7Ay/Dhdg2YxFcm3wTE1H/rMqbKdA7p8FGonpu
         Uy93iozeEgL7UdbL7V+2jjRJ70R40Ok6LClFIPyHBgHOgfp3cvlo8LnRa27Zu8TA//Lu
         OiOg==
X-Received: by 10.182.48.230 with SMTP id p6mr5683599obn.1.1377842470326;
        Thu, 29 Aug 2013 23:01:10 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm36892685oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233401>

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
index 98a8e7a..52e146e 100644
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
index 7a7fde6..d3ae2c4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -101,11 +101,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	int remove_state = 0;
 	int contin = 0;
 	int rollback = 0;
+	int skip = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_BOOLEAN(0, "quit", &remove_state, N_("end revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "continue", &contin, N_("resume revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "abort", &rollback, N_("cancel revert or cherry-pick sequence")),
+		OPT_BOOLEAN(0, "skip", &skip, N_("skip current commit in the sequence")),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOLEAN('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
@@ -166,6 +168,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->subcommand = REPLAY_CONTINUE;
 	else if (rollback)
 		opts->subcommand = REPLAY_ROLLBACK;
+	else if (skip)
+		opts->subcommand = REPLAY_SKIP;
 	else
 		opts->subcommand = REPLAY_NONE;
 
@@ -176,6 +180,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			this_operation = "--quit";
 		else if (opts->subcommand == REPLAY_CONTINUE)
 			this_operation = "--continue";
+		else if (opts->subcommand == REPLAY_SKIP)
+			this_operation = "--skip";
 		else {
 			assert(opts->subcommand == REPLAY_ROLLBACK);
 			this_operation = "--abort";
diff --git a/sequencer.c b/sequencer.c
index d6199e4..d0e65de 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1056,6 +1056,28 @@ static int sequencer_continue(struct replay_opts *opts)
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
@@ -1086,6 +1108,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
1.8.4-fc
