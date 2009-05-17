From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] commit: add function to unparse a commit and its parents
Date: Sun, 17 May 2009 17:36:45 +0200
Message-ID: <20090517153647.6403.44036.chriscool@tuxfamily.org>
References: <20090517153307.6403.73576.>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 17:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5iTP-0006mY-Qj
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 17:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbZEQPj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 11:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZEQPjy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 11:39:54 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42635 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488AbZEQPjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 11:39:51 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5E4C5940172;
	Sun, 17 May 2009 17:39:45 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6341A940182;
	Sun, 17 May 2009 17:39:43 +0200 (CEST)
X-git-sha1: 13086c64892ab98bbbb212b11445c195c8473148 
X-Mailer: git-mail-commits v0.4.3
In-Reply-To: <20090517153307.6403.73576.>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119397>

This patch adds the "unparse_commit" function that returns a commit
into an unparsed state by freeing its data and resetting its fields
to 0.

Its parents are recursively unparsed too, because they might have
been changed. But its tree is not unparsed as it should not have
been modifed.

Note that as the "flags" and "used" fields may be used even if the
object is not parsed, we have to reset them anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c |   20 ++++++++++++++++++++
 commit.h |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index cf72143..1d4db4d 100644
--- a/commit.c
+++ b/commit.c
@@ -317,6 +317,26 @@ int parse_commit(struct commit *item)
 	return ret;
 }
 
+static void unparse_commit_list(struct commit_list *list)
+{
+	for (; list; list = list->next)
+		unparse_commit(list->item);
+}
+
+void unparse_commit(struct commit *item)
+{
+	item->object.flags = 0;
+	item->object.used = 0;
+	if (item->object.parsed) {
+		item->object.parsed = 0;
+		if (item->parents) {
+			unparse_commit_list(item->parents);
+			free_commit_list(item->parents);
+			item->parents = NULL;
+		}
+	}
+}
+
 struct commit_list *commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
diff --git a/commit.h b/commit.h
index 8bfdf0e..a8bdd09 100644
--- a/commit.h
+++ b/commit.h
@@ -40,6 +40,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
 
 int parse_commit(struct commit *item);
 
+void unparse_commit(struct commit *item);
+
 struct commit_list * commit_list_insert(struct commit *item, struct commit_list **list_p);
 unsigned commit_list_count(const struct commit_list *l);
 struct commit_list * insert_by_date(struct commit *item, struct commit_list **list);
-- 
1.6.3.rc1.112.g17e25
