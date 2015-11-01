From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v8] checkout: add --progress option
Date: Sun,  1 Nov 2015 15:19:05 -0600
Message-ID: <1446412745-19658-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, sunshine@sunshineco.com,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 22:19:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt024-0002Lk-8v
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 22:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbbKAVTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 16:19:16 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35255 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbKAVTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 16:19:15 -0500
Received: by ykek133 with SMTP id k133so123135081yke.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 13:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IxlCiXXy0RKtPK8m2WeVC9j75ojQTSONBirLciJvApw=;
        b=rr2S+Ieohktia/69QMCDbfPjy6jtIoPQ7lNl6tAZYSAOIQWewpLuGVTaKHsghMSfes
         DKvin8cFfPaaWnOUuoJdAKkUpQM8MNyziscsuKr38I2cDJvXv3mIWSR3GKd6PQ076y1b
         VOiUhRzizSQfKR7Y4cm9uRtdh8LbiVf4+TCiYnqmHJo/TEklJHveLhujt2KrjV7tTUzU
         cTxLsv8+GmmOZTU555CY2oJe0hUHMBGDAK3b7QjIVmMg7PEnan7Xl+Z5ol1JQ/h4z4p3
         b9HV8ysCv2Mu4m36TWV50sBnlaj33mAKZzNuHgzZ9ZXbOoDZtv8vUQSwrNJhaFHuFwlz
         ZfCw==
X-Received: by 10.13.235.133 with SMTP id u127mr3204503ywe.97.1446412755217;
        Sun, 01 Nov 2015 13:19:15 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id w3sm11495964ywf.47.2015.11.01.13.19.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 13:19:14 -0800 (PST)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280674>

Under normal circumstances, and like other git commands,
git checkout will write progress info to stderr if
attached to a terminal. This option allows progress
to be forced even if not using a terminal. Also,
progress can be skipped if using option --no-progress.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e269fb1..5e5273e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -107,6 +107,12 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
+--[no-]progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless `--quiet`
+	is specified. This flag enables progress reporting even if not
+	attached to a terminal, regardless of `--quiet`.
+
 -f::
 --force::
 	When switching branches, proceed even if the index or the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc703c0..e346f52 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -37,6 +37,7 @@ struct checkout_opts {
 	int overwrite_ignore;
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
+	int show_progress;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -417,7 +418,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	opts.verbose_update = !o->quiet && isatty(2);
+	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -501,7 +502,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet && isatty(2);
+		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -1156,6 +1157,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
@@ -1163,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
+	opts.show_progress = -1;
 
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
@@ -1172,6 +1175,13 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (opts.show_progress < 0) {
+		if (opts.quiet)
+			opts.show_progress = 0;
+		else
+			opts.show_progress = isatty(2);
+	}
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
-- 
2.6.1
