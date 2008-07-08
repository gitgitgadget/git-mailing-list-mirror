From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/3] git-blame: migrate to incremental parse-option [2/2]
Date: Tue,  8 Jul 2008 15:19:35 +0200
Message-ID: <1215523175-28436-4-git-send-email-madcoder@debian.org>
References: <1215523175-28436-1-git-send-email-madcoder@debian.org>
 <1215523175-28436-2-git-send-email-madcoder@debian.org>
 <1215523175-28436-3-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:20:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGD7V-0002yx-4I
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 15:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYGHNTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbYGHNTj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 09:19:39 -0400
Received: from pan.madism.org ([88.191.52.104]:33611 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbYGHNTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 09:19:39 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9019234452;
	Tue,  8 Jul 2008 15:19:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DBDE65A15DD; Tue,  8 Jul 2008 15:19:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.396.gca539
In-Reply-To: <1215523175-28436-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87762>

Now use handle_revision_args instead of parse_revisions, and simplify the
handling of old-style arguments a lot thanks to the filtering.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-blame.c |  130 ++++++++++++++++---------------------------------------
 1 files changed, 38 insertions(+), 92 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 5e82cd3..99f5140 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2262,8 +2262,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct scoreboard sb;
 	struct origin *o;
 	struct blame_entry *ent;
-	int i, seen_dashdash, unk;
-	long bottom, top, lno;
+	long dashdash_pos, bottom, top, lno;
 	const char *final_commit_name = NULL;
 	enum object_type type;
 
@@ -2301,6 +2300,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
+	dashdash_pos = 0;
 
 	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
 			    PARSE_OPT_KEEP_ARGV0);
@@ -2311,6 +2311,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		case PARSE_OPT_HELP:
 			exit(129);
 		case PARSE_OPT_DONE:
+			if (ctx.argv[0])
+				dashdash_pos = ctx.cpidx;
 			goto parse_done;
 		}
 
@@ -2330,20 +2332,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
-	seen_dashdash = 0;
-	for (unk = i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (*arg != '-')
-			break;
-		else if (!strcmp("--", arg)) {
-			seen_dashdash = 1;
-			i++;
-			break;
-		}
-		else
-			argv[unk++] = arg;
-	}
-
 	if (!blame_move_score)
 		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
 	if (!blame_copy_score)
@@ -2356,92 +2344,50 @@ parse_done:
 	 *
 	 * The remaining are:
 	 *
-	 * (1) if seen_dashdash, its either
-	 *     "-options -- <path>" or
-	 *     "-options -- <path> <rev>".
-	 *     but the latter is allowed only if there is no
-	 *     options that we passed to revision machinery.
+	 * (1) if dashdash_pos != 0, its either
+	 *     "blame [revisions] -- <path>" or
+	 *     "blame -- <path> <rev>"
 	 *
-	 * (2) otherwise, we may have "--" somewhere later and
-	 *     might be looking at the first one of multiple 'rev'
-	 *     parameters (e.g. " master ^next ^maint -- path").
-	 *     See if there is a dashdash first, and give the
-	 *     arguments before that to revision machinery.
-	 *     After that there must be one 'path'.
+	 * (2) otherwise, its one of the two:
+	 *     "blame [revisions] <path>"
+	 *     "blame <path> <rev>"
 	 *
-	 * (3) otherwise, its one of the three:
-	 *     "-options <path> <rev>"
-	 *     "-options <rev> <path>"
-	 *     "-options <path>"
-	 *     but again the first one is allowed only if
-	 *     there is no options that we passed to revision
-	 *     machinery.
+	 * Note that we must strip out <path> from the arguments: we do not
+	 * want the path pruning but we may want "bottom" processing.
 	 */
-
-	if (seen_dashdash) {
-		/* (1) */
-		if (argc <= i)
-			usage_with_options(blame_opt_usage, options);
-		path = add_prefix(prefix, argv[i]);
-		if (i + 1 == argc - 1) {
-			if (unk != 1)
+	if (dashdash_pos) {
+		switch (argc - dashdash_pos - 1) {
+		case 2: /* (1b) */
+			if (argc != 4)
 				usage_with_options(blame_opt_usage, options);
-			argv[unk++] = argv[i + 1];
+			/* reorder for the new way: <rev> -- <path> */
+			argv[1] = argv[3];
+			argv[3] = argv[2];
+			argv[2] = "--";
+			/* FALLTHROUGH */
+		case 1: /* (1a) */
+			path = add_prefix(prefix, argv[--argc]);
+			argv[argc] = NULL;
+			break;
+		default:
+			usage_with_options(blame_opt_usage, options);
 		}
-		else if (i + 1 != argc)
-			/* garbage at end */
+	} else {
+		if (argc < 2)
 			usage_with_options(blame_opt_usage, options);
-	}
-	else {
-		int j;
-		for (j = i; !seen_dashdash && j < argc; j++)
-			if (!strcmp(argv[j], "--"))
-				seen_dashdash = j;
-		if (seen_dashdash) {
-			/* (2) */
-			if (seen_dashdash + 1 != argc - 1)
-				usage_with_options(blame_opt_usage, options);
-			path = add_prefix(prefix, argv[seen_dashdash + 1]);
-			for (j = i; j < seen_dashdash; j++)
-				argv[unk++] = argv[j];
+		path = add_prefix(prefix, argv[argc - 1]);
+		if (argc == 3 && !has_path_in_work_tree(path)) { /* (2b) */
+			path = add_prefix(prefix, argv[1]);
+			argv[1] = argv[2];
 		}
-		else {
-			/* (3) */
-			if (argc <= i)
-				usage_with_options(blame_opt_usage, options);
-			path = add_prefix(prefix, argv[i]);
-			if (i + 1 == argc - 1) {
-				final_commit_name = argv[i + 1];
-
-				/* if (unk == 1) we could be getting
-				 * old-style
-				 */
-				if (unk == 1 && !has_path_in_work_tree(path)) {
-					path = add_prefix(prefix, argv[i + 1]);
-					final_commit_name = argv[i];
-				}
-			}
-			else if (i != argc - 1)
-				usage_with_options(blame_opt_usage, options);
+		argv[argc - 1] = "--";
 
-			setup_work_tree();
-			if (!has_path_in_work_tree(path))
-				die("cannot stat path %s: %s",
-				    path, strerror(errno));
-		}
+		setup_work_tree();
+		if (!has_path_in_work_tree(path))
+			die("cannot stat path %s: %s", path, strerror(errno));
 	}
 
-	if (final_commit_name)
-		argv[unk++] = final_commit_name;
-
-	/*
-	 * Now we got rev and path.  We do not want the path pruning
-	 * but we may want "bottom" processing.
-	 */
-	argv[unk++] = "--"; /* terminate the rev name */
-	argv[unk] = NULL;
-
-	setup_revisions(unk, argv, &revs, NULL);
+	setup_revisions(argc, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
 	sb.revs = &revs;
-- 
1.5.6.2.396.gca539
