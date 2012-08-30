From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] merge_bases_many(): split out the logic to paint history
Date: Thu, 30 Aug 2012 16:13:05 -0700
Message-ID: <1346368388-23576-2-git-send-email-gitster@pobox.com>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 01:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7DvR-00075a-E8
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 01:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702Ab2H3XNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 19:13:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2H3XNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 19:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC818CEB
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=c5/X
	dbLqn/G90jAmdO23Jrsk8DU=; b=hYWmrcvHHpwcba1twryMMpVyK48/I44Gre87
	xboRhVWlEFxjNZdI96WVnhbh6cOYMpLdV7TSWwijfXutCjuqPlHnC5+hbubnHfUV
	ntUOJyJa2dFRDvB8Q4YYZWvl7G904GR+E2JKHpuP077kNvTyZbOVJfW27+LIf68q
	/WdgQts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xK0jb/
	zWyWPpPnmQ9KhoeULXn3QBhzWCRcE9U39HmD9OeSYgTPIo99UeLdfDYsK2x65bYU
	8DfujBFcNgQl113Fob3n51AGE5rvhZB7wAbOGnrFdk3UWVSScP0JkwpIPz3Ztl1o
	w5KrGqKIlzGtmaot9mlHGwcdZqbHRg52U3xjU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D7418CEA
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C00D8CE8 for
 <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.293.g6aeebca
In-Reply-To: <1346368388-23576-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 44989A28-F2F8-11E1-8BC0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204575>

Introduce a new helper function paint_down_to_common() that takes
the same parameters as merge_bases_many(), but without the first
optimization of not painting anything when "one" is one of the
"twos" (or vice versa), and the last clean-up of removing the common
ancestor that is known to be an ancestor of another common one.

This way, the caller of the new function could tell if "one" is
reachable from any of the "twos" by simply looking at the flag bits
of "one".  If (and only if) it is painted in PARENT2, it is
reachable from one of the "twos".
---
 commit.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index 12e5396..0058fa5 100644
--- a/commit.c
+++ b/commit.c
@@ -581,28 +581,12 @@ static struct commit *interesting(struct commit_list *list)
 	return NULL;
 }
 
-static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+static struct commit_list *paint_down_to_common(struct commit *one, int n, struct commit **twos)
 {
 	struct commit_list *list = NULL;
 	struct commit_list *result = NULL;
 	int i;
 
-	for (i = 0; i < n; i++) {
-		if (one == twos[i])
-			/*
-			 * We do not mark this even with RESULT so we do not
-			 * have to clean it up.
-			 */
-			return commit_list_insert(one, &result);
-	}
-
-	if (parse_commit(one))
-		return NULL;
-	for (i = 0; i < n; i++) {
-		if (parse_commit(twos[i]))
-			return NULL;
-	}
-
 	one->object.flags |= PARENT1;
 	commit_list_insert_by_date(one, &list);
 	for (i = 0; i < n; i++) {
@@ -643,9 +627,34 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 		}
 	}
 
-	/* Clean up the result to remove stale ones */
 	free_commit_list(list);
-	list = result; result = NULL;
+	return result;
+}
+
+static struct commit_list *merge_bases_many(struct commit *one, int n, struct commit **twos)
+{
+	struct commit_list *list = NULL;
+	struct commit_list *result = NULL;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (one == twos[i])
+			/*
+			 * We do not mark this even with RESULT so we do not
+			 * have to clean it up.
+			 */
+			return commit_list_insert(one, &result);
+	}
+
+	if (parse_commit(one))
+		return NULL;
+	for (i = 0; i < n; i++) {
+		if (parse_commit(twos[i]))
+			return NULL;
+	}
+
+	list = paint_down_to_common(one, n, twos);
+
 	while (list) {
 		struct commit_list *next = list->next;
 		if (!(list->item->object.flags & STALE))
-- 
1.7.12.293.g6aeebca
