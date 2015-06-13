From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/12] initial_ref_transaction_commit(): check for duplicate refs
Date: Sat, 13 Jun 2015 16:42:13 +0200
Message-ID: <73ebe2bdae4e7e38a2349db4c5be783085971b19.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:43:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3meJ-0007yB-BP
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbbFMOmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62250 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753715AbbFMOme (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:34 -0400
X-AuditID: 12074412-f79066d000000bc5-3a-557c4157ed53
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 85.39.03013.7514C755; Sat, 13 Jun 2015 10:42:31 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpY026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:30 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqBvuWBNq8PqLpEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/5e62YsOMRV8XvmCbYGxlMcXYycHBICJhLz/mxhhrDFJC7cW88GYgsJXGaUWPTeq4uR
	C8g+wSSxfM4CsASbgK7Eop5mJhBbREBNYmLbIRaQImaBDkaJC8u3sYMkhAVCJHavXM4IYrMI
	qEpM6D0AFOfg4BWIktj1zQNimZzE+eM/mUHCnAIWEi+bMiH2mku8XdHOOoGRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkHAS2sG4/qTcIUYBDkYlHt6M2OpQIdbE
	suLK3EOMkhxMSqK8kXuAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4BbVrQoV4UxIrq1KL8mFS
	0hwsSuK8Pxer+wkJpCeWpGanphakFsFkNTg4BGacmzudSYolLz8vVUmCV9oBaIhgUWp6akVa
	Zk4JQikTByfIIi4pkeLUvJTUosTSkox4ULzEFwMjBiTFA3SDPEg7b3FBYi5QFKL1FKOilDhv
	OEhCACSRUZoHNxaWPF4xigN9LMx73h6oigeYeOC6XwENZgIa3N5TBTK4JBEhJdXA2Kka0G6z
	UjpiDrM0/zQptqyJDrWp//hb3ulqLYvaVdZxwPKb9Tzhw09YutW7/zq0unb/fnTC4ccsHbuP
	0TMDL8vZynVwhLxecGsn47NrzybveDTR09JMc5GorPCJH0y/BcL+mVWqLY8Xkn08 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271558>

Error out if the ref_transaction includes more than one update for any
refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs.c b/refs.c
index a715524..dfe9090 100644
--- a/refs.c
+++ b/refs.c
@@ -4068,12 +4068,22 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
 
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
+	/* Fail if a refname appears more than once in the transaction: */
+	for (i = 0; i < n; i++)
+		string_list_append(&affected_refnames, updates[i]->refname);
+	string_list_sort(&affected_refnames);
+	if (ref_update_reject_duplicates(&affected_refnames, err)) {
+		ret = TRANSACTION_GENERIC_ERROR;
+		goto cleanup;
+	}
+
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -4106,6 +4116,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
+	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
-- 
2.1.4
