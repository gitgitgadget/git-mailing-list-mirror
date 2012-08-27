From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] (BROKEN) get_merge_bases_many(): walk from many tips in
 parallel
Date: Mon, 27 Aug 2012 16:12:03 -0700
Message-ID: <1346109123-12357-6-git-send-email-gitster@pobox.com>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:12:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T68Ts-0007Qr-K9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 01:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab2H0XMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 19:12:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab2H0XMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 19:12:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26B969172;
	Mon, 27 Aug 2012 19:12:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=rAvv
	xv8lYuIpX9HvAvPhvg2NxwA=; b=WDVvkFVZWv42N+rQCbyRLPVK/nhsvut9O3MA
	ePCO7gxj/Exex2AGFfIq7ivQC+h+YozriEmSXeqcMrOv0zh95mWSIdQflZWweisU
	XXiLL2wtOKdX/iUQQBlbPdyk9uuGEwfgM4+wqFL7pu/zi5vyRgwIRzEz53ALGMav
	/4bLem4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	PreXTI9Ozu53wo8nyUjxAeJyk0FR/xOStAx2W4LnODhjpTx/tFMggrq8VobbBnZm
	J07/QkM5Uhdbg1WknbJG31OHK2ma6ny+pvlA0gIyvVKwkcXxLNhALW3xWRpAEMEg
	1Wx6/nnx9Vt7UqVJctVTxMUNrMbjb2dcxG8IFV/81m8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 146DA9171;
	Mon, 27 Aug 2012 19:12:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55234916F; Mon, 27 Aug 2012
 19:12:15 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.270.g724661d
In-Reply-To: <1346109123-12357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A3EC20F2-F09C-11E1-A405-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204388>

After merge_bases_many() paints the graph in two colors to find
common ancestors, get_merge_bases_many() reduces the result by
excluding commits that can be reached from other commits in the
result.  We used to do N * (N-1) traversals for this, but we can
check if one commit is reachable from any of the other (N-1) commits
by a single traversal, and repeat it N times to find the answer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/commit.c b/commit.c
index f5211bd..ccf2c5a 100644
--- a/commit.c
+++ b/commit.c
@@ -715,7 +715,7 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int cleanup)
 {
 	struct commit_list *list;
-	struct commit **rslt;
+	struct commit **rslt, **others;
 	struct commit_list *result;
 	int cnt, i, j;
 
@@ -744,33 +744,37 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 	for (list = result, i = 0; list; list = list->next)
 		rslt[i++] = list->item;
 	free_commit_list(result);
+	result = NULL;
 
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
-	result = NULL;
+	others = xcalloc(cnt - 1, sizeof(*others));
 	for (i = 0; i < cnt; i++) {
-		if (rslt[i])
+		/*
+		 * Is rslt[i] an ancestor of any of the others?
+		 * then it is not interesting to us.
+		 */
+		for (j = 0; j < i; j++)
+			others[j] = rslt[j];
+		for (j = 1 + 1; j < cnt; j++)
+			others[j - 1] = rslt[j];
+		list = merge_bases_many(rslt[i], cnt - 1, others);
+		clear_commit_marks(rslt[i], all_flags);
+		for (j = 0; j < cnt - 1; j++)
+			clear_commit_marks(others[j], all_flags);
+		while (list) {
+			if (rslt[i] == list->item)
+				break;
+			list = list->next;
+		}
+		if (!list)
 			commit_list_insert_by_date(rslt[i], &result);
+		free_commit_list(list);
 	}
 	free(rslt);
+	free(others);
 	return result;
 }
 
-- 
1.7.12.116.g31e0100
