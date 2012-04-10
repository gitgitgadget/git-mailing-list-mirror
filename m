From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 11:47:45 -0400
Message-ID: <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 17:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHdIv-0004NT-D6
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 17:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759070Ab2DJPsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 11:48:15 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:49324 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab2DJPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 11:48:14 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SHdIf-0005Wx-FF; Tue, 10 Apr 2012 11:48:11 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195097>

git cherry-pick fails when picking a non-ff commit that is empty.  The advice
given with the failure is that a git-commit --allow-empty should be issued to
explicitly add the empty commit during the cherry pick.  This option allows a
user to specify before hand that they want to keep the empty commit.  This
eliminates the need to issue both a cherry pick and a commit operation.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 Documentation/git-cherry-pick.txt |    9 +++++++++
 builtin/commit.c                  |    6 +++---
 builtin/revert.c                  |    2 ++
 sequencer.c                       |    7 +++++--
 sequencer.h                       |    1 +
 5 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index fed5097..730237a 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -103,6 +103,15 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
+--allow-empty::
+	By default, cherry-picking an empty commit will fail,
+	indicating that an explicit invocation of `git commit
+	--allow-empty` is required. This option overrides that
+	behavior, allowing empty commits to be preserved automatically
+	in a cherry-pick. Note that when "--ff" is in effect, empty
+	commits that meet the "fast-forward" requirement will be kept
+	even without this option.
+
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/builtin/commit.c b/builtin/commit.c
index 3714582..0cd10ab 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -56,10 +56,10 @@ N_("You asked to amend the most recent commit, but doing so would make\n"
 "remove the commit entirely with \"git reset HEAD^\".\n");
 
 static const char empty_cherry_pick_advice[] =
-N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\n"
-"If you wish to commit it anyway, use:\n"
+N_("The previous cherry-pick is empty.\n"
+"If the commit was created empty, please use:\n"
 "\n"
-"    git commit --allow-empty\n"
+"    git cherry-pick --allow-empty\n"
 "\n"
 "Otherwise, please use 'git reset'\n");
 
diff --git a/builtin/revert.c b/builtin/revert.c
index e6840f2..06b00e6 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -114,12 +114,14 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
 			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
+			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve empty commits"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index a37846a..71929ba 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -260,8 +260,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 {
-	/* 6 is max possible length of our args array including NULL */
-	const char *args[6];
+	/* 7 is max possible length of our args array including NULL */
+	const char *args[7];
 	int i = 0;
 
 	args[i++] = "commit";
@@ -272,6 +272,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts)
 		args[i++] = "-F";
 		args[i++] = defmsg;
 	}
+	if (opts->allow_empty)
+		args[i++] = "--allow-empty";
+
 	args[i] = NULL;
 
 	return run_command_v_opt(args, RUN_GIT_CMD);
diff --git a/sequencer.h b/sequencer.h
index bb4b138..e2cd725 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -29,6 +29,7 @@ struct replay_opts {
 	int signoff;
 	int allow_ff;
 	int allow_rerere_auto;
+	int allow_empty;
 
 	int mainline;
 
-- 
1.7.7.6
