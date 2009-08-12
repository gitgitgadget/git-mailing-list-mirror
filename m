From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/13] pick: simplify "error(...)" followed by "return -1"
Date: Wed, 12 Aug 2009 07:15:44 +0200
Message-ID: <20090812051552.18155.1868.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:29:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6Ou-000460-Iv
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbZHLF2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbZHLF2R
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:17 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47766 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbZHLF2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4639281810B;
	Wed, 12 Aug 2009 07:27:57 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 04BA98180EA;
	Wed, 12 Aug 2009 07:27:54 +0200 (CEST)
X-git-sha1: ac3df346f173c3b887bf67dcd9a09bd22d283271 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125666>

into "return error(...)", as suggested by Junio.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pick.c |   62 ++++++++++++++++++++++++--------------------------------------
 1 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/pick.c b/pick.c
index 77c7169..6fea39c 100644
--- a/pick.c
+++ b/pick.c
@@ -93,24 +93,18 @@ int pick(struct commit *pick_commit, int mainline, int flags,
 	 * that represents the "current" state for merge-recursive
 	 * to work on.
 	 */
-	if (write_cache_as_tree(head, 0, NULL)) {
-		error("Your index file is unmerged.");
-		return -1;
-	}
+	if (write_cache_as_tree(head, 0, NULL))
+		return error("Your index file is unmerged.");
 	discard_cache();
 
 	index_fd = hold_locked_index(&index_lock, 0);
-	if (index_fd < 0) {
-		error("Unable to create locked index: %s",
-						strerror(errno));
-		return -1;
-	}
+	if (index_fd < 0)
+		return error("Unable to create locked index: %s",
+			     strerror(errno));
 
 	if (!commit->parents) {
-		if (flags & PICK_REVERSE) {
-			error("Cannot revert a root commit");
-			return -1;
-		}
+		if (flags & PICK_REVERSE)
+			return error("Cannot revert a root commit");
 		parent = NULL;
 	}
 	else if (commit->parents->next) {
@@ -118,40 +112,32 @@ int pick(struct commit *pick_commit, int mainline, int flags,
 		int cnt;
 		struct commit_list *p;
 
-		if (!mainline) {
-			error("Commit %s is a merge but no mainline was given.",
-			    sha1_to_hex(commit->object.sha1));
-			return -1;
-		}
+		if (!mainline)
+			return error("Commit %s is a merge but no mainline was given.",
+				     sha1_to_hex(commit->object.sha1));
 
 		for (cnt = 1, p = commit->parents;
 		     cnt != mainline && p;
 		     cnt++)
 			p = p->next;
-		if (cnt != mainline || !p) {
-			error("Commit %s does not have parent %d",
-			    sha1_to_hex(commit->object.sha1), mainline);
-			return -1;
-		}
+		if (cnt != mainline || !p)
+			return error("Commit %s does not have parent %d",
+				     sha1_to_hex(commit->object.sha1),
+				     mainline);
 		parent = p->item;
-	} else if (0 < mainline) {
-		error("Mainline was specified but commit %s is not a merge.",
-		    sha1_to_hex(commit->object.sha1));
-		return -1;
-	} else
+	} else if (0 < mainline)
+		return error("Mainline was specified but commit %s is not a merge.",
+			     sha1_to_hex(commit->object.sha1));
+	else
 		parent = commit->parents->item;
 
-	if (!(message = commit->buffer)) {
-		error("Cannot get commit message for %s",
-				sha1_to_hex(commit->object.sha1));
-		return -1;
-	}
+	if (!(message = commit->buffer))
+		return error("Cannot get commit message for %s",
+			     sha1_to_hex(commit->object.sha1));
 
-	if (parent && parse_commit(parent) < 0) {
-		error("Cannot parse parent commit %s",
-		      sha1_to_hex(parent->object.sha1));
-		return -1;
-	}
+	if (parent && parse_commit(parent) < 0)
+		return error("Cannot parse parent commit %s",
+			     sha1_to_hex(parent->object.sha1));
 
 	oneline = get_oneline(message);
 
-- 
1.6.4.271.ge010d
