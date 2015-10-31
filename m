From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v2] checkout: refactor of --progress option
Date: Sat, 31 Oct 2015 12:47:16 -0600
Message-ID: <1446317236-18051-1-git-send-email-eantoranz@gmail.com>
Cc: peff@peff.net, Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 19:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsbBb-0007L3-QT
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 19:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbbJaSr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 14:47:28 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36678 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbJaSr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 14:47:27 -0400
Received: by ykba4 with SMTP id a4so105397116ykb.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 11:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wvd16B2LEHUTni3QczLpg1cymWxlsmjBROZh3vD0cbI=;
        b=TTqch5TX1254+7rUbGCn7dIQVMaXInJxv0gZMNBNzU/+Gozo5v2uaDmYA1vTURqRh4
         5/T4o71G8EujTns0EtXNYjUOT+muMiQe4fMbSTM1WvnNvEI4c03w4IpKd504VB8q6B9s
         Yi37YEB81mjscVyugEZu8Opem1vNUW81yjsJEeLKlzMOF7/PuQLjPq3aEf2FV2Om/8/O
         qaJWUKYAPrYEMe8kzZuhoR/tqbR2J5+cUMd7G97N6NE2spSkyugH5mZsAjwlSDJ8Mi+o
         txX31B3poKdkHkM97O16MSEfR3FXDrrLRtkTyzNSGx6lr6UDwhOHSSy8Q9viBUBAEvsT
         S7Kg==
X-Received: by 10.129.153.70 with SMTP id q67mr11008245ywg.59.1446317246802;
        Sat, 31 Oct 2015 11:47:26 -0700 (PDT)
Received: from linuxerio.cabletica.com (ip157-11-15-186.ct.co.cr. [186.15.11.157])
        by smtp.gmail.com with ESMTPSA id j23sm8025223ywb.10.2015.10.31.11.47.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 31 Oct 2015 11:47:26 -0700 (PDT)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280598>

- removed static variable show_progress
- processing if progress will be shown or not right
  after running parse_options()

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/checkout.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e28c36b..81c9e6f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -27,8 +27,6 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
-static int option_progress = -1;
-
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -39,6 +37,7 @@ struct checkout_opts {
 	int overwrite_ignore;
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
+	int show_progress;
 
 	const char *new_branch;
 	const char *new_branch_force;
@@ -419,19 +418,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.reset = 1;
 	opts.merge = 1;
 	opts.fn = oneway_merge;
-	/**
-	 * Rules to display progress:
-	 * -q is selected
-	 *      no verbiage
-	 * -q is _not_ selected and --no-progress _is_ selected,
-	 *      progress will be skipped
-	 * -q is _not_ selected and --progress _is_ selected,
-	 *      progress will be printed to stderr
-	 * -q is _not_ selected and --progress is 'undefined'
-	 *      progress will be printed to stderr _if_ working on a terminal
-	 */
-	opts.verbose_update = !o->quiet && (option_progress > 0 ||
-					   (option_progress < 0 && isatty(2)));
+	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	parse_tree(tree);
@@ -515,7 +502,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		topts.update = 1;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
-		topts.verbose_update = !opts->quiet && isatty(2);
+		topts.verbose_update = opts->show_progress;
 		topts.fn = twoway_merge;
 		if (opts->overwrite_ignore) {
 			topts.dir = xcalloc(1, sizeof(*topts.dir));
@@ -1170,7 +1157,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
-		OPT_BOOL(0, "progress", &option_progress, N_("force progress reporting")),
+		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
@@ -1178,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&new, 0, sizeof(new));
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
+	opts.show_progress = -1;
 
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
@@ -1187,6 +1175,22 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	/*
+	 * Final processing of show_progress
+	 * Any of these 3 conditions will make progress output be skipped:
+	 * - selected --quiet
+	 * - selected --no-progress
+	 * - didn't select --progress and not working on a terminal
+	 */
+	if (opts.show_progress) {
+		/* user selected --progress or didn't specify */
+		if (opts.quiet) {
+			opts.show_progress = 0;
+		} else if (opts.show_progress < 0) {
+			opts.show_progress = isatty(2);
+		}
+	}
+
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
-- 
2.6.1
