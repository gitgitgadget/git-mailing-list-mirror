From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/5] match_pathspec() -- return how well the spec matched
Date: Mon, 25 Dec 2006 03:09:52 -0800
Message-ID: <7vk60gmdtr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 25 12:10:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyniY-0003Sw-Qb
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 12:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbWLYLJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 06:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbWLYLJy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 06:09:54 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42831 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754409AbWLYLJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 06:09:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225110952.CATN15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 06:09:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2zA51W0111kojtg0000000; Mon, 25 Dec 2006 06:10:06 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35382>

This updates the return value from match_pathspec() so that the
caller can tell cases between exact match, leading pathname
match (i.e. file "foo/bar" matches a pathspec "foo"), or
filename glob match.  This can be used to prevent "rm dir" from
removing "dir/file" without explicitly asking for recursive
behaviour with -r flag, for example.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 dir.c |   51 +++++++++++++++++++++++++++++++++++----------------
 dir.h |    4 ++++
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index 16401d8..8477472 100644
--- a/dir.c
+++ b/dir.c
@@ -40,6 +40,18 @@ int common_prefix(const char **pathspec)
 	return prefix;
 }
 
+/*
+ * Does 'match' matches the given name?
+ * A match is found if
+ *
+ * (1) the 'match' string is leading directory of 'name', or
+ * (2) the 'match' string is a wildcard and matches 'name', or
+ * (3) the 'match' string is exactly the same as 'name'.
+ *
+ * and the return value tells which case it was.
+ *
+ * It returns 0 when there is no match.
+ */
 static int match_one(const char *match, const char *name, int namelen)
 {
 	int matchlen;
@@ -47,27 +59,30 @@ static int match_one(const char *match, const char *name, int namelen)
 	/* If the match was just the prefix, we matched */
 	matchlen = strlen(match);
 	if (!matchlen)
-		return 1;
+		return MATCHED_RECURSIVELY;
 
 	/*
 	 * If we don't match the matchstring exactly,
 	 * we need to match by fnmatch
 	 */
 	if (strncmp(match, name, matchlen))
-		return !fnmatch(match, name, 0);
+		return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
 
-	/*
-	 * If we did match the string exactly, we still
-	 * need to make sure that it happened on a path
-	 * component boundary (ie either the last character
-	 * of the match was '/', or the next character of
-	 * the name was '/' or the terminating NUL.
-	 */
-	return	match[matchlen-1] == '/' ||
-		name[matchlen] == '/' ||
-		!name[matchlen];
+	if (!name[matchlen])
+		return MATCHED_EXACTLY;
+	if (match[matchlen-1] == '/' || name[matchlen] == '/')
+		return MATCHED_RECURSIVELY;
+	return 0;
 }
 
+/*
+ * Given a name and a list of pathspecs, see if the name matches
+ * any of the pathspecs.  The caller is also interested in seeing
+ * all pathspec matches some names it calls this function with
+ * (otherwise the user could have mistyped the unmatched pathspec),
+ * and a mark is left in seen[] array for pathspec element that
+ * actually matched anything.
+ */
 int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen)
 {
 	int retval;
@@ -77,12 +92,16 @@ int match_pathspec(const char **pathspec, const char *name, int namelen, int pre
 	namelen -= prefix;
 
 	for (retval = 0; (match = *pathspec++) != NULL; seen++) {
-		if (retval & *seen)
+		int how;
+		if (retval && *seen == MATCHED_EXACTLY)
 			continue;
 		match += prefix;
-		if (match_one(match, name, namelen)) {
-			retval = 1;
-			*seen = 1;
+		how = match_one(match, name, namelen);
+		if (how) {
+			if (retval < how)
+				retval = how;
+			if (*seen < how)
+				*seen = how;
 		}
 	}
 	return retval;
diff --git a/dir.h b/dir.h
index 550551a..c919727 100644
--- a/dir.h
+++ b/dir.h
@@ -40,6 +40,10 @@ struct dir_struct {
 };
 
 extern int common_prefix(const char **pathspec);
+
+#define MATCHED_RECURSIVELY 1
+#define MATCHED_FNMATCH 2
+#define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
 extern int read_directory(struct dir_struct *, const char *path, const char *base, int baselen);
-- 
1.4.4.3.g50da
