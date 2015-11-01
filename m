From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v5] checkout: add --progress option
Date: Sun,  1 Nov 2015 12:03:59 -0600
Message-ID: <1446401039-13848-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 19:04:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zswzw-0001zY-7A
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbbKASEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:04:40 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33400 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbKASEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:04:09 -0500
Received: by ykft191 with SMTP id t191so119873283ykf.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YBRDRjCjW9w52w4w7K4ERpJLaY2IB7uTjiqXRvV34v0=;
        b=EFNIb1JQRdk2wisw675IopBprfUmo3UoYbpPf7cWRAQZEm642ef8pzO2iVHoBK4FPT
         dsD3uZysgGl6vmhLSEzFypufFuk89UptbtceazMTO7Px/r2FDVy02pMs3Kif2kgBEI2E
         JChyZTUGurmnj/huDEzqn74y0Z6Odt8U4anPXO9KYhJ24Vn9V8vErQDSMc/0Muu9uak0
         pOZTNgxeq8r4lPgmuGbBQwpym5OCjK3fa7ubDVOvGl1Z3w7DTkBMw8RYUQBasf+YtThg
         cJxdM80UjLvlHPEilykcc9NesRksMoZNq5GTGJzrP3+n3igVvvpU4lEDtlmsM3Mc/j9I
         pdwQ==
X-Received: by 10.129.56.194 with SMTP id f185mr13510978ywa.142.1446401048231;
        Sun, 01 Nov 2015 10:04:08 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id 17sm11050235ywe.22.2015.11.01.10.04.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 10:04:07 -0800 (PST)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280644>

Under normal circumstances, and like other git commands,
git checkout will write progress info to stderr if
attached to a terminal. This option allows progress
to be forced even if not using a terminal. Also,
progress can be skipped if using option --no-progress.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index e269fb1..93ba35a 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -107,6 +107,12 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
+--progress::
+	Progress status is reported on the standard error stream
+	by default when it is attached to a terminal, unless -q
+	is specified. This flag forces progress status even if the
+	standard error stream is not directed to a terminal.
+
 -f::
 --force::
 	When switching branches, proceed even if the index or the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bc703c0..65b8b90 100644
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
@@ -1172,6 +1175,24 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	/*
+	 * Final processing of show_progress
+	 * - User selected --progress: show progress
+	 * - user selected --no-progress: skip progress
+	 * - User didn't specify:
+	 *     (check rules in order till finding the first matching one)
+	 *     - user selected --quiet: skip progress
+	 *     - stderr is connected to a terminal: show progress
+	 *     - fallback: skip progress
+	 */
+	if (opts.show_progress < 0) {
+		/* user didn't specify --[no-]progress */
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
