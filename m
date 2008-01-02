From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] receive-pack: check object type of sha1 before using them as commits
Date: Wed,  2 Jan 2008 08:39:21 +0100
Message-ID: <11992595612601-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 08:39:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9yCe-0006D8-DF
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 08:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbYABHjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 02:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYABHjX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 02:39:23 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:49663 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYABHjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 02:39:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4BA45680BF61;
	Wed,  2 Jan 2008 08:39:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmpH0yMv0Bk7; Wed,  2 Jan 2008 08:39:21 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 295EB680BEA4; Wed,  2 Jan 2008 08:39:21 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69460>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 receive-pack.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index fba4cf8..d0a563d 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -178,11 +178,21 @@ static const char *update(struct command *cmd)
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
 	    !prefixcmp(name, "refs/heads/")) {
+		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
-		old_commit = (struct commit *)parse_object(old_sha1);
-		new_commit = (struct commit *)parse_object(new_sha1);
+		old_object = parse_object(old_sha1);
+		new_object = parse_object(new_sha1);
+
+		if (!old_object || !new_object ||
+		    old_object->type != OBJ_COMMIT ||
+		    new_object->type != OBJ_COMMIT) {
+			error("bad sha1 objects for %s", name);
+			return "bad ref";
+		}
+		old_commit = (struct commit *)old_object;
+		new_commit = (struct commit *)new_object;
 		bases = get_merge_bases(old_commit, new_commit, 1);
 		for (ent = bases; ent; ent = ent->next)
 			if (!hashcmp(old_sha1, ent->item->object.sha1))
-- 
1.4.4.4
