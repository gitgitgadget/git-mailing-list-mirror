From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] convert.c: restructure the attribute checking part.
Date: Sat, 21 Apr 2007 03:40:57 -0700
Message-ID: <1177152059853-git-send-email-junkio@cox.net>
References: <11771520591529-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 12:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfD1k-0004KC-LO
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 12:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbXDUKlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 06:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030656AbXDUKlE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 06:41:04 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46655 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030658AbXDUKlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 06:41:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421104100.UDFN1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Sat, 21 Apr 2007 06:41:00 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pmgz1W00A1kojtg0000200; Sat, 21 Apr 2007 06:40:59 -0400
X-Mailer: git-send-email 1.5.1.1.948.g9f6f
In-Reply-To: <11771520591529-git-send-email-junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45166>

This separates the checkattr() call and interpretation of the
returned value specific to the 'crlf' attribute into separate
routines, so that we can run a single call to checkattr() to
check for more than one attributes, and then interprete what
the returned settings mean separately.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 convert.c |   48 ++++++++++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/convert.c b/convert.c
index 742b895..37239ac 100644
--- a/convert.c
+++ b/convert.c
@@ -200,7 +200,7 @@ static char *crlf_to_worktree(const char *path, const char *src, unsigned long *
 	return buffer;
 }
 
-static void setup_crlf_check(struct git_attr_check *check)
+static void setup_convert_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_crlf;
 
@@ -209,33 +209,41 @@ static void setup_crlf_check(struct git_attr_check *check)
 	check->attr = attr_crlf;
 }
 
-static int git_path_check_crlf(const char *path)
+static int git_path_check_crlf(const char *path, struct git_attr_check *check)
 {
-	struct git_attr_check attr_crlf_check;
-
-	setup_crlf_check(&attr_crlf_check);
-
-	if (!git_checkattr(path, 1, &attr_crlf_check)) {
-		const char *value = attr_crlf_check.value;
-		if (ATTR_TRUE(value))
-			return CRLF_TEXT;
-		else if (ATTR_FALSE(value))
-			return CRLF_BINARY;
-		else if (ATTR_UNSET(value))
-			;
-		else if (!strcmp(value, "input"))
-			return CRLF_INPUT;
-		/* fallthru */
-	}
+	const char *value = check->value;
+
+	if (ATTR_TRUE(value))
+		return CRLF_TEXT;
+	else if (ATTR_FALSE(value))
+		return CRLF_BINARY;
+	else if (ATTR_UNSET(value))
+		;
+	else if (!strcmp(value, "input"))
+		return CRLF_INPUT;
 	return CRLF_GUESS;
 }
 
 char *convert_to_git(const char *path, const char *src, unsigned long *sizep)
 {
-	return crlf_to_git(path, src, sizep, git_path_check_crlf(path));
+	struct git_attr_check check[1];
+	int crlf = CRLF_GUESS;
+
+	setup_convert_check(check);
+	if (!git_checkattr(path, 1, check)) {
+		crlf = git_path_check_crlf(path, check);
+	}
+	return crlf_to_git(path, src, sizep, crlf);
 }
 
 char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep)
 {
-	return crlf_to_worktree(path, src, sizep, git_path_check_crlf(path));
+	struct git_attr_check check[1];
+	int crlf = CRLF_GUESS;
+
+	setup_convert_check(check);
+	if (!git_checkattr(path, 1, check)) {
+		crlf = git_path_check_crlf(path, check);
+	}
+	return crlf_to_worktree(path, src, sizep, crlf);
 }
-- 
1.5.1.1.948.g9f6f
