From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/3] fsck_commit: remove duplicate tests
Date: Sun,  3 Feb 2008 22:22:38 +0100
Message-ID: <12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:23:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmJX-0001mO-F5
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYBCVWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbYBCVWq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:22:46 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43561 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYBCVWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:22:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3F22E680BED8;
	Sun,  3 Feb 2008 22:22:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrUL8wZX4OT1; Sun,  3 Feb 2008 22:22:40 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0DB23680BF6B; Sun,  3 Feb 2008 22:22:40 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72404>

All tests on the commit buffer in fsck_cmd are ready done by
parse_commit_buffer.

This patch rips out all redundant tests. It still leaves the check for
author, as this is can be used as starting point for validation the
author/committer information.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cc7524b..ba785ec 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -354,7 +354,7 @@ static int fsck_tree(struct tree *item)
 static int fsck_commit(struct commit *commit)
 {
 	char *buffer = commit->buffer;
-	unsigned char tree_sha1[20], sha1[20];
+	unsigned char tree_sha1[20];
 
 	if (verbose)
 		fprintf(stderr, "Checking commit %s\n",
@@ -363,22 +363,17 @@ static int fsck_commit(struct commit *commit)
 	if (!commit->date)
 		return objerror(&commit->object, "invalid author/committer line");
 
-	if (memcmp(buffer, "tree ", 5))
-		return objerror(&commit->object, "invalid format - expected 'tree' line");
-	if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
+	if (get_sha1_hex(buffer+5, tree_sha1))
 		return objerror(&commit->object, "invalid 'tree' line format - bad sha1");
 	buffer += 46;
-	while (!memcmp(buffer, "parent ", 7)) {
-		if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
-			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
+	while (!memcmp(buffer, "parent ", 7))
 		buffer += 48;
-	}
 	if (memcmp(buffer, "author ", 7))
 		return objerror(&commit->object, "invalid format - expected 'author' line");
 	free(commit->buffer);
 	commit->buffer = NULL;
 	if (!commit->tree)
-		return objerror(&commit->object, "could not load commit's tree %s", tree_sha1);
+		return objerror(&commit->object, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
 	if (!commit->parents && show_root)
 		printf("root %s\n", sha1_to_hex(commit->object.sha1));
 	return 0;
-- 
1.5.4.g22bc
