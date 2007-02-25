From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/8] diff: support reading a file from stdin via "-"
Date: Sun, 25 Feb 2007 23:36:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRyZ-0003XL-5f
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbXBYWgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXBYWgM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:36:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:47239 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752437AbXBYWgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:36:12 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:36:10 -0000
X-Provags-ID: V01U2FsdGVkX18REqc4gRoRkrtEFb5dlfHCYop7eIOVrHGHpJKlsI
	PzJA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40586>


This allows you to say

	echo Hello World | git diff x -

to compare the contents of file "x" with the line "Hello World".
This automatically switches to --no-index mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Since the revision machinery checks for the presence of files,
	diff_populate_filespec() will only change behaviour when there
	is a file "-"... I have yet to think of an elegant fix for that.

 diff-lib.c |   16 +++++++++++-----
 diff.c     |   20 ++++++++++++++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 6678e22..089c94c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -37,14 +37,20 @@ static int queue_diff(struct diff_options *o,
 	int mode1 = 0, mode2 = 0;
 
 	if (name1) {
-		if (stat(name1, &st))
+		if (!strcmp(name1, "-"))
+			mode1 = 0644;
+		else if (stat(name1, &st))
 			return error("Could not access '%s'", name1);
-		mode1 = st.st_mode;
+		else
+			mode1 = st.st_mode;
 	}
 	if (name2) {
-		if (stat(name2, &st))
+		if (!strcmp(name2, "-"))
+			mode2 = 0644;
+		else if (stat(name2, &st))
 			return error("Could not access '%s'", name2);
-		mode2 = st.st_mode;
+		else
+			mode2 = st.st_mode;
 	}
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
@@ -224,7 +230,7 @@ int setup_diff_no_index(struct rev_info *revs,
 {
 	int i;
 	for (i = 1; i < argc; i++)
-		if (argv[i][0] != '-')
+		if (argv[i][0] != '-' || argv[i][1] == '\0')
 			break;
 		else if (!strcmp(argv[i], "--")) {
 			i++;
diff --git a/diff.c b/diff.c
index 5651152..31129d1 100644
--- a/diff.c
+++ b/diff.c
@@ -1389,6 +1389,22 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		char *buf;
 		unsigned long size;
 
+		if (!strcmp(s->path, "-")) {
+#define INCREMENT 1024
+			int i = INCREMENT;
+			size = 0;
+			buf = NULL;
+			while (i == INCREMENT) {
+				buf = xrealloc(buf, size + INCREMENT);
+				i = xread(0, buf + size, INCREMENT);
+				size += i;
+			}
+			s->should_munmap = 0;
+			s->data = buf;
+			s->size = size;
+			s->should_free = 1;
+			return 0;
+		}
 		if (lstat(s->path, &st) < 0) {
 			if (errno == ENOENT) {
 			err_empty:
@@ -1688,6 +1704,10 @@ static void diff_fill_sha1_info(struct diff_filespec *one)
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->sha1_valid) {
 			struct stat st;
+			if (!strcmp(one->path, "-")) {
+				hashcpy(one->sha1, null_sha1);
+				return;
+			}
 			if (lstat(one->path, &st) < 0)
 				die("stat %s", one->path);
 			if (index_path(one->sha1, one->path, &st, 0))
-- 
1.5.0.1.788.g8ca52
