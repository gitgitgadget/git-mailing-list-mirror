From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/18] ref_transaction_commit(): use a string_list for detecting duplicates
Date: Mon, 11 May 2015 17:25:11 +0200
Message-ID: <1431357920-25090-10-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:27:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpbr-0003Bm-Kw
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbbEKP1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:27:06 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48229 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753213AbbEKPZp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:45 -0400
X-AuditID: 12074412-f79e46d0000036b4-47-5550c9f81ea5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.B7.14004.8F9C0555; Mon, 11 May 2015 11:25:44 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnL002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:42 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqPvjZECoweO/fBZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7ozFm7exFbwVr3h27TtbA+My4S5GTg4JAROJZROeMULYYhIX7q1n62Lk
	4hASuMwo8X7zfyaQhJDAcSaJJ8+kQWw2AV2JRT3NYHERATWJiW2HWEAamAV2MUrcWzoVyOHg
	EBaIk5iz1wykhkVAVWLN+ZPsIDavgKtE/4xuqGVyEueP/2QGsTmB4kuvXmaB2OUi0fT4HssE
	Rt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIzS/RSU0o3MUJCTGgH4/qTcocYBTgY
	lXh4DS74hwqxJpYVV+YeYpTkYFIS5f21NyBUiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv8hqg
	HG9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwGB4fAjHNzpzNJseTl56UqSfA2
	ngAaIliUmp5akZaZU4JQysTBCbKIS0qkODUvJbUosbQkIx4UMfHFwJgBSfEA3VAF0s5bXJCY
	CxSFaD3FqCglzpsCkhAASWSU5sGNhSWUV4ziQB8L864HqeIBJiO47ldAg5mABjvGgQ0uSURI
	STUwrtac+m3enFWlveyfVoab3nUXzzFhPWbGUN3wgKm+4TpbboyKbf4fQQmJx/3/Pjxhmaes
	y5i1Tf+lutR7+bUJpu8zrxWFXPdevfUfE39JUOHs/eYbnk+1z11ZtrvuscGqzxn/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268793>

Detect duplicates by storing the reference names in a string_list and
sorting that, instead of sorting the ref_updates directly.

* In a moment the string_list will be used for another purpose, too.

* This removes the need for the custom comparison function
  ref_update_compare().

* This means that we can carry out the updates in the order that the
  user specified them instead of reordering them. This might be handy
  someday if, we want to permit multiple updates to a single reference
  as long as they are compatible with each other.

Note: we can't use string_list_remove_duplicates() to check for
duplicates, because we need to know the name of the reference that
appeared multiple times, to be used in the error message.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 8316bb1..6bb65ab 100644
--- a/refs.c
+++ b/refs.c
@@ -3720,25 +3720,18 @@ int update_ref(const char *msg, const char *refname,
 	return 0;
 }
 
-static int ref_update_compare(const void *r1, const void *r2)
-{
-	const struct ref_update * const *u1 = r1;
-	const struct ref_update * const *u2 = r2;
-	return strcmp((*u1)->refname, (*u2)->refname);
-}
-
-static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+static int ref_update_reject_duplicates(struct string_list *refnames,
 					struct strbuf *err)
 {
-	int i;
+	int i, n = refnames->nr;
 
 	assert(err);
 
 	for (i = 1; i < n; i++)
-		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
+		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
 			strbuf_addf(err,
 				    "Multiple updates for ref '%s' not allowed.",
-				    updates[i]->refname);
+				    refnames->items[i].string);
 			return 1;
 		}
 	return 0;
@@ -3752,6 +3745,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
 
@@ -3763,9 +3757,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Copy, sort, and reject duplicate refs */
-	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	if (ref_update_reject_duplicates(updates, n, err)) {
+	/* Fail if a refname appears more than once in the transaction: */
+	for (i = 0; i < n; i++)
+		string_list_append(&affected_refnames, updates[i]->refname);
+	string_list_sort(&affected_refnames);
+	if (ref_update_reject_duplicates(&affected_refnames, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
@@ -3857,6 +3853,7 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	string_list_clear(&refs_to_delete, 0);
+	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
-- 
2.1.4
