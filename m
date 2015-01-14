From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/10] revision.c: make save_parents() and free_saved_parents() static
Date: Wed, 14 Jan 2015 15:40:49 -0800
Message-ID: <1421278855-8126-5-git-send-email-gitster@pobox.com>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:41:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXYx-0002jw-3E
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbbANXlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:41:16 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751421AbbANXlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:41:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94D012DB9D;
	Wed, 14 Jan 2015 18:41:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7LpD
	sgWCxTuQSUsmwtcJ3mScexU=; b=O2nctDAB7A2YHh/lZLFFnWbbtcLuCPWOAP5q
	FWji4ebCFY/4TjlOSYPp69dJUl0qz0piI0H6c4SA3CjEWhfmW4aeXTh5G/lhEFSt
	hecXpornvFUZtC8W1FUDBOJ8A5zztBaR/1fs7VSIQHnakfCVGMrMKc5b3vgnOPAU
	KiHPx+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=aiqZvq
	X91GyJcHLd7+WPaxCFU9IACnXcOvwd/B1eWsuuV6qJ4Ka26LzIJXvPWs3J3yH6ob
	7w3TZ2/xynhQRSyi4LNrTMCt1lvoFoVdvP7tEuVcg6rK2VvKcfVjVSQl/puWtthT
	6ubygJCkyvY3df8XbSRgndMDaF6YcdHYBIHNI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AF012DB9C;
	Wed, 14 Jan 2015 18:41:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43F1A2DB85;
	Wed, 14 Jan 2015 18:41:03 -0500 (EST)
X-Mailer: git-send-email 2.3.0-rc0-134-g109a908
In-Reply-To: <1421278855-8126-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CD3C0582-9C46-11E4-AB31-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262443>

No external callers exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 106 ++++++++++++++++++++++++++++++++-----------------------------
 revision.h |  12 +++----
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/revision.c b/revision.c
index 86406a2..0f4619c 100644
--- a/revision.c
+++ b/revision.c
@@ -2968,6 +2968,61 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	return commit_show;
 }
 
+define_commit_slab(saved_parents, struct commit_list *);
+
+#define EMPTY_PARENT_LIST ((struct commit_list *)-1)
+
+/*
+ * You may only call save_parents() once per commit (this is checked
+ * for non-root commits).
+ */
+static void save_parents(struct rev_info *revs, struct commit *commit)
+{
+	struct commit_list **pp;
+
+	if (!revs->saved_parents_slab) {
+		revs->saved_parents_slab = xmalloc(sizeof(struct saved_parents));
+		init_saved_parents(revs->saved_parents_slab);
+	}
+
+	pp = saved_parents_at(revs->saved_parents_slab, commit);
+
+	/*
+	 * When walking with reflogs, we may visit the same commit
+	 * several times: once for each appearance in the reflog.
+	 *
+	 * In this case, save_parents() will be called multiple times.
+	 * We want to keep only the first set of parents.  We need to
+	 * store a sentinel value for an empty (i.e., NULL) parent
+	 * list to distinguish it from a not-yet-saved list, however.
+	 */
+	if (*pp)
+		return;
+	if (commit->parents)
+		*pp = copy_commit_list(commit->parents);
+	else
+		*pp = EMPTY_PARENT_LIST;
+}
+
+static void free_saved_parents(struct rev_info *revs)
+{
+	if (revs->saved_parents_slab)
+		clear_saved_parents(revs->saved_parents_slab);
+}
+
+struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit)
+{
+	struct commit_list *parents;
+
+	if (!revs->saved_parents_slab)
+		return commit->parents;
+
+	parents = *saved_parents_at(revs->saved_parents_slab, commit);
+	if (parents == EMPTY_PARENT_LIST)
+		return NULL;
+	return parents;
+}
+
 enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	enum commit_action action = get_commit_action(revs, commit);
@@ -3267,54 +3322,3 @@ void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 	fputs(mark, stdout);
 	putchar(' ');
 }
-
-define_commit_slab(saved_parents, struct commit_list *);
-
-#define EMPTY_PARENT_LIST ((struct commit_list *)-1)
-
-void save_parents(struct rev_info *revs, struct commit *commit)
-{
-	struct commit_list **pp;
-
-	if (!revs->saved_parents_slab) {
-		revs->saved_parents_slab = xmalloc(sizeof(struct saved_parents));
-		init_saved_parents(revs->saved_parents_slab);
-	}
-
-	pp = saved_parents_at(revs->saved_parents_slab, commit);
-
-	/*
-	 * When walking with reflogs, we may visit the same commit
-	 * several times: once for each appearance in the reflog.
-	 *
-	 * In this case, save_parents() will be called multiple times.
-	 * We want to keep only the first set of parents.  We need to
-	 * store a sentinel value for an empty (i.e., NULL) parent
-	 * list to distinguish it from a not-yet-saved list, however.
-	 */
-	if (*pp)
-		return;
-	if (commit->parents)
-		*pp = copy_commit_list(commit->parents);
-	else
-		*pp = EMPTY_PARENT_LIST;
-}
-
-struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit)
-{
-	struct commit_list *parents;
-
-	if (!revs->saved_parents_slab)
-		return commit->parents;
-
-	parents = *saved_parents_at(revs->saved_parents_slab, commit);
-	if (parents == EMPTY_PARENT_LIST)
-		return NULL;
-	return parents;
-}
-
-void free_saved_parents(struct rev_info *revs)
-{
-	if (revs->saved_parents_slab)
-		clear_saved_parents(revs->saved_parents_slab);
-}
diff --git a/revision.h b/revision.h
index 033a244..07807e5 100644
--- a/revision.h
+++ b/revision.h
@@ -298,18 +298,14 @@ extern int rewrite_parents(struct rev_info *revs, struct commit *commit,
 	rewrite_parent_fn_t rewrite_parent);
 
 /*
- * Save a copy of the parent list, and return the saved copy.  This is
- * used by the log machinery to retrieve the original parents when
- * commit->parents has been modified by history simpification.
- *
- * You may only call save_parents() once per commit (this is checked
- * for non-root commits).
+ * The log machinery saves the original parent list so that
+ * get_saved_parents() can later tell what the real parents of the
+ * commits are, when commit->parents has been modified by history
+ * simpification.
  *
  * get_saved_parents() will transparently return commit->parents if
  * history simplification is off.
  */
-extern void save_parents(struct rev_info *revs, struct commit *commit);
 extern struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
-extern void free_saved_parents(struct rev_info *revs);
 
 #endif
-- 
2.3.0-rc0-134-g109a908
