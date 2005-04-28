From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-tree-helper: do not report unmerged path outside
 specification.
Date: Wed, 27 Apr 2005 19:22:39 -0700
Message-ID: <7vwtqnbpxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 04:17:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQyai-0001Nl-AE
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 04:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVD1CWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 22:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVD1CWu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 22:22:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5568 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261717AbVD1CWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 22:22:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428022239.SBNQ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 22:22:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

My bad.  diff-tree-helper reports all unmerged paths even when
the command line specifies to filter the paths.  This patch
fixes it.  Also reverse-diff option was left out during the last
round, which this patch restores as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree-helper.c |  110 ++++++++++++++++++++++++-----------------------------
1 files changed, 50 insertions(+), 60 deletions(-)

# - [PATCH] diff-tree -p implies diff-tree -p -r
# + 04/27 19:18 Fix diff-tree-helper for unmerged path with path specification
--- k/diff-tree-helper.c
+++ l/diff-tree-helper.c
@@ -5,7 +5,7 @@
 #include "strbuf.h"
 #include "diff.h"
 
-static int matches_pathspec(const char *name, char **spec, int cnt)
+static int matches_pathspec(const char *name, const char **spec, int cnt)
 {
 	int i;
 	int namelen = strlen(name);
@@ -44,70 +44,69 @@ static int parse_oneside_change(const ch
 	return 0;
 }
 
-#define PLEASE_WARN -1
-#define WARNED_OURSELVES -2
- 
-static int parse_diff_tree_output(const char *buf,
-				  struct diff_spec *old,
-				  struct diff_spec *new,
-				  char *path) {
+static int parse_diff_tree_output(const char *buf, const char **spec, int cnt)
+{
+	struct diff_spec old, new;
+	char path[PATH_MAX];
 	const char *cp = buf;
 	int ch;
 
 	switch (*cp++) {
 	case 'U':
-		diff_unmerge(cp + 1);
-		return WARNED_OURSELVES;
+		if (!cnt || matches_pathspec(cp + 1, spec, cnt))
+			diff_unmerge(cp + 1);
+		return 0;
 	case '+':
-		old->file_valid = 0;
-		return parse_oneside_change(cp, new, path);
+		old.file_valid = 0;
+		parse_oneside_change(cp, &new, path);
+		break;
 	case '-':
-		new->file_valid = 0;
-		return parse_oneside_change(cp, old, path);
+		new.file_valid = 0;
+		parse_oneside_change(cp, &old, path);
+		break;
 	case '*':
+		old.file_valid = old.sha1_valid =
+			new.file_valid = new.sha1_valid = 1;
+		old.mode = new.mode = 0;
+		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+			old.mode = (old.mode << 3) | (ch - '0');
+			cp++;
+		}
+		if (strncmp(cp, "->", 2))
+			return -1;
+		cp += 2;
+		while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
+			new.mode = (new.mode << 3) | (ch - '0');
+			cp++;
+		}
+		if (strncmp(cp, "\tblob\t", 6))
+			return -1;
+		cp += 6;
+		if (get_sha1_hex(cp, old.u.sha1))
+			return -1;
+		cp += 40;
+		if (strncmp(cp, "->", 2))
+			return -1;
+		cp += 2;
+		if (get_sha1_hex(cp, new.u.sha1))
+			return -1;
+		cp += 40;
+		if (*cp++ != '\t')
+			return -1;
+		strcpy(path, cp);
 		break;
 	default:
-		return PLEASE_WARN;
-	}
-	
-	/* This is for '*' entries */
-	old->file_valid = old->sha1_valid = 1;
-	new->file_valid = new->sha1_valid = 1;
-
-	old->mode = new->mode = 0;
-	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-		old->mode = (old->mode << 3) | (ch - '0');
-		cp++;
-	}
-	if (strncmp(cp, "->", 2))
-		return PLEASE_WARN;
-	cp += 2;
-	while ((ch = *cp) && ('0' <= ch && ch <= '7')) {
-		new->mode = (new->mode << 3) | (ch - '0');
-		cp++;
+		return -1;
 	}
-	if (strncmp(cp, "\tblob\t", 6))
-		return PLEASE_WARN;
-	cp += 6;
-	if (get_sha1_hex(cp, old->u.sha1))
-		return PLEASE_WARN;
-	cp += 40;
-	if (strncmp(cp, "->", 2))
-		return PLEASE_WARN;
-	cp += 2;
-	if (get_sha1_hex(cp, new->u.sha1))
-		return PLEASE_WARN;
-	cp += 40;
-	if (*cp++ != '\t')
-		return PLEASE_WARN;
-	strcpy(path, cp);
+	if (!cnt || matches_pathspec(path, spec, cnt))
+		run_external_diff(path, &old, &new);
 	return 0;
 }
 
 static const char *diff_tree_helper_usage =
 "diff-tree-helper [-R] [-z] paths...";
 
-int main(int ac, char **av) {
+int main(int ac, const char **av) {
 	struct strbuf sb;
 	int reverse_diff = 0;
 	int line_termination = '\n';
@@ -127,21 +126,12 @@ int main(int ac, char **av) {
 
 	while (1) {
 		int status;
-		struct diff_spec old, new;
-		char path[PATH_MAX];
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		status = parse_diff_tree_output(sb.buf, &old, &new, path);
-		if (status) {
-			if (status == PLEASE_WARN)
-				fprintf(stderr, "cannot parse %s\n", sb.buf);
-			continue;
-		}
-		if (1 < ac && !matches_pathspec(path, av+1, ac-1))
-			continue;
-
-		run_external_diff(path, &old, &new);
+		status = parse_diff_tree_output(sb.buf, av+1, ac-1);
+		if (status)
+			fprintf(stderr, "cannot parse %s\n", sb.buf);
 	}
 	return 0;
 }

