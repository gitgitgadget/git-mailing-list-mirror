From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 1/8] cherry-pick, revert: add the --gpg-sign option
Date: Sun,  3 Nov 2013 16:54:17 +0100
Message-ID: <1383494064-5653-2-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd01J-0008DK-Bt
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab3KCPyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:53 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35773 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3KCPym (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 780654E5A
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:54:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9IP97UKoFKxB; Sun,  3 Nov 2013 16:54:56 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 72C603ECC;
	Sun,  3 Nov 2013 16:54:56 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 14AC243934; Sun,  3 Nov 2013 16:54:40 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237268>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-cherry-pick.txt | 7 ++++++-
 Documentation/git-revert.txt      | 6 +++++-
 builtin/revert.c                  | 2 ++
 sequencer.c                       | 7 +++++++
 sequencer.h                       | 2 ++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d2363e42..f1e6b2fd6d15 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -8,7 +8,8 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 SYNOPSIS
 --------
 [verse]
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
+		  [-S[<keyid>]] <commit>...
 'git cherry-pick' --continue
 'git cherry-pick' --quit
 'git cherry-pick' --abort
@@ -100,6 +101,10 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commits.
+
 --ff::
 	If the current HEAD is the same as the parent of the
 	cherry-pick'ed commit, then a fast forward to this commit will
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 2de67a54962b..9eb83f01a451 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
+'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
 'git revert' --continue
 'git revert' --quit
 'git revert' --abort
@@ -80,6 +80,10 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commits.
+
 -s::
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
diff --git a/builtin/revert.c b/builtin/revert.c
index 87659c9fdb74..065d88dd05ea 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -89,6 +89,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge strategy")),
 		OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
 			N_("option for merge strategy"), option_parse_x),
+		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key id"),
+		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
diff --git a/sequencer.c b/sequencer.c
index 06e52b4c83ff..b10a90fe70f6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -392,11 +392,18 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 {
 	struct argv_array array;
 	int rc;
+	char *gpg_sign;
 
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
+	if (opts->gpg_sign) {
+		gpg_sign = xmalloc(3 + strlen(opts->gpg_sign));
+		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
+		argv_array_push(&array, gpg_sign);
+		free(gpg_sign);
+	}
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
 	if (!opts->edit) {
diff --git a/sequencer.h b/sequencer.h
index 1fc22dcabe13..db43e9cf86dc 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -37,6 +37,8 @@ struct replay_opts {
 
 	int mainline;
 
+	const char *gpg_sign;
+
 	/* Merge strategy */
 	const char *strategy;
 	const char **xopts;
-- 
1.8.4.2
