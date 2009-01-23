From: Jake Goulding <goulding@vivisimo.com>
Subject: [PATCH 2/3] Make has_commit non-static
Date: Thu, 22 Jan 2009 19:48:36 -0500
Message-ID: <497913E4.6050806@vivisimo.com>
References: <1232671630-19683-1-git-send-email-goulding@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 01:50:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQAG1-0004kQ-IA
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 01:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbZAWAt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 19:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZAWAtZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 19:49:25 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:57385 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbZAWAtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 19:49:24 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id 1FA3C850D64
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 19:49:05 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id EEC9A2E68D1
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 19:49:04 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3p-K8Wjpg+j for <git@vger.kernel.org>;
	Thu, 22 Jan 2009 19:49:04 -0500 (EST)
Received: from [192.168.0.20] (unknown [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id BE4B22E68DE
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 19:48:36 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1232671630-19683-1-git-send-email-goulding@vivisimo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106814>

Moving has_commit from branch to a common location in preparation for
using it in tag.

Signed-off-by: Jake Goulding <goulding@vivisimo.com>
---
 builtin-branch.c |   15 ---------------
 commit.c         |   15 +++++++++++++++
 commit.h         |    1 +
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 82d6fb2..bb42911 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -193,21 +193,6 @@ struct ref_list {
 	int kinds;
 };

-static int has_commit(struct commit *commit, struct commit_list
*with_commit)
-{
-	if (!with_commit)
-		return 1;
-	while (with_commit) {
-		struct commit *other;
-
-		other = with_commit->item;
-		with_commit = with_commit->next;
-		if (in_merge_bases(other, &commit, 1))
-			return 1;
-	}
-	return 0;
-}
-
 static int append_ref(const char *refname, const unsigned char *sha1,
int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
diff --git a/commit.c b/commit.c
index c99db16..5ccb338 100644
--- a/commit.c
+++ b/commit.c
@@ -705,6 +705,21 @@ struct commit_list *get_merge_bases(struct commit
*one, struct commit *two,
 	return get_merge_bases_many(one, 1, &two, cleanup);
 }

+int has_commit(struct commit *commit, struct commit_list *with_commit)
+{
+	if (!with_commit)
+		return 1;
+	while (with_commit) {
+		struct commit *other;
+
+		other = with_commit->item;
+		with_commit = with_commit->next;
+		if (in_merge_bases(other, &commit, 1))
+			return 1;
+	}
+	return 0;
+}
+
 int in_merge_bases(struct commit *commit, struct commit **reference,
int num)
 {
 	struct commit_list *bases, *b;
diff --git a/commit.h b/commit.h
index 3a7b06a..1b8444f 100644
--- a/commit.h
+++ b/commit.h
@@ -133,6 +133,7 @@ extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);

+int has_commit(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);

 extern int interactive_add(int argc, const char **argv, const char
*prefix);
-- 
1.6.0.4
