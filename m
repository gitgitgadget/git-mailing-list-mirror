From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] get_merge_bases_many(): walk from many tips in parallel
Date: Thu, 30 Aug 2012 16:13:08 -0700
Message-ID: <1346368388-23576-5-git-send-email-gitster@pobox.com>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 01:13:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7DvS-00075a-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 01:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab2H3XNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 19:13:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab2H3XNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 19:13:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AA008D12
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0rFn
	o3kiNf3e5foT5nhcFv/lXIQ=; b=XVo4cJ4UKPixfT5Rp8RifXka4tN0CRFDdOBg
	iWoH6jXuO7++mZSWARJZaBUzl0KIXYFwyfOQ4EW9WPrurSGjqAHPefVDlM5jOANz
	bJSito7y7fGwImRv2rJDlIIyzclKcAsFZFysYp0yKuNwkZNebfZxXcIH593HLct5
	qC2SiDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Zqob6m
	SBhv9macpXle+xNZCy2wpUIXjf0cHTh8luqPK/r2nJ72NGJ6ffo5oTcT6BF1bVyc
	qZbcXbFRVnyrR+5MQ0UK6QsS84DZTort4W+SJ5eRgyxdvt0brVX+NlTeMoeZWNqV
	bAA7Si+hLD5HGdj2r88xAI69C1WN3GlHJkuQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B5858D11
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 989A38D0D for
 <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.293.g6aeebca
In-Reply-To: <1346368388-23576-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 48480442-F2F8-11E1-A3F7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204573>

The get_merge_bases_many() function reduces the result returned by
the merge_bases_many() function, which is a set of possible merge
bases, by excluding commits that can be reached from other commits.
We used to do N*(N-1) traversals for this, but we can check if one
commit reaches which other (N-1) commits by a single traversal, and
repeat it for all the candidates to find the answer.

Introduce remove_redundant() helper function to do this painting; we
should be able to use it to reimplement reduce_heads() as well.
---
 commit.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/commit.c b/commit.c
index d39a9e9..2ff5061 100644
--- a/commit.c
+++ b/commit.c
@@ -692,6 +692,60 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 	return ret;
 }
 
+static int remove_redundant(struct commit **array, int cnt)
+{
+	/*
+	 * Some commit in the array may be an ancestor of
+	 * another commit.  Move such commit to the end of
+	 * the array, and return the number of commits that
+	 * are independent from each other.
+	 */
+	struct commit **work;
+	unsigned char *redundant;
+	int *filled_index;
+	int i, j, filled;
+
+	work = xcalloc(cnt, sizeof(*work));
+	redundant = xcalloc(cnt, 1);
+	filled_index = xmalloc(sizeof(*filled_index) * (cnt - 1));
+
+	for (i = 0; i < cnt; i++) {
+		struct commit_list *common;
+
+		if (redundant[i])
+			continue;
+		for (j = filled = 0; j < cnt; j++) {
+			if (i == j || redundant[j])
+				continue;
+			filled_index[filled] = j;
+			work[filled++] = array[j];
+		}
+		common = paint_down_to_common(array[i], filled, work);
+		if (array[i]->object.flags & PARENT2)
+			redundant[i] = 1;
+		for (j = 0; j < filled; j++)
+			if (work[j]->object.flags & PARENT1)
+				redundant[filled_index[j]] = 1;
+		clear_commit_marks(array[i], all_flags);
+		for (j = 0; j < filled; j++)
+			clear_commit_marks(work[j], all_flags);
+		free_commit_list(common);
+	}
+
+	/* Now collect the result */
+	memcpy(work, array, sizeof(*array) * cnt);
+	for (i = filled = 0; i < cnt; i++)
+		if (!redundant[i])
+			array[filled++] = work[i];
+	for (j = filled, i = 0; i < cnt; i++)
+		if (redundant[i])
+			array[j++] = work[i];
+	free(work);
+	free(redundant);
+	free(filled_index);
+	return filled;
+}
+
 struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos,
@@ -700,7 +754,7 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	struct commit_list *list;
 	struct commit **rslt;
 	struct commit_list *result;
-	int cnt, i, j;
+	int cnt, i;
 
 	result = merge_bases_many(one, n, twos);
 	for (i = 0; i < n; i++) {
@@ -731,28 +785,11 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	for (i = 0; i < n; i++)
 		clear_commit_marks(twos[i], all_flags);
-	for (i = 0; i < cnt - 1; i++) {
-		for (j = i+1; j < cnt; j++) {
-			if (!rslt[i] || !rslt[j])
-				continue;
-			result = merge_bases_many(rslt[i], 1, &rslt[j]);
-			clear_commit_marks(rslt[i], all_flags);
-			clear_commit_marks(rslt[j], all_flags);
-			for (list = result; list; list = list->next) {
-				if (rslt[i] == list->item)
-					rslt[i] = NULL;
-				if (rslt[j] == list->item)
-					rslt[j] = NULL;
-			}
-		}
-	}
 
-	/* Surviving ones in rslt[] are the independent results */
+	cnt = remove_redundant(rslt, cnt);
 	result = NULL;
-	for (i = 0; i < cnt; i++) {
-		if (rslt[i])
-			commit_list_insert_by_date(rslt[i], &result);
-	}
+	for (i = 0; i < cnt; i++)
+		commit_list_insert_by_date(rslt[i], &result);
 	free(rslt);
 	return result;
 }
-- 
1.7.12.293.g6aeebca
