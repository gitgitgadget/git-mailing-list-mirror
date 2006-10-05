From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/5] blame.c: move code to output metainfo into a separate function.
Date: Thu, 05 Oct 2006 14:06:42 -0700
Message-ID: <7vbqoqcw0t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:08:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaQZ-00086I-Gr
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWJEVGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWJEVGo
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:06:44 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23267 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751358AbWJEVGn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:06:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005210642.CGQN16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:06:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wl6l1V00B1kojtg0000000
	Thu, 05 Oct 2006 17:06:45 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28367>

This does not change any behaviour, but just separates out the
code to emit the initial part of the output of each line into a
separate function, since I'll be mucking with it further.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 blame.c |   76 +++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/blame.c b/blame.c
index bf4a1a1..47471e8 100644
--- a/blame.c
+++ b/blame.c
@@ -750,6 +750,42 @@ static int find_orig_linenum(struct util
 	return 0;
 }
 
+static void emit_meta(struct commit *c, int lno,
+		      int sha1_len, int compatibility,
+		      int show_name, int show_number, int show_raw_time,
+		      int longest_file, int longest_author,
+		      int max_digits, int max_orig_digits)
+{
+	struct util_info *u;
+	int lineno;
+	struct commit_info ci;
+
+	u = c->util;
+	lineno = find_orig_linenum(u, lno);
+
+	get_commit_info(c, &ci);
+	fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
+	if (compatibility) {
+		printf("\t(%10s\t%10s\t%d)", ci.author,
+		       format_time(ci.author_time, ci.author_tz,
+				   show_raw_time),
+		       lno + 1);
+	}
+	else {
+		if (show_name)
+			printf(" %-*.*s", longest_file, longest_file,
+			       u->pathname);
+		if (show_number)
+			printf(" %*d", max_orig_digits,
+			       lineno);
+		printf(" (%-*.*s %10s %*d) ",
+		       longest_author, longest_author, ci.author,
+		       format_time(ci.author_time, ci.author_tz,
+				   show_raw_time),
+		       max_digits, lno + 1);
+	}
+}
+
 int main(int argc, const char **argv)
 {
 	int i;
@@ -877,6 +913,10 @@ int main(int argc, const char **argv)
 	prepare_revision_walk(&rev);
 	process_commits(&rev, filename, &initial);
 
+	for (i = 0; i < num_blame_lines; i++)
+		if (!blame_lines[i])
+			blame_lines[i] = initial;
+
 	buf = blame_contents;
 	max_digits = lineno_width(num_blame_lines);
 
@@ -886,8 +926,6 @@ int main(int argc, const char **argv)
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		struct util_info *u;
-		if (!c)
-			c = initial;
 		u = c->util;
 
 		if (!show_name && strcmp(filename, u->pathname))
@@ -904,35 +942,11 @@ int main(int argc, const char **argv)
 	max_orig_digits = lineno_width(longest_file_lines);
 
 	for (i = 0; i < num_blame_lines; i++) {
-		struct commit *c = blame_lines[i];
-		struct util_info *u;
-		int lineno;
-		if (!c)
-			c = initial;
-		u = c->util;
-		lineno = find_orig_linenum(u, i);
-
-		get_commit_info(c, &ci);
-		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
-		if (compatibility) {
-			printf("\t(%10s\t%10s\t%d)", ci.author,
-			       format_time(ci.author_time, ci.author_tz,
-					   show_raw_time),
-			       i+1);
-		}
-		else {
-			if (show_name)
-				printf(" %-*.*s", longest_file, longest_file,
-				       u->pathname);
-			if (show_number)
-				printf(" %*d", max_orig_digits,
-				       lineno);
-			printf(" (%-*.*s %10s %*d) ",
-			       longest_author, longest_author, ci.author,
-			       format_time(ci.author_time, ci.author_tz,
-					   show_raw_time),
-			       max_digits, i+1);
-		}
+		emit_meta(blame_lines[i], i,
+			  sha1_len, compatibility,
+			  show_name, show_number, show_raw_time,
+			  longest_file, longest_author,
+			  max_digits, max_orig_digits);
 
 		if (i == num_blame_lines - 1) {
 			fwrite(buf, blame_len - (buf - blame_contents),
-- 
1.4.2.3.g866f3
