From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/19] initial_ref_transaction_commit(): check for duplicate refs
Date: Mon, 22 Jun 2015 16:03:03 +0200
Message-ID: <63ae59139a3a7b5c85f6d44864eade79a93965fb.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KZ-0005pZ-GI
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933696AbbFVOEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:04 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52843 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933663AbbFVODv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:51 -0400
X-AuditID: 12074412-f79a76d000007c8b-89-558815b24c0d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.21.31883.2B518855; Mon, 22 Jun 2015 10:03:30 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3CcA030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:29 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqLtJtCPUYPpPZYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ9zeepu94BBXxYSnc1gaGE9xdDFycEgImEg821fVxcgJZIpJXLi3nq2LkYtDSOAyo8SL
	qYfYIZyTTBIr1kxlA6liE9CVWNTTzARiiwioSUxsO8QCUsQs0MEocWH5NnaQhLBAiETjjYMs
	IDaLgKrEs+OzwWxegSiJp5vvsEKsk5M4f/wnM4jNKWAhMX/ff7BeIQFziYkzH7FMYORdwMiw
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkpIR2MK4/KXeIUYCDUYmH18G2
	PVSINbGsuDL3EKMkB5OSKO+B10AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwtZ4FyvCmJlVWp
	RfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgshocHAIzzs2dziTFkpefl6okwesn0hEqJFiU
	mp5akZaZU4JQysTBCbKIS0qkODUvJbUosbQkIx4UM/HFwKgBSfEA3bAUpJ23uCAxFygK0XqK
	UVFKnHcySEIAJJFRmgc3FpZAXjGKA30szPsSpIoHmHzgul8BDWYCGvwltw1kcEkiQkqqgVHr
	+2nT2rlBoVtdb5089nzOhYuX9vGsuXP0ufd1jpRMtvfVlziYahewntO3WCtXNC2H8V3ZDd/S
	pwq/dKYystWw9GQ+bdcPzXUx87ojw7mSvf3vKi7DlVkM2YX+zOEHbwlN0bYvZn1n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272356>

Error out if the ref_transaction includes more than one update for any
refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/refs.c b/refs.c
index 31661c7..53d9e45 100644
--- a/refs.c
+++ b/refs.c
@@ -4087,12 +4087,22 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
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
 
@@ -4125,6 +4135,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 cleanup:
 	transaction->state = REF_TRANSACTION_CLOSED;
+	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
-- 
2.1.4
