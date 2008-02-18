From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 06/12] check results of parse_commit in merge_bases
Date: Mon, 18 Feb 2008 21:47:57 +0100
Message-ID: <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvf-0000iE-OF
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbYBRUsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYBRUsV
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:21 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40284 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761453AbYBRUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 655F06A63A78;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UTZfV9-TL4Af; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id CE7626CF0060; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74347>

An error is signaled by returning NULL.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 commit.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index 8b8fb04..70f1266 100644
--- a/commit.c
+++ b/commit.c
@@ -552,8 +552,10 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 		 */
 		return commit_list_insert(one, &result);
 
-	parse_commit(one);
-	parse_commit(two);
+	if (parse_commit(one))
+		return NULL;
+	if (parse_commit(two))
+		return NULL;
 
 	one->object.flags |= PARENT1;
 	two->object.flags |= PARENT2;
@@ -586,7 +588,8 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 			parents = parents->next;
 			if ((p->object.flags & flags) == flags)
 				continue;
-			parse_commit(p);
+			if (parse_commit(p))
+				return NULL;
 			p->object.flags |= flags;
 			insert_by_date(p, &list);
 		}
-- 
1.5.4.1.g96b77
