From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 02/12] pick: refactor checking parent in a check_parent
	function
Date: Sun, 28 Feb 2010 23:21:57 +0100
Message-ID: <20100228222208.2260.56956.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:23:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrXr-0006Rr-CG
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032143Ab0B1WWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:22:50 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48494 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032119Ab0B1WWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:47 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A5CE08180EA;
	Sun, 28 Feb 2010 23:22:38 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 96B90818103;
	Sun, 28 Feb 2010 23:22:35 +0100 (CET)
X-git-sha1: ab6c36335f13aef7fa6b735ee24fa63fba648f8b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141286>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pick.c |   69 ++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/pick.c b/pick.c
index 1e1628a..40673ca 100644
--- a/pick.c
+++ b/pick.c
@@ -59,6 +59,40 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
+static int check_parent(struct commit *commit, int mainline, int flags,
+			struct commit **parent)
+{
+	if (!commit->parents) {
+		if (flags & PICK_REVERSE)
+			return error("Cannot revert a root commit");
+	}
+	else if (commit->parents->next) {
+		/* Reverting or cherry-picking a merge commit */
+		int cnt;
+		struct commit_list *p;
+
+		if (!mainline)
+			return error("Commit %s is a merge but no mainline was given.",
+				     sha1_to_hex(commit->object.sha1));
+
+		for (cnt = 1, p = commit->parents;
+		     cnt != mainline && p;
+		     cnt++)
+			p = p->next;
+		if (cnt != mainline || !p)
+			return error("Commit %s does not have parent %d",
+				     sha1_to_hex(commit->object.sha1),
+				     mainline);
+		*parent = p->item;
+	} else if (0 < mainline)
+		return error("Mainline was specified but commit %s is not a merge.",
+			     sha1_to_hex(commit->object.sha1));
+	else
+		*parent = commit->parents->item;
+
+	return 0;
+}
+
 /*
  * Pick changes introduced by "commit" argument into current working
  * tree and index.
@@ -80,8 +114,8 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 		struct strbuf *msg)
 {
 	unsigned char head[20];
-	struct commit *base, *next, *parent;
-	int i, index_fd, clean;
+	struct commit *base, *next, *parent = NULL;
+	int i, index_fd, clean, err;
 	int ret = 0;
 	char *oneline;
 	const char *message;
@@ -105,34 +139,9 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 		return error("Unable to create locked index: %s",
 			     strerror(errno));
 
-	if (!commit->parents) {
-		if (flags & PICK_REVERSE)
-			return error("Cannot revert a root commit");
-		parent = NULL;
-	}
-	else if (commit->parents->next) {
-		/* Reverting or cherry-picking a merge commit */
-		int cnt;
-		struct commit_list *p;
-
-		if (!mainline)
-			return error("Commit %s is a merge but no mainline was given.",
-				     sha1_to_hex(commit->object.sha1));
-
-		for (cnt = 1, p = commit->parents;
-		     cnt != mainline && p;
-		     cnt++)
-			p = p->next;
-		if (cnt != mainline || !p)
-			return error("Commit %s does not have parent %d",
-				     sha1_to_hex(commit->object.sha1),
-				     mainline);
-		parent = p->item;
-	} else if (0 < mainline)
-		return error("Mainline was specified but commit %s is not a merge.",
-			     sha1_to_hex(commit->object.sha1));
-	else
-		parent = commit->parents->item;
+	err = check_parent(commit, mainline, flags, &parent);
+	if (err)
+		return err;
 
 	if (!(message = commit->buffer))
 		return error("Cannot get commit message for %s",
-- 
1.7.0.321.g2d270
