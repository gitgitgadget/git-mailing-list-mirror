From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/8] diff --no-index: support /dev/null as filename
Date: Sun, 25 Feb 2007 23:36:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252336190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRyt-0003hc-RW
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbXBYWgd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbXBYWgd
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:36:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:46802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965176AbXBYWgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:36:32 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:36:31 -0000
X-Provags-ID: V01U2FsdGVkX19hbOQMWpVhHFV9Vawy4G1Z9OWu7/QzvkgYSnSlWN
	iMiA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40587>


This allows us to create "new file" and "delete file" patches.
It also cleans up the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 089c94c..43907c2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -30,28 +30,28 @@ static int read_directory(const char *path, struct path_list *list)
 	return 0;
 }
 
+static int get_mode(const char *path, int *mode)
+{
+	struct stat st;
+
+	if (!path || !strcmp(path, "/dev/null"))
+		*mode = 0;
+	else if (!strcmp(path, "-"))
+		*mode = 0644;
+	else if (stat(path, &st))
+		return error("Could not access '%s'", path);
+	else
+		*mode = st.st_mode;
+	return 0;
+}
+
 static int queue_diff(struct diff_options *o,
 		const char *name1, const char *name2)
 {
-	struct stat st;
 	int mode1 = 0, mode2 = 0;
 
-	if (name1) {
-		if (!strcmp(name1, "-"))
-			mode1 = 0644;
-		else if (stat(name1, &st))
-			return error("Could not access '%s'", name1);
-		else
-			mode1 = st.st_mode;
-	}
-	if (name2) {
-		if (!strcmp(name2, "-"))
-			mode2 = 0644;
-		else if (stat(name2, &st))
-			return error("Could not access '%s'", name2);
-		else
-			mode2 = st.st_mode;
-	}
+	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
+		return -1;
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
 		return error("file/directory conflict: %s, %s", name1, name2);
-- 
1.5.0.1.788.g8ca52
