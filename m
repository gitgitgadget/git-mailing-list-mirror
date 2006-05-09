From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/6] ls-tree: convert to gitopt
Date: Mon, 08 May 2006 22:06:46 -0700
Message-ID: <1147151211399-git-send-email-normalperson@yhbt.net>
References: <11471512101532-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 08:22:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdLcQ-00087J-33
	for gcvg-git@gmane.org; Tue, 09 May 2006 08:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWEIGWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 02:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIGWq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 02:22:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8159 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751423AbWEIGWn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 02:22:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 0BF2D7DC020;
	Mon,  8 May 2006 23:22:42 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11471512101532-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19819>

A pretty simple and straight forward conversion, imho.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 gitopt/abbrev.h |   24 +++++++++++++++++
 ls-tree.c       |   79 +++++++++++++++++++++++--------------------------------
 2 files changed, 57 insertions(+), 46 deletions(-)
 create mode 100644 gitopt/abbrev.h

06d5dc3649e7407f7ff8df0d42a55a906b39cb39
diff --git a/gitopt/abbrev.h b/gitopt/abbrev.h
new file mode 100644
index 0000000..c3b2353
--- /dev/null
+++ b/gitopt/abbrev.h
@@ -0,0 +1,24 @@
+#include "../cache.h"
+
+/* we specify rewrite_fmt here to make opt_abbrev() simpler: */
+#define abbrev_ost_row \
+	{ "abbrev",		0,	"a %s",	ARG_OPTINT,	opt_abbrev }
+
+#define gitopt_opt_abbrev(dest) \
+static struct exec_args *opt_abbrev(const struct opt_spec *s, \
+			const int argc, const char **argv, int *argc_pos) \
+{ \
+	struct exec_args *ea = optional_int_arg(s, argc, argv, argc_pos); \
+	if (!ea) return NULL; \
+	if (ea->argc == 1) \
+		dest = DEFAULT_ABBREV; \
+	else { \
+		dest = strtoul(ea->argv[1], NULL, 10); \
+		if (dest && dest < MINIMUM_ABBREV) \
+			dest = MINIMUM_ABBREV; \
+		else if (dest > 40) \
+			dest = 40; \
+	} \
+	return nil_exec_args(ea); \
+}
+
diff --git a/ls-tree.c b/ls-tree.c
index f2b3bc1..4fb6343 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -7,6 +7,8 @@ #include "cache.h"
 #include "blob.h"
 #include "tree.h"
 #include "quote.h"
+#include "gitopt.h"
+#include "gitopt/abbrev.h"
 
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
@@ -84,68 +86,53 @@ static int show_tree(unsigned char *sha1
 	return retval;
 }
 
+gitopt_eat(opt_d, ls_options |= LS_TREE_ONLY;)
+gitopt_eat(opt_t, ls_options |= LS_SHOW_TREES;)
+gitopt_eat(opt_z, line_termination = 0;)
+gitopt_eat(opt_r, ls_options |= LS_RECURSIVE;)
+gitopt_eat(opt_name_only_status, ls_options |= LS_NAME_ONLY;)
+gitopt_eat(opt_full_name, chomp_prefix = 0;)
+gitopt_opt_abbrev(abbrev)
+
+static const struct opt_spec ls_tree_ost[] = {
+	{ 0,			'z',	0,	0,	opt_z },
+	{ 0,			'r',	0,	0,	opt_r },
+	{ 0,			'd',	0,	0,	opt_d },
+	{ 0,			't',	0,	0,	opt_t },
+	{ "name-only",		0,	0,	0,	opt_name_only_status },
+	{ "name-status",	0,	0,	0,	opt_name_only_status },
+	{ "full-name",		0,	0,	0,	opt_full_name },
+	abbrev_ost_row,
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
+	struct exec_args *a = new_exec_args(argc); /* argv[0] and options: */
+	struct exec_args *b = new_exec_args(argc); /* non-option args */
 
 	prefix = setup_git_directory();
 	git_config(git_default_config);
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
-		case '-':
-			if (!strcmp(argv[1]+2, "name-only") ||
-			    !strcmp(argv[1]+2, "name-status")) {
-				ls_options |= LS_NAME_ONLY;
-				break;
-			}
-			if (!strcmp(argv[1]+2, "full-name")) {
-				chomp_prefix = 0;
-				break;
-			}
-			if (!strncmp(argv[1]+2, "abbrev=",7)) {
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
+	if (gitopt_parse_ost_split(a, b, ls_tree_ost, argc, argv) < 0)
+		usage(ls_tree_usage);
+	free_exec_args(a);
+
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
-	if (argc < 2)
+	if (b->argc < 1)
 		usage(ls_tree_usage);
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
+	if (get_sha1(b->argv[0], sha1))
+		die("Not a valid object name %s", b->argv[0]);
 
-	pathspec = get_pathspec(prefix, argv + 2);
+	pathspec = get_pathspec(prefix, b->argv + 1);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-- 
1.3.2.g0a3ae
