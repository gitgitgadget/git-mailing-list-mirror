From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v3] checkout: add --progress option
Date: Sun,  1 Nov 2015 11:22:25 -0600
Message-ID: <1446398545-8245-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 18:22:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZswL6-0007mU-KL
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbbKARWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 12:22:41 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34569 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbKARWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 12:22:40 -0500
Received: by ykdr3 with SMTP id r3so119529987ykd.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 09:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M8NClMFping1hnYRUy2Vn4pnpEZvc19+6o1Z/hDnaus=;
        b=yXkzeoMgMvQ6AWUmt6p6FSTa6/hi9pQ40WmOAND66/Nw3PiyN+KXoZE2/F9VHMCi+4
         8WUnxLwUrITPlS2Zo290ljaUY/sNRKrbBdBBtNZCG7iLTtp4PHU23xvfgyHA9wZz+PB+
         dgmLc/axnvDQVaHGtACDnpFYnk2pa3ID2OEAOEb0DWj1Ofbq1LzuiaxFwIyE8oE6lOXe
         d3avvgN/M19KbUcvJewJM7z0LOakv2k8Sr7RDL3G6BZbdQSIEf+JUJ3o+nvRfitvkWTO
         IaQaM3zkHesNKP2r3xtnRH0pG1Zl17Yo49XCOmx3G5ukxAziToT5rr//aC/EelI7xXjv
         g4YQ==
X-Received: by 10.13.234.70 with SMTP id t67mr10399280ywe.321.1446398559442;
        Sun, 01 Nov 2015 09:22:39 -0800 (PST)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id c5sm10950952ywf.12.2015.11.01.09.22.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 09:22:38 -0800 (PST)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280636>

Under normal circumstances, and like other git commands,
git checkout will write progress info to stderr if
attached to a terminal. This option allows progress
to be forced even if not using a terminal. Also,
progress can be skipped if using option --no-progress.
---
 Documentation/git-checkout.txt |  6 ++++++
 builtin/checkout.c             | 26 ++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

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
index bc703c0..1bc4efe 100644
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
@@ -1172,6 +1175,25 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
+		/* user selected --progress or didn't specify */
+		if (opts.quiet) {
+			opts.show_progress = 0;
+		} else {
+			opts.show_progress = isatty(2);
+		}
+	}
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
-- 
2.6.1
