From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] git-blame: --show-name (and -f)
Date: Thu, 05 Oct 2006 14:06:22 -0700
Message-ID: <7vmz8acw1d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:06:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaQI-00081i-2o
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWJEVG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWJEVG1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:06:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:19077 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751348AbWJEVG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:06:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005210626.SRMH22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:06:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wl6R1V00a1kojtg0000000
	Thu, 05 Oct 2006 17:06:28 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28365>

The new option makes the command's native output format show the
filename even when there were no renames in its history, to make
it simpler for Porcelains to parse its output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 blame.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/blame.c b/blame.c
index 394b5c3..d830b29 100644
--- a/blame.c
+++ b/blame.c
@@ -752,7 +752,7 @@ int main(int argc, const char **argv)
 	const char *buf;
 	int max_digits;
 	int longest_file, longest_author;
-	int found_rename;
+	int show_name = 0;
 
 	const char *prefix = setup_git_directory();
 	git_config(git_default_config);
@@ -786,6 +786,11 @@ int main(int argc, const char **argv)
 				}
 				usage(blame_usage);
 			}
+			if (!strcmp(argv[i], "-f") ||
+			    !strcmp(argv[i], "--show-name")) {
+				show_name = 1;
+				continue;
+			}
 			if (!strcmp(argv[i], "--")) {
 				options = 0;
 				continue;
@@ -853,7 +858,6 @@ int main(int argc, const char **argv)
 
 	longest_file = 0;
 	longest_author = 0;
-	found_rename = 0;
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		struct util_info *u;
@@ -861,8 +865,8 @@ int main(int argc, const char **argv)
 			c = initial;
 		u = c->util;
 
-		if (!found_rename && strcmp(filename, u->pathname))
-			found_rename = 1;
+		if (!show_name && strcmp(filename, u->pathname))
+			show_name = 1;
 		if (longest_file < strlen(u->pathname))
 			longest_file = strlen(u->pathname);
 		get_commit_info(c, &ci);
@@ -886,7 +890,7 @@ int main(int argc, const char **argv)
 			       i+1);
 		}
 		else {
-			if (found_rename)
+			if (show_name)
 				printf(" %-*.*s", longest_file, longest_file,
 				       u->pathname);
 			printf(" (%-*.*s %10s %*d) ",
-- 
1.4.2.3.g866f3
