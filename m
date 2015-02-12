From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/12] struct ref_update: move "have_old" into "flags"
Date: Thu, 12 Feb 2015 12:12:14 +0100
Message-ID: <1423739543-1025-4-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:13:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhf-0004Bo-II
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbbBLLMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:50 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56110 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755593AbbBLLMh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:37 -0500
X-AuditID: 12074412-f79e46d0000036b4-ff-54dc8aa43ced
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 22.52.14004.4AA8CD45; Thu, 12 Feb 2015 06:12:36 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7W003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:34 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqLuk606IwbOXHBZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzpnz5xFawQKJi7oo77A2Mt4S6GDk5JARMJHZ/Xs8EYYtJXLi3nq2L
	kYtDSOAyo8SJH4tZIJwTTBKfH5xgBaliE9CVWNTTDNYhIqAmMbHtEAuIzSywmkli6102EFtY
	wFOiZc0csHoWAVWJ7QdOMYPYvALOEpN2PofaJidx/vhPsDingIvEu0sNjCC2EFDNrrYtrBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAkzoR2M60/KHWIU4GBU
	4uFdYXonRIg1say4MvcQoyQHk5IoL1crUIgvKT+lMiOxOCO+qDQntfgQowQHs5IIr28TUI43
	JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYK3vBOoUbAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4UG/HFwOgASfEA7RUDaectLkjMBYpCtJ5iVJQS580ESQiA
	JDJK8+DGwpLHK0ZxoC+Fee+AVPEAEw9c9yugwUxAgyfOuA0yuCQRISXVwMjOveeWlsu3/8sW
	XHyf+bk9mb9Qzd3rfcmC8qvPkvxfdTxpOP276Prx7wsPRk3af27VXqaYAxt9JftWpex2u3Ix
	YkZLhDx32NoH7ccWtRbfLFXpdHE0j7D0dhSY53mAl+Fn/dTGzaGuH9l36U8rdNgs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263720>

Instead of having a separate have_old field, record this boolean value
as a bit in the "flags" field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 4de1383..6cfc07f 100644
--- a/refs.c
+++ b/refs.c
@@ -41,12 +41,18 @@ static unsigned char refname_disposition[256] = {
 #define REF_DELETING	0x02
 
 /*
- * Used as a flag to ref_transaction_delete when a loose ref is being
+ * Used as a flag in ref_update::flags when a loose ref is being
  * pruned.
  */
 #define REF_ISPRUNING	0x04
 
 /*
+ * Used as a flag in ref_update::flags when old_sha1 should be
+ * checked.
+ */
+#define REF_HAVE_OLD	0x08
+
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -3563,16 +3569,20 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 }
 
 /**
- * Information needed for a single ref update.  Set new_sha1 to the
- * new value or to zero to delete the ref.  To check the old value
- * while locking the ref, set have_old to 1 and set old_sha1 to the
- * value or to zero to ensure the ref does not exist before update.
+ * Information needed for a single ref update. Set new_sha1 to the new
+ * value or to null_sha1 to delete the ref. To check the old value
+ * while the ref is locked, set (flags & REF_HAVE_OLD) and set
+ * old_sha1 to the old value, or to null_sha1 to ensure the ref does
+ * not exist before update.
  */
 struct ref_update {
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	/*
+	 * One or more of REF_HAVE_OLD, REF_NODEREF,
+	 * REF_DELETING, and REF_IS_PRUNING:
+	 */
+	int flags;
 	struct ref_lock *lock;
 	int type;
 	char *msg;
@@ -3666,10 +3676,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old)
+	if (have_old) {
 		hashcpy(update->old_sha1, old_sha1);
+		flags |= REF_HAVE_OLD;
+	}
+	update->flags = flags;
 	if (msg)
 		update->msg = xstrdup(msg);
 	return 0;
@@ -3785,13 +3796,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
-		update->lock = lock_ref_sha1_basic(update->refname,
-						   (update->have_old ?
-						    update->old_sha1 :
-						    NULL),
-						   NULL,
-						   flags,
-						   &update->type);
+		update->lock = lock_ref_sha1_basic(
+				update->refname,
+				((update->flags & REF_HAVE_OLD) ?
+				 update->old_sha1 : NULL),
+				NULL,
+				flags,
+				&update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
 				? TRANSACTION_NAME_CONFLICT
-- 
2.1.4
