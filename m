From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] cherry-pick, revert: add the --gpg-sign option
Date: Sun,  3 Nov 2013 19:46:15 +0100
Message-ID: <1383504375-22743-1-git-send-email-boklm@mars-attacks.org>
References: <20131103175015.GA183446@vauxhall.crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org, sandals@crustytoothpaste.net
X-From: git-owner@vger.kernel.org Sun Nov 03 19:46:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd2gw-0002YI-Qt
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 19:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab3KCSq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 13:46:26 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:36518 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab3KCSq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 13:46:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 752C74941;
	Sun,  3 Nov 2013 19:46:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PSz_o0gIRYii; Sun,  3 Nov 2013 19:46:39 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id A2F313ECC;
	Sun,  3 Nov 2013 19:46:39 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 2FDFD43934; Sun,  3 Nov 2013 19:46:23 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <20131103175015.GA183446@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237273>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Helped-by: Brian M. Carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-cherry-pick.txt |  7 ++++++-
 Documentation/git-revert.txt      |  6 +++++-
 builtin/revert.c                  |  2 ++
 sequencer.c                       | 11 +++++++++++
 sequencer.h                       |  2 ++
 5 files changed, 26 insertions(+), 2 deletions(-)

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
index 06e52b4c83ff..2048cd81b3b2 100644
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
@@ -808,6 +815,8 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.strategy"))
 		git_config_string(&opts->strategy, key, value);
+	else if (!strcmp(key, "options.gpg-sign"))
+		git_config_string(&opts->gpg_sign, key, value);
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
@@ -981,6 +990,8 @@ static void save_opts(struct replay_opts *opts)
 	}
 	if (opts->strategy)
 		git_config_set_in_file(opts_file, "options.strategy", opts->strategy);
+	if (opts->gpg_sign)
+		git_config_set_in_file(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
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
