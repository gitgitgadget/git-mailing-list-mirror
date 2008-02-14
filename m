From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] parse_commit: don't ignore NULL from loopup_commit
Date: Thu, 14 Feb 2008 23:02:01 +0100
Message-ID: <12030265212108-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 23:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPmAC-0005NY-VU
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 23:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbYBNWCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 17:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756389AbYBNWCG
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 17:02:06 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:41830 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138AbYBNWCE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 17:02:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 82217680BEB9;
	Thu, 14 Feb 2008 23:02:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUGLmlUcY3Ny; Thu, 14 Feb 2008 23:02:01 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 605B5680B59E; Thu, 14 Feb 2008 23:02:01 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73918>

This behaviour causes a different parent list depending on
the already loaded objects, if the parent points contains
a non commit sha1.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
This will hide such an error from fsck (as the parent is not
returned) and make it only print a message to stderr.

 commit.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 8b8fb04..116afb7 100644
--- a/commit.c
+++ b/commit.c
@@ -275,7 +275,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		if (new_parent) {
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 			n_refs++;
-		}
+		} else
+			return error("bad parents in commit %s", sha1_to_hex(item->object.sha1));
 	}
 	if (graft) {
 		int i;
@@ -283,7 +284,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 		for (i = 0; i < graft->nr_parent; i++) {
 			new_parent = lookup_commit(graft->parent[i]);
 			if (!new_parent)
-				continue;
+				return error("bad graft in commit %s", sha1_to_hex(item->object.sha1));
 			pptr = &commit_list_insert(new_parent, pptr)->next;
 			n_refs++;
 		}
-- 
1.5.4.1.g3a858
