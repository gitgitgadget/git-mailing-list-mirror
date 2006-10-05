From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] git-blame: --show-number (and -n)
Date: Thu, 05 Oct 2006 14:06:26 -0700
Message-ID: <7vhcyicw19.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaQa-00086I-3D
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJEVGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWJEVGn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:06:43 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:46313 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751357AbWJEVGm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:06:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005210642.ZXTM18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:06:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wl6k1V0011kojtg0000000
	Thu, 05 Oct 2006 17:06:44 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28366>

The new option makes the command's native output format show the
original line number in the blamed revision.

Note: the current implementation of find_orig_linenum involves
linear search through the line_map array every time.  It should
probably build a reverse map upfront and do a simple look-up to
speed things up, but I'll leave it to more clever and beautiful
people ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 blame.c |   42 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/blame.c b/blame.c
index d830b29..bf4a1a1 100644
--- a/blame.c
+++ b/blame.c
@@ -731,6 +731,25 @@ static int read_ancestry(const char *gra
 	return 0;
 }
 
+static int lineno_width(int lines)
+{
+	int i, width;
+
+	for (width = 1, i = 10; i <= lines + 1; width++)
+		i *= 10;
+	return width;
+}
+
+static int find_orig_linenum(struct util_info *u, int lineno)
+{
+	int i;
+
+	for (i = 0; i < u->num_lines; i++)
+		if (lineno == u->line_map[i])
+			return i + 1;
+	return 0;
+}
+
 int main(int argc, const char **argv)
 {
 	int i;
@@ -750,9 +769,10 @@ int main(int argc, const char **argv)
 
 	struct commit_info ci;
 	const char *buf;
-	int max_digits;
-	int longest_file, longest_author;
+	int max_digits, max_orig_digits;
+	int longest_file, longest_author, longest_file_lines;
 	int show_name = 0;
+	int show_number = 0;
 
 	const char *prefix = setup_git_directory();
 	git_config(git_default_config);
@@ -791,6 +811,11 @@ int main(int argc, const char **argv)
 				show_name = 1;
 				continue;
 			}
+			if (!strcmp(argv[i], "-n") ||
+			    !strcmp(argv[i], "--show-number")) {
+				show_number = 1;
+				continue;
+			}
 			if (!strcmp(argv[i], "--")) {
 				options = 0;
 				continue;
@@ -853,11 +878,11 @@ int main(int argc, const char **argv)
 	process_commits(&rev, filename, &initial);
 
 	buf = blame_contents;
-	for (max_digits = 1, i = 10; i <= num_blame_lines + 1; max_digits++)
-		i *= 10;
+	max_digits = lineno_width(num_blame_lines);
 
 	longest_file = 0;
 	longest_author = 0;
+	longest_file_lines = 0;
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		struct util_info *u;
@@ -869,17 +894,23 @@ int main(int argc, const char **argv)
 			show_name = 1;
 		if (longest_file < strlen(u->pathname))
 			longest_file = strlen(u->pathname);
+		if (longest_file_lines < u->num_lines)
+			longest_file_lines = u->num_lines;
 		get_commit_info(c, &ci);
 		if (longest_author < strlen(ci.author))
 			longest_author = strlen(ci.author);
 	}
 
+	max_orig_digits = lineno_width(longest_file_lines);
+
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		struct util_info *u;
+		int lineno;
 		if (!c)
 			c = initial;
 		u = c->util;
+		lineno = find_orig_linenum(u, i);
 
 		get_commit_info(c, &ci);
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
@@ -893,6 +924,9 @@ int main(int argc, const char **argv)
 			if (show_name)
 				printf(" %-*.*s", longest_file, longest_file,
 				       u->pathname);
+			if (show_number)
+				printf(" %*d", max_orig_digits,
+				       lineno);
 			printf(" (%-*.*s %10s %*d) ",
 			       longest_author, longest_author, ci.author,
 			       format_time(ci.author_time, ci.author_tz,
-- 
1.4.2.3.g866f3
