From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix 'crlf' attribute semantics.
Date: Sun, 15 Apr 2007 16:10:56 -0700
Message-ID: <7vr6ql1ben.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
	<7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
	<7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
	<7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704142103210.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDs6-00055I-55
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbXDOXK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbXDOXK6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:10:58 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62748 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbXDOXK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:10:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415231058.JXOS1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 19:10:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nbAw1W00c1kojtg0000000; Sun, 15 Apr 2007 19:10:57 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44541>

Earlier we said 'crlf lets the path go through core.autocrlf
process while !crlf disables it altogether'.  This fixes the
semantics to:

 - Lack of 'crlf' attribute makes core.autocrlf to apply
   (i.e. we guess based on the contents and if platform
   expresses its desire to have CRLF line endings via
   core.autocrlf, we do so).

 - Setting 'crlf' attribute to true forces CRLF line endings in
   working tree files, even if blob does not look like text
   (e.g. contains NUL or other bytes we consider binary).

 - Setting 'crlf' attribute to false disables conversion.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Linus Torvalds <torvalds@linux-foundation.org> writes:

  > Here's a simple example:
  >
  > 	echo -e '\007Bell!' > bell
  >
  > and just because we consider the BEL character to be binary, we'll think 
  > the file is binary.

 You are right.  This replaces my earlier "we could do..." patch.

 convert.c |  122 +++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/convert.c b/convert.c
index 20c744a..d0d4b81 100644
--- a/convert.c
+++ b/convert.c
@@ -74,13 +74,13 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-static int autocrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
+static int crlf_to_git(const char *path, char **bufp, unsigned long *sizep, int guess)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
 	struct text_stat stats;
 
-	if (!auto_crlf)
+	if (guess && !auto_crlf)
 		return 0;
 
 	size = *sizep;
@@ -94,19 +94,21 @@ static int autocrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
 	if (!stats.cr)
 		return 0;
 
-	/*
-	 * We're currently not going to even try to convert stuff
-	 * that has bare CR characters. Does anybody do that crazy
-	 * stuff?
-	 */
-	if (stats.cr != stats.crlf)
-		return 0;
-
-	/*
-	 * And add some heuristics for binary vs text, of course...
-	 */
-	if (is_binary(size, &stats))
-		return 0;
+	if (guess) {
+		/*
+		 * We're currently not going to even try to convert stuff
+		 * that has bare CR characters. Does anybody do that crazy
+		 * stuff?
+		 */
+		if (stats.cr != stats.crlf)
+			return 0;
+
+		/*
+		 * And add some heuristics for binary vs text, of course...
+		 */
+		if (is_binary(size, &stats))
+			return 0;
+	}
 
 	/*
 	 * Ok, allocate a new buffer, fill it in, and return true
@@ -116,28 +118,42 @@ static int autocrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
 	nbuf = xmalloc(nsize);
 	*bufp = nbuf;
 	*sizep = nsize;
-	do {
-		unsigned char c = *buffer++;
-		if (c != '\r')
-			*nbuf++ = c;
-	} while (--size);
+
+	if (guess) {
+		do {
+			unsigned char c = *buffer++;
+			if (c != '\r')
+				*nbuf++ = c;
+		} while (--size);
+	} else {
+		do {
+			unsigned char c = *buffer++;
+			if (! (c == '\r' && (1 < size && *buffer == '\n')))
+				*nbuf++ = c;
+		} while (--size);
+	}
 
 	return 1;
 }
 
-static int autocrlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+static int autocrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
+{
+	return crlf_to_git(path, bufp, sizep, 1);
+}
+
+static int forcecrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
+{
+	return crlf_to_git(path, bufp, sizep, 0);
+}
+
+static int crlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep, int guess)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
 	struct text_stat stats;
 	unsigned char last;
 
-	/*
-	 * FIXME! Other pluggable conversions should go here,
-	 * based on filename patterns. Right now we just do the
-	 * stupid auto-CRLF one.
-	 */
-	if (auto_crlf <= 0)
+	if (guess && auto_crlf <= 0)
 		return 0;
 
 	size = *sizep;
@@ -155,12 +171,14 @@ static int autocrlf_to_working_tree(const char *path, char **bufp, unsigned long
 	if (stats.lf == stats.crlf)
 		return 0;
 
-	/* If we have any bare CR characters, we're not going to touch it */
-	if (stats.cr != stats.crlf)
-		return 0;
+	if (guess) {
+		/* If we have any bare CR characters, we're not going to touch it */
+		if (stats.cr != stats.crlf)
+			return 0;
 
-	if (is_binary(size, &stats))
-		return 0;
+		if (is_binary(size, &stats))
+			return 0;
+	}
 
 	/*
 	 * Ok, allocate a new buffer, fill it in, and return true
@@ -182,6 +200,16 @@ static int autocrlf_to_working_tree(const char *path, char **bufp, unsigned long
 	return 1;
 }
 
+static int autocrlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+{
+	return crlf_to_working_tree(path, bufp, sizep, 1);
+}
+
+static int forcecrlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+{
+	return crlf_to_working_tree(path, bufp, sizep, 0);
+}
+
 static void setup_crlf_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_crlf;
@@ -191,31 +219,37 @@ static void setup_crlf_check(struct git_attr_check *check)
 	check->attr = attr_crlf;
 }
 
-static int git_path_is_binary(const char *path)
+static int git_path_check_crlf(const char *path)
 {
 	struct git_attr_check attr_crlf_check;
 
 	setup_crlf_check(&attr_crlf_check);
 
-	/*
-	 * If crlf is not mentioned, default to autocrlf;
-	 * disable autocrlf only when crlf attribute is explicitly
-	 * unset.
-	 */
-	return (!git_checkattr(path, 1, &attr_crlf_check) &&
-		(0 == attr_crlf_check.isset));
+	if (git_checkattr(path, 1, &attr_crlf_check))
+		return -1;
+	return attr_crlf_check.isset;
 }
 
 int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
-	if (git_path_is_binary(path))
+	switch (git_path_check_crlf(path)) {
+	case 0:
 		return 0;
-	return autocrlf_to_git(path, bufp, sizep);
+	case 1:
+		return forcecrlf_to_git(path, bufp, sizep);
+	default:
+		return autocrlf_to_git(path, bufp, sizep);
+	}
 }
 
 int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 {
-	if (git_path_is_binary(path))
+	switch (git_path_check_crlf(path)) {
+	case 0:
 		return 0;
-	return autocrlf_to_working_tree(path, bufp, sizep);
+	case 1:
+		return forcecrlf_to_working_tree(path, bufp, sizep);
+	default:
+		return autocrlf_to_working_tree(path, bufp, sizep);
+	}
 }
-- 
1.5.1.1.815.g3e763
