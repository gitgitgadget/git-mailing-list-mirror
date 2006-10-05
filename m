From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] git-blame --porcelain
Date: Thu, 05 Oct 2006 14:07:42 -0700
Message-ID: <7v4puicvz5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Oct 05 23:09:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaRk-0008UA-SQ
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWJEVHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWJEVHq
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:07:46 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23203 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751360AbWJEVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 17:07:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005210745.TPLU21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 17:07:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Wl7l1V00W1kojtg0000000
	Thu, 05 Oct 2006 17:07:47 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28368>

The new option makes the command's native output format to emit
output that is easier to handle by Porcelain.

Each line is output after a header.  The header at the minimum
has the first line which has:

 - 40-byte SHA-1 of the commit the line is attributed to;

 - the line number of the line in the final file;

 - the line number of the line in the original file;

 - on a line that starts a group of line from a different commit
   than the previous one, the number of lines in this group.  On
   subsequent lines this field is absent.

This header line is followed by the following information once
for each commit:

 - author name ("author"), email ("author-mail"), time
   ("author-time"), and timezone ("author-tz"); similarly for
   committer.

 - filename in the commit the line is attributed to.

 - the first line of the commit log message ("summary").

The contents of the actual line is output after the above
header, prefixed by a TAB. This is to allow adding more header
elements later.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * By now, Luben would have guessed where this series is leading
   to...

 blame.c |  149 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 127 insertions(+), 22 deletions(-)

diff --git a/blame.c b/blame.c
index 47471e8..8189318 100644
--- a/blame.c
+++ b/blame.c
@@ -17,6 +17,7 @@ #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "xdiff-interface.h"
+#include "quote.h"
 
 #define DEBUG 0
 
@@ -40,6 +41,7 @@ struct util_info {
 	unsigned long size;
 	int num_lines;
 	const char *pathname;
+	unsigned meta_given:1;
 
 	void *topo_data;
 };
@@ -332,12 +334,8 @@ static struct util_info *get_util(struct
 	if (util)
 		return util;
 
-	util = xmalloc(sizeof(struct util_info));
-	util->buf = NULL;
-	util->size = 0;
-	util->line_map = NULL;
+	util = xcalloc(1, sizeof(struct util_info));
 	util->num_lines = -1;
-	util->pathname = NULL;
 	commit->util = util;
 	return util;
 }
@@ -642,39 +640,99 @@ struct commit_info
 	char *author_mail;
 	unsigned long author_time;
 	char *author_tz;
+
+	/* filled only when asked for details */
+	char *committer;
+	char *committer_mail;
+	unsigned long committer_time;
+	char *committer_tz;
+
+	char *summary;
 };
 
-static void get_commit_info(struct commit *commit, struct commit_info *ret)
+static void get_ac_line(const char *inbuf, const char *what,
+			int bufsz, char *person, char **mail,
+			unsigned long *time, char **tz)
 {
 	int len;
-	char *tmp;
-	static char author_buf[1024];
-
-	tmp = strstr(commit->buffer, "\nauthor ") + 8;
-	len = strchr(tmp, '\n') - tmp;
-	ret->author = author_buf;
-	memcpy(ret->author, tmp, len);
+	char *tmp, *endp;
+
+	tmp = strstr(inbuf, what);
+	if (!tmp)
+		goto error_out;
+	tmp += strlen(what);
+	endp = strchr(tmp, '\n');
+	if (!endp)
+		len = strlen(tmp);
+	else
+		len = endp - tmp;
+	if (bufsz <= len) {
+	error_out:
+		/* Ugh */
+		person = *mail = *tz = "(unknown)";
+		*time = 0;
+		return;
+	}
+	memcpy(person, tmp, len);
 
-	tmp = ret->author;
+	tmp = person;
 	tmp += len;
 	*tmp = 0;
 	while (*tmp != ' ')
 		tmp--;
-	ret->author_tz = tmp+1;
+	*tz = tmp+1;
 
 	*tmp = 0;
 	while (*tmp != ' ')
 		tmp--;
-	ret->author_time = strtoul(tmp, NULL, 10);
+	*time = strtoul(tmp, NULL, 10);
 
 	*tmp = 0;
 	while (*tmp != ' ')
 		tmp--;
-	ret->author_mail = tmp + 1;
-
+	*mail = tmp + 1;
 	*tmp = 0;
 }
 
+static void get_commit_info(struct commit *commit, struct commit_info *ret, int detailed)
+{
+	int len;
+	char *tmp, *endp;
+	static char author_buf[1024];
+	static char committer_buf[1024];
+	static char summary_buf[1024];
+
+	ret->author = author_buf;
+	get_ac_line(commit->buffer, "\nauthor ",
+		    sizeof(author_buf), author_buf, &ret->author_mail,
+		    &ret->author_time, &ret->author_tz);
+
+	if (!detailed)
+		return;
+
+	ret->committer = committer_buf;
+	get_ac_line(commit->buffer, "\ncommitter ",
+		    sizeof(committer_buf), committer_buf, &ret->committer_mail,
+		    &ret->committer_time, &ret->committer_tz);
+
+	ret->summary = summary_buf;
+	tmp = strstr(commit->buffer, "\n\n");
+	if (!tmp) {
+	error_out:
+		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
+		return;
+	}
+	tmp += 2;
+	endp = strchr(tmp, '\n');
+	if (!endp)
+		goto error_out;
+	len = endp - tmp;
+	if (len >= sizeof(summary_buf))
+		goto error_out;
+	memcpy(summary_buf, tmp, len);
+	summary_buf[len] = 0;
+}
+
 static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
@@ -751,7 +809,7 @@ static int find_orig_linenum(struct util
 }
 
 static void emit_meta(struct commit *c, int lno,
-		      int sha1_len, int compatibility,
+		      int sha1_len, int compatibility, int porcelain,
 		      int show_name, int show_number, int show_raw_time,
 		      int longest_file, int longest_author,
 		      int max_digits, int max_orig_digits)
@@ -763,7 +821,47 @@ static void emit_meta(struct commit *c, 
 	u = c->util;
 	lineno = find_orig_linenum(u, lno);
 
-	get_commit_info(c, &ci);
+	if (porcelain) {
+		int group_size = -1;
+		struct commit *cc = (lno == 0) ? NULL : blame_lines[lno-1];
+		if (cc != c) {
+			/* This is the beginning of this group */
+			int i;
+			for (i = lno + 1; i < num_blame_lines; i++)
+				if (blame_lines[i] != c)
+					break;
+			group_size = i - lno;
+		}
+		if (0 < group_size)
+			printf("%s %d %d %d\n", sha1_to_hex(c->object.sha1),
+			       lno + 1, lineno, group_size);
+		else
+			printf("%s %d %d\n", sha1_to_hex(c->object.sha1),
+			       lno + 1, lineno);
+		if (!u->meta_given) {
+			get_commit_info(c, &ci, 1);
+			printf("author %s\n", ci.author);
+			printf("author-mail %s\n", ci.author_mail);
+			printf("author-time %lu\n", ci.author_time);
+			printf("author-tz %s\n", ci.author_tz);
+			printf("committer %s\n", ci.committer);
+			printf("committer-mail %s\n", ci.committer_mail);
+			printf("committer-time %lu\n", ci.committer_time);
+			printf("committer-tz %s\n", ci.committer_tz);
+			printf("filename ");
+			if (quote_c_style(u->pathname, NULL, NULL, 0))
+				quote_c_style(u->pathname, NULL, stdout, 0);
+			else
+				fputs(u->pathname, stdout);
+			printf("\nsummary %s\n", ci.summary);
+
+			u->meta_given = 1;
+		}
+		putchar('\t');
+		return;
+	}
+
+	get_commit_info(c, &ci, 0);
 	fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
 	if (compatibility) {
 		printf("\t(%10s\t%10s\t%d)", ci.author,
@@ -809,6 +907,7 @@ int main(int argc, const char **argv)
 	int longest_file, longest_author, longest_file_lines;
 	int show_name = 0;
 	int show_number = 0;
+	int porcelain = 0;
 
 	const char *prefix = setup_git_directory();
 	git_config(git_default_config);
@@ -852,6 +951,12 @@ int main(int argc, const char **argv)
 				show_number = 1;
 				continue;
 			}
+			if (!strcmp(argv[i], "--porcelain")) {
+				porcelain = 1;
+				sha1_len = 40;
+				show_raw_time = 1;
+				continue;
+			}
 			if (!strcmp(argv[i], "--")) {
 				options = 0;
 				continue;
@@ -934,7 +1039,7 @@ int main(int argc, const char **argv)
 			longest_file = strlen(u->pathname);
 		if (longest_file_lines < u->num_lines)
 			longest_file_lines = u->num_lines;
-		get_commit_info(c, &ci);
+		get_commit_info(c, &ci, 0);
 		if (longest_author < strlen(ci.author))
 			longest_author = strlen(ci.author);
 	}
@@ -943,7 +1048,7 @@ int main(int argc, const char **argv)
 
 	for (i = 0; i < num_blame_lines; i++) {
 		emit_meta(blame_lines[i], i,
-			  sha1_len, compatibility,
+			  sha1_len, compatibility, porcelain,
 			  show_name, show_number, show_raw_time,
 			  longest_file, longest_author,
 			  max_digits, max_orig_digits);
-- 
1.4.2.3.g866f3
