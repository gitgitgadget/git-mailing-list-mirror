From: Jake Goulding <goulding@vivisimo.com>
Subject: [PATCH 2/3] Make has_commit non-static
Date: Mon, 26 Jan 2009 09:13:24 -0500
Message-ID: <1232979205-17161-2-git-send-email-goulding@vivisimo.com>
References: <1232979205-17161-1-git-send-email-goulding@vivisimo.com>
Cc: gitster@pobox.com, Jake Goulding <goulding@vivisimo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 15:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRSEs-0001XV-W1
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 15:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZAZONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZAZONa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 09:13:30 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:43820 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZAZON3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 09:13:29 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id CFB0585294F;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id A511A2E68D3;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uSEWoLWeZHLG; Mon, 26 Jan 2009 09:13:28 -0500 (EST)
Received: from localhost.localdomain (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 72A682E68D0;
	Mon, 26 Jan 2009 09:13:28 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1232979205-17161-1-git-send-email-goulding@vivisimo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107212>

Moving has_commit from branch to a common location in preparation for
using it in tag. Renaming it to commit_has_any_in_commit_list to be
more unique.

Signed-off-by: Jake Goulding <goulding@vivisimo.com>
---

Function renamed to less-generic name as suggested by Junio.

 builtin-branch.c |   20 +++-----------------
 commit.c         |   16 ++++++++++++++++
 commit.h         |    1 +
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 82d6fb2..a30ef76 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -193,21 +193,6 @@ struct ref_list {
 	int kinds;
 };
 
-static int has_commit(struct commit *commit, struct commit_list *with_commit)
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
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
@@ -231,7 +216,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		return error("branch '%s' does not point at a commit", refname);
 
 	/* Filter with with_commit if specified */
-	if (!has_commit(commit, ref_list->with_commit))
+	if (!commit_has_any_in_commit_list(commit, ref_list->with_commit))
 		return 0;
 
 	/* Don't add types the caller doesn't want */
@@ -401,7 +386,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && head_commit && has_commit(head_commit, with_commit)) {
+	if (detached && head_commit &&
+	    commit_has_any_in_commit_list(head_commit, with_commit)) {
 		struct ref_item item;
 		item.name = xstrdup("(no branch)");
 		item.kind = REF_LOCAL_BRANCH;
diff --git a/commit.c b/commit.c
index c99db16..97c8a8a 100644
--- a/commit.c
+++ b/commit.c
@@ -705,6 +705,22 @@ struct commit_list *get_merge_bases(struct commit *one, struct commit *two,
 	return get_merge_bases_many(one, 1, &two, cleanup);
 }
 
+int commit_has_any_in_commit_list(struct commit *commit,
+				  struct commit_list *with_commit)
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
 int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 {
 	struct commit_list *bases, *b;
diff --git a/commit.h b/commit.h
index 3a7b06a..4084102 100644
--- a/commit.h
+++ b/commit.h
@@ -133,6 +133,7 @@ extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
+int commit_has_any_in_commit_list(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit **, int);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix);
-- 
1.6.0.6
