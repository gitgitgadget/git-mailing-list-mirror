From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/9] revert: refactor checking parent in a check_parent()
	function
Date: Wed, 03 Mar 2010 21:11:39 +0100
Message-ID: <20100303201146.23506.21157.chriscool@tuxfamily.org>
References: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0Rn-0008HT-Po
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab0CDCFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:05:31 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40550 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755277Ab0CDCFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:05:18 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6468C81805A;
	Thu,  4 Mar 2010 03:05:08 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4CF08818040;
	Thu,  4 Mar 2010 03:05:06 +0100 (CET)
X-git-sha1: ef270ca9665adba6248001299861434ca24b640a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141498>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   62 ++++++++++++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..a611960 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -244,6 +244,40 @@ static NORETURN void die_dirty_index(const char *me)
 	}
 }
 
+static struct commit * check_parent(struct commit *commit, int mainline)
+{
+	if (!commit->parents) {
+		if (action == REVERT)
+			die ("Cannot revert a root commit");
+		return NULL;
+	}
+
+	if (commit->parents->next) {
+		/* Reverting or cherry-picking a merge commit */
+		int cnt;
+		struct commit_list *p;
+
+		if (!mainline)
+			die("Commit %s is a merge but no -m option was given.",
+			    sha1_to_hex(commit->object.sha1));
+
+		for (cnt = 1, p = commit->parents;
+		     cnt != mainline && p;
+		     cnt++)
+			p = p->next;
+		if (cnt != mainline || !p)
+			die("Commit %s does not have parent %d",
+			    sha1_to_hex(commit->object.sha1), mainline);
+		return p->item;
+	}
+
+	if (0 < mainline)
+		die("Mainline was specified but commit %s is not a merge.",
+		    sha1_to_hex(commit->object.sha1));
+
+	return commit->parents->item;
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -286,33 +320,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	index_fd = hold_locked_index(&index_lock, 1);
 
-	if (!commit->parents) {
-		if (action == REVERT)
-			die ("Cannot revert a root commit");
-		parent = NULL;
-	}
-	else if (commit->parents->next) {
-		/* Reverting or cherry-picking a merge commit */
-		int cnt;
-		struct commit_list *p;
-
-		if (!mainline)
-			die("Commit %s is a merge but no -m option was given.",
-			    sha1_to_hex(commit->object.sha1));
-
-		for (cnt = 1, p = commit->parents;
-		     cnt != mainline && p;
-		     cnt++)
-			p = p->next;
-		if (cnt != mainline || !p)
-			die("Commit %s does not have parent %d",
-			    sha1_to_hex(commit->object.sha1), mainline);
-		parent = p->item;
-	} else if (0 < mainline)
-		die("Mainline was specified but commit %s is not a merge.",
-		    sha1_to_hex(commit->object.sha1));
-	else
-		parent = commit->parents->item;
+	parent = check_parent(commit, mainline);
 
 	if (!(message = commit->buffer))
 		die ("Cannot get commit message for %s",
-- 
1.7.0.315.gbc198
