From: Chris Webb <chris@arachsys.com>
Subject: [PATCH] cherry-pick: add --allow-empty-message option
Date: Thu,  2 Aug 2012 11:38:51 +0100
Message-ID: <86938f900c630d983852a250090f2aa6112fcc3c.1343903931.git.chris@arachsys.com>
References: <20120802085554.GI19416@arachsys.com>
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
	Chris Webb <chris@arachsys.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:39:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwsoU-0001ED-GC
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 12:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab2HBKjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 06:39:24 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:35496 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab2HBKjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 06:39:24 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Swso9-0003Qk-J9; Thu, 02 Aug 2012 11:39:13 +0100
X-Mailer: git-send-email 1.7.12.rc0.24.gecb6fd1
In-Reply-To: <20120802085554.GI19416@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202749>

Scripts such as git rebase -i cannot currently cherry-pick commits which
have an empty commit message, as git cherry-pick calls git commit
without the --allow-empty-message option.

Add an --allow-empty-message option to git cherry-pick which is passed
through to git commit, so this behaviour can be overridden.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 Documentation/git-cherry-pick.txt | 5 +++++
 builtin/revert.c                  | 2 ++
 sequencer.c                       | 3 +++
 sequencer.h                       | 1 +
 t/t3505-cherry-pick-empty.sh      | 5 +++++
 5 files changed, 16 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 0e170a5..c205d23 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -118,6 +118,11 @@ effect to your index in a row.
 	previous commit are dropped.  To force the inclusion of those commits
 	use `--keep-redundant-commits`.
 
+--allow-empty-message::
+	By default, cherry-picking a commit with an empty message will fail.
+	This option overrides that behaviour, allowing commits with empty
+	messages to be cherry picked.
+
 --keep-redundant-commits::
 	If a commit being cherry picked duplicates a commit already in the
 	current history, it will become empty.  By default these
diff --git a/builtin/revert.c b/builtin/revert.c
index 82d1bf8..5652f23 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -117,6 +117,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -124,6 +125,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
 			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve initially empty commits"),
+			OPT_BOOLEAN(0, "allow-empty-message", &opts->allow_empty_message, "allow commits with empty messages"),
 			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_redundant_commits, "keep redundant, empty commits"),
 			OPT_END(),
 		};
diff --git a/sequencer.c b/sequencer.c
index bf078f2..1ea5293 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -311,6 +311,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (allow_empty)
 		argv_array_push(&array, "--allow-empty");
 
+	if (opts->allow_empty_message)
+		argv_array_push(&array, "--allow-empty-message");
+
 	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
 	argv_array_clear(&array);
 	return rc;
diff --git a/sequencer.h b/sequencer.h
index aa5f17c..d849420 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -30,6 +30,7 @@ struct replay_opts {
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
+	int allow_empty_message;
 	int keep_redundant_commits;
 
 	int mainline;
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 5a1340c..a0c6e30 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -53,6 +53,11 @@ test_expect_success 'index lockfile was removed' '
 
 '
 
+test_expect_success 'cherry-pick a commit with an empty message with --allow-empty-message' '
+	git checkout -f master &&
+	git cherry-pick --allow-empty-message empty-branch
+'
+
 test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
 	git checkout master &&
 	echo fourth >>file2 &&
