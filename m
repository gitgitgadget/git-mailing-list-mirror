From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] builtin-grep: wildcard pathspec fixes
Date: Mon, 01 May 2006 12:30:36 -0700
Message-ID: <7v64kpsftv.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<20060501140410.GA3505@mars.ravnborg.org>
	<20060501140704.GA6096@mars.ravnborg.org>
	<20060501145328.GA14856@mars.ravnborg.org>
	<Pine.LNX.4.64.0605010842130.21189@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 21:30:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fae6W-0001lF-Og
	for gcvg-git@gmane.org; Mon, 01 May 2006 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWEATai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 15:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWEATai
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 15:30:38 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5053 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932199AbWEATah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 15:30:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501193036.IQKD18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 15:30:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605010842130.21189@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 1 May 2006 08:48:44 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19385>

This tweaks the pathspec wildcard used in builtin-grep to match
that of ls-files.  With this:

	git grep -e DEBUG -- '*/Kconfig*'

would work like the shell script version, and you could even do:

	git grep -e DEBUG --cached -- '*/Kconfig*' ;# from index
	git grep -e DEBUG v2.6.12 -- '*/Kconfig*' ;# from rev

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Still haven't improved the "-e" issue (and to a lesser extent
   I think requiring -- is not right in this context either), but

 builtin-grep.c |   85 +++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 36150bf..653b65e 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -12,33 +12,66 @@ #include "diff.h"
 #include "revision.h"
 #include "builtin.h"
 #include <regex.h>
+#include <fnmatch.h>
 
+/*
+ * git grep pathspecs are somewhat different from diff-tree pathspecs;
+ * pathname wildcards are allowed.
+ */
 static int pathspec_matches(struct diff_options *opt, const char *name)
 {
-	int i, j;
-	int namelen;
+	int namelen, i;
 	if (!opt->nr_paths)
 		return 1;
 	namelen = strlen(name);
 	for (i = 0; i < opt->nr_paths; i++) {
 		const char *match = opt->paths[i];
 		int matchlen = opt->pathlens[i];
-		if (matchlen <= namelen) {
-			if (!strncmp(name, match, matchlen))
-				return 1;
+		const char *slash, *cp;
+
+		if ((matchlen <= namelen) &&
+		    !strncmp(name, match, matchlen) &&
+		    (match[matchlen-1] == '/' ||
+		     name[matchlen] == '\0' || name[matchlen] == '/'))
+			return 1;
+		if (!fnmatch(match, name, 0))
+			return 1;
+		if (name[namelen-1] != '/')
 			continue;
-		}
-		/* If name is "Documentation" and pathspec is
-		 * "Documentation/", they should match.  Maybe
-		 * we would want to strip it in get_pathspec()???
+
+		/* We are being asked if the name directory is worth
+		 * descending into.
+		 *
+		 * Find the longest leading directory name that does
+		 * not have metacharacter in the pathspec; the name
+		 * we are looking at must overlap with that directory.
 		 */
-		if (strncmp(name, match, namelen))
-			continue;
-		for (j = namelen; j < matchlen; j++)
-			if (match[j] != '/')
+		for (cp = match, slash = NULL; cp - match < matchlen; cp++) {
+			char ch = *cp;
+			if (ch == '/')
+				slash = cp;
+			if (ch == '*' || ch == '[')
 				break;
-		if (matchlen <= j)
-			return 1;
+		}
+		if (!slash)
+			slash = match; /* toplevel */
+		else
+			slash++;
+		if (namelen <= slash - match) {
+			/* Looking at "Documentation/" and
+			 * the pattern says "Documentation/howto/", or
+			 * "Documentation/diff*.txt".
+			 */
+			if (!memcmp(match, name, namelen))
+				return 1;
+		}
+		else {
+			/* Looking at "Documentation/howto/" and
+			 * the pattern says "Documentation/h*".
+			 */
+			if (!memcmp(match, name, slash - match))
+				return 1;
+		}
 	}
 	return 0;
 }
@@ -232,17 +265,17 @@ static int grep_tree(struct grep_opt *op
 	int hit = 0;
 	const char *path;
 	const unsigned char *sha1;
-	char *down_base;
+	char *down;
 	char *path_buf = xmalloc(PATH_MAX + strlen(tree_name) + 100);
 
 	if (tree_name[0]) {
 		int offset = sprintf(path_buf, "%s:", tree_name);
-		down_base = path_buf + offset;
-		strcat(down_base, base);
+		down = path_buf + offset;
+		strcat(down, base);
 	}
 	else {
-		down_base = path_buf;
-		strcpy(down_base, base);
+		down = path_buf;
+		strcpy(down, base);
 	}
 	len = strlen(path_buf);
 
@@ -252,7 +285,14 @@ static int grep_tree(struct grep_opt *op
 		pathlen = strlen(path);
 		strcpy(path_buf + len, path);
 
-		if (!pathspec_matches(&revs->diffopt, down_base))
+		if (S_ISDIR(mode))
+			/* Match "abc/" against pathspec to
+			 * decide if we want to descend into "abc"
+			 * directory.
+			 */
+			strcpy(path_buf + len + pathlen, "/");
+
+		if (!pathspec_matches(&revs->diffopt, down))
 			;
 		else if (S_ISREG(mode))
 			hit |= grep_sha1(opt, sha1, path_buf);
@@ -264,9 +304,8 @@ static int grep_tree(struct grep_opt *op
 			if (!data)
 				die("unable to read tree (%s)",
 				    sha1_to_hex(sha1));
-			strcpy(path_buf + len + pathlen, "/");
 			sub.buf = data;
-			hit = grep_tree(opt, revs, &sub, tree_name, down_base);
+			hit |= grep_tree(opt, revs, &sub, tree_name, down);
 			free(data);
 		}
 		update_tree_entry(tree);
-- 
1.3.1.gd233
