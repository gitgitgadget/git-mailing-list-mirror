From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 17:34:10 -0700
Message-ID: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 03:59:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS3if-0001qL-E1
	for gcvg-git@gmane.org; Sun, 01 May 2005 03:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVEAAeh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 20:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVEAAef
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 20:34:35 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:22414 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261482AbVEAAeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2005 20:34:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501003411.SIBW12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Apr 2005 20:34:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Diff-tree-helper take two patch inadvertently dropped the
support of -R option, which is necessary to produce reverse diff
based on diff-cache and diff-files output (diff-tree does not
matter since you can feed two trees in reverse order).  This
patch restores it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff-tree-helper.c |   17 +++++++++++------
1 files changed, 11 insertions(+), 6 deletions(-)

jit-diff 0 diff-tree-helper.c
# - Fix up d_type handling - we need to include <dirent.h> before
# + working-tree
--- k/diff-tree-helper.c  (mode:100644)
+++ l/diff-tree-helper.c  (mode:100644)
@@ -44,7 +44,8 @@ static int parse_oneside_change(const ch
 	return 0;
 }
 
-static int parse_diff_tree_output(const char *buf, const char **spec, int cnt)
+static int parse_diff_tree_output(const char *buf,
+				  const char **spec, int cnt, int reverse)
 {
 	struct diff_spec old, new;
 	char path[PATH_MAX];
@@ -98,8 +99,12 @@ static int parse_diff_tree_output(const 
 	default:
 		return -1;
 	}
-	if (!cnt || matches_pathspec(path, spec, cnt))
-		run_external_diff(path, &old, &new);
+	if (!cnt || matches_pathspec(path, spec, cnt)) {
+		if (reverse)
+			run_external_diff(path, &new, &old);
+		else
+			run_external_diff(path, &old, &new);
+	}
 	return 0;
 }
 
@@ -108,14 +113,14 @@ static const char *diff_tree_helper_usag
 
 int main(int ac, const char **av) {
 	struct strbuf sb;
-	int reverse_diff = 0;
+	int reverse = 0;
 	int line_termination = '\n';
 
 	strbuf_init(&sb);
 
 	while (1 < ac && av[1][0] == '-') {
 		if (av[1][1] == 'R')
-			reverse_diff = 1;
+			reverse = 1;
 		else if (av[1][1] == 'z')
 			line_termination = 0;
 		else
@@ -129,7 +134,7 @@ int main(int ac, const char **av) {
 		read_line(&sb, stdin, line_termination);
 		if (sb.eof)
 			break;
-		status = parse_diff_tree_output(sb.buf, av+1, ac-1);
+		status = parse_diff_tree_output(sb.buf, av+1, ac-1, reverse);
 		if (status)
 			fprintf(stderr, "cannot parse %s\n", sb.buf);
 	}



