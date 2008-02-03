From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/3] git-fsck: report missing author/commit line in a commit as an error
Date: Sun,  3 Feb 2008 22:22:37 +0100
Message-ID: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:23:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmJW-0001mO-4a
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbYBCVWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754116AbYBCVWn
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:22:43 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43563 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbYBCVWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:22:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 285D5680BF79;
	Sun,  3 Feb 2008 22:22:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kLabgPPCewT; Sun,  3 Feb 2008 22:22:40 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 08861680BED8; Sun,  3 Feb 2008 22:22:39 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72403>

A zero commit date could be caused by:
* a missing author line
* a missing commiter line
* a malformed email address in the commiter line
* a malformed commit date

Simply reporting it as zero commit date is missleading.

Additionally, it upgrades the message to an error (instead of an printf).

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6fc9525..cc7524b 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -360,6 +360,9 @@ static int fsck_commit(struct commit *commit)
 		fprintf(stderr, "Checking commit %s\n",
 			sha1_to_hex(commit->object.sha1));
 
+	if (!commit->date)
+		return objerror(&commit->object, "invalid author/committer line");
+
 	if (memcmp(buffer, "tree ", 5))
 		return objerror(&commit->object, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
@@ -378,9 +381,6 @@ static int fsck_commit(struct commit *commit)
 		return objerror(&commit->object, "could not load commit's tree %s", tree_sha1);
 	if (!commit->parents && show_root)
 		printf("root %s\n", sha1_to_hex(commit->object.sha1));
-	if (!commit->date)
-		printf("bad commit date in %s\n",
-		       sha1_to_hex(commit->object.sha1));
 	return 0;
 }
 
-- 
1.5.4.g22bc
