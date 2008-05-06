From: Aidan Van Dyk <aidan@highrise.ca>
Subject: [PATCH] git-grep: Add ability to limit directory recursion
Date: Tue,  6 May 2008 13:18:24 -0400
Message-ID: <1210094304-2450-1-git-send-email-aidan@highrise.ca>
Cc: Aidan Van Dyk <aidan@highrise.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:19:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtQot-000779-FR
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 19:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760432AbYEFRS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 13:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758500AbYEFRS0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 13:18:26 -0400
Received: from yugib.highrise.ca ([205.150.199.213]:53925 "EHLO
	yugib.highrise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbYEFRSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 13:18:25 -0400
Received: from localhost.localdomain (trb229.travel-net.com [205.150.254.229])
	by yugib.highrise.ca (Postfix) with ESMTP id 8375A111E39;
	Tue,  6 May 2008 13:18:24 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.67.g9a49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81371>

This add a -R <limit> option to git-grep which will limit the depth of the
directories recursed when git is doing a grep.

This allows you to do something like:
        git grep -R 1 <pattern>
and see only the results of the grep on files in the current directory.

It defaults to a limit of "0" which disables the limiting.
---
 Documentation/git-grep.txt |    6 +++++
 builtin-grep.c             |   52 +++++++++++++++++++++++++++++++++++++++++--
 grep.h                     |    1 +
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a97f055..2f73c90 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -97,6 +97,12 @@ OPTIONS
 -f <file>::
 	Read patterns from <file>, one per line.
 
+-R <limit>::
+	Limit the recursion depth when grepping.  A limit of 1 stops
+	the grep from accessing any subdirectories from the specified
+	tree, cache, or working files.  A higher limit will limit the
+	files to N directories deep.
+
 -e::
 	The next parameter is the pattern. This option has to be
 	used for patterns starting with - and should be used in
diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..2877584 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -343,6 +343,15 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
+		if (opt->recurse_limit) {
+			int d = 0;
+			const char* cp = ce->name + ce_namelen(ce);
+			while (--cp > ce->name)
+				if (*cp == '/' && opt->recurse_limit < ++d)
+					break;
+			if (opt->recurse_limit <= d)
+				continue;
+		}
 		name = ce->name;
 		if (name[0] == '-') {
 			int len = ce_namelen(ce);
@@ -399,6 +408,16 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
+		if (opt->recurse_limit) {
+			int d = 0;
+			const char* cp = ce->name + ce_namelen(ce);
+			while (--cp > ce->name)
+				if (*cp == '/' && opt->recurse_limit < ++d)
+					break;
+			if (opt->recurse_limit <= d)
+				continue;
+		}
+
 		if (cached) {
 			if (ce_stage(ce))
 				continue;
@@ -420,7 +439,8 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 
 static int grep_tree(struct grep_opt *opt, const char **paths,
 		     struct tree_desc *tree,
-		     const char *tree_name, const char *base)
+		     const char *tree_name, const char *base,
+		     int recurse_depth)
 {
 	int len;
 	int hit = 0;
@@ -460,12 +480,17 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			void *data;
 			unsigned long size;
 
+			if (opt->recurse_limit &&
+					opt->recurse_limit <= recurse_depth)
+				continue;
+
 			data = read_sha1_file(entry.sha1, &type, &size);
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(entry.sha1));
 			init_tree_desc(&sub, data, size);
-			hit |= grep_tree(opt, paths, &sub, tree_name, down);
+			hit |= grep_tree(opt, paths, &sub, tree_name, down,
+					recurse_depth+1);
 			free(data);
 		}
 	}
@@ -487,7 +512,7 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 		if (!data)
 			die("unable to read tree (%s)", sha1_to_hex(obj->sha1));
 		init_tree_desc(&tree, data, size);
-		hit = grep_tree(opt, paths, &tree, name, "");
+		hit = grep_tree(opt, paths, &tree, name, "", 1);
 		free(data);
 		return hit;
 	}
@@ -499,6 +524,8 @@ static const char builtin_grep_usage[] =
 
 static const char emsg_invalid_context_len[] =
 "%s: invalid context length argument";
+static const char emsg_invalid_recurse_limit[] =
+"%s: invalid recursion limit argument";
 static const char emsg_missing_context_len[] =
 "missing context length argument";
 static const char emsg_missing_argument[] =
@@ -704,6 +731,25 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			}
 			die(emsg_missing_argument, arg);
 		}
+		if (!strcmp("-R", arg)) {
+			unsigned num;
+			const char *scan;
+			if (1 < argc) {
+				int i;
+				scan = *++argv;
+				argc--;
+				if (strtoul_ui(scan, 10, &num))
+					die(emsg_invalid_recurse_limit, scan);
+				opt.recurse_limit = num;
+				/* increase by the depth of the prefix */
+				if (prefix && *prefix)
+					for (i = 0; i < strlen(prefix); i++)
+						if (prefix[i] == '/')
+							opt.recurse_limit++;
+				continue;
+			}
+			die(emsg_missing_argument, arg);
+		}
 		if (!strcmp("--full-name", arg)) {
 			opt.relative = 0;
 			continue;
diff --git a/grep.h b/grep.h
index d252dd2..b71dbf2 100644
--- a/grep.h
+++ b/grep.h
@@ -51,6 +51,7 @@ struct grep_opt {
 	struct grep_pat **pattern_tail;
 	struct grep_expr *pattern_expression;
 	int prefix_length;
+	int recurse_limit;
 	regex_t regexp;
 	unsigned linenum:1;
 	unsigned invert:1;
-- 
1.5.5.67.g9a49
