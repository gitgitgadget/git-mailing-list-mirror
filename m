From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/18] ref_transaction_commit(): use a string_list for detecting duplicates
Date: Fri,  1 May 2015 14:25:49 +0200
Message-ID: <1430483158-14349-10-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:34:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA90-0006wI-S8
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbbEAMeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:34:04 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47609 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789AbbEAMeC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:34:02 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2015 08:34:02 EDT
X-AuditID: 12074411-f79fa6d000006b8a-7a-554370edd7c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.28.27530.DE073455; Fri,  1 May 2015 08:26:21 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zm004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:20 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqPu2wDnUYMEeFYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ1w/8IC54K14xaqODuYGxmXCXYwcHBICJhKT/5R1MXICmWISF+6tZ+ti5OIQErjMKHGu
	8TozhHOCSaLt63E2kCo2AV2JRT3NTCC2iICaxMS2QywgRcwCHYwSF5ZvYwdJCAtES8x6uw+s
	gUVAVeJV9xpGEJtXwFViw7mnTBDr5CTOH//JDHIFJ1D8y9REkLCQgIvE/e9f2SYw8i5gZFjF
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJQgjsYZ5yUO8QowMGoxMO74ZhT
	qBBrYllxZe4hRkkOJiVRXtsE51AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrz31IFyvCmJlVWp
	RfkwKWkOFiVxXr4l6n5CAumJJanZqakFqUUwWQ0ODoEZ5+ZOZ5JiycvPS1WS4E3MBxoiWJSa
	nlqRlplTglDKxMEJsohLSqQ4NS8ltSixtCQjHhQx8cXAmAFJ8QDdsAyknbe4IDEXKArReopR
	UUqctwckIQCSyCjNgxsLSx+vGMWBPhbmPQ5SxQNMPXDdr4AGMwENPn/LAWRwSSJCSqqBUdR1
	3957q5IjXHUf3j605cuDJskbGXnXFzH2862oNUr/9KZTMeSdUW2t93G/sxcXOZzawr434G3P
	vWMX+vNP/dlzd0+EmLVDoeF8yfm3KhdW8Lz/wiT57vWOjbflkp2iBG+wOsgsmSy3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268134>

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
index 8e929c7..fca3ef1 100644
--- a/refs.c
+++ b/refs.c
@@ -3718,25 +3718,18 @@ int update_ref(const char *msg, const char *refname,
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
@@ -3750,6 +3743,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	struct ref_update **updates = transaction->updates;
 	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
 	struct string_list_item *ref_to_delete;
+	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
 	assert(err);
 
@@ -3761,9 +3755,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
@@ -3879,6 +3875,7 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	string_list_clear(&refs_to_delete, 0);
+	string_list_clear(&affected_refnames, 0);
 	return ret;
 }
 
-- 
2.1.4
