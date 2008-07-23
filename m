From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 5/9] builtin-rev-list.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:08 +0200
Message-ID: <1216849332-26813-6-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1b-00026o-4i
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556AbYGWVf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbYGWVf4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:56 -0400
Received: from smtp.katamail.com ([62.149.157.154]:37020 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754847AbYGWVfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:52 -0400
Received: (qmail 11537 invoked by uid 89); 23 Jul 2008 21:35:43 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:41 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89779>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-rev-list.c |  132 +++++++++++++++++++++++++--------------------------
 1 files changed, 65 insertions(+), 67 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 893762c..9200b20 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -11,44 +11,16 @@
 #include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
+#include "parse-options.h"
 
 /* bits #0-15 in revision.h */
 
 #define COUNTED		(1u<<16)
 
-static const char rev_list_usage[] =
-"git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
-"  limiting output:\n"
-"    --max-count=nr\n"
-"    --max-age=epoch\n"
-"    --min-age=epoch\n"
-"    --sparse\n"
-"    --no-merges\n"
-"    --remove-empty\n"
-"    --all\n"
-"    --branches\n"
-"    --tags\n"
-"    --remotes\n"
-"    --stdin\n"
-"    --quiet\n"
-"  ordering output:\n"
-"    --topo-order\n"
-"    --date-order\n"
-"    --reverse\n"
-"  formatting output:\n"
-"    --parents\n"
-"    --children\n"
-"    --objects | --objects-edge\n"
-"    --unpacked\n"
-"    --header | --pretty\n"
-"    --abbrev=nr | --no-abbrev\n"
-"    --abbrev-commit\n"
-"    --left-right\n"
-"  special purpose:\n"
-"    --bisect\n"
-"    --bisect-vars\n"
-"    --bisect-all"
-;
+static const char * const rev_list_usage[] = {
+	"git rev-list [OPTION] <commit-id>... [ -- paths... ]",
+	NULL
+};
 
 static struct rev_info revs;
 
@@ -575,15 +547,65 @@ static struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static int parse_header_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct rev_info *t_revs = opt->value;
+	t_revs->verbose_header = unset ? 0 : 1;
+	return 0;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
-	int i;
 	int read_from_stdin = 0;
 	int bisect_show_vars = 0;
 	int bisect_find_all = 0;
 	int quiet = 0;
 
+	const struct option options[] = {
+		OPT_GROUP("limiting output:"),
+		OPT_ARGUMENT("max-count=nr", "limit number of commits output"),
+		OPT_ARGUMENT("max-age=epoch", "limit commits output by time"),
+		OPT_ARGUMENT("min-age=epoch", "limit commits output by time"),
+		OPT_ARGUMENT("sparse", ""),
+		OPT_ARGUMENT("no-merges", "do not print merges"),
+		OPT_ARGUMENT("remove-empty", "stop when a given path disappears from the tree"),
+		OPT_ARGUMENT("all", "all refs"),
+		OPT_ARGUMENT("branches", "show local branches"),
+		OPT_ARGUMENT("tags", "show tags"),
+		OPT_ARGUMENT("remotes", "show remote-tracking branches"),
+		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
+			    "read commits also from command line"),
+		OPT__QUIET(&quiet),
+		OPT_GROUP("ordering output:"),
+		OPT_ARGUMENT("topo-order", "show commits in topological order"),
+		OPT_ARGUMENT("date-order", "use date order, preserving topology"),
+		OPT_ARGUMENT("reverse", "output commits in reverse order"),
+		OPT_GROUP("formatting output:"),
+		OPT_ARGUMENT("parents", "print the parents of the commit"),
+		OPT_ARGUMENT("children", "print the children of the commit"),
+		OPT_ARGUMENT("objects", "print all objects"),
+		OPT_ARGUMENT("objects-edge", "similar to --objects, used by git-pack-objects"),
+		OPT_ARGUMENT("unpacked", "print objects not in packs"),
+		{ OPTION_CALLBACK, 0, "header", &revs, NULL,
+		  "use raw-format", PARSE_OPT_NOARG, parse_header_cb, 0 },
+		OPT_ARGUMENT("pretty", "print contents in a given format"),
+		OPT_BOOLEAN(0, "timestamp", &show_timestamp,
+			    "print the raw commit timestamp"),
+		OPT_ARGUMENT("abbrev-commit", "show short sha1"),
+		OPT_ARGUMENT("abbrev=nr", "number of digits used for short sha1"),
+		OPT_ARGUMENT("no-abbrev", "do not use short sha1"),
+		OPT_ARGUMENT("left-right", "mark side of symmetric diff"),
+		OPT_ARGUMENT("graph", "show an ASCII graph"),
+		OPT_GROUP("special purpose:"),
+		OPT_BOOLEAN(0, "bisect", &bisect_list, "useful for binary searches"),
+		OPT_BOOLEAN(0, "bisect-all", &bisect_find_all,
+			    "order commits by their distance from given commits"),
+		OPT_BOOLEAN(0, "bisect-vars", &bisect_show_vars,
+			    "like --bisect, but ready to be eval'ed"),
+		OPT_END()
+	};
+
 	git_config(git_default_config, NULL);
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
@@ -591,40 +613,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &revs, NULL);
 
 	quiet = DIFF_OPT_TST(&revs.diffopt, QUIET);
-	for (i = 1 ; i < argc; i++) {
-		const char *arg = argv[i];
+	argc = parse_options(argc, argv, options, rev_list_usage, 0);
 
-		if (!strcmp(arg, "--header")) {
-			revs.verbose_header = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--timestamp")) {
-			show_timestamp = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--bisect")) {
-			bisect_list = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--bisect-all")) {
-			bisect_list = 1;
-			bisect_find_all = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--bisect-vars")) {
-			bisect_list = 1;
-			bisect_show_vars = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--stdin")) {
-			if (read_from_stdin++)
-				die("--stdin given twice?");
-			read_revisions_from_stdin(&revs);
-			continue;
-		}
-		usage(rev_list_usage);
+	if (argc > 0)
+		usage_with_options(rev_list_usage, options);
+
+	if (bisect_find_all || bisect_show_vars)
+		bisect_list = 1;
+	if (read_from_stdin)
+		read_revisions_from_stdin(&revs);
 
-	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
 		hdr_termination = '\n';
@@ -643,7 +641,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
-		usage(rev_list_usage);
+		usage_with_options(rev_list_usage, options);
 
 	save_commit_buffer = revs.verbose_header || revs.grep_filter;
 	if (bisect_list)
-- 
1.5.6.3
