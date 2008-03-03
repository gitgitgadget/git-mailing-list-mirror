From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] fetch-pack: check parse_commit/object results
Date: Mon,  3 Mar 2008 07:31:23 +0100
Message-ID: <12045258831942-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4DZ-0000jq-KH
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 07:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYCCGb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 01:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbYCCGbZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 01:31:25 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:56216 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbYCCGbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 01:31:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 32C836CF0079;
	Mon,  3 Mar 2008 07:31:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frRKYyAgcqE5; Mon,  3 Mar 2008 07:31:23 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 146F96CF0078; Mon,  3 Mar 2008 07:31:23 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75888>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
Resent with other subject, as the last was rejected by the mailing list.

 builtin-fetch-pack.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index b23e886..423d637 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -41,7 +41,8 @@ static void rev_list_push(struct commit *commit, int mark)
 		commit->object.flags |= mark;
 
 		if (!(commit->object.parsed))
-			parse_commit(commit);
+			if (parse_commit(commit))
+				return;
 
 		insert_by_date(commit, &rev_list);
 
@@ -83,7 +84,8 @@ static void mark_common(struct commit *commit,
 			if (!ancestors_only && !(o->flags & POPPED))
 				non_common_revs--;
 			if (!o->parsed && !dont_parse)
-				parse_commit(commit);
+				if (parse_commit(commit))
+					return;
 
 			for (parents = commit->parents;
 					parents;
@@ -103,20 +105,20 @@ static const unsigned char* get_rev(void)
 
 	while (commit == NULL) {
 		unsigned int mark;
-		struct commit_list* parents;
+		struct commit_list *parents = 0;
 
 		if (rev_list == NULL || non_common_revs == 0)
 			return NULL;
 
 		commit = rev_list->item;
 		if (!(commit->object.parsed))
-			parse_commit(commit);
+			if (!parse_commit(commit))
+				parents = commit->parents;
+
 		commit->object.flags |= POPPED;
 		if (!(commit->object.flags & COMMON))
 			non_common_revs--;
 
-		parents = commit->parents;
