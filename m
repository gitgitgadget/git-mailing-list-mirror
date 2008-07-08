From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/3] revisions: split handle_revision_opt from setup_revisions.
Date: Tue,  8 Jul 2008 15:19:33 +0200
Message-ID: <1215523175-28436-2-git-send-email-madcoder@debian.org>
References: <1215523175-28436-1-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGD7V-0002yx-Ve
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 15:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbYGHNTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 09:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbYGHNTm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 09:19:42 -0400
Received: from pan.madism.org ([88.191.52.104]:33623 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbYGHNTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 09:19:40 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9060934453;
	Tue,  8 Jul 2008 15:19:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CF8744F5D08; Tue,  8 Jul 2008 15:19:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.396.gca539
In-Reply-To: <1215523175-28436-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87761>

struct rev_info gains two new field:
* .def to store --default argument;
* .show_merge 1-bit field.

handle_revision_opt is able to deal with any revision option, and consumes
them, and leaves revision arguments or pseudo arguments (like --all,
--not, ...) in place.

For now setup_revisions does a pass of handle_revision_opt again so that
code not using it in a parse-opt parser still work the same.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 revision.c |  612 ++++++++++++++++++++++++++++--------------------------------
 revision.h |    4 +
 2 files changed, 290 insertions(+), 326 deletions(-)

diff --git a/revision.c b/revision.c
index 0191160..3dbb7a8 100644
--- a/revision.c
+++ b/revision.c
@@ -974,6 +974,276 @@ static void add_ignore_packed(struct rev_info *revs, const char *name)
 	revs->ignore_packed[num] = NULL;
 }
 
+int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
+			int *unkc, const char **unkv)
+{
+	const char *arg = argv[0];
+
+	/* pseudo revision arguments */
+	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
+	    !strcmp(arg, "--tags") || !strcmp(arg, "--remotes") ||
+	    !strcmp(arg, "--reflog") || !strcmp(arg, "--not") ||
+	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
+	{
+		unkv[(*unkc)++] = arg;
+		return 0;
+	}
+
+	if (!prefixcmp(arg, "--max-count=")) {
+		revs->max_count = atoi(arg + 12);
+	}
+	else if (!prefixcmp(arg, "--skip=")) {
+		revs->skip_count = atoi(arg + 7);
+	}
+	/* accept -<digit>, like traditional "head" */
+	else if ((*arg == '-') && isdigit(arg[1])) {
+		revs->max_count = atoi(arg + 1);
+	}
+	else if (!strcmp(arg, "-n")) {
+		if (argc <= 1)
+			return error("-n requires an argument");
+		revs->max_count = atoi(argv[1]);
+		return 2;
+	}
+	else if (!prefixcmp(arg, "-n")) {
+		revs->max_count = atoi(arg + 2);
+	}
+	else if (!prefixcmp(arg, "--max-age=")) {
+		revs->max_age = atoi(arg + 10);
+	}
+	else if (!prefixcmp(arg, "--since=")) {
+		revs->max_age = approxidate(arg + 8);
+	}
+	else if (!prefixcmp(arg, "--after=")) {
+		revs->max_age = approxidate(arg + 8);
+	}
+	else if (!prefixcmp(arg, "--min-age=")) {
+		revs->min_age = atoi(arg + 10);
+	}
+	else if (!prefixcmp(arg, "--before=")) {
+		revs->min_age = approxidate(arg + 9);
+	}
+	else if (!prefixcmp(arg, "--until=")) {
+		revs->min_age = approxidate(arg + 8);
+	}
+	else if (!strcmp(arg, "--first-parent")) {
+		revs->first_parent_only = 1;
+	}
+	else if (!strcmp(arg, "-g") ||
+	    !strcmp(arg, "--walk-reflogs")) {
+		init_reflog_walk(&revs->reflog_info);
+	}
+	else if (!strcmp(arg, "--default")) {
+		if (argc <= 1)
+			return error("bad --default argument");
+		revs->def = argv[1];
+		return 2;
+	}
+	else if (!strcmp(arg, "--merge")) {
+		revs->show_merge = 1;
+	}
+	else if (!strcmp(arg, "--topo-order")) {
+		revs->lifo = 1;
+		revs->topo_order = 1;
+	}
+	else if (!strcmp(arg, "--date-order")) {
+		revs->lifo = 0;
+		revs->topo_order = 1;
+	}
+	else if (!prefixcmp(arg, "--early-output")) {
+		int count = 100;
+		switch (arg[14]) {
+		  case '=':
+		    count = atoi(arg+15);
+		    /* Fallthrough */
+		  case 0:
+		    revs->topo_order = 1;
+		    revs->early_output = count;
+		}
+	}
+	else if (!strcmp(arg, "--parents")) {
+		revs->rewrite_parents = 1;
+		revs->print_parents = 1;
+	}
+	else if (!strcmp(arg, "--dense")) {
+		revs->dense = 1;
+	}
+	else if (!strcmp(arg, "--sparse")) {
+		revs->dense = 0;
+	}
+	else if (!strcmp(arg, "--show-all")) {
+		revs->show_all = 1;
+	}
+	else if (!strcmp(arg, "--remove-empty")) {
+		revs->remove_empty_trees = 1;
+	}
+	else if (!strcmp(arg, "--no-merges")) {
+		revs->no_merges = 1;
+	}
+	else if (!strcmp(arg, "--boundary")) {
+		revs->boundary = 1;
+	}
+	else if (!strcmp(arg, "--left-right")) {
+		revs->left_right = 1;
+	}
+	else if (!strcmp(arg, "--cherry-pick")) {
+		revs->cherry_pick = 1;
+		revs->limited = 1;
+	}
+	else if (!strcmp(arg, "--objects")) {
+		revs->tag_objects = 1;
+		revs->tree_objects = 1;
+		revs->blob_objects = 1;
+	}
+	else if (!strcmp(arg, "--objects-edge")) {
+		revs->tag_objects = 1;
+		revs->tree_objects = 1;
+		revs->blob_objects = 1;
+		revs->edge_hint = 1;
+	}
+	else if (!strcmp(arg, "--unpacked")) {
+		revs->unpacked = 1;
+		free(revs->ignore_packed);
+		revs->ignore_packed = NULL;
+		revs->num_ignore_packed = 0;
+	}
+	else if (!prefixcmp(arg, "--unpacked=")) {
+		revs->unpacked = 1;
+		add_ignore_packed(revs, arg+11);
+	}
+	else if (!strcmp(arg, "-r")) {
+		revs->diff = 1;
+		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
+	}
+	else if (!strcmp(arg, "-t")) {
+		revs->diff = 1;
+		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
+		DIFF_OPT_SET(&revs->diffopt, TREE_IN_RECURSIVE);
+	}
+	else if (!strcmp(arg, "-m")) {
+		revs->ignore_merges = 0;
+	}
+	else if (!strcmp(arg, "-c")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 0;
+		revs->combine_merges = 1;
+	}
+	else if (!strcmp(arg, "--cc")) {
+		revs->diff = 1;
+		revs->dense_combined_merges = 1;
+		revs->combine_merges = 1;
+	}
+	else if (!strcmp(arg, "-v")) {
+		revs->verbose_header = 1;
+	}
+	else if (!strcmp(arg, "--pretty")) {
+		revs->verbose_header = 1;
+		get_commit_format(arg+8, revs);
+	}
+	else if (!prefixcmp(arg, "--pretty=")) {
+		revs->verbose_header = 1;
+		get_commit_format(arg+9, revs);
+	}
+	else if (!strcmp(arg, "--graph")) {
+		revs->topo_order = 1;
+		revs->rewrite_parents = 1;
+		revs->graph = graph_init(revs);
+	}
+	else if (!strcmp(arg, "--root")) {
+		revs->show_root_diff = 1;
+	}
+	else if (!strcmp(arg, "--no-commit-id")) {
+		revs->no_commit_id = 1;
+	}
+	else if (!strcmp(arg, "--always")) {
+		revs->always_show_header = 1;
+	}
+	else if (!strcmp(arg, "--no-abbrev")) {
+		revs->abbrev = 0;
+	}
+	else if (!strcmp(arg, "--abbrev")) {
+		revs->abbrev = DEFAULT_ABBREV;
+	}
+	else if (!prefixcmp(arg, "--abbrev=")) {
+		revs->abbrev = strtoul(arg + 9, NULL, 10);
+		if (revs->abbrev < MINIMUM_ABBREV)
+			revs->abbrev = MINIMUM_ABBREV;
+		else if (revs->abbrev > 40)
+			revs->abbrev = 40;
+	}
+	else if (!strcmp(arg, "--abbrev-commit")) {
+		revs->abbrev_commit = 1;
+	}
+	else if (!strcmp(arg, "--full-diff")) {
+		revs->diff = 1;
+		revs->full_diff = 1;
+	}
+	else if (!strcmp(arg, "--full-history")) {
+		revs->simplify_history = 0;
+	}
+	else if (!strcmp(arg, "--relative-date")) {
+		revs->date_mode = DATE_RELATIVE;
+	}
+	else if (!strncmp(arg, "--date=", 7)) {
+		revs->date_mode = parse_date_format(arg + 7);
+	}
+	else if (!strcmp(arg, "--log-size")) {
+		revs->show_log_size = 1;
+	}
+	/*
+	 * Grepping the commit log
+	 */
+	else if (!prefixcmp(arg, "--author=")) {
+		add_header_grep(revs, "author", arg+9);
+	}
+	else if (!prefixcmp(arg, "--committer=")) {
+		add_header_grep(revs, "committer", arg+12);
+	}
+	else if (!prefixcmp(arg, "--grep=")) {
+		add_message_grep(revs, arg+7);
+	}
+	else if (!strcmp(arg, "--extended-regexp") ||
+	    !strcmp(arg, "-E")) {
+		if (revs->grep_filter)
+			revs->grep_filter->regflags |= REG_EXTENDED;
+	}
+	else if (!strcmp(arg, "--regexp-ignore-case") ||
+	    !strcmp(arg, "-i")) {
+		if (revs->grep_filter)
+			revs->grep_filter->regflags |= REG_ICASE;
+	}
+	else if (!strcmp(arg, "--fixed-strings") ||
+	    !strcmp(arg, "-F")) {
+		if (revs->grep_filter)
+			revs->grep_filter->fixed = 1;
+	}
+	else if (!strcmp(arg, "--all-match")) {
+		if (revs->grep_filter)
+			revs->grep_filter->all_match = 1;
+	}
+	else if (!prefixcmp(arg, "--encoding=")) {
+		arg += 11;
+		if (strcmp(arg, "none"))
+			git_log_output_encoding = xstrdup(arg);
+		else
+			git_log_output_encoding = "";
+	}
+	else if (!strcmp(arg, "--reverse")) {
+		revs->reverse ^= 1;
+	}
+	else if (!strcmp(arg, "--children")) {
+		revs->children.name = "children";
+		revs->limited = 1;
+	} else {
+		int opts = diff_opt_parse(&revs->diffopt, argv, argc);
+		if (!opts)
+			unkv[(*unkc)++] = arg;
+		return opts;
+	}
+
+	return 1;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -983,12 +1253,7 @@ static void add_ignore_packed(struct rev_info *revs, const char *name)
  */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
-	int i, flags, seen_dashdash, show_merge;
-	const char **unrecognized = argv + 1;
-	int left = 1;
-	int all_match = 0;
-	int regflags = 0;
-	int fixed = 0;
+	int i, flags, left, seen_dashdash;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1004,58 +1269,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		break;
 	}
 
-	flags = show_merge = 0;
-	for (i = 1; i < argc; i++) {
+	/* Second, deal with arguments and options */
+	flags = 0;
+	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg == '-') {
 			int opts;
-			if (!prefixcmp(arg, "--max-count=")) {
-				revs->max_count = atoi(arg + 12);
-				continue;
-			}
-			if (!prefixcmp(arg, "--skip=")) {
-				revs->skip_count = atoi(arg + 7);
-				continue;
-			}
-			/* accept -<digit>, like traditional "head" */
-			if ((*arg == '-') && isdigit(arg[1])) {
-				revs->max_count = atoi(arg + 1);
-				continue;
-			}
-			if (!strcmp(arg, "-n")) {
-				if (argc <= i + 1)
-					die("-n requires an argument");
-				revs->max_count = atoi(argv[++i]);
-				continue;
-			}
-			if (!prefixcmp(arg, "-n")) {
-				revs->max_count = atoi(arg + 2);
-				continue;
-			}
-			if (!prefixcmp(arg, "--max-age=")) {
-				revs->max_age = atoi(arg + 10);
-				continue;
-			}
-			if (!prefixcmp(arg, "--since=")) {
-				revs->max_age = approxidate(arg + 8);
-				continue;
-			}
-			if (!prefixcmp(arg, "--after=")) {
-				revs->max_age = approxidate(arg + 8);
-				continue;
-			}
-			if (!prefixcmp(arg, "--min-age=")) {
-				revs->min_age = atoi(arg + 10);
-				continue;
-			}
-			if (!prefixcmp(arg, "--before=")) {
-				revs->min_age = approxidate(arg + 9);
-				continue;
-			}
-			if (!prefixcmp(arg, "--until=")) {
-				revs->min_age = approxidate(arg + 8);
-				continue;
-			}
+
 			if (!strcmp(arg, "--all")) {
 				handle_refs(revs, flags, for_each_ref);
 				continue;
@@ -1072,265 +1292,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
-			if (!strcmp(arg, "--first-parent")) {
-				revs->first_parent_only = 1;
-				continue;
-			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
 			}
-			if (!strcmp(arg, "-g") ||
-					!strcmp(arg, "--walk-reflogs")) {
-				init_reflog_walk(&revs->reflog_info);
-				continue;
-			}
 			if (!strcmp(arg, "--not")) {
 				flags ^= UNINTERESTING;
 				continue;
 			}
-			if (!strcmp(arg, "--default")) {
-				if (++i >= argc)
-					die("bad --default argument");
-				def = argv[i];
-				continue;
-			}
-			if (!strcmp(arg, "--merge")) {
-				show_merge = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--topo-order")) {
-				revs->lifo = 1;
-				revs->topo_order = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--date-order")) {
-				revs->lifo = 0;
-				revs->topo_order = 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--early-output")) {
-				int count = 100;
-				switch (arg[14]) {
-				case '=':
-					count = atoi(arg+15);
-					/* Fallthrough */
-				case 0:
-					revs->topo_order = 1;
-					revs->early_output = count;
-					continue;
-				}
-			}
-			if (!strcmp(arg, "--parents")) {
-				revs->rewrite_parents = 1;
-				revs->print_parents = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--dense")) {
-				revs->dense = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--sparse")) {
-				revs->dense = 0;
-				continue;
-			}
-			if (!strcmp(arg, "--show-all")) {
-				revs->show_all = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--remove-empty")) {
-				revs->remove_empty_trees = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-merges")) {
-				revs->no_merges = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--boundary")) {
-				revs->boundary = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--left-right")) {
-				revs->left_right = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--cherry-pick")) {
-				revs->cherry_pick = 1;
-				revs->limited = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--objects")) {
-				revs->tag_objects = 1;
-				revs->tree_objects = 1;
-				revs->blob_objects = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--objects-edge")) {
-				revs->tag_objects = 1;
-				revs->tree_objects = 1;
-				revs->blob_objects = 1;
-				revs->edge_hint = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--unpacked")) {
-				revs->unpacked = 1;
-				free(revs->ignore_packed);
-				revs->ignore_packed = NULL;
-				revs->num_ignore_packed = 0;
-				continue;
-			}
-			if (!prefixcmp(arg, "--unpacked=")) {
-				revs->unpacked = 1;
-				add_ignore_packed(revs, arg+11);
-				continue;
-			}
-			if (!strcmp(arg, "-r")) {
-				revs->diff = 1;
-				DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
-				continue;
-			}
-			if (!strcmp(arg, "-t")) {
-				revs->diff = 1;
-				DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
-				DIFF_OPT_SET(&revs->diffopt, TREE_IN_RECURSIVE);
-				continue;
-			}
-			if (!strcmp(arg, "-m")) {
-				revs->ignore_merges = 0;
-				continue;
-			}
-			if (!strcmp(arg, "-c")) {
-				revs->diff = 1;
-				revs->dense_combined_merges = 0;
-				revs->combine_merges = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--cc")) {
-				revs->diff = 1;
-				revs->dense_combined_merges = 1;
-				revs->combine_merges = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-v")) {
-				revs->verbose_header = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--pretty")) {
-				revs->verbose_header = 1;
-				get_commit_format(arg+8, revs);
-				continue;
-			}
-			if (!prefixcmp(arg, "--pretty=")) {
-				revs->verbose_header = 1;
-				get_commit_format(arg+9, revs);
-				continue;
-			}
-			if (!strcmp(arg, "--graph")) {
-				revs->topo_order = 1;
-				revs->rewrite_parents = 1;
-				revs->graph = graph_init(revs);
-				continue;
-			}
-			if (!strcmp(arg, "--root")) {
-				revs->show_root_diff = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-commit-id")) {
-				revs->no_commit_id = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--always")) {
-				revs->always_show_header = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-abbrev")) {
-				revs->abbrev = 0;
-				continue;
-			}
-			if (!strcmp(arg, "--abbrev")) {
-				revs->abbrev = DEFAULT_ABBREV;
-				continue;
-			}
-			if (!prefixcmp(arg, "--abbrev=")) {
-				revs->abbrev = strtoul(arg + 9, NULL, 10);
-				if (revs->abbrev < MINIMUM_ABBREV)
-					revs->abbrev = MINIMUM_ABBREV;
-				else if (revs->abbrev > 40)
-					revs->abbrev = 40;
-				continue;
-			}
-			if (!strcmp(arg, "--abbrev-commit")) {
-				revs->abbrev_commit = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--full-diff")) {
-				revs->diff = 1;
-				revs->full_diff = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--full-history")) {
-				revs->simplify_history = 0;
-				continue;
-			}
-			if (!strcmp(arg, "--relative-date")) {
-				revs->date_mode = DATE_RELATIVE;
-				continue;
-			}
-			if (!strncmp(arg, "--date=", 7)) {
-				revs->date_mode = parse_date_format(arg + 7);
-				continue;
-			}
-			if (!strcmp(arg, "--log-size")) {
-				revs->show_log_size = 1;
-				continue;
-			}
-
-			/*
-			 * Grepping the commit log
-			 */
-			if (!prefixcmp(arg, "--author=")) {
-				add_header_grep(revs, "author", arg+9);
-				continue;
-			}
-			if (!prefixcmp(arg, "--committer=")) {
-				add_header_grep(revs, "committer", arg+12);
-				continue;
-			}
-			if (!prefixcmp(arg, "--grep=")) {
-				add_message_grep(revs, arg+7);
-				continue;
-			}
-			if (!strcmp(arg, "--extended-regexp") ||
-			    !strcmp(arg, "-E")) {
-				regflags |= REG_EXTENDED;
-				continue;
-			}
-			if (!strcmp(arg, "--regexp-ignore-case") ||
-			    !strcmp(arg, "-i")) {
-				regflags |= REG_ICASE;
-				continue;
-			}
-			if (!strcmp(arg, "--fixed-strings") ||
-			    !strcmp(arg, "-F")) {
-				fixed = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--all-match")) {
-				all_match = 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--encoding=")) {
-				arg += 11;
-				if (strcmp(arg, "none"))
-					git_log_output_encoding = xstrdup(arg);
-				else
-					git_log_output_encoding = "";
-				continue;
-			}
-			if (!strcmp(arg, "--reverse")) {
-				revs->reverse ^= 1;
-				continue;
-			}
 			if (!strcmp(arg, "--no-walk")) {
 				revs->no_walk = 1;
 				continue;
@@ -1339,19 +1308,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->no_walk = 0;
 				continue;
 			}
-			if (!strcmp(arg, "--children")) {
-				revs->children.name = "children";
-				revs->limited = 1;
-				continue;
-			}
 
-			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
+			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
 			if (opts > 0) {
 				i += opts - 1;
 				continue;
 			}
-			*unrecognized++ = arg;
-			left++;
+			if (opts < 0)
+				exit(128);
 			continue;
 		}
 
@@ -1375,21 +1339,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
-	if (revs->grep_filter) {
-		revs->grep_filter->regflags |= regflags;
-		revs->grep_filter->fixed = fixed;
-	}
-
-	if (show_merge)
+	if (revs->def == NULL)
+		revs->def = def;
+	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (def && !revs->pending.nr) {
+	if (revs->def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(def, sha1, &mode))
-			die("bad default revision '%s'", def);
-		object = get_reference(revs, def, sha1, 0);
-		add_pending_object_with_mode(revs, object, def, mode);
+		if (get_sha1_with_mode(revs->def, sha1, &mode))
+			die("bad default revision '%s'", revs->def);
+		object = get_reference(revs, revs->def, sha1, 0);
+		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
@@ -1423,7 +1384,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		die("diff_setup_done failed");
 
 	if (revs->grep_filter) {
-		revs->grep_filter->all_match = all_match;
 		compile_grep_patterns(revs->grep_filter);
 	}
 
diff --git a/revision.h b/revision.h
index 5b8c56b..cc80fcd 100644
--- a/revision.h
+++ b/revision.h
@@ -26,6 +26,7 @@ struct rev_info {
 
 	/* Basic information */
 	const char *prefix;
+	const char *def;
 	void *prune_data;
 	unsigned int early_output;
 
@@ -66,6 +67,7 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
+			show_merge:1,
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1;
@@ -120,6 +122,8 @@ volatile show_early_output_fn_t show_early_output;
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
 extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
+			       int *unkc, const char **unkv);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
 extern int prepare_revision_walk(struct rev_info *revs);
-- 
1.5.6.2.396.gca539
