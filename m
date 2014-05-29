From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 39/41] refs.c: propagate any errno==ENOTDIR from _commit back to the callers
Date: Thu, 29 May 2014 09:07:54 -0700
Message-ID: <1401379676-9307-13-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2si-0006y9-JH
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757598AbaE2QIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:31 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:54227 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so96185pbc.4
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8llpSbU2FVas7VD64QB2H3eXmUSjL4YveQqnEYNfndg=;
        b=abve1++IloRxzX/TStZ2kLFtth9E/H+waDtKGmL1QccIF3ZS+aJeul3mTWnJOSBnED
         xhb2XQk5ezTncxR/bYD92TKUW5ubym1JKZJ7cPsbkIQUQpVjqrIvl2/ZDpEIWLBkM7S8
         EIB78UdNk8akmq1rGwRO8MUb7NrWGDczKYDEoC6xBN9tcsHRguLiAK6c4R2QAOkeh8EZ
         0iJwQoLOsXsi+T0buH4MXJ5V6Z6MyFp3EzVIhoiAoJIdZrlJSoIAkDlhcDwQ52fHA6Dn
         vLALPYAjzEh9yhH5bO1pqxdMjJvktbgQV2cFRE/T6asPMt5oa0cs118YklDywNyuvs7e
         aPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8llpSbU2FVas7VD64QB2H3eXmUSjL4YveQqnEYNfndg=;
        b=HKXmDr10L8uDcuHxWLNjoEhE0I2zGlO8ps4Fxw+OOzit6vFSLUBEbMNdp+Pc68u4lb
         +aj+1XaJBn6PUQKzaERC6a1dwmFHn89A7aYSbYHPvF8w4TsyjAc7iCdihJC4urMRa+V9
         f5HWsmkJWFtHWM9uwnzz2LaXK8wpzuRCVBo7+/8BWxi7ZsUsZDkWMto4pxC//quW/gkC
         kengiprYyqi3nho2bg9CC4Vsfvm+QW4eNkQwpg3psJVyARVH6X/VgUBsBQRUaGIvqyzd
         GXIoousC3Hd67O724kXDau3qAV+f4jeMXLKFLgAH498H9t16gbVBOIxOpcQPWJH1jnM1
         crHA==
X-Gm-Message-State: ALoCoQmR3qXo+/wOYqd7JsU/jaAt9AOW6us3nvp3wylHS4LmaGYoTUiGQwWj25e5gSgzBYCmWZMQ
X-Received: by 10.66.164.167 with SMTP id yr7mr3376319pab.15.1401379679882;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si82766yhe.1.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8DB9931C3FC;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3F934E1944; Thu, 29 May 2014 09:07:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250382>

In _commit, ENOTDIR can happen in the call to lock_ref_sha1_basic, either when
we lstat the new refname and it returns ENOTDIR or if the name checking
function reports that the same type of conflict happened. In both cases it
means that we can not create the new ref due to a name conflict.

For these cases, save the errno value and abort and make sure that the caller
can see errno==ENOTDIR.

Also start defining specific return codes for _commit, assign -1 as a generic
error and -2 as the error that refers to a name conflict. Callers can (and
should) use that return value inspecting errno directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 23 ++++++++++++++++-------
 refs.h |  4 ++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index ec8d642..6414afc 100644
--- a/refs.c
+++ b/refs.c
@@ -3504,7 +3504,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i;
+	int ret = 0, delnum = 0, i, save_errno = 0;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3522,9 +3522,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err);
-	if (ret)
+	if (ref_update_reject_duplicates(updates, n, err)) {
+		ret = -1;
 		goto cleanup;
+	}
 
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
@@ -3538,10 +3539,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   &update->type,
 						   delnames, delnum);
 		if (!update->lock) {
+			if (errno == ENOTDIR)
+				save_errno = errno;
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
 					    update->refname);
-			ret = 1;
+			ret = -1;
 			goto cleanup;
 		}
 	}
@@ -3559,6 +3562,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 				if (err)
 					strbuf_addf(err, str, update->refname);
+				ret = -1;
 				goto cleanup;
 			}
 		}
@@ -3569,14 +3573,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			ret |= delete_ref_loose(update->lock, update->type,
-						err);
+			if (delete_ref_loose(update->lock, update->type, err))
+				ret = -1;
+
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum, err);
+	if (repack_without_refs(delnames, delnum, err))
+		ret = -1;
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
@@ -3589,6 +3595,9 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
+	errno = save_errno;
+	if (save_errno == ENOTDIR)
+		ret = -2;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 5c6c20f..88732a1 100644
--- a/refs.h
+++ b/refs.h
@@ -323,6 +323,10 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ * If the transaction is already in failed state this function will return
+ * an error.
+ * Function returns 0 on success, -1 for generic failures and -2 if the
+ * failure was due to a name collision (ENOTDIR).
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err);
-- 
2.0.0.rc3.474.g3833130
