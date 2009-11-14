From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/2] ls-tree: migrate to parse-options
Date: Fri, 13 Nov 2009 20:34:08 -0800
Message-ID: <1258173248-31059-3-git-send-email-bebarino@gmail.com>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 05:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9ALQ-0006F7-2I
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 05:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbZKNEeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 23:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757835AbZKNEeP
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 23:34:15 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:52529 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757823AbZKNEeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 23:34:13 -0500
Received: by mail-gx0-f226.google.com with SMTP id 26so3672602gxk.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 20:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=wr1Ay/yVM3Vb5m/nF1h+WpA0VSOzWS9GFlW/8jSBBsA=;
        b=J8G85WNRiECKwb2pSyqscQI4AeFY3fGF1yoDHQQNu3X8vFi5z/C5PP7bzURC1eW9yv
         FkuHFvUe6Gtoh8JzR+s1OvP6e0afgEIL0FL/Zwdwn4FfUkPd9JHVbF+Zr7U61eVvCUma
         zYSj5smJaLfRe2BBjPHDYdTFhLTxQdGQBHpug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nuL+gbRXN9OXLqjOdEk28NvXovp9PKBofr89rkpnZT+BzsFmn/Y3CjpVnINUPivflC
         UrVEg9+0my9BgdyWwzRZ5SncTIwiedRJpq8GISl8gVjG7BqGt12prFbbXihSRaItveWN
         WU0uXO3m0JbCv8kmUdVQ373Q8M4zvKd/1otTk=
Received: by 10.150.125.3 with SMTP id x3mr9383115ybc.28.1258173259300;
        Fri, 13 Nov 2009 20:34:19 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 23sm199646ywh.33.2009.11.13.20.34.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 20:34:18 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Fri, 13 Nov 2009 20:34:16 -0800
X-Mailer: git-send-email 1.6.5.2.155.gbb47
In-Reply-To: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132858>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-ls-tree.c |  100 +++++++++++++++++++++-------------------------------
 1 files changed, 40 insertions(+), 60 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 22008df..04408df 100644
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
-	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]";
+static const  char * const ls_tree_usage[] = {
+	"git ls-tree [-d] [-r] [-t] [-l | --long] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]",
+	NULL
+};
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -117,76 +120,53 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 {
 	unsigned char sha1[20];
 	struct tree *tree;
+	int full_tree = 0;
+	const struct option ls_tree_options[] = {
+		OPT_BIT('d', NULL, &ls_options, "only show trees",
+			LS_TREE_ONLY),
+		OPT_BIT('r', NULL, &ls_options, "recurse into subtrees",
+			LS_RECURSIVE),
+		OPT_BIT('t', NULL, &ls_options, "show trees when recursing",
+			LS_SHOW_TREES),
+		OPT_SET_INT('z', NULL, &line_termination,
+			    "terminate entries with NUL byte", 0),
+		OPT_BIT('l', "long", &ls_options, "include object size",
+			LS_SHOW_SIZE),
+		OPT_BIT(0, "name-only", &ls_options, "list only filenames",
+			LS_NAME_ONLY),
+		OPT_BIT(0, "name-status", &ls_options, "list only filenames",
+			LS_NAME_ONLY),
+		OPT_SET_INT(0, "full-name", &chomp_prefix,
+			    "use full path names", 0),
+		OPT_BOOLEAN(0, "full-tree", &full_tree,
+			    "list entire tree; not just current directory "
+			    "(implies --full-name)"),
+		OPT__ABBREV(&abbrev),
+		OPT_END()
+	};
 
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
-			if (!strcmp(argv[1]+2, "full-tree")) {
-				ls_tree_prefix = prefix = NULL;
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
+
+	argc = parse_options(argc, argv, prefix, ls_tree_options,
+			     ls_tree_usage, 0);
+	if (full_tree) {
+		ls_tree_prefix = prefix = NULL;
+		chomp_prefix = 0;
 	}
 	/* -d -r should imply -t, but -d by itself should not have to. */
 	if ( (LS_TREE_ONLY|LS_RECURSIVE) ==
 	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
 		ls_options |= LS_SHOW_TREES;
 
-	if (argc < 2)
-		usage(ls_tree_usage);
-	if (get_sha1(argv[1], sha1))
-		die("Not a valid object name %s", argv[1]);
+	if (argc < 1)
+		usage_with_options(ls_tree_usage, ls_tree_options);
+	if (get_sha1(argv[0], sha1))
+		die("Not a valid object name %s", argv[0]);
 
-	pathspec = get_pathspec(prefix, argv + 2);
+	pathspec = get_pathspec(prefix, argv + 1);
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-- 
1.6.5.2.155.gbb47
