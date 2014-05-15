From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 10/44] refs.c: change ref_transaction_update() to do error checking and return status
Date: Thu, 15 May 2014 10:29:25 -0700
Message-ID: <1400174999-26786-11-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzW1-0002bm-AI
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbaEORcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:12 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:44456 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbaEORaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:08 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so257087pab.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQaWtylJKgFV3Zf/BTnM3CIcfpdn2lDDZKNdkMY6gvA=;
        b=BNwnQpdALTS9cRGW1JP3xnKS3Fld9RqWdqFEWfOPeGkfPzMn6vbIZsRQbTiCT9vHrT
         6La23UTvE3KAJ6iXNoDfRhszswO2D6UuaHWEywGz9cKUeFXaiiPgu40agOg3oByQLkC/
         Uhv2zTH4dOFeiKU2Txdb43siY0EQ/H05Fsz41rdxFY3lMKEC/fFaO9IB/IveQd5nTCvC
         8FpS+vb4SpVI1SO3gKCm1rOGGDFzDHchQjF3Wkzpi+jKut/A3YiJ+/mVUbPgXsJoPOMk
         AadXZCYu6vKVmv+84d+TRV3oF5Ow/0oAJQ1ijW6LdyPRe1QIVK++qqOzMLNCm3SalEl9
         1GBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQaWtylJKgFV3Zf/BTnM3CIcfpdn2lDDZKNdkMY6gvA=;
        b=Zu4bCzx69nalLSDWl710+MG/vKUNNX5cKfkjkK7xjeK7HbQ/uKQz65tTu9LhCI8SWQ
         i5A7RRhH+bWHUXeD3JocL0ql4eOJNl7MT0JG4U8VRt8qgzTgsTKoLr1FZUg87UaKHt7I
         GCJK9FKDiRa/SiQXMdK0oRC/HpKdBFrfHIRH4OlQRfYQ+8IaU4r27QdxZW1tvWTZSqd7
         Kqb2rIAf/jxUn1+n5eq57tm4W3z4Kgoh0nv5t9Ay7zz4TohZzrKO2EV6i0/gvjlPkHaV
         MFvOrv+e3MeEOPMoXg8ClECDpSYZelDHZW0piQYnqGJFKMDCUbPNlcw8o3phCDgN5YmW
         Ijyw==
X-Gm-Message-State: ALoCoQmldZ6PPQ5wqT+xZnTmwe4nqkccOZyYwzybHxT1yXBso/C5n9WbqmsuiWmbl7iUx7RqkWof
X-Received: by 10.67.5.165 with SMTP id cn5mr3195168pad.9.1400175006475;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si273446yhq.3.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 27F5731C239;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DD928E1747; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249156>

Update ref_transaction_update() do some basic error checking and return
non-zero on error. Update all callers to check ref_transaction_update() for
error. There are currently no conditions in _update that will return error but
there will be in the future.

Also check for BUGs during update and die(BUG:...) if we are calling
_update with have_old but the old_sha1 pointer is NULL.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 13 ++++++++-----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2bef2a0..59c4d6b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("update %s: failed", refname);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index bc21060..e8c2345 100644
--- a/refs.c
+++ b/refs.c
@@ -3353,19 +3353,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
+int ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 555ee59..fd8d731 100644
--- a/refs.h
+++ b/refs.h
@@ -242,12 +242,15 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
+ * Function returns 0 on success and non-zero on failure. A failure to update
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
2.0.0.rc3.477.g0f8edf7
