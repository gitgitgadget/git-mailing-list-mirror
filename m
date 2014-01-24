From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/9] cherry-pick, revert: add the --gpg-sign option
Date: Fri, 24 Jan 2014 00:50:58 +0000
Message-ID: <1390524666-51274-2-git-send-email-sandals@crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Uzn-0001lT-LM
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbaAXAvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:19 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51323 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752902AbaAXAvS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:18 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 885F72807A;
	Fri, 24 Jan 2014 00:51:16 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240989>

From: Nicolas Vigier <boklm@mars-attacks.org>

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-cherry-pick.txt |  7 ++++++-
 Documentation/git-revert.txt      |  6 +++++-
 builtin/revert.c                  |  2 ++
 sequencer.c                       | 11 +++++++++++
 sequencer.h                       |  2 ++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d23..f1e6b2f 100644
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
index 2de67a5..9eb83f0 100644
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
index 87659c9..065d88d 100644
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
index 90cac7b..bde5f04 100644
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
index 1fc22dc..db43e9c 100644
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
1.9.rc0.1002.gd081c64.dirty
