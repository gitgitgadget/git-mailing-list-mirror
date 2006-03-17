From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/2] blame: Nicer output
Date: Fri, 17 Mar 2006 22:49:28 +0100
Message-ID: <20060317214928.23075.76032.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 17 22:49:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKMpG-00089W-JF
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 22:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbWCQVtg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 16:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbWCQVtg
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 16:49:36 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:28565 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S932797AbWCQVtf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 16:49:35 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3237540FD; Fri, 17 Mar 2006 23:05:33 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FKMp7-00060M-00; Fri, 17 Mar 2006 22:49:29 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17672>


As pointed out by Junio, it may be dangerous to cut off people's names
after 15 bytes. If the name is encoded in an encoding which uses more
than one byte per code point we may end up with outputting garbage.
Instead of trying to do something smart, just output the entire name.
We don't gain much screen space by chopping it off anyway.

Furthermore, only output the file name if we actually found any
renames.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 blame.c |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/blame.c b/blame.c
index 1fb5070..8af4b54 100644
--- a/blame.c
+++ b/blame.c
@@ -742,6 +742,8 @@ int main(int argc, const char **argv)
 	struct commit_info ci;
 	const char *buf;
 	int max_digits;
+	size_t longest_file, longest_author;
+	int found_rename;
 
 	const char* prefix = setup_git_directory();
 
@@ -818,6 +820,25 @@ int main(int argc, const char **argv)
 	for (max_digits = 1, i = 10; i <= num_blame_lines + 1; max_digits++)
 		i *= 10;
 
+	longest_file = 0;
+	longest_author = 0;
+	found_rename = 0;
+	for (i = 0; i < num_blame_lines; i++) {
+		struct commit *c = blame_lines[i];
+		struct util_info* u;
+		if (!c)
+			c = initial;
+		u = c->object.util;
+
+		if (!found_rename && strcmp(filename, u->pathname))
+			found_rename = 1;
+		if (longest_file < strlen(u->pathname))
+			longest_file = strlen(u->pathname);
+		get_commit_info(c, &ci);
+		if (longest_author < strlen(ci.author))
+			longest_author = strlen(ci.author);
+	}
+
 	for (i = 0; i < num_blame_lines; i++) {
 		struct commit *c = blame_lines[i];
 		struct util_info* u;
@@ -828,14 +849,18 @@ int main(int argc, const char **argv)
 		u = c->object.util;
 		get_commit_info(c, &ci);
 		fwrite(sha1_to_hex(c->object.sha1), sha1_len, 1, stdout);
-		if(compability)
+		if(compability) {
 			printf("\t(%10s\t%10s\t%d)", ci.author,
 			       format_time(ci.author_time, ci.author_tz), i+1);
-		else
-			printf(" %s (%-15.15s %10s %*d) ", u->pathname,
-			       ci.author, format_time(ci.author_time,
-						      ci.author_tz),
+		} else {
+			if (found_rename)
+				printf(" %-*.*s", longest_file, longest_file,
+				       u->pathname);
+			printf(" (%-*.*s %10s %*d) ",
+			       longest_author, longest_author, ci.author,
+			       format_time(ci.author_time, ci.author_tz),
 			       max_digits, i+1);
+		}
 
 		if(i == num_blame_lines - 1) {
 			fwrite(buf, blame_len - (buf - blame_contents),
