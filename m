From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] git-fsck: report missing author/commit line in a commit as an error
Date: Sun, 20 Jan 2008 19:59:52 +0100
Message-ID: <12008555922208-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 20:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGfP7-0003ED-8u
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 20:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbYATS74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 13:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYATS7z
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 13:59:55 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35585 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYATS7z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 13:59:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id E9840680BEC2;
	Sun, 20 Jan 2008 19:59:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iL1Au4F8ZfjS; Sun, 20 Jan 2008 19:59:52 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id C7CE0680BEBE; Sun, 20 Jan 2008 19:59:52 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71183>

Report a commit date (returned by parse_commit), if it is zero
as an error (instead by a printf).

A zero date means missing author/commiter line or a totally
corrupted commiter line.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index e4874f6..c4e91bf 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -360,6 +360,10 @@ static int fsck_commit(struct commit *commit)
 		fprintf(stderr, "Checking commit %s\n",
 			sha1_to_hex(commit->object.sha1));
 
+	if (!commit->date)
+		return objerror(&commit->object, "invalid author/commiter line in %s",
+				sha1_to_hex(commit->object.sha1));
+
 	if (memcmp(buffer, "tree ", 5))
 		return objerror(&commit->object, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
@@ -378,9 +382,6 @@ static int fsck_commit(struct commit *commit)
 		return objerror(&commit->object, "could not load commit's tree %s", tree_sha1);
 	if (!commit->parents && show_root)
 		printf("root %s\n", sha1_to_hex(commit->object.sha1));
-	if (!commit->date)
-		printf("bad commit date in %s\n",
-		       sha1_to_hex(commit->object.sha1));
 	return 0;
 }
 
-- 
gitgui.0.9.1.gdeb16
