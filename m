From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 20/31] refs.c: check for lock conflicts already in _update
Date: Wed, 14 May 2014 15:13:19 -0700
Message-ID: <1400105610-21194-21-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRp-00088M-HE
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbaENWOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:10 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:37345 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbaENWNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:39 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so51508pab.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sz4QiPdHT3mZv5HQDiYBcTOEW7koDqjFbasits3bcZI=;
        b=lRW/t9HWOV/KSNPveVKxCDaqRPWus3BVIbYz0AUxt3NJulLarRkkogg7oXP8rvw2Qn
         yrIDPNA9mmOk1IkQ0o9nhHHD33WiUgMC3kzqKAVnD6s1YDKQTeYhYWhVesNhkMNQeGER
         3bW1177Q2Qrxmsk0++25VZ2dI02gM+j4mzzTX/INJ8mo6NKf2UkbOQhYZeclN00MbL83
         kHXHXL8smDclwvCsM9Gygv0tw1QSJMhz0pJKVzs+T3ihSLkF0Bxg1PWlHqE1BWz4sjEh
         Y3RihebpKcKFfnWAGzDVm7r8GfyPtiRTZemjemZ7ybmyKvtBrmRdihZ1GVxuw/0lTT3b
         Uj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sz4QiPdHT3mZv5HQDiYBcTOEW7koDqjFbasits3bcZI=;
        b=TjQ5juDQ42HswreCw0TiiOKhF0mI/Cn2GPGmTKmFZIcf9IRD2q9djr3NC5acWB2rgf
         N6FdjsK3YXEEFAVIUK2Caj206oM3l39idL6N5IyP1x1NFUy7CxHcForc/QZGcRW7S09A
         4kodkYbCXp2FXj3OW7PRj6Xq3khOBr+65Klh7Zes2keqpgeex3kpIdWM9RRnvcTiouJn
         GxXUW9v/tH3C2nFVl8b9toOZH51mkIJB+27cWrYKYsSOEkxPQIlnQ4KlwTEmHUBGzpbL
         fEeoZVwiX+zQRrzCjGEH3h/WltdnZvmUnKW+pqdgQ/arRXz/piuXXC6crWtmftvd2Pwe
         7OCQ==
X-Gm-Message-State: ALoCoQlYJOx7m8I34wulrVieKDoKnh35KZBFIcePo7/utmrC4nrxpc2lhF70U38aXF8/9m9lp6aS
X-Received: by 10.67.4.170 with SMTP id cf10mr525121pad.31.1400105619502;
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si152503yhj.2.2014.05.14.15.13.39
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1F51331C1F8;
	Wed, 14 May 2014 15:13:39 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D7FF2E0973; Wed, 14 May 2014 15:13:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249025>

Check for lock conflicts in _update and flag the transaction as errored
instead of waiting until _commit for doing these checks. If there was a lock
failure we check if this was due to a previous update in the same transaction
or not. This so that we can preserve the current error messages on lock failure
and log "Multiple updates for ref '%s' not allowed." when we have multiple
updates in the same transaction and "Cannot lock the ref '%s'." for any other
reason that the lock failed.

This also means that we no longer need to sort all the refs and check for
duplicates during _commit so all that code can be removed too.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 85 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/refs.c b/refs.c
index 93f01e8..76cab6e 100644
--- a/refs.c
+++ b/refs.c
@@ -3415,6 +3415,7 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 			    struct strbuf *err)
 {
 	struct ref_update *update;
+	int i;
 
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
@@ -3438,19 +3439,49 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 	 * we do not need to check against this ref for name collissions
 	 * during locking.
 	 */
-	if (update->flags & REF_ISPACKONLY)
+	if (update->flags & REF_ISPACKONLY) {
 		add_delname(transaction, update->refname);
-	else {
-		update->lock = lock_ref_sha1_basic(update->refname,
-						   (update->have_old ?
-						    update->old_sha1 :
-						    NULL),
-						   update->flags,
-						   &update->type,
-						   transaction->delnames,
-						   transaction->delnum);
+		return 0;
 	}
-	return 0;
+
+	update->lock = lock_ref_sha1_basic(update->refname,
+					   (update->have_old ?
+					    update->old_sha1 :
+					    NULL),
+					   update->flags,
+					   &update->type,
+					   transaction->delnames,
+					   transaction->delnum);
+	if (update->lock)
+		return 0;
+
+	/* If we could not lock the ref it means we either collided with a
+	   different command or that we tried to perform a second update to
+	   the same ref from within the same transaction.
+	*/
+	transaction->status = REF_TRANSACTION_ERROR;
+
+	/* -1 is the update we just added. Start at -2 and find the most recent
+	   previous update for this ref.
+	*/
+	for (i = transaction->nr - 2; i >= 0; i--) {
+		if (transaction->updates[i]->update_type != UPDATE_SHA1) {
+			continue;
+		}
+		if (!strcmp(transaction->updates[i]->refname,
+			    update->refname))
+			break;
+	}
+	if (err)
+		if (i >= 0) {
+			const char *str =
+				"Multiple updates for ref '%s' not allowed.";
+			strbuf_addf(err, str, update->refname);
+		} else {
+			const char *str = "Cannot lock the ref '%s'.";
+			strbuf_addf(err, str, update->refname);
+		}
+	return 1;
 }
 
 int transaction_create_sha1(struct ref_transaction *transaction,
@@ -3525,32 +3556,6 @@ int update_ref(const char *action, const char *refname,
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
-					struct strbuf *err)
-{
-	int i;
-	for (i = 1; i < n; i++) {
-		if (updates[i]->update_type != UPDATE_SHA1)
-			continue;
-		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
-			const char *str =
-				"Multiple updates for ref '%s' not allowed.";
-			if (err)
-				strbuf_addf(err, str, updates[i]->refname);
-
-			return 1;
-		}
-	}
-	return 0;
-}
-
 int transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
@@ -3569,12 +3574,6 @@ int transaction_commit(struct ref_transaction *transaction,
 		return 0;
 	}
 
-	/* Copy, sort, and reject duplicate refs */
-	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
-		goto cleanup;
-
 	/* Acquire all ref locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-- 
2.0.0.rc3.506.g3739a35
