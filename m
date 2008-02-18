From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 12/12] check return value from parse_commit
Date: Mon, 18 Feb 2008 21:48:03 +0100
Message-ID: <12033676844141-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833893-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676842301-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676841373-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676841015-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvj-0000iE-4W
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbYBRUsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbYBRUsc
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:32 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40290 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761461AbYBRUsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id F09E8680CD42;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pqRvCJj5Uz-0; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 668866CF006C; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676841015-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74343>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 commit.c      |    3 +--
 shallow.c     |    3 ++-
 upload-pack.c |    3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 5d57450..22ce776 100644
--- a/commit.c
+++ b/commit.c
@@ -387,8 +387,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		parse_commit(commit);
-		if (!(commit->object.flags & mark)) {
+		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
 			insert_by_date(commit, list);
 		}
diff --git a/shallow.c b/shallow.c
index 212e62b..4d90eda 100644
--- a/shallow.c
+++ b/shallow.c
@@ -70,7 +70,8 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 				cur_depth = *(int *)commit->util;
 			}
 		}
-		parse_commit(commit);
+		if (parse_commit(commit))
+			die("invalid commit");
 		commit->object.flags |= not_shallow_flag;
 		cur_depth++;
 		for (p = commit->parents, commit = NULL; p; p = p->next) {
diff --git a/upload-pack.c b/upload-pack.c
index 53676ee..20d5462 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -534,7 +534,8 @@ static void receive_needs(void)
 				/* make sure the real parents are parsed */
 				unregister_shallow(object->sha1);
 				object->parsed = 0;
-				parse_commit((struct commit *)object);
+				if (parse_commit((struct commit *)object))
+					die("invalid commit");
 				parents = ((struct commit *)object)->parents;
 				while (parents) {
 					add_object_array(&parents->item->object,
-- 
1.5.4.1.g96b77
