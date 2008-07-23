From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 4/9] builtin-ls-tree.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:07 +0200
Message-ID: <1216849332-26813-5-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1a-00026o-Fp
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYGWVfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbYGWVfz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:55 -0400
Received: from smtp.katamail.com ([62.149.157.154]:37001 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754915AbYGWVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:50 -0400
Received: (qmail 11508 invoked by uid 89); 23 Jul 2008 21:35:41 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:40 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89778>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-ls-tree.c |   92 +++++++++++++++++++++--------------------------------
 1 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index d25767a..a0b17aa 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -9,6 +9,7 @@
 #include "commit.h"
 #include "quote.h"
 #include "builtin.h"
+#include "parse-options.h"
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
@@ -22,8 +23,10 @@ static const char **pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 
-static const char ls_tree_usage[] =
-	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+static const char * const ls_tree_usage[] = {
+	"git ls-tree [options] <tree-ish> [path...]",
+	NULL
+};
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -122,70 +125,47 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20];
 	struct tree *tree;
 
+	const struct option options[] = {
+		OPT_SET_INT('z', NULL, &line_termination,
+			    "\\0 line termination on output", 0),
+		OPT_BIT('r', NULL, &ls_options,
+			"recurse into sub-trees", LS_RECURSIVE),
+		OPT_BIT('d', NULL, &ls_options,
+			"show only the tree, not its children",
+			LS_TREE_ONLY),
+		OPT_BIT('t', NULL, &ls_options,
+			"show tree entries", LS_SHOW_TREES),
+		OPT_BIT('l', "long", &ls_options,
+			"show object size of blob (file) entries",
+			LS_SHOW_SIZE),
+		OPT_BIT(0, "name-only", &ls_options,
+			"list only filenames", LS_NAME_ONLY),
+		OPT_BIT(0, "name-status", &ls_options,
+			"same as --name-only", LS_NAME_ONLY),
+		OPT_SET_INT(0, "full-name", &chomp_prefix,
+			    "show the full path name", 0),
+		OPT__ABBREV(&abbrev),
+		OPT_END()
+	};
+
 	git_config(git_default_config, NULL);
 	ls_tree_prefix = prefix;
 	if (prefix && *prefix)
 		chomp_prefix = strlen(prefix);
-	while (1 < argc && argv[1][0] == '-') {
-		switch (argv[1][1]) {
-		case 'z':
-			line_termination = 0;
-			break;
-		case 'r':
-			ls_options |= LS_RECURSIVE;
-			break;
-		case 'd':
-			ls_options |= LS_TREE_ONLY;
-			break;
-		case 't':
-			ls_options |= LS_SHOW_TREES;
-			break;
-		case 'l':
-			ls_options |= LS_SHOW_SIZE;
-			break;
-		case '-':
-			if (!strcmp(argv[1]+2, "name-only") ||
-			    !strcmp(argv[1]+2, "name-status")) {
-				ls_options |= LS_NAME_ONLY;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "long")) {
-				ls_options |= LS_SHOW_SIZE;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "full-name")) {
-				chomp_prefix = 0;
-				break;
-			}
-			if (!prefixcmp(argv[1]+2, "abbrev=")) {
-				abbrev = strtoul(argv[1]+9, NULL, 10);
-				if (abbrev && abbrev < MINIMUM_ABBREV)
-					abbrev = MINIMUM_ABBREV;
-				else if (abbrev > 40)
-					abbrev = 40;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "abbrev")) {
-				abbrev = DEFAULT_ABBREV;
-				break;
-			}
-			/* otherwise fallthru */
-		default:
-			usage(ls_tree_usage);
-		}
-		argc--; argv++;
-	}
+
+	argc = parse_options(argc, argv, options, ls_tree_usage, 0);
+
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
-	if (argc < 2)
-		usage(ls_tree_usage);
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
+	if (argc < 1)
+		usage_with_options(ls_tree_usage, options);
+	if (get_sha1(argv[0], sha1))
+		die("Not a valid object name %s", argv[0]);
 
-	pathspec = get_pathspec(prefix, argv + 2);
+	pathspec = get_pathspec(prefix, argv + 1);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-- 
1.5.6.3
