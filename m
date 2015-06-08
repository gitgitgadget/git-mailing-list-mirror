From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/13] initial_ref_transaction_commit(): check for duplicate refs
Date: Mon,  8 Jun 2015 13:45:45 +0200
Message-ID: <e8bc4ba5053b6b6b06805bb3e84724e052c82dff.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVe-0005Ts-6f
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbbFHLqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:25 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49633 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752421AbbFHLqH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:07 -0400
X-AuditID: 1207440d-f79026d000000bad-3d-5575807e5d4b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.5E.02989.E7085755; Mon,  8 Jun 2015 07:46:06 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop8017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:46:05 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqFvXUBpqcHuPikXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M3ZeusZScIir4vT5NvYGxlMcXYycHBICJhKL2/ezQNhiEhfurWfrYuTiEBK4zCjxauky
	dgjnBJPE9AOzmUGq2AR0JRb1NDOB2CICahIT2w6xgBQxC3QwSlxYvo0dJCEsEChxc3UjG4jN
	IqAq0dYyiRXE5hWIkpj48TcjxDo5ifPHf4IN5RSwkLj7/wJYvZCAucTHbe2MExh5FzAyrGKU
	S8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICSreHYz/18kcYhTgYFTi4T2wqCRU
	iDWxrLgy9xCjJAeTkihvV1lpqBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXiYLoBxvSmJlVWpR
	PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWg4NDYMa5udOZpFjy8vNSlSR4P9YBDREsSk1P
	rUjLzClBKGXi4ARZxCUlUpyal5JalFhakhEPipr4YmDcgKR4gG5QqQe5obggMRcoCtF6ilFR
	Spz3MchcAZBERmke3FhYCnnFKA70sTBvNkg7DzD9wHW/AhrMBDT4+9dikMEliQgpqQbGvLAi
	48ncXMYtk62MCws0PxlsefbX2fwW47dV3ox7/t9Kf3daOJDj4e+7yev9ohlPflf0W5L59MP8
	Fw96RF5WvP/S5iEfq620QjTe23nje3nr7BXPXPfwpTYb3EjcbzqtZZtF55Qa/vy5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271020>

Error out if the ref_transaction includes more than one update for any
refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs.c b/refs.c
index b103a4b..ced4e53 100644
--- a/refs.c
+++ b/refs.c
@@ -4064,12 +4064,22 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -4102,6 +4112,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
+	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
-- 
2.1.4
