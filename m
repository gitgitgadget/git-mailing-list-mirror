From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] commit.c: add clear_commit_marks_many()
Date: Tue,  5 Mar 2013 14:47:16 -0800
Message-ID: <1362523639-30566-2-git-send-email-gitster@pobox.com>
References: <1362523639-30566-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 23:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD0eD-0004uP-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 23:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab3CEWrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 17:47:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052Ab3CEWrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 17:47:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AC3DAD45
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lOCR
	4Vw31EC7MxtVyR8jq+8XGu4=; b=n+pc2zyjVtQnbX6pYQ7HR74qvEpxs1JrOr7p
	7yHHyj1pAFb/8HMaes4psLjeDO0j97drhA/NJlRHIJyMAxKEsTJg5xRh1S1cBF5P
	XVNsm3Y6vrrz1+vYZAFCUWP5tXPCSy8D/Zg85/CtBR2Q5T9ZZUq60kRKziJIvjF7
	eOXq5RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sRf36y
	CgXVq6tQrIRX6ZzOjZbDSUNu21/5H6YTTmz+u3GYkmNSq+49V7NnwMgxNusJk/ez
	k3IuoiicOA9ExypuXEp03f1B+o6nXb7++AIUq83wsIYSconx2+MOPpNtY7puNi4k
	iLpfbuQ0bEc+EUppd9/Q8gZ/NcXKgDoFNVD9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 900DCAD3C
	for <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA89BAD11 for
 <git@vger.kernel.org>; Tue,  5 Mar 2013 17:47:22 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc2-194-g549a9ef
In-Reply-To: <1362523639-30566-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A4E04012-85E6-11E2-98AC-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217489>

clear_commit_marks(struct commit *, unsigned) only can clear flag
bits starting from a single commit; introduce an API to allow
feeding an array of commits, so that flag bits can be cleared from
commits reachable from any of them with a single traversal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 19 +++++++++++++------
 commit.h |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index e8eb0ae..4757e50 100644
--- a/commit.c
+++ b/commit.c
@@ -463,14 +463,23 @@ static void clear_commit_marks_1(struct commit_list **plist,
 	}
 }
 
-void clear_commit_marks(struct commit *commit, unsigned int mark)
+void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark)
 {
 	struct commit_list *list = NULL;
-	commit_list_insert(commit, &list);
+
+	while (nr--) {
+		commit_list_insert(*commit, &list);
+		commit++;
+	}
 	while (list)
 		clear_commit_marks_1(&list, pop_commit(&list), mark);
 }
 
+void clear_commit_marks(struct commit *commit, unsigned int mark)
+{
+	clear_commit_marks_many(1, &commit, mark);
+}
+
 void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
 {
 	struct object *object;
@@ -797,8 +806,7 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	if (!result || !result->next) {
 		if (cleanup) {
 			clear_commit_marks(one, all_flags);
-			for (i = 0; i < n; i++)
-				clear_commit_marks(twos[i], all_flags);
+			clear_commit_marks_many(n, twos, all_flags);
 		}
 		return result;
 	}
@@ -816,8 +824,7 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	free_commit_list(result);
 
 	clear_commit_marks(one, all_flags);
-	for (i = 0; i < n; i++)
-		clear_commit_marks(twos[i], all_flags);
+	clear_commit_marks_many(n, twos, all_flags);
 
 	cnt = remove_redundant(rslt, cnt);
 	result = NULL;
diff --git a/commit.h b/commit.h
index b6ad8f3..b997eea 100644
--- a/commit.h
+++ b/commit.h
@@ -134,6 +134,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 struct commit *pop_commit(struct commit_list **stack);
 
 void clear_commit_marks(struct commit *commit, unsigned int mark);
+void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark);
 void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark);
 
 /*
-- 
1.8.2-rc2-194-g549a9ef
