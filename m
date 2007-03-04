From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] cherry-pick: Suggest a better method to retain authorship
Date: Sun, 4 Mar 2007 14:26:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703041425280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 04 14:26:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNqjN-0002qI-OV
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 14:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbXCDN0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 08:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbXCDN0J
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 08:26:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:45506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751674AbXCDN0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 08:26:07 -0500
Received: (qmail invoked by alias); 04 Mar 2007 13:26:06 -0000
X-Provags-ID: V01U2FsdGVkX1/JjUJEJQDJncmfWLH9N3X5uBEcIMh/X5/gv1EuMs
	EZ4dodATPmkODO
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41359>


When a cherry-pick failed, we used to recommend setting environment
variables to retain the authorship. It is much easier, though, to use
the "-c" flag of git-commit.

Print this message also when merge-recursive fails (the code used to
exit(1) in that case, never reaching the proper failure path).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-revert.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index bc3cfcb..382fe0c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -323,9 +323,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (merge_recursive(sha1_to_hex(base->object.sha1),
 				sha1_to_hex(head), "HEAD",
-				sha1_to_hex(next->object.sha1), oneline))
-		exit(1);
-	if (write_tree(head, 0, NULL)) {
+				sha1_to_hex(next->object.sha1), oneline) ||
+			write_tree(head, 0, NULL)) {
 		const char *target = git_path("MERGE_MSG");
 		add_to_msg("\nConflicts:\n\n");
 		read_cache();
@@ -350,16 +349,10 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			"mark the corrected paths with 'git-add <paths>'\n"
 			"and commit the result.\n", me);
 		if (action == CHERRY_PICK) {
-			fprintf(stderr, "You may choose to use the following "
-				"when making the commit:\n"
-				"GIT_AUTHOR_NAME=\"%s\"\n",
-				getenv("GIT_AUTHOR_NAME"));
-			fprintf(stderr, "GIT_AUTHOR_EMAIL=\"%s\"\n",
-				getenv("GIT_AUTHOR_EMAIL"));
-			fprintf(stderr, "GIT_AUTHOR_DATE=\"%s\"\n"
-				"export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL "
-				"GIT_AUTHOR_DATE\n",
-				getenv("GIT_AUTHOR_DATE"));
+			fprintf(stderr, "When commiting, use the option "
+				"'-c %s' to retain authorship and message.\n",
+				find_unique_abbrev(commit->object.sha1,
+					DEFAULT_ABBREV));
 		}
 		exit(1);
 	}
-- 
1.5.0.2.2531.g5a43-dirty
